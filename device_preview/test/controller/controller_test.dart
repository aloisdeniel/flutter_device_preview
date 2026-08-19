import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/controller/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show EdgeInsets, Orientation;
import 'package:flutter_test/flutter_test.dart';

import '../binding/fakes.dart';

/// Harness bundling a [DevicePreviewControllerImpl] with recording handlers
/// and a scriptable target-platform override.
class ControllerHarness {
  ControllerHarness({EdgeInsets framePadding = EdgeInsets.zero}) {
    controller = DevicePreviewControllerImpl(
      state: state,
      hostView: dispatcher.implicitView!,
      hostDispatcher: dispatcher,
      framePadding: framePadding,
      handleMetricsChanged: () => handlerCalls.add('metrics'),
      handleTextScaleFactorChanged: () => handlerCalls.add('textScale'),
      handlePlatformBrightnessChanged: () => handlerCalls.add('brightness'),
      handleLocaleChanged: () => handlerCalls.add('locale'),
      handleAccessibilityFeaturesChanged: () =>
          handlerCalls.add('accessibility'),
      applyTargetPlatformOverride: (TargetPlatform? platform) {
        platformOverrides.add(platform);
        return applyPlatformOverride(platform);
      },
    );
    controller.onStateChanged = events.add;
  }

  final PreviewState state = PreviewState();
  final FakePlatformDispatcher dispatcher = FakePlatformDispatcher();
  final List<String> handlerCalls = <String>[];
  final List<TargetPlatform?> platformOverrides = <TargetPlatform?>[];
  final List<Map<String, Object?>> events = <Map<String, Object?>>[];

  /// The behavior of the injected target-platform override; defaults to a
  /// synchronous no-op.
  Future<void> Function(TargetPlatform? platform) applyPlatformOverride = (
    TargetPlatform? platform,
  ) async {};

  late final DevicePreviewControllerImpl controller;

  void dispose() => controller.dispose();
}

void main() {
  group('apply serialization (reentrancy across the reassemble await)', () {
    test('the observable state commits before the platform propagation '
        'awaits', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      final Completer<void> reassemble = Completer<void>();
      harness.applyPlatformOverride = (_) => reassemble.future;

      const DeviceSimulation a = DeviceSimulation(
        platformBrightness: ui.Brightness.dark,
        targetPlatform: TargetPlatform.iOS,
      );
      final Future<void> applyA = harness.controller.applyTagged(
        a,
        source: 'devtools',
        requestId: 'A',
      );
      await pumpEventQueue();

      // A is suspended inside the (fake) reassemble: the rendered state and
      // the reported state are already committed and identical.
      expect(harness.platformOverrides, <TargetPlatform?>[TargetPlatform.iOS]);
      expect(harness.state.simulation, a);
      expect(harness.controller.simulation, a);
      // The stateChanged event waits for propagation to complete.
      expect(harness.events, isEmpty);

      reassemble.complete();
      await applyA;
      expect(harness.events.single['requestId'], 'A');
    });

    test('an apply issued during an in-flight platform apply is queued, not '
        'interleaved', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      final Completer<void> reassemble = Completer<void>();
      harness.applyPlatformOverride = (TargetPlatform? platform) =>
          platform == null ? Future<void>.value() : reassemble.future;

      const DeviceSimulation a = DeviceSimulation(
        platformBrightness: ui.Brightness.dark,
        targetPlatform: TargetPlatform.iOS,
      );
      const DeviceSimulation b = DeviceSimulation(
        platformBrightness: ui.Brightness.light,
        targetPlatform: TargetPlatform.iOS,
      );
      final Future<void> applyA = harness.controller.applyTagged(
        a,
        source: 'devtools',
        requestId: 'A',
      );
      final Future<void> applyB = harness.controller.applyTagged(
        b,
        source: 'devtools',
        requestId: 'B',
      );
      await pumpEventQueue();

      // B must not have run (or committed anything) while A is suspended.
      expect(harness.state.simulation, a);
      expect(harness.controller.simulation, a);
      expect(harness.events, isEmpty);

      reassemble.complete();
      await applyA;
      await applyB;

      // Strict call order, and rendered == reported == last event.
      expect(
        harness.events.map((Map<String, Object?> e) => e['requestId']),
        <Object?>['A', 'B'],
      );
      expect(harness.state.simulation, b);
      expect(harness.controller.simulation, b);
      expect(
        harness.events.last['simulation'],
        harness.controller.simulation!.toJson(),
      );
    });

    test('update() during an in-flight apply builds on the in-flight '
        'simulation, not a stale snapshot', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      final Completer<void> reassemble = Completer<void>();
      harness.applyPlatformOverride = (_) => reassemble.future;

      const DeviceSimulation a = DeviceSimulation(
        targetPlatform: TargetPlatform.iOS,
      );
      final Future<void> applyA = harness.controller.applyTagged(a);
      final Future<void> applyUpdate = harness.controller.update(
        (DeviceSimulation s) => s.copyWith(textScaleFactor: 2.0),
      );
      await pumpEventQueue();
      reassemble.complete();
      await applyA;
      await applyUpdate;

      // The update preserved A's platform override instead of dropping it
      // (and did not trigger a second platform apply).
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.targetPlatform, TargetPlatform.iOS);
      expect(result.textScaleFactor, 2.0);
      expect(harness.platformOverrides, <TargetPlatform?>[TargetPlatform.iOS]);
      expect(harness.state.simulation, result);
    });

    test('a throwing platform apply still posts the stateChanged event, '
        'keeps state consistent, and keeps the queue alive', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      harness.applyPlatformOverride = (_) async {
        throw StateError('reassemble failed');
      };

      const DeviceSimulation a = DeviceSimulation(
        targetPlatform: TargetPlatform.iOS,
      );
      await expectLater(
        harness.controller.applyTagged(a, requestId: 'X'),
        throwsStateError,
      );
      // The state changed, so the event must have been posted anyway.
      expect(harness.events.single['requestId'], 'X');
      expect(harness.controller.simulation, a);
      expect(harness.state.simulation, a);

      // The queue survives: a later apply still goes through. (Clearing the
      // platform override throws again in this harness, so keep it set.)
      const DeviceSimulation b = DeviceSimulation(
        targetPlatform: TargetPlatform.iOS,
        textScaleFactor: 3.0,
      );
      await harness.controller.applyTagged(b);
      expect(harness.controller.simulation, b);
      expect(harness.events, hasLength(2));
    });
  });

  group('setOrientation padding (preset-less rotation)', () {
    test('the documented rotation rule and its inverse round-trip the '
        'paddings', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      const EdgeInsets portrait = EdgeInsets.only(top: 47, bottom: 34);
      await harness.controller.apply(
        const DeviceSimulation(
          screenSize: ui.Size(375, 667),
          padding: portrait,
          viewPadding: portrait,
        ),
      );

      await harness.controller.setOrientation(Orientation.landscape);
      const EdgeInsets landscape =
          EdgeInsets.only(left: 47, right: 47, bottom: 34);
      expect(harness.controller.simulation!.padding, landscape);
      expect(harness.controller.simulation!.viewPadding, landscape);
      expect(
        harness.controller.simulation!.screenSize,
        const ui.Size(667, 375),
      );

      await harness.controller.setOrientation(Orientation.portrait);
      expect(harness.controller.simulation!.padding, portrait);
      expect(harness.controller.simulation!.viewPadding, portrait);
      expect(
        harness.controller.simulation!.screenSize,
        const ui.Size(375, 667),
      );
    });
  });

  group('setOrientation display features (preset-less rotation)', () {
    const SimulatedDisplayFeature verticalHinge = SimulatedDisplayFeature(
      // Vertical hinge on an 800×1104 portrait screen.
      bounds: ui.Rect.fromLTRB(390, 0, 410, 1104),
      type: ui.DisplayFeatureType.hinge,
      state: ui.DisplayFeatureState.postureFlat,
    );

    test('rotating to landscape maps hinge bounds through the 90° rotation', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(
          screenSize: ui.Size(800, 1104),
          devicePixelRatio: 2.0,
          padding: EdgeInsets.only(top: 24),
          displayFeatures: <SimulatedDisplayFeature>[verticalHinge],
        ),
      );
      await harness.controller.setOrientation(Orientation.landscape);

      final DeviceSimulation rotated = harness.controller.simulation!;
      expect(rotated.screenSize, const ui.Size(1104, 800));
      // The vertical hinge becomes a horizontal band fully inside the
      // landscape screen: (l, t, r, b) → (t, w − r, b, w − l) with w = 800.
      expect(
        rotated.displayFeatures!.single.bounds,
        const ui.Rect.fromLTRB(0, 390, 1104, 410),
      );
      expect(
        rotated.displayFeatures!.single.type,
        ui.DisplayFeatureType.hinge,
      );
    });

    test('rotating back to portrait restores the original bounds', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(
          screenSize: ui.Size(800, 1104),
          devicePixelRatio: 2.0,
          displayFeatures: <SimulatedDisplayFeature>[verticalHinge],
        ),
      );
      await harness.controller.setOrientation(Orientation.landscape);
      await harness.controller.setOrientation(Orientation.portrait);

      final DeviceSimulation restored = harness.controller.simulation!;
      expect(restored.screenSize, const ui.Size(800, 1104));
      expect(restored.displayFeatures!.single.bounds, verticalHinge.bounds);
    });

    test('systemGestureInsets intentionally pass through unrotated', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      const EdgeInsets gestureInsets = EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 20,
      );
      await harness.controller.apply(
        const DeviceSimulation(
          screenSize: ui.Size(400, 800),
          systemGestureInsets: gestureInsets,
        ),
      );
      await harness.controller.setOrientation(Orientation.landscape);
      // Edge semantics (back-gesture side edges, home area at the bottom)
      // are orientation-invariant on real devices.
      expect(harness.controller.simulation!.systemGestureInsets, gestureInsets);
    });
  });

  group('preset resolution through the controller', () {
    test('applyPreset preserves non-metric overrides', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(platformBrightness: ui.Brightness.dark),
      );
      await harness.controller.applyPreset(DevicePresets.iPhone16);
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.presetId, 'apple-iphone-16');
      expect(result.platformBrightness, ui.Brightness.dark);
    });

    test('applyPreset preserves touchInput and showSystemUi — the DevTools '
        'panel treats both as device-switch-surviving overrides', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(touchInput: false, showSystemUi: false),
      );
      await harness.controller.applyPreset(DevicePresets.iPhone16);
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.touchInput, false);
      expect(result.showSystemUi, false);
    });

    test('setOrientation on a preset simulation keeps wire-pushed frame and '
        'systemUi artwork the local preset does not carry', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      // What the DevTools panel pushes: a built-in presetId plus catalog
      // artwork that only exists on the wire, never in DevicePresets.
      const DeviceFrame frame = DeviceFrame(
        size: ui.Size(120, 220),
        screenOffset: ui.Offset(10, 10),
        screenPath: 'M0,0 H100 V200 H0 Z',
        body: '<svg viewBox="0 0 120 220"/>',
      );
      const SystemUiSimulation systemUi = SystemUiSimulation(
        statusBar: SystemUiBar(),
      );
      await harness.controller.apply(
        DevicePresets.iPhone16
            .resolve()
            .copyWith(frame: frame, systemUi: systemUi),
      );
      await harness.controller.setOrientation(Orientation.landscape);
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.orientation, Orientation.landscape);
      expect(result.presetId, 'apple-iphone-16');
      expect(result.frame, frame);
      expect(result.systemUi, systemUi);
    });
  });

  group('applyJson', () {
    // A complete spec in the device_specs/*.json format: metrics, frame
    // artwork and decorative system UI, like every catalog entry.
    const String spec = '''
    {
      "id": "acme-phone",
      "name": "Acme Phone",
      "brand": "Acme",
      "year": 2026,
      "platform": "android",
      "kind": "phone",
      "portraitSize": {"width": 400, "height": 800},
      "devicePixelRatio": 2.5,
      "portraitPadding": {"left": 0, "top": 40, "right": 0, "bottom": 20},
      "landscapePadding": {"left": 40, "top": 0, "right": 40, "bottom": 12},
      "frame": {
        "size": {"width": 440, "height": 840},
        "screenOffset": {"x": 20, "y": 20},
        "screenPath": "M 0,0 H 400 V 800 H 0 Z",
        "body": [
          "<svg viewBox=\\"0 0 440 840\\">",
          "  <rect x=\\"0\\" y=\\"0\\" width=\\"440\\" height=\\"840\\" rx=\\"40\\" fill=\\"#000\\"/>",
          "</svg>"
        ]
      },
      "systemUi": {
        "statusBar": {
          "inset": 18,
          "leading": "<svg viewBox=\\"0 0 20 10\\"><rect width=\\"20\\" height=\\"10\\" fill=\\"currentColor\\"/></svg>",
          "trailing": "<svg viewBox=\\"0 0 30 10\\"><rect width=\\"30\\" height=\\"10\\" fill=\\"currentColor\\"/></svg>"
        },
        "navigationBar": {
          "center": "<svg viewBox=\\"0 0 100 4\\"><rect width=\\"100\\" height=\\"4\\" rx=\\"2\\" fill=\\"currentColor\\"/></svg>",
          "bottomInset": 8
        }
      }
    }
    ''';

    test(
      'decodes the frame and system UI of a device_specs-style spec',
      () async {
        final ControllerHarness harness = ControllerHarness();
        addTearDown(harness.dispose);
        await harness.controller.applyJson(spec);
        final DeviceSimulation result = harness.controller.simulation!;
        final DeviceFrame frame = result.frame!;
        expect(frame.size, const ui.Size(440, 840));
        expect(frame.screenOffset, const ui.Offset(20, 20));
        expect(frame.screenPath, 'M 0,0 H 400 V 800 H 0 Z');
        expect(frame.body, contains('<svg viewBox="0 0 440 840">'));
        expect(frame.body, contains('rx="40"'));
        final SystemUiSimulation systemUi = result.systemUi!;
        expect(systemUi.statusBar!.inset, 18);
        expect(systemUi.statusBar!.leading, contains('viewBox="0 0 20 10"'));
        expect(systemUi.statusBar!.trailing, contains('viewBox="0 0 30 10"'));
        expect(systemUi.navigationBar!.bottomInset, 8);
        expect(systemUi.navigationBar!.center, contains('viewBox="0 0 100 4"'));
        // The registered preset carries the artwork too, so a later
        // setOrientation keeps it.
        await harness.controller.setOrientation(Orientation.landscape);
        expect(harness.controller.simulation!.frame, frame);
        expect(harness.controller.simulation!.systemUi, systemUi);
      },
    );

    test('loads a real catalog spec file from device_specs/', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      final File file = File('../device_specs/google-pixel-9.json');
      expect(file.existsSync(), isTrue, reason: 'run from device_preview/');
      await harness.controller.applyJson(file.readAsStringSync());
      final DeviceSimulation result = harness.controller.simulation!;
      expect(result.presetId, 'google-pixel-9');
      expect(result.deviceKind, DeviceKind.phone);
      expect(result.devicePixelRatio, 2.625);
      expect(result.frame, isNotNull);
      expect(result.frame!.body, contains('<svg'));
      expect(result.frame!.screenPath, isNotEmpty);
      expect(result.systemUi, isNotNull);
      expect(result.systemUi!.statusBar, isNotNull);
      expect(result.systemUi!.navigationBar, isNotNull);
      final DevicePreset registered = harness.controller.presets.singleWhere(
        (DevicePreset p) => p.id == 'google-pixel-9',
      );
      expect(registered.name, 'Pixel 9');
      expect(registered.frame, result.frame);
      expect(registered.systemUi, result.systemUi);
    });

    test(
      'decodes a JSON string, registers the preset and applies it',
      () async {
        final ControllerHarness harness = ControllerHarness();
        addTearDown(harness.dispose);
        final List<int> presetCounts = <int>[];
        harness.controller.onPresetsChanged = presetCounts.add;
        await harness.controller.applyJson(spec);
        final DeviceSimulation? result = harness.controller.simulation;
        expect(result!.presetId, 'acme-phone');
        expect(result.screenSize, const ui.Size(400, 800));
        expect(result.devicePixelRatio, 2.5);
        expect(result.padding, const EdgeInsets.only(top: 40, bottom: 20));
        expect(
          harness.controller.presets.where(
            (DevicePreset p) => p.id == 'acme-phone',
          ),
          hasLength(1),
        );
        expect(presetCounts, <int>[DevicePresets.all.length + 1]);
      },
    );

    test('accepts an already decoded map and honors orientation', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.applyJson(
        jsonDecode(spec) as Map<String, Object?>,
        orientation: Orientation.landscape,
      );
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.orientation, Orientation.landscape);
      expect(result.screenSize, const ui.Size(800, 400));
      expect(
        result.padding,
        const EdgeInsets.only(left: 40, right: 40, bottom: 12),
      );
    });

    test('a later setOrientation resolves the registered spec\'s explicit '
        'landscape safe areas', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.applyJson(spec);
      await harness.controller.setOrientation(Orientation.landscape);
      expect(
        harness.controller.simulation!.padding,
        const EdgeInsets.only(left: 40, right: 40, bottom: 12),
      );
    });

    test(
      're-applying a spec with the same id replaces the registered preset',
      () async {
        final ControllerHarness harness = ControllerHarness();
        addTearDown(harness.dispose);
        await harness.controller.applyJson(spec);
        await harness.controller.applyJson(
          spec.replaceFirst('"name": "Acme Phone"', '"name": "Acme Phone 2"'),
        );
        final Iterable<DevicePreset> matches = harness.controller.presets.where(
          (DevicePreset p) => p.id == 'acme-phone',
        );
        expect(matches, hasLength(1));
        expect(matches.single.name, 'Acme Phone 2');
      },
    );

    test('preserves non-metric overrides unless resetOverrides', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(platformBrightness: ui.Brightness.dark),
      );
      await harness.controller.applyJson(spec);
      expect(
        harness.controller.simulation!.platformBrightness,
        ui.Brightness.dark,
      );
      await harness.controller.applyJson(spec, resetOverrides: true);
      expect(harness.controller.simulation!.platformBrightness, isNull);
    });

    test('rejects malformed input with a FormatException', () async {
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      expect(
        () => harness.controller.applyJson('not json'),
        throwsFormatException,
      );
      expect(
        () => harness.controller.applyJson('[1, 2]'),
        throwsFormatException,
      );
      expect(
        () => harness.controller.applyJson(<String, Object?>{'id': 'x'}),
        throwsFormatException,
      );
      expect(harness.controller.simulation, isNull);
    });
  });

  group('scale-to-fit chrome insets', () {
    test('the fit reserves the host safe areas', () async {
      // The fake host is 800x600 logical (2400x1800 at 3.0x) with a
      // 120-physical-pixel top view padding → a 40-logical-pixel safe area.
      final ControllerHarness harness = ControllerHarness();
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(screenSize: ui.Size(800, 600)),
      );
      final FitTransform fit = harness.controller.fitTransform;
      // Available 800x560: min(800/800, 560/600) = 560/600.
      expect(fit.scale, closeTo(560 / 600, 1e-12));
      // Centered below the safe area: 40 + (560 − 600 × scale) / 2 = 40.
      expect(fit.offset.dy, closeTo(40, 1e-12));
      expect(fit.offset.dx, closeTo((800 - 800 * 560 / 600) / 2, 1e-12));
    });

    test('the configured frame padding adds to the host safe areas', () async {
      final ControllerHarness harness = ControllerHarness(
        framePadding: const EdgeInsets.all(10),
      );
      addTearDown(harness.dispose);
      await harness.controller.apply(
        const DeviceSimulation(screenSize: ui.Size(800, 600)),
      );
      final FitTransform fit = harness.controller.fitTransform;
      // Available (10, 50)–(790, 590) = 780x540: min(780/800, 540/600) = 0.9.
      expect(fit.scale, closeTo(0.9, 1e-12));
      expect(fit.offset.dx, closeTo(10 + (780 - 800 * 0.9) / 2, 1e-12));
      expect(fit.offset.dy, closeTo(50 + (540 - 600 * 0.9) / 2, 1e-12));
    });
  });
}

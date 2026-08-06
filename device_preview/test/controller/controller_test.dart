import 'dart:async';
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
  ControllerHarness() {
    controller = DevicePreviewControllerImpl(
      state: state,
      hostView: dispatcher.implicitView!,
      hostDispatcher: dispatcher,
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
      await harness.controller.applyPreset(DevicePresets.iPhoneSe3);
      final DeviceSimulation? result = harness.controller.simulation;
      expect(result!.presetId, 'apple-iphone-se-3');
      expect(result.platformBrightness, ui.Brightness.dark);
    });
  });
}

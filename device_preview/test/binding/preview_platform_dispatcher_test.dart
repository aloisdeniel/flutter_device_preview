import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/binding/preview_platform_dispatcher.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/binding/preview_values.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  late PreviewState state;
  late FakePlatformDispatcher host;
  late FakeFlutterView hostView;
  late FakeFlutterView secondaryView;
  late PreviewPlatformDispatcher dispatcher;

  setUp(() {
    state = PreviewState();
    secondaryView = FakeFlutterView(viewId: 99);
    host = FakePlatformDispatcher(otherViews: <FakeFlutterView>[secondaryView]);
    hostView = host.implicitView!;
    dispatcher = PreviewPlatformDispatcher(host: host, state: state);
  });

  const DeviceSimulation metricSimulation = DeviceSimulation(
    screenSize: ui.Size(200, 400),
    devicePixelRatio: 2.0,
  );

  group('views', () {
    test('implicitView is the cached wrapper with a stable identity', () {
      final ui.FlutterView? first = dispatcher.implicitView;
      final ui.FlutterView? second = dispatcher.implicitView;
      expect(first, isNotNull);
      expect(first, isNot(same(hostView)));
      expect(identical(first, second), isTrue);
      expect(identical(first, dispatcher.previewImplicitView), isTrue);
    });

    test('view(id:) maps the implicit id to the wrapper', () {
      expect(
        dispatcher.view(id: hostView.viewId),
        same(dispatcher.previewImplicitView),
      );
      expect(dispatcher.view(id: 99), same(secondaryView));
      expect(dispatcher.view(id: 12345), isNull);
    });

    test('views swaps the implicit view, secondary views pass through', () {
      final List<ui.FlutterView> views = dispatcher.views.toList();
      expect(views, hasLength(2));
      expect(views[0], same(dispatcher.previewImplicitView));
      expect(views[1], same(secondaryView));
    });

    test('displays and engineId delegate', () {
      expect(dispatcher.displays.length, host.displays.length);
      expect(dispatcher.engineId, host.engineId);
    });
  });

  group('pass-through (no simulation)', () {
    test('per-member checklist: every state getter delegates to the host', () {
      expect(dispatcher.locale, host.locale);
      expect(dispatcher.locales, same(host.locales));
      expect(dispatcher.platformBrightness, host.platformBrightness);
      expect(dispatcher.textScaleFactor, host.textScaleFactor);
      expect(
        dispatcher.accessibilityFeatures,
        same(host.accessibilityFeatures),
      );
      expect(dispatcher.alwaysUse24HourFormat, host.alwaysUse24HourFormat);
      expect(dispatcher.initialLifecycleState, host.initialLifecycleState);
      expect(
        dispatcher.lineHeightScaleFactorOverride,
        host.lineHeightScaleFactorOverride,
      );
      expect(dispatcher.letterSpacingOverride, host.letterSpacingOverride);
      expect(dispatcher.wordSpacingOverride, host.wordSpacingOverride);
      expect(
        dispatcher.paragraphSpacingOverride,
        host.paragraphSpacingOverride,
      );
      expect(
        dispatcher.nativeSpellCheckServiceDefined,
        host.nativeSpellCheckServiceDefined,
      );
      expect(
        dispatcher.supportsShowingSystemContextMenu,
        host.supportsShowingSystemContextMenu,
      );
      expect(dispatcher.brieflyShowPassword, host.brieflyShowPassword);
      expect(dispatcher.systemFontFamily, host.systemFontFamily);
      expect(dispatcher.semanticsEnabled, host.semanticsEnabled);
      expect(dispatcher.frameData, same(host.frameData));
      expect(dispatcher.defaultRouteName, host.defaultRouteName);
    });

    test('engine side effects delegate', () {
      dispatcher.scheduleFrame();
      dispatcher.sendPlatformMessage('channel', null, null);
      dispatcher.setSemanticsTreeEnabled(true);
      dispatcher.setIsolateDebugName('name');
      dispatcher.requestDartPerformanceMode(ui.DartPerformanceMode.balanced);
      dispatcher.getPersistentIsolateData();
      dispatcher.scheduleWarmUpFrame(beginFrame: () {}, drawFrame: () {});
      dispatcher.setApplicationLocale(const ui.Locale('fr'));
      dispatcher.requestViewFocusChange(
        viewId: hostView.viewId,
        state: ui.ViewFocusState.focused,
        direction: ui.ViewFocusDirection.forward,
      );
      expect(
        host.calls,
        containsAll(<String>[
          'scheduleFrame',
          'sendPlatformMessage',
          'setSemanticsTreeEnabled',
          'setIsolateDebugName',
          'requestDartPerformanceMode',
          'getPersistentIsolateData',
          'scheduleWarmUpFrame',
          'setApplicationLocale',
          'requestViewFocusChange',
        ]),
      );
    });

    test('pass-through callbacks delegate directly to the host', () {
      void callback() {}
      ui.HitTestResponse hitTest(ui.HitTestRequest _) =>
          ui.HitTestResponse.empty;
      dispatcher.onSystemFontFamilyChanged = callback;
      expect(host.onSystemFontFamilyChanged, same(callback));
      expect(dispatcher.onSystemFontFamilyChanged, same(callback));
      dispatcher.onSemanticsEnabledChanged = callback;
      expect(host.onSemanticsEnabledChanged, same(callback));
      dispatcher.onFrameDataChanged = callback;
      expect(host.onFrameDataChanged, same(callback));
      dispatcher.onPlatformConfigurationChanged = callback;
      expect(host.onPlatformConfigurationChanged, same(callback));
      dispatcher.onDrawFrame = callback;
      expect(host.onDrawFrame, same(callback));
      dispatcher.onHitTest = hitTest;
      expect(host.onHitTest, same(hitTest));
      expect(dispatcher.onHitTest, same(hitTest));
    });

    test('scaleFontSize delegates to the host scaler', () {
      expect(dispatcher.scaleFontSize(10), 15);
      expect(host.calls, contains('scaleFontSize'));
    });

    test('computePlatformResolvedLocale delegates', () {
      final ui.Locale? resolved = dispatcher.computePlatformResolvedLocale(
        const <ui.Locale>[ui.Locale('en')],
      );
      expect(resolved, host.platformResolvedLocaleValue);
      expect(host.calls, contains('computePlatformResolvedLocale'));
    });
  });

  group('simulatable getters', () {
    test('locale and locales', () {
      state.simulation = const DeviceSimulation(
        locales: <ui.Locale>[ui.Locale('fr', 'FR'), ui.Locale('en', 'US')],
      );
      expect(dispatcher.locale, const ui.Locale('fr', 'FR'));
      expect(dispatcher.locales, hasLength(2));
    });

    test('platformBrightness, textScaleFactor, alwaysUse24HourFormat', () {
      state.simulation = const DeviceSimulation(
        platformBrightness: ui.Brightness.dark,
        textScaleFactor: 1.3,
        alwaysUse24HourFormat: true,
      );
      expect(dispatcher.platformBrightness, ui.Brightness.dark);
      expect(dispatcher.textScaleFactor, 1.3);
      expect(dispatcher.alwaysUse24HourFormat, isTrue);
    });

    test('scaleFontSize is linear and atomic with textScaleFactor', () {
      state.simulation = const DeviceSimulation(textScaleFactor: 2.0);
      host.calls.clear();
      expect(dispatcher.textScaleFactor, 2.0);
      expect(dispatcher.scaleFontSize(10), 20);
      expect(host.calls, isNot(contains('scaleFontSize')));
    });

    test('accessibilityFeatures merges tri-state flags over the host', () {
      host.accessibilityFeaturesValue = StubAccessibilityFeatures(
        invertColors: true,
      );
      state.simulation = const DeviceSimulation(
        accessibility: SimulatedAccessibilityFeatures(boldText: true),
      );
      final ui.AccessibilityFeatures features =
          dispatcher.accessibilityFeatures;
      expect(features, isA<PreviewAccessibilityFeatures>());
      expect(features.boldText, isTrue);
      expect(features.invertColors, isTrue);
      expect(features.reduceMotion, isFalse);
    });

    test(
      'computePlatformResolvedLocale resolves against simulated locales',
      () {
        state.simulation = const DeviceSimulation(
          locales: <ui.Locale>[ui.Locale('fr', 'FR'), ui.Locale('en', 'US')],
        );
        host.calls.clear();
        final ui.Locale? resolved = dispatcher.computePlatformResolvedLocale(
          const <ui.Locale>[ui.Locale('en'), ui.Locale('fr')],
        );
        expect(resolved, const ui.Locale('fr'));
        expect(host.calls, isNot(contains('computePlatformResolvedLocale')));
        expect(
          dispatcher.computePlatformResolvedLocale(const <ui.Locale>[]),
          isNull,
        );
      },
    );
  });

  group('store-and-forward trampolines', () {
    test('setting a callback stores it and registers a trampoline', () {
      int calls = 0;
      void framework() => calls += 1;
      dispatcher.onMetricsChanged = framework;
      expect(dispatcher.onMetricsChanged, same(framework));
      expect(host.onMetricsChanged, isNotNull);
      expect(host.onMetricsChanged, isNot(same(framework)));
      host.onMetricsChanged!();
      expect(calls, 1);
    });

    test('metrics: forwards when not simulating metrics, swallows when '
        'simulating, always notifies the state hook', () {
      int frameworkCalls = 0;
      int hookCalls = 0;
      dispatcher.onMetricsChanged = () => frameworkCalls += 1;
      state.onHostMetricsChanged = () => hookCalls += 1;

      host.onMetricsChanged!();
      expect(frameworkCalls, 1);
      expect(hookCalls, 1);

      state.simulation = metricSimulation;
      host.onMetricsChanged!();
      expect(frameworkCalls, 1); // swallowed
      expect(hookCalls, 2); // hook always runs

      // Non-metric simulation does not swallow metrics notifications.
      state.simulation = const DeviceSimulation(textScaleFactor: 2.0);
      host.onMetricsChanged!();
      expect(frameworkCalls, 2);
    });

    test('textScaleFactor: swallow iff simulated', () {
      int calls = 0;
      dispatcher.onTextScaleFactorChanged = () => calls += 1;
      host.onTextScaleFactorChanged!();
      expect(calls, 1);
      state.simulation = const DeviceSimulation(textScaleFactor: 2.0);
      host.onTextScaleFactorChanged!();
      expect(calls, 1);
      state.simulation = metricSimulation; // no text scale override
      host.onTextScaleFactorChanged!();
      expect(calls, 2);
    });

    test('platformBrightness: swallow iff simulated', () {
      int calls = 0;
      dispatcher.onPlatformBrightnessChanged = () => calls += 1;
      host.onPlatformBrightnessChanged!();
      expect(calls, 1);
      state.simulation = const DeviceSimulation(
        platformBrightness: ui.Brightness.dark,
      );
      host.onPlatformBrightnessChanged!();
      expect(calls, 1);
    });

    test('locales: swallow iff simulated', () {
      int calls = 0;
      dispatcher.onLocaleChanged = () => calls += 1;
      host.onLocaleChanged!();
      expect(calls, 1);
      state.simulation = const DeviceSimulation(
        locales: <ui.Locale>[ui.Locale('fr')],
      );
      host.onLocaleChanged!();
      expect(calls, 1);
    });

    test('accessibility: ALWAYS forwards (tri-state merge stays live)', () {
      int calls = 0;
      dispatcher.onAccessibilityFeaturesChanged = () => calls += 1;
      host.onAccessibilityFeaturesChanged!();
      expect(calls, 1);
      state.simulation = const DeviceSimulation(
        accessibility: SimulatedAccessibilityFeatures(boldText: true),
      );
      host.onAccessibilityFeaturesChanged!();
      expect(calls, 2);
    });
  });

  group('pointer trampoline', () {
    ui.PointerDataPacket packetAt(double x, double y, {int? viewId}) =>
        ui.PointerDataPacket(
          data: <ui.PointerData>[
            ui.PointerData(
              viewId: viewId ?? hostView.viewId,
              physicalX: x,
              physicalY: y,
              change: ui.PointerChange.down,
            ),
          ],
        );

    test('forwards the identical packet object when not simulating', () {
      ui.PointerDataPacket? received;
      dispatcher.onPointerDataPacket = (ui.PointerDataPacket packet) =>
          received = packet;
      final ui.PointerDataPacket packet = packetAt(30, 60);
      host.onPointerDataPacket!(packet);
      expect(identical(received, packet), isTrue);
    });

    test('fast path: identity fit and equal ratios forward untouched', () {
      state.simulation = DeviceSimulation(
        screenSize: const ui.Size(800, 600),
        devicePixelRatio: hostView.devicePixelRatio,
      );
      state.fit = FitTransform.identity;
      ui.PointerDataPacket? received;
      dispatcher.onPointerDataPacket = (ui.PointerDataPacket packet) =>
          received = packet;
      final ui.PointerDataPacket packet = packetAt(30, 60);
      host.onPointerDataPacket!(packet);
      expect(identical(received, packet), isTrue);
    });

    test('rewrites positions into simulated physical space', () {
      state.simulation = metricSimulation;
      state.fit = const FitTransform(scale: 0.5, offset: ui.Offset(100, 50));
      ui.PointerDataPacket? received;
      dispatcher.onPointerDataPacket = (ui.PointerDataPacket packet) =>
          received = packet;
      // realPhysical (450, 300) → realLogical (150, 100) → simLogical
      // ((150-100)/0.5, (100-50)/0.5) = (100, 100) → simPhysical (200, 200).
      host.onPointerDataPacket!(packetAt(450, 300));
      final ui.PointerData datum = received!.data.single;
      expect(datum.physicalX, closeTo(200, 1e-9));
      expect(datum.physicalY, closeTo(200, 1e-9));
      expect(datum.viewId, hostView.viewId);
    });

    test('data for other views passes through untouched', () {
      state.simulation = metricSimulation;
      state.fit = const FitTransform(scale: 0.5, offset: ui.Offset.zero);
      ui.PointerDataPacket? received;
      dispatcher.onPointerDataPacket = (ui.PointerDataPacket packet) =>
          received = packet;
      final ui.PointerDataPacket packet = packetAt(450, 300, viewId: 99);
      host.onPointerDataPacket!(packet);
      expect(identical(received!.data.single, packet.data.single), isTrue);
    });

    test('debugReceiveHostPointerDataPacket feeds the trampoline', () {
      ui.PointerDataPacket? received;
      dispatcher.onPointerDataPacket = (ui.PointerDataPacket packet) =>
          received = packet;
      final ui.PointerDataPacket packet = packetAt(1, 2);
      dispatcher.debugReceiveHostPointerDataPacket(packet);
      expect(identical(received, packet), isTrue);
    });
  });
}

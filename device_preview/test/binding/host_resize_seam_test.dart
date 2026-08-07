// Covers the PRODUCTION host-resize path end to end across the wrapper
// dispatcher / controller seam, with no substitutes on either side:
//
//   engine fires host.onMetricsChanged
//     → wrapper trampoline (installed when the framework set its callback)
//       → state.onHostMetricsChanged → controller.handleHostMetricsChanged
//         → recomputeFit + re-triggered framework handleMetricsChanged
//
// DESIGN threat-matrix row "Real device changes lost while simulating": if
// the re-trigger or the fit recompute regressed, resizing the window while a
// device is simulated would leave the letterbox matrix stale — painted
// content and remapped pointer coordinates diverge.

import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_platform_dispatcher.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/controller/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  late PreviewState state;
  late FakePlatformDispatcher host;
  late PreviewPlatformDispatcher wrapper;
  late DevicePreviewControllerImpl controller;
  late List<String> handlerCalls;
  late int frameworkMetricsCallbacks;

  setUp(() {
    state = PreviewState();
    host = FakePlatformDispatcher();
    // Production composition: wrapper and controller share the same state,
    // exactly as DevicePreviewBindingMixin wires them.
    wrapper = PreviewPlatformDispatcher(host: host, state: state);
    handlerCalls = <String>[];
    controller = DevicePreviewControllerImpl(
      state: state,
      hostView: host.implicitView!,
      hostDispatcher: host,
      handleMetricsChanged: () => handlerCalls.add('metrics'),
      handleTextScaleFactorChanged: () => handlerCalls.add('textScale'),
      handlePlatformBrightnessChanged: () => handlerCalls.add('brightness'),
      handleLocaleChanged: () => handlerCalls.add('locale'),
      handleAccessibilityFeaturesChanged: () => handlerCalls.add('a11y'),
      applyTargetPlatformOverride: (TargetPlatform? _) async {},
    );
    // The framework registers its metrics callback on the wrapper (what the
    // binding does at init); this installs the trampoline on the host.
    frameworkMetricsCallbacks = 0;
    wrapper.onMetricsChanged = () => frameworkMetricsCallbacks++;
  });

  tearDown(() => controller.dispose());

  test('a host resize while simulating refreshes the fit and re-triggers '
      'the framework metrics handler', () async {
    await controller.apply(DevicePresets.iPhone16.resolve());
    handlerCalls.clear();
    frameworkMetricsCallbacks = 0;
    final FitTransform before = controller.fitTransform;
    expect(before, isNot(FitTransform.identity));

    // The desktop window shrinks: host logical 800x600 → 400x300.
    host.implicitView!.physicalSize = const ui.Size(1200, 900);
    host.onMetricsChanged!.call(); // as the engine would

    // The fit matrix followed the new host size…
    expect(controller.fitTransform, isNot(before));
    expect(controller.fitTransform.scale, lessThan(before.scale));
    // …the framework was re-notified through the controller (the trampoline
    // swallowed the host notification while simulating)…
    expect(handlerCalls, <String>['metrics']);
    // …and exactly once: not directly by the host firing.
    expect(frameworkMetricsCallbacks, 0);
  });

  test('without metric simulation the host notification passes through '
      'unswallowed', () async {
    await controller.apply(
      const DeviceSimulation(platformBrightness: ui.Brightness.dark),
    );
    handlerCalls.clear();
    frameworkMetricsCallbacks = 0;

    host.implicitView!.physicalSize = const ui.Size(1200, 900);
    host.onMetricsChanged!.call();

    // No metric simulation: the framework hears the host directly, and the
    // controller does not re-trigger.
    expect(frameworkMetricsCallbacks, 1);
    expect(handlerCalls, isEmpty);
    expect(controller.fitTransform, FitTransform.identity);
  });
}

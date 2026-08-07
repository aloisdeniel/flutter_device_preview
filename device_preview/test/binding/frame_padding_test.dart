// Pins the enable-time chrome configuration end to end: a padding latched
// with `latchConfiguration(padding: ...)` (what `DevicePreview.enable(
// padding: ...)` does) must reach the controller and shrink the area the
// simulated device is fitted into.
//
// This lives in its own file because a latched configuration is consumed by
// the one binding a process can construct.

import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

void main() {
  DevicePreviewBindingMixin.latchConfiguration(
    enabled: true,
    padding: const EdgeInsets.all(50),
  );
  final TestDevicePreviewBinding binding =
      TestDevicePreviewBinding.ensureInitializedWithoutLatching();

  testWidgets('the latched padding shrinks the fit target area', (
    WidgetTester tester,
  ) async {
    expect(binding.framePadding, const EdgeInsets.all(50));
    addTearDown(() => binding.devicePreview!.reset());

    // The test window is 800x600 logical with no host safe areas, so the
    // available area is 700x500. A 1400x1000 simulated screen fits at 0.5,
    // flush against the padded rect on all sides.
    await binding.devicePreview!.apply(
      const DeviceSimulation(screenSize: ui.Size(1400, 1000)),
    );
    final FitTransform fit = binding.devicePreview!.fitTransform;
    expect(fit.scale, closeTo(0.5, 1e-12));
    expect(fit.offset.dx, closeTo(50, 1e-12));
    expect(fit.offset.dy, closeTo(50, 1e-12));
  });
}

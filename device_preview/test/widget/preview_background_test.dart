import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/widgets/preview_background.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../binding/fakes.dart';

void main() {
  const Color kBackground = Color(0xFF123456);

  /// A harness around [PreviewBackground] with a live simulation and fit.
  ///
  /// The fake host view is 800x600 logical (2400x1800 at 3.0x).
  (ValueNotifier<DeviceSimulation?>, ValueNotifier<FitTransform>, Widget)
  buildHarness() {
    final ValueNotifier<DeviceSimulation?> simulation =
        ValueNotifier<DeviceSimulation?>(
          const DeviceSimulation(screenSize: ui.Size(200, 400)),
        );
    final ValueNotifier<FitTransform> fit = ValueNotifier<FitTransform>(
      const FitTransform(scale: 0.5, offset: ui.Offset(100, 50)),
    );
    final Widget widget = PreviewBackground(
      decoration: const BoxDecoration(color: kBackground),
      simulation: simulation,
      fit: fit,
      hostView: FakeFlutterView(),
      child: const SizedBox.expand(),
    );
    return (simulation, fit, widget);
  }

  testWidgets('paints the decoration over the real window, in simulated '
      'coordinates', (WidgetTester tester) async {
    final (_, _, Widget widget) = buildHarness();
    await tester.pumpWidget(widget);

    // The window corners inverse-mapped through the fit: (0, 0) →
    // (-200, -100) and (800, 600) → (1400, 1100).
    expect(
      tester.renderObject(find.byType(PreviewBackground)),
      paints
        ..rect(
          rect: const Rect.fromLTRB(-200, -100, 1400, 1100),
          color: kBackground,
        ),
    );
  });

  testWidgets('paints nothing while no metric simulation is active', (
    WidgetTester tester,
  ) async {
    final (ValueNotifier<DeviceSimulation?> simulation, _, Widget widget) =
        buildHarness();
    simulation.value = null;
    await tester.pumpWidget(widget);

    expect(
      tester.renderObject(find.byType(PreviewBackground)),
      isNot(paints..rect(color: kBackground)),
    );
  });

  testWidgets('repaints when the fit changes (the letterbox moved)', (
    WidgetTester tester,
  ) async {
    final (_, ValueNotifier<FitTransform> fit, Widget widget) = buildHarness();
    await tester.pumpWidget(widget);

    fit.value = const FitTransform(scale: 0.25, offset: ui.Offset.zero);
    await tester.pump();

    expect(
      tester.renderObject(find.byType(PreviewBackground)),
      paints..rect(rect: const Rect.fromLTRB(0, 0, 3200, 2400)),
    );
  });
}

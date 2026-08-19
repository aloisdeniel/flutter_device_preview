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

  testWidgets('paints the decoration over the real window, in real '
      'coordinates', (WidgetTester tester) async {
    final (_, _, Widget widget) = buildHarness();
    await tester.pumpWidget(widget);

    // The fit is undone on the canvas — the window origin (0, 0) maps to
    // (-200, -100) in simulated coordinates, and 1 real px is 2 simulated px
    // — so the decoration paints the 800x600 window at its real size.
    expect(
      tester.renderObject(find.byType(PreviewBackground)),
      paints
        ..save()
        ..translate(x: -200, y: -100)
        ..scale(x: 2, y: 2)
        ..rect(rect: const Rect.fromLTRB(0, 0, 800, 600), color: kBackground)
        ..restore(),
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
      paints
        ..translate(x: 0, y: 0)
        ..scale(x: 4, y: 4)
        ..rect(rect: const Rect.fromLTRB(0, 0, 800, 600)),
    );
  });
}

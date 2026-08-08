// Smoke coverage for the device-lab showcase (`lib/showcase.dart`): the
// screen builds, the clock ticker is cleaned up, the layout splits around a
// vertical hinge, and an RTL locale flips the app and translates the
// greeting.

import 'dart:ui' as ui;

import 'package:device_preview_example/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('builds, ticks, and disposes its clock timer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(DeviceLabPage), findsOneWidget);
    expect(find.text('Hello!'), findsOneWidget);
    // Dispose the app; a leaked periodic timer would fail the test here.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('splits into two panes around a vertical hinge', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const ui.Size(1000, 800);
    tester.view.devicePixelRatio = 1;
    tester.view.displayFeatures = <ui.DisplayFeature>[
      const ui.DisplayFeature(
        bounds: ui.Rect.fromLTRB(490, 0, 510, 800),
        type: ui.DisplayFeatureType.hinge,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ];
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ShowcaseApp());
    expect(find.byType(ListView), findsNWidgets(2));

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('an RTL locale flips the app and the greeting follows', (
    WidgetTester tester,
  ) async {
    tester.platformDispatcher.localesTestValue = <Locale>[
      const Locale('ar', 'SA'),
    ];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pump();
    expect(find.text('مرحبًا'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(DeviceLabPage))),
      TextDirection.rtl,
    );

    await tester.pumpWidget(const SizedBox());
  });
}

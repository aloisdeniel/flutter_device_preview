import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DotGridDecoration', () {
    testWidgets('paints the fill and a dot grid anchored at the top-left', (
      WidgetTester tester,
    ) async {
      const DotGridDecoration decoration = DotGridDecoration(
        color: Color(0xFF111111),
        dotColor: Color(0xFF222222),
        spacing: 10,
        dotRadius: 1.5,
      );
      await tester.pumpWidget(
        const Center(
          child: DecoratedBox(
            decoration: decoration,
            child: SizedBox(width: 100, height: 50),
          ),
        ),
      );

      expect(
        tester.renderObject(find.byType(DecoratedBox)),
        paints
          ..rect(
            rect: const Rect.fromLTWH(0, 0, 100, 50),
            color: const Color(0xFF111111),
          )
          ..something((Symbol method, List<dynamic> arguments) {
            if (method != #drawRawPoints) {
              return false;
            }
            final Float32List points = arguments[1] as Float32List;
            final Paint paint = arguments[2] as Paint;
            // 10 columns x 5 rows, centred in their cells.
            expect(points.length, 10 * 5 * 2);
            expect(points.sublist(0, 4), <double>[5, 5, 15, 5]);
            expect(points.sublist(points.length - 2), <double>[95, 45]);
            expect(paint.color, isSameColorAs(const Color(0xFF222222)));
            expect(paint.strokeWidth, 3);
            expect(paint.strokeCap, ui.StrokeCap.round);
            return true;
          }),
      );
    });

    testWidgets('paints no dots with a zero radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const DecoratedBox(decoration: DotGridDecoration(dotRadius: 0)),
      );

      expect(
        tester.renderObject(find.byType(DecoratedBox)),
        isNot(
          paints..something(
            (Symbol method, List<dynamic> _) => method == #drawRawPoints,
          ),
        ),
      );
    });

    test('the defaults are a dark grey with slightly lighter dots', () {
      const DotGridDecoration decoration = DotGridDecoration();
      expect(decoration.color, const Color(0xFF232327));
      expect(decoration.dotColor, const Color(0xFF3A3A40));
      expect(decoration.spacing, 24);
      expect(decoration.dotRadius, 1);
    });

    test('equality is by value', () {
      expect(const DotGridDecoration(), const DotGridDecoration());
      expect(
        const DotGridDecoration(),
        isNot(const DotGridDecoration(spacing: 12)),
      );
    });
  });
}

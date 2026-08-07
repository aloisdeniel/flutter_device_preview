import 'dart:ui' as ui;

import 'package:device_preview/svg.dart';
import 'package:flutter_test/flutter_test.dart';

/// Approximate rectangle comparison — béziers and arcs are flattened by Skia
/// with a small tolerance.
Matcher rectCloseTo(ui.Rect expected, {double epsilon = 0.5}) =>
    predicate<ui.Rect>(
      (ui.Rect actual) =>
          (actual.left - expected.left).abs() < epsilon &&
          (actual.top - expected.top).abs() < epsilon &&
          (actual.right - expected.right).abs() < epsilon &&
          (actual.bottom - expected.bottom).abs() < epsilon,
      'is within $epsilon of $expected',
    );

void main() {
  group('move / line', () {
    test('absolute moveto and lineto', () {
      final ui.Path path = parseSvgPathData('M 10,20 L 30,50 Z');
      expect(path.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(10, 20, 30, 50)));
      expect(path.contains(const ui.Offset(-5, -5)), isFalse);
    });

    test('relative commands accumulate from the current point', () {
      final ui.Path path = parseSvgPathData('m 10,10 l 10,0 l 0,10 l -10,0 z');
      expect(
        path.getBounds(),
        rectCloseTo(const ui.Rect.fromLTRB(10, 10, 20, 20)),
      );
    });

    test('coordinate pairs after a moveto are implicit linetos', () {
      final ui.Path path = parseSvgPathData('M0,0 10,0 10,10 0,10Z');
      expect(path.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(0, 0, 10, 10)));
    });

    test('horizontal and vertical linetos, absolute and relative', () {
      final ui.Path path = parseSvgPathData('M5,5 H15 V25 h-10 v-20 Z');
      expect(path.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(5, 5, 15, 25)));
    });

    test('a closed subpath returns the pen to the subpath start', () {
      // The second subpath's relative moveto starts from (0, 0), not (10, 10).
      final ui.Path path = parseSvgPathData('M0,0 L10,10 Z m 20,20 l 5,0 l 0,5 z');
      expect(
        path.getBounds(),
        rectCloseTo(const ui.Rect.fromLTRB(0, 0, 25, 25)),
      );
    });
  });

  group('curves', () {
    test('cubic bezier', () {
      final ui.Path path = parseSvgPathData('M0,0 C0,50 100,50 100,0');
      final ui.Rect bounds = path.getBounds();
      expect(bounds.left, closeTo(0, 0.5));
      expect(bounds.right, closeTo(100, 0.5));
      expect(bounds.bottom, greaterThan(30));
    });

    test('smooth cubic reflects the previous control point', () {
      final ui.Path reflected = parseSvgPathData(
        'M0,0 C0,40 40,40 40,0 S80,-40 80,0',
      );
      final ui.Path explicit = parseSvgPathData(
        'M0,0 C0,40 40,40 40,0 C40,-40 80,-40 80,0',
      );
      expect(reflected.getBounds(), rectCloseTo(explicit.getBounds()));
    });

    test('a smooth cubic without a preceding cubic uses the current point', () {
      final ui.Path smooth = parseSvgPathData('M0,0 S40,40 80,0');
      final ui.Path explicit = parseSvgPathData('M0,0 C0,0 40,40 80,0');
      expect(smooth.getBounds(), rectCloseTo(explicit.getBounds()));
    });

    test('quadratic and smooth quadratic', () {
      final ui.Path reflected = parseSvgPathData('M0,0 Q20,40 40,0 T80,0');
      final ui.Path explicit = parseSvgPathData(
        'M0,0 Q20,40 40,0 Q60,-40 80,0',
      );
      expect(reflected.getBounds(), rectCloseTo(explicit.getBounds()));
    });
  });

  group('arcs', () {
    test('a rounded rectangle spans its declared box', () {
      final ui.Path path = parseSvgPathData(
        'M 10,0 H 90 A 10,10 0 0 1 100,10 V 90 A 10,10 0 0 1 90,100 '
        'H 10 A 10,10 0 0 1 0,90 V 10 A 10,10 0 0 1 10,0 Z',
      );
      expect(path.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(0, 0, 100, 100)));
      // The corners are cut: the box corner is outside the rounded shape.
      expect(path.contains(const ui.Offset(1, 1)), isFalse);
      expect(path.contains(const ui.Offset(50, 50)), isTrue);
    });

    test('flags may be written without separators', () {
      final ui.Path compact = parseSvgPathData('M0,0 a5 5 0 0150 5');
      final ui.Path spaced = parseSvgPathData('M0,0 a5 5 0 0 1 50 5');
      expect(compact.getBounds(), rectCloseTo(spaced.getBounds()));
    });

    test('a zero radius degenerates to a line', () {
      final ui.Path arc = parseSvgPathData('M0,0 A0,0 0 0 1 50,50');
      expect(arc.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(0, 0, 50, 50)));
    });

    test('the large-arc flag selects the other sweep', () {
      final ui.Path small = parseSvgPathData('M0,0 A20,20 0 0 1 20,20');
      final ui.Path large = parseSvgPathData('M0,0 A20,20 0 1 1 20,20');
      expect(large.getBounds().height, greaterThan(small.getBounds().height));
    });
  });

  group('numbers', () {
    test('exponents and implicit signs', () {
      final ui.Path path = parseSvgPathData('M0,0L1e2,5e1L10-5');
      expect(path.getBounds(), rectCloseTo(const ui.Rect.fromLTRB(0, -5, 100, 50)));
    });

    test('leading-dot decimals and repeated decimals', () {
      final ui.Path path = parseSvgPathData('M.5.5L2.5 2.5');
      expect(
        path.getBounds(),
        rectCloseTo(const ui.Rect.fromLTRB(0.5, 0.5, 2.5, 2.5)),
      );
    });
  });

  test('the fill type is applied', () {
    final ui.Path path = parseSvgPathData(
      'M0,0 H100 V100 H0 Z M25,25 H75 V75 H25 Z',
      fillType: ui.PathFillType.evenOdd,
    );
    expect(path.fillType, ui.PathFillType.evenOdd);
    // The inner square is a hole under the even-odd rule.
    expect(path.contains(const ui.Offset(50, 50)), isFalse);
    expect(path.contains(const ui.Offset(10, 50)), isTrue);
  });

  group('errors', () {
    test('data not starting with a command', () {
      expect(() => parseSvgPathData('10,20'), throwsFormatException);
    });

    test('unknown command', () {
      expect(() => parseSvgPathData('M0,0 X10'), throwsFormatException);
    });

    test('arguments after a close command', () {
      expect(() => parseSvgPathData('M0,0 Z 10,10'), throwsFormatException);
    });

    test('missing coordinate', () {
      expect(() => parseSvgPathData('M0,0 L10'), throwsFormatException);
    });

    test('invalid arc flag', () {
      expect(
        () => parseSvgPathData('M0,0 A5,5 0 2 1 10,10'),
        throwsFormatException,
      );
    });

    test('empty data is an empty path', () {
      expect(parseSvgPathData('   ').getBounds(), ui.Rect.zero);
    });
  });
}

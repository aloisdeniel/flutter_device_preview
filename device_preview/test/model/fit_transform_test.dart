import 'dart:math' as math;
import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FitTransform.compute', () {
    test('simulated smaller than real renders 1:1 centered (clamp <= 1)', () {
      final fit = FitTransform.compute(
        realLogicalSize: const Size(1000, 800),
        simulatedLogicalSize: const Size(400, 600),
      );
      expect(fit.scale, 1.0);
      expect(fit.offset, const Offset((1000 - 400) / 2, (800 - 600) / 2));
    });

    test('simulated larger than real scales down, width-constrained', () {
      final fit = FitTransform.compute(
        realLogicalSize: const Size(400, 900),
        simulatedLogicalSize: const Size(800, 600),
      );
      expect(fit.scale, 0.5); // min(400/800 = 0.5, 900/600 = 1.5)
      expect(fit.offset.dx, 0.0);
      expect(fit.offset.dy, (900 - 600 * 0.5) / 2);
    });

    test('simulated larger than real scales down, height-constrained', () {
      final fit = FitTransform.compute(
        realLogicalSize: const Size(900, 400),
        simulatedLogicalSize: const Size(600, 800),
      );
      expect(fit.scale, 0.5); // min(900/600 = 1.5, 400/800 = 0.5)
      expect(fit.offset.dx, (900 - 600 * 0.5) / 2);
      expect(fit.offset.dy, 0.0);
    });

    test('content bounds reserve room for the device body', () {
      // A 400x600 screen inside a 420x620 body starting at (-10, -10).
      const content = Rect.fromLTRB(-10, -10, 410, 610);
      final fit = FitTransform.compute(
        realLogicalSize: const Size(420, 620),
        simulatedLogicalSize: const Size(400, 600),
        contentBounds: content,
      );
      // The whole body fits exactly, so no down-scaling is needed...
      expect(fit.scale, 1.0);
      // ...and the origin moves to leave the body's top-left inside.
      expect(fit.offset, const Offset(10, 10));
      // The body's corners land exactly on the window's corners.
      expect(fit.toRealLogical(content.topLeft), Offset.zero);
      expect(fit.toRealLogical(content.bottomRight), const Offset(420, 620));
    });

    test('content bounds drive the scale, not the screen size', () {
      const content = Rect.fromLTRB(-100, -100, 500, 700);
      final fit = FitTransform.compute(
        realLogicalSize: const Size(300, 400),
        simulatedLogicalSize: const Size(400, 600),
        contentBounds: content,
      );
      // min(300/600, 400/800) = 0.5 — the screen alone would have fit better.
      expect(fit.scale, 0.5);
      expect(fit.toRealLogical(content.topLeft), Offset.zero);
      expect(fit.toRealLogical(content.bottomRight), const Offset(300, 400));
    });

    test('degenerate content bounds fall back to the screen rectangle', () {
      final fit = FitTransform.compute(
        realLogicalSize: const Size(1000, 800),
        simulatedLogicalSize: const Size(400, 600),
        contentBounds: Rect.zero,
      );
      expect(fit.scale, 1.0);
      expect(fit.offset, const Offset((1000 - 400) / 2, (800 - 600) / 2));
    });

    test('same sizes yield identity', () {
      final fit = FitTransform.compute(
        realLogicalSize: const Size(402, 874),
        simulatedLogicalSize: const Size(402, 874),
      );
      expect(fit, FitTransform.identity);
    });

    test('exact fit with letterbox on one axis only', () {
      // iPhone 16 Pro simulated on a 800x600 desktop window.
      final fit = FitTransform.compute(
        realLogicalSize: const Size(800, 600),
        simulatedLogicalSize: const Size(402, 874),
      );
      expect(fit.scale, closeTo(600 / 874, 1e-12));
      expect(fit.offset.dy, closeTo(0, 1e-12));
      expect(fit.offset.dx, closeTo((800 - 402 * 600 / 874) / 2, 1e-12));
    });

    group('degenerate inputs yield identity', () {
      const good = Size(400, 800);
      final degenerates = <Size>[
        Size.zero,
        const Size(0, 800),
        const Size(400, 0),
        const Size(-400, 800),
        const Size(400, -800),
        const Size(double.nan, 800),
        const Size(400, double.infinity),
      ];

      for (final bad in degenerates) {
        test('real = $bad', () {
          expect(
            FitTransform.compute(
              realLogicalSize: bad,
              simulatedLogicalSize: good,
            ),
            FitTransform.identity,
          );
        });
        test('simulated = $bad', () {
          expect(
            FitTransform.compute(
              realLogicalSize: good,
              simulatedLogicalSize: bad,
            ),
            FitTransform.identity,
          );
        });
      }
    });
  });

  group('coordinate mapping', () {
    test('toRealLogical applies scale then offset', () {
      const fit = FitTransform(scale: 0.5, offset: Offset(10, 20));
      expect(fit.toRealLogical(const Offset(100, 40)), const Offset(60, 40));
    });

    test('toSimulatedLogical subtracts offset then unscales', () {
      const fit = FitTransform(scale: 0.5, offset: Offset(10, 20));
      expect(
        fit.toSimulatedLogical(const Offset(60, 40)),
        const Offset(100, 40),
      );
    });

    test('identity maps points onto themselves', () {
      const point = Offset(123.4, 567.8);
      expect(FitTransform.identity.toRealLogical(point), point);
      expect(FitTransform.identity.toSimulatedLogical(point), point);
    });

    test('round-trip property: toReal ∘ toSim and toSim ∘ toReal ≈ id', () {
      final random = math.Random(42);
      for (var i = 0; i < 200; i++) {
        final real = Size(
          random.nextDouble() * 2000 + 1,
          random.nextDouble() * 2000 + 1,
        );
        final sim = Size(
          random.nextDouble() * 2000 + 1,
          random.nextDouble() * 2000 + 1,
        );
        final fit = FitTransform.compute(
          realLogicalSize: real,
          simulatedLogicalSize: sim,
        );
        final point = Offset(
          random.nextDouble() * 3000 - 500,
          random.nextDouble() * 3000 - 500,
        );
        final thereAndBack = fit.toSimulatedLogical(fit.toRealLogical(point));
        expect(thereAndBack.dx, closeTo(point.dx, 1e-6));
        expect(thereAndBack.dy, closeTo(point.dy, 1e-6));
        final backAndThere = fit.toRealLogical(fit.toSimulatedLogical(point));
        expect(backAndThere.dx, closeTo(point.dx, 1e-6));
        expect(backAndThere.dy, closeTo(point.dy, 1e-6));
      }
    });
  });

  group('value semantics', () {
    test('== and hashCode', () {
      const a = FitTransform(scale: 0.5, offset: Offset(1, 2));
      const b = FitTransform(scale: 0.5, offset: Offset(1, 2));
      const c = FitTransform(scale: 0.6, offset: Offset(1, 2));
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });

    test('toJson matches the state-shape fit object', () {
      const fit = FitTransform(scale: 0.82, offset: Offset(12, 0));
      expect(fit.toJson(), <String, Object?>{
        'scale': 0.82,
        'offset': <String, Object?>{'x': 12.0, 'y': 0.0},
      });
    });

    test('toString mentions scale and offset', () {
      expect(FitTransform.identity.toString(), contains('scale'));
    });
  });
}

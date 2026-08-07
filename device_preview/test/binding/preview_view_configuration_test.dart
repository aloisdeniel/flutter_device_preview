import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/binding/preview_view_configuration.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PreviewViewConfiguration configuration({
    Size simulatedLogicalSize = const Size(200, 400),
    double simulatedDevicePixelRatio = 2.0,
    double realDevicePixelRatio = 3.0,
    Size realPhysicalSize = const Size(2400, 1800),
    FitTransform fit = const FitTransform(
      scale: 0.5,
      offset: ui.Offset(100, 50),
    ),
  }) => PreviewViewConfiguration(
    simulatedLogicalSize: simulatedLogicalSize,
    simulatedDevicePixelRatio: simulatedDevicePixelRatio,
    realDevicePixelRatio: realDevicePixelRatio,
    realPhysicalSize: realPhysicalSize,
    fit: fit,
  );

  test('logicalConstraints are tight at the simulated logical size', () {
    expect(
      configuration().logicalConstraints,
      BoxConstraints.tight(const Size(200, 400)),
    );
    expect(configuration().devicePixelRatio, 2.0);
  });

  test(
    'toMatrix is translate(offset × realDPR) · scale(realDPR × fit.scale)',
    () {
      final Matrix4 matrix = configuration().toMatrix();
      final Matrix4 expected = Matrix4.translationValues(
        100 * 3.0,
        50 * 3.0,
        0,
      ).multiplied(Matrix4.diagonal3Values(3.0 * 0.5, 3.0 * 0.5, 1));
      expect(matrix, expected);

      // Point checks: simulated-logical origin lands at the letterbox origin in
      // real physical pixels; a point scales by realDPR × fit.scale.
      final ui.Offset origin = MatrixUtils.transformPoint(
        matrix,
        ui.Offset.zero,
      );
      expect(origin, const ui.Offset(300, 150));
      final ui.Offset point = MatrixUtils.transformPoint(
        matrix,
        const ui.Offset(10, 20),
      );
      expect(point, const ui.Offset(300 + 10 * 1.5, 150 + 20 * 1.5));
    },
  );

  test('identity fit degenerates to a pure realDPR scale', () {
    final Matrix4 matrix = configuration(fit: FitTransform.identity).toMatrix();
    expect(matrix, Matrix4.diagonal3Values(3, 3, 1));
  });

  group('shouldUpdateMatrix', () {
    test('false for an equivalent configuration', () {
      expect(configuration().shouldUpdateMatrix(configuration()), isFalse);
    });

    test('true when only the fit changes', () {
      final PreviewViewConfiguration a = configuration();
      final PreviewViewConfiguration b = configuration(
        fit: const FitTransform(scale: 0.4, offset: ui.Offset(100, 50)),
      );
      expect(b.shouldUpdateMatrix(a), isTrue);
    });

    test('true when only the offset changes', () {
      final PreviewViewConfiguration a = configuration();
      final PreviewViewConfiguration b = configuration(
        fit: const FitTransform(scale: 0.5, offset: ui.Offset(0, 50)),
      );
      expect(b.shouldUpdateMatrix(a), isTrue);
    });

    test('true against a different ViewConfiguration runtimeType', () {
      expect(
        configuration().shouldUpdateMatrix(const ViewConfiguration()),
        isTrue,
      );
    });
  });

  test('toPhysicalSize returns the REAL physical size', () {
    expect(
      configuration().toPhysicalSize(const Size(200, 400)),
      const Size(2400, 1800),
    );
  });

  test('toPhysicalSize asserts on a size that is not the simulated size', () {
    expect(
      () => configuration().toPhysicalSize(const Size(300, 400)),
      throwsAssertionError,
    );
  });

  test('equality includes the fit and real-surface fields', () {
    expect(configuration(), configuration());
    expect(configuration().hashCode, configuration().hashCode);
    expect(configuration(), isNot(configuration(fit: FitTransform.identity)));
    expect(configuration(), isNot(configuration(realDevicePixelRatio: 2.0)));
    // Not equal to a base configuration with the same base fields.
    final PreviewViewConfiguration preview = configuration();
    final ViewConfiguration base = ViewConfiguration(
      logicalConstraints: preview.logicalConstraints,
      physicalConstraints: preview.physicalConstraints,
      devicePixelRatio: preview.devicePixelRatio,
    );
    expect(preview == base, isFalse);
    expect(base == preview, isFalse);
  });
}

import 'package:flutter/rendering.dart';

import '../model/fit_transform.dart';

/// A [ViewConfiguration] that lays the root out at the simulated logical
/// size and paints it scaled-to-fit onto the real surface.
///
/// * [logicalConstraints] are tight at the simulated logical size, so the
///   root layout is exactly the simulated screen.
/// * [toMatrix] returns `translate(offset × realDPR) · scale(realDPR ×
///   fit.scale)`, which becomes the root `TransformLayer` and folds into
///   `applyPaintTransform`, keeping painting, `localToGlobal`, and semantics
///   geometry consistent for free.
/// * [toPhysicalSize] returns the **real** physical size: `compositeFrame`
///   passes its result to `FlutterView.render`, and rendering with a
///   simulated physical size is undefined behavior on the real surface.
/// * [shouldUpdateMatrix] compares full matrices (the base class compares
///   only the device pixel ratio, which is insufficient here).
class PreviewViewConfiguration extends ViewConfiguration {
  /// Creates a scale-to-fit view configuration.
  PreviewViewConfiguration({
    required this.simulatedLogicalSize,
    required double simulatedDevicePixelRatio,
    required this.realDevicePixelRatio,
    required this.realPhysicalSize,
    required this.fit,
  }) : super(
         logicalConstraints: BoxConstraints.tight(simulatedLogicalSize),
         physicalConstraints: BoxConstraints.tight(realPhysicalSize),
         devicePixelRatio: simulatedDevicePixelRatio,
       );

  /// The simulated logical screen size.
  final Size simulatedLogicalSize;

  /// The real device pixel ratio of the host surface.
  final double realDevicePixelRatio;

  /// The real physical size of the host surface, in device pixels.
  final Size realPhysicalSize;

  /// The scale-to-fit mapping from simulated logical to real logical space.
  final FitTransform fit;

  @override
  Matrix4 toMatrix() {
    final double scale = realDevicePixelRatio * fit.scale;
    return Matrix4.diagonal3Values(scale, scale, 1)..setTranslationRaw(
      fit.offset.dx * realDevicePixelRatio,
      fit.offset.dy * realDevicePixelRatio,
      0,
    );
  }

  @override
  bool shouldUpdateMatrix(ViewConfiguration oldConfiguration) {
    if (oldConfiguration.runtimeType != runtimeType) {
      return true;
    }
    return toMatrix() != oldConfiguration.toMatrix();
  }

  @override
  Size toPhysicalSize(Size logicalSize) {
    assert(
      (logicalSize.width - simulatedLogicalSize.width).abs() < 1e-6 &&
          (logicalSize.height - simulatedLogicalSize.height).abs() < 1e-6,
      'PreviewViewConfiguration.toPhysicalSize was given $logicalSize, but '
      'the root should have been laid out at the simulated logical size '
      '$simulatedLogicalSize.',
    );
    return realPhysicalSize;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PreviewViewConfiguration &&
        other.simulatedLogicalSize == simulatedLogicalSize &&
        other.devicePixelRatio == devicePixelRatio &&
        other.realDevicePixelRatio == realDevicePixelRatio &&
        other.realPhysicalSize == realPhysicalSize &&
        other.fit == fit;
  }

  @override
  int get hashCode => Object.hash(
    simulatedLogicalSize,
    devicePixelRatio,
    realDevicePixelRatio,
    realPhysicalSize,
    fit,
  );

  @override
  String toString() =>
      'PreviewViewConfiguration($simulatedLogicalSize at '
      '${devicePixelRatio}x, fit: $fit, real: $realPhysicalSize at '
      '${realDevicePixelRatio}x)';
}

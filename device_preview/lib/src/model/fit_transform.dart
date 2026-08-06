import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

/// The scale-to-fit mapping between the simulated logical coordinate space
/// and the real logical coordinate space.
///
/// A simulated screen larger than the host is scaled down uniformly to fit;
/// a smaller one renders 1:1 ([scale] is clamped to at most `1.0` — never
/// upscaled). The simulated content is centered, producing a letterbox whose
/// origin is [offset].
@immutable
class FitTransform {
  /// Creates a fit transform from raw values.
  const FitTransform({required this.scale, required this.offset});

  /// The identity mapping: no scaling, no letterbox.
  static const FitTransform identity = FitTransform(
    scale: 1,
    offset: ui.Offset.zero,
  );

  /// Computes the fit of [simulatedLogicalSize] inside [realLogicalSize]:
  ///
  /// ```
  /// scale  = min(real.w / sim.w, real.h / sim.h).clamp(0, 1)
  /// offset = (real − sim × scale) / 2
  /// ```
  ///
  /// Degenerate inputs (non-finite, zero, or negative dimensions on either
  /// size) yield [identity] so downstream math stays safe.
  factory FitTransform.compute({
    required ui.Size realLogicalSize,
    required ui.Size simulatedLogicalSize,
  }) {
    if (!_isValid(realLogicalSize) || !_isValid(simulatedLogicalSize)) {
      return identity;
    }
    final double scale = math
        .min(
          realLogicalSize.width / simulatedLogicalSize.width,
          realLogicalSize.height / simulatedLogicalSize.height,
        )
        .clamp(0.0, 1.0);
    final ui.Offset offset = ui.Offset(
      (realLogicalSize.width - simulatedLogicalSize.width * scale) / 2,
      (realLogicalSize.height - simulatedLogicalSize.height * scale) / 2,
    );
    return FitTransform(scale: scale, offset: offset);
  }

  static bool _isValid(ui.Size size) =>
      size.width.isFinite &&
      size.height.isFinite &&
      size.width > 0 &&
      size.height > 0;

  /// Uniform scale from simulated-logical to real-logical space (≤ 1.0).
  final double scale;

  /// The letterbox origin (top-left of the simulated content), in real
  /// logical pixels.
  final ui.Offset offset;

  /// Maps a point from simulated-logical space to real-logical space.
  ui.Offset toRealLogical(ui.Offset simulatedLogical) =>
      simulatedLogical * scale + offset;

  /// Maps a point from real-logical space to simulated-logical space.
  ///
  /// The inverse of [toRealLogical].
  ui.Offset toSimulatedLogical(ui.Offset realLogical) =>
      (realLogical - offset) / scale;

  /// Encodes this transform as the `fit` object of the service extension
  /// state shape.
  Map<String, Object?> toJson() => <String, Object?>{
    'scale': scale,
    'offset': <String, Object?>{'x': offset.dx, 'y': offset.dy},
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FitTransform &&
        other.scale == scale &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(scale, offset);

  @override
  String toString() => 'FitTransform(scale: $scale, offset: $offset)';
}

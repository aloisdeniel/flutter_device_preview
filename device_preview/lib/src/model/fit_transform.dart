import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show EdgeInsets;

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
  /// available = (0,0 & real) deflated by realInsets
  /// scale  = min(available.w / content.w, available.h / content.h).clamp(0, 1)
  /// offset = available.topLeft
  ///        + (available − content × scale) / 2 − content.topLeft × scale
  /// ```
  ///
  /// [contentBounds] is what must stay visible, in simulated logical
  /// coordinates; it defaults to the screen rectangle
  /// (`Offset.zero & simulatedLogicalSize`). A device frame extends past the
  /// screen — usually into negative coordinates — so passing its bounds is
  /// what keeps the whole device body inside the window. [offset] stays the
  /// position of the simulated origin either way, so pointer remapping and
  /// the root paint matrix are unaffected.
  ///
  /// [realInsets] is the strip of the real window reserved around the
  /// content, in real logical pixels — the configured frame padding plus the
  /// host's own safe areas. The content is scaled to fit and centered inside
  /// the deflated rectangle instead of the full window. Insets that leave no
  /// room (or are non-finite) are ignored rather than collapsing the fit.
  ///
  /// Degenerate inputs (non-finite, zero, or negative dimensions on either
  /// size) yield [identity] so downstream math stays safe.
  factory FitTransform.compute({
    required ui.Size realLogicalSize,
    required ui.Size simulatedLogicalSize,
    ui.Rect? contentBounds,
    EdgeInsets realInsets = EdgeInsets.zero,
  }) {
    if (!_isValid(realLogicalSize) || !_isValid(simulatedLogicalSize)) {
      return identity;
    }
    ui.Rect content = contentBounds ?? (ui.Offset.zero & simulatedLogicalSize);
    if (!_isValid(content.size)) {
      content = ui.Offset.zero & simulatedLogicalSize;
    }
    ui.Rect available = realInsets.deflateRect(
      ui.Offset.zero & realLogicalSize,
    );
    if (!_isValid(available.size)) {
      available = ui.Offset.zero & realLogicalSize;
    }
    final double scale = math
        .min(
          available.width / content.width,
          available.height / content.height,
        )
        .clamp(0.0, 1.0);
    final ui.Offset offset = ui.Offset(
      available.left +
          (available.width - content.width * scale) / 2 -
          content.left * scale,
      available.top +
          (available.height - content.height * scale) / 2 -
          content.top * scale,
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

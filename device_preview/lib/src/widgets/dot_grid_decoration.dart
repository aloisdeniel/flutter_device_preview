import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// A solid [color] under a regular grid of small dots — the default
/// background painted around the simulated device.
///
/// A dark grey with slightly lighter dots keeps a dark device body readable
/// against the letterbox, where a plain black background would swallow it.
/// The grid is anchored at the top-left corner of the painted rectangle.
///
/// The binding paints the background in *real* logical pixels, so [spacing]
/// and [dotRadius] keep the same size on screen whatever the simulated
/// device or the fit scale.
@immutable
class DotGridDecoration extends Decoration {
  /// Creates a dot-grid decoration; the defaults are the ones the binding
  /// uses when `DevicePreview.enable` is given no `backgroundDecoration`.
  const DotGridDecoration({
    this.color = const ui.Color(0xFF232327),
    this.dotColor = const ui.Color(0xFF3A3A40),
    this.spacing = 24,
    this.dotRadius = 1,
  }) : assert(spacing > 0),
       assert(dotRadius >= 0);

  /// The fill behind the dots.
  final ui.Color color;

  /// The color of the dots.
  final ui.Color dotColor;

  /// The distance between two neighbouring dots, in logical pixels.
  final double spacing;

  /// The radius of a dot, in logical pixels. Zero paints no dots.
  final double dotRadius;

  @override
  bool get isComplex => false;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _DotGridPainter(this, onChanged);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DotGridDecoration &&
          other.color == color &&
          other.dotColor == dotColor &&
          other.spacing == spacing &&
          other.dotRadius == dotRadius;

  @override
  int get hashCode => Object.hash(color, dotColor, spacing, dotRadius);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(ColorProperty('dotColor', dotColor))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DoubleProperty('dotRadius', dotRadius));
  }
}

class _DotGridPainter extends BoxPainter {
  _DotGridPainter(this.decoration, super.onChanged);

  final DotGridDecoration decoration;

  @override
  void paint(ui.Canvas canvas, ui.Offset offset, ImageConfiguration config) {
    final ui.Size? size = config.size;
    if (size == null || size.isEmpty) {
      return;
    }
    final ui.Rect rect = offset & size;
    canvas.drawRect(rect, ui.Paint()..color = decoration.color);
    if (decoration.dotRadius <= 0) {
      return;
    }
    final double spacing = decoration.spacing;
    final List<double> points = <double>[];
    for (double y = rect.top + spacing / 2; y < rect.bottom; y += spacing) {
      for (double x = rect.left + spacing / 2; x < rect.right; x += spacing) {
        points
          ..add(x)
          ..add(y);
      }
    }
    canvas.drawRawPoints(
      ui.PointMode.points,
      Float32List.fromList(points),
      ui.Paint()
        ..color = decoration.dotColor
        ..strokeWidth = decoration.dotRadius * 2
        ..strokeCap = ui.StrokeCap.round,
    );
  }
}

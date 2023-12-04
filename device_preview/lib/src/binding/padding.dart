import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class PreviewWindowPadding implements ui.ViewPadding {
  const PreviewWindowPadding({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  factory PreviewWindowPadding.fromEdgeInsets(EdgeInsets insets) =>
      PreviewWindowPadding(
        left: insets.left,
        top: insets.top,
        right: insets.right,
        bottom: insets.bottom,
      );

  const PreviewWindowPadding.all(double value)
      : left = value,
        right = value,
        top = value,
        bottom = value;

  /// The distance from the left edge to the first unpadded pixel, in physical pixels.
  @override
  final double left;

  /// The distance from the top edge to the first unpadded pixel, in physical pixels.
  @override
  final double top;

  /// The distance from the right edge to the first unpadded pixel, in physical pixels.
  @override
  final double right;

  /// The distance from the bottom edge to the first unpadded pixel, in physical pixels.
  @override
  final double bottom;

  /// Converts this window padding to a [EdgeInsets] object.
  EdgeInsets asEdgeInsets() => EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );

  @override
  String toString() {
    return 'WindowPadding(left: $left, top: $top, right: $right, bottom: $bottom)';
  }
}

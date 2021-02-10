import 'package:flutter/widgets.dart';

extension GlobalKeyExtensions on GlobalKey {
  /// Getting the absolute position of an element on the screen from
  /// a global key.
  Rect? get absolutePosition {
    final renderObject = currentContext?.findRenderObject();
    if (renderObject != null) {
      var translation = renderObject.getTransformTo(null).getTranslation();
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    }
  }
}

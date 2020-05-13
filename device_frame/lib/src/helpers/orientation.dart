import 'package:flutter/widgets.dart';

extension OrientationExtensions on Orientation {
  MediaQueryData toMediaQuery({
    @required Size size,
    @required double pixelRatio,
    EdgeInsets landscape = EdgeInsets.zero,
    EdgeInsets portrait = EdgeInsets.zero,
  }) {
    return this == Orientation.landscape
        ? MediaQueryData(
            size: Size(size.height, size.width),
            padding: landscape,
            devicePixelRatio: pixelRatio,
          )
        : MediaQueryData(
            size: Size(size.width, size.height),
            padding: portrait,
            devicePixelRatio: pixelRatio,
          );
  }
}

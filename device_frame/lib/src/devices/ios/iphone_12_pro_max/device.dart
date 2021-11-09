import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-12-pro-max',
  ),
  name: 'iPhone 12 Pro Max',
  year: 2019,
  pixelRatio: 3.0,
  frameSize: const Size(873.0, 1770.0),
  screenSize: const Size(428.0, 926.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 44.0,
    right: 0.0,
    bottom: 34.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 44.0,
    top: 0.0,
    right: 44.0,
    bottom: 21.0,
  ),
  framePainter: const _FramePainter(),
  screenPath: parseSvgPathData(
    'M284.809 99.021C263.338 99.021 245.596 81.7495 245.596 60.4441V49.9231C245.596 44.1125 241.132 39.1958 235.277 39.1958H187.994C145.528 39.1958 124.295 39.1958 107.406 45.727C81.9318 55.5778 61.7934 75.7075 51.9383 101.17C45.4043 118.052 45.4043 139.276 45.4043 181.724V1588.28C45.4043 1630.72 45.4043 1651.95 51.9383 1668.83C61.7934 1694.29 81.9318 1714.42 107.406 1724.27C124.295 1730.8 145.528 1730.8 187.994 1730.8H685.006C727.472 1730.8 748.705 1730.8 765.594 1724.27C791.068 1714.42 811.207 1694.29 821.062 1668.83C827.596 1651.95 827.596 1630.72 827.596 1588.28V181.724C827.596 139.276 827.596 118.052 821.062 101.17C811.207 75.7075 791.068 55.5778 765.594 45.727C748.705 39.1958 727.472 39.1958 685.006 39.1958H637.723C631.868 39.1958 627.404 44.1125 627.404 49.9231V60.4441C627.404 81.7495 609.662 99.021 588.191 99.021H284.809Z',
  )..fillType = PathFillType.evenOdd,
);

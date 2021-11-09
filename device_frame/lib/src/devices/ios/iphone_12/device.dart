import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-12',
  ),
  name: 'iPhone 12',
  year: 2019,
  pixelRatio: 3.0,
  frameSize: const Size(873.0, 1771.0),
  screenSize: const Size(390.0, 844.0),
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
    'M224.958 50.564V59.8513L225.106 59.8466L224.958 60.8831C224.958 85.3893 244.824 105.255 269.33 105.255H603.67C628.176 105.255 648.043 85.3893 648.043 60.8831L647.895 59.8466L648.042 59.8513V50.564C648.042 44.295 653.124 39.213 659.393 39.213L685.976 39.2129C727.533 39.2129 748.311 39.2129 764.883 45.4748C790.93 55.3172 811.492 75.8786 821.334 101.926C827.596 118.498 827.596 139.276 827.596 180.833V1589.93C827.596 1631.49 827.596 1652.27 821.334 1668.84C811.492 1694.89 790.93 1715.45 764.883 1725.29C748.311 1731.55 727.533 1731.55 685.976 1731.55H187.024C145.467 1731.55 124.689 1731.55 108.117 1725.29C82.07 1715.45 61.5086 1694.89 51.6662 1668.84C45.4043 1652.27 45.4043 1631.49 45.4043 1589.93V180.833C45.4043 139.276 45.4043 118.498 51.6662 101.926C61.5086 75.8786 82.07 55.3172 108.117 45.4748C124.689 39.2129 145.467 39.2129 187.024 39.2129L213.607 39.213C219.876 39.213 224.958 44.295 224.958 50.564Z',
  )..fillType = PathFillType.evenOdd,
);

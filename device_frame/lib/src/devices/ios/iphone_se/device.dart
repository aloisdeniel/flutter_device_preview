import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-se',
  ),
  name: 'iPhone SE',
  year: 2019,
  pixelRatio: 2.0,
  frameSize: const Size(891.0, 1790.0),
  screenSize: const Size(375.0, 667.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 20.0,
    right: 0.0,
    bottom: 0.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 20.0,
    right: 0.0,
    bottom: 0.0,
  ),
  framePainter: const _FramePainter(),
  screenPath: parseSvgPathData(
    'M836.747 198.193H54.2529V1589.72H836.747V198.193Z',
  )..fillType = PathFillType.evenOdd,
);

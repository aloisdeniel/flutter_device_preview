import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-s8',
  ),
  year: 2017,
  name: 'Samsung Galaxy S8',
  pixelRatio: 4.0,
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 24.0,
    right: 0.0,
    bottom: 0.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 24.0,
    right: 0.0,
    bottom: 0.0,
  ),
  framePainter: const _FramePainter(),
  screenPath: parseSvgPathData(
    'M96.0736 103.848C56.5086 103.848 26.6562 138.699 26.6562 178.264V1673.23C26.6562 1712.8 56.5086 1747.65 96.0736 1747.65H756.926C796.491 1747.65 826.344 1712.8 826.344 1673.23V178.264C826.344 138.699 796.491 103.848 756.926 103.848H96.0736Z',
  )..fillType = PathFillType.evenOdd,
  frameSize: const Size(853.0, 1854.0),
  screenSize: const Size(360.0, 740.0),
);

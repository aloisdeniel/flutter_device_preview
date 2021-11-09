import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.windows,
    DeviceType.tablet,
    'surface3',
  ),
  year: 2015,
  name: 'Microsoft Surface 3',
  pixelRatio: 1.0,
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
  frameSize: const Size(2008.0, 2911.0),
  screenSize: const Size(1280.0, 1920.0),
  framePainter: const _FramePainter(),
  screenPath: parseSvgPathData(
    'M1852.85 182.932L1852.85 2728.07H156.094L156.094 182.932L1852.85 182.932Z',
  )..fillType = PathFillType.evenOdd,
);

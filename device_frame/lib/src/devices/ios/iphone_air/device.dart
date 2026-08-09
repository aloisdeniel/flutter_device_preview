import 'dart:ui' as ui;

import 'package:device_frame/src/info/device_type.dart';
import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';

part 'frame.g.dart';
part 'screen.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-air',
  ),
  name: 'iPhone Air',
  pixelRatio: 3,
  frameSize: const Size(1295, 2712),
  screenSize: const Size(420, 912),
  safeAreas: const EdgeInsets.only(
    top: 68,
    bottom: 34,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 68,
    right: 68,
    top: 20,
    bottom: 29,
  ),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
);

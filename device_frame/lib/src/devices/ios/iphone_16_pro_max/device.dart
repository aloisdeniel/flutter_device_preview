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
    'iphone-16-pro-max',
  ),
  name: 'iPhone 16 Pro Max',
  pixelRatio: 3,
  frameSize: const Size(873, 1812),
  screenSize: const Size(440, 956),
  safeAreas: const EdgeInsets.only(
    top: 62,
    bottom: 34,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 62,
    right: 62,
    bottom: 21,
  ),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
);

import 'dart:ui' as ui;

import 'package:device_frame/src/info/device_type.dart';
import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';

part 'frame.g.dart';
part 'screen.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.android,
    DeviceType.phone,
    'google-pixel-9-pro-xl',
  ),
  name: 'Google Pixel 9 Pro XL',
  pixelRatio: 3,
  frameSize: const Size(787, 1663),
  screenSize: const Size(1344 / 3, 2992 / 3),
  safeAreas: const EdgeInsets.only(
    top: 53,
    bottom: 24,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 53,
    top: 52,
    bottom: 24,
  ),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
);

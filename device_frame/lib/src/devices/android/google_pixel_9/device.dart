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
    'google-pixel-9',
  ),
  name: 'Google Pixel 9',
  pixelRatio: 2.625,
  frameSize: const Size(792, 1669),
  screenSize: const Size(1080 / 2.625, 2424 / 2.625),
  safeAreas: const EdgeInsets.only(
    top: 54.1,
    bottom: 24,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 54.1,
    top: 52.2,
    bottom: 24,
  ),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
);

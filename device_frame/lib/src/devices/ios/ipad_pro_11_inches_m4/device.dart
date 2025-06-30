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
    DeviceType.tablet,
    'ipad-pro-11-inches-m4',
  ),
  name: 'iPad Pro 11" (M4)',
  pixelRatio: 2.0,
  frameSize: const Size(927, 1303),
  screenSize: const Size(834, 1210),
  safeAreas: const EdgeInsets.only(
    top: 24,
    bottom: 20,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 24,
    right: 24,
    bottom: 20,
  ),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
);

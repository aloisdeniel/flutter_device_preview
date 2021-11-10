import 'package:device_frame/src/devices/generic/common.dart';
import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';

part 'frame.dart';

/// Creates a generic desktop monitor device definition.
DeviceInfo buildGenericDesktopMonitorDevice({
  required TargetPlatform platform,
  required String id,
  required String name,
  required Size screenSize,
  required Rect windowPosition,
  EdgeInsets safeAreas = EdgeInsets.zero,
  EdgeInsets rotatedSafeAreas = EdgeInsets.zero,
  double pixelRatio = 2.0,
  GenericDesktopMonitorFramePainter? framePainter,
}) {
  final effectivePainter = framePainter ??
      GenericDesktopMonitorFramePainter(
        platform: platform,
        windowPosition: windowPosition,
      );
  return DeviceInfo(
    identifier: DeviceIdentifier(
      platform,
      DeviceType.desktop,
      id,
    ),
    name: name,
    pixelRatio: pixelRatio,
    frameSize: effectivePainter.calculateFrameSize(screenSize),
    screenSize: effectivePainter.effectiveWindowSize,
    safeAreas: safeAreas,
    rotatedSafeAreas: rotatedSafeAreas,
    framePainter: effectivePainter,
    screenPath: effectivePainter.createScreenPath(screenSize),
  );
}

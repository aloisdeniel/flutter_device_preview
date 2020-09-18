import 'package:flutter/widgets.dart';

import '../devices.dart';

/// Info about a device and its frame.
class DeviceInfo {
  /// Identifier of the device.
  final DeviceIdentifier identifier;

  /// The display name of the device.
  final String name;

  /// The safe areas when the device is in portrait orientation.
  final EdgeInsets safeAreas;

  /// The safe areas when the device is in landscape orientation.
  final EdgeInsets rotatedSafeAreas;

  /// Indicates whether the device can rotate.
  bool get canRotate => rotatedSafeAreas != null;

  /// A shape representing the screen.
  final Path screenPath;

  /// The size in points of the screen content.
  final Size screenSize;

  /// The frame image as a SVG string.
  final String svgFrame;

  /// The screen pixel density of the device.
  final double pixelRatio;

  /// The frame size's width.
  final double frameWidth;

  /// The frame size's height.
  final double frameHeight;

  /// Create a new device info.
  const DeviceInfo({
    @required this.identifier,
    @required this.name,
    @required this.rotatedSafeAreas,
    @required this.safeAreas,
    @required this.screenPath,
    @required this.pixelRatio,
    @required this.svgFrame,
    @required this.frameWidth,
    @required this.frameHeight,
    @required this.screenSize,
  });
}

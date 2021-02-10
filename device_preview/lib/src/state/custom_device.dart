import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'state.dart';

/// A device info that can be customized at runtime to update
/// its current preview.
///
/// See also:
///
/// * [DeviceInfo] which describes a simulated device.
class CustomDeviceInfo implements DeviceInfo {
  const CustomDeviceInfo._({
    required this.identifier,
    required this.data,
    required this.screenPath,
    required this.svgFrame,
    required this.frameSize,
  });

  /// Create a new custom device from stored [data].
  factory CustomDeviceInfo(CustomDeviceInfoData data) {
    const _insets = EdgeInsets.only(
      left: 20,
      right: 20,
      top: 40,
      bottom: 24,
    );

    final screenPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            _insets.left,
            _insets.top,
            data.screenSize.width,
            data.screenSize.height,
          ),
          Radius.circular(10),
        ),
      );

    final frameSize = Size(
      data.screenSize.width + _insets.horizontal,
      data.screenSize.height + _insets.vertical,
    );

    final svgFrame = '''
    <svg width="${frameSize.width}" height="${frameSize.height}" viewBox="0 0 ${frameSize.width} ${frameSize.height}" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect x="0" y="0" width="${frameSize.width}" height="${frameSize.height}" rx="20" fill="#0A0A0A" stroke="url(#paint0_linear)" stroke-width="6"/>
      <defs>
      <linearGradient id="paint0_linear" x1="${frameSize.width}" y1="0" x2="${frameSize.width}" y2="${frameSize.height}" gradientUnits="userSpaceOnUse">
        <stop stop-color="#D2D2D2"/>
        <stop offset="1" stop-color="#525252"/>
        </linearGradient>
      </defs>
    </svg>
    ''';

    return CustomDeviceInfo._(
      data: data,
      identifier: CustomDeviceIdentifier(data),
      screenPath: screenPath,
      svgFrame: svgFrame,
      frameSize: frameSize,
    );
  }

  final CustomDeviceInfoData data;

  @override
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw UnsupportedError('Read only');

  @override
  final DeviceIdentifier identifier;

  @override
  String get name => data.name;

  @override
  double get pixelRatio => data.pixelRatio;

  @override
  EdgeInsets? get rotatedSafeAreas => null;

  @override
  EdgeInsets get safeAreas => data.safeAreas;

  @override
  Size get screenSize => data.screenSize;

  @override
  final Path screenPath;

  @override
  final String svgFrame;

  @override
  final Size frameSize;
}

class CustomDeviceIdentifier implements DeviceIdentifier {
  final CustomDeviceInfoData data;

  const CustomDeviceIdentifier(this.data);

  static const identifier = 'custom_device';

  @override
  String get name => data.name;

  @override
  TargetPlatform get platform => data.platform;

  @override
  DeviceType get type => data.type;
}

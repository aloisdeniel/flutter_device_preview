import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

extension DeviceIdentifierFormatExtensions on DeviceIdentifier {
  IconData typeIcon() => type.typeIcon();

  String typeLabel() => type.typeLabel();
}

extension DeviceTypeFormatExtensions on DeviceType {
  IconData typeIcon() {
    switch (this) {
      case DeviceType.tablet:
        return Icons.tablet_android;
      case DeviceType.desktop:
        return Icons.desktop_mac;
      case DeviceType.laptop:
        return Icons.laptop_mac;
      case DeviceType.tv:
        return Icons.tv;
      default:
        return Icons.phone_android;
    }
  }

  String typeLabel() {
    switch (this) {
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.desktop:
        return 'Desktop';
      case DeviceType.tv:
        return 'TV';
      case DeviceType.laptop:
        return 'Laptop';
      default:
        return 'Phone';
    }
  }
}

import 'package:device_preview/device_preview.dart';

extension DeviceIdentifierFormatExtensions on DeviceIdentifier {
  String typeLabel() => type.typeLabel();
}

extension DeviceTypeFormatExtensions on DeviceType {
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

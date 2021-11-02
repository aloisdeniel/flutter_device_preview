import 'package:device_preview/device_preview.dart';

extension DeviceIdentifierFormatExtensions on DeviceIdentifier {
  /// The formatted label for the identifier's [type].
  String typeLabel() => type.typeLabel();
}

extension DeviceTypeFormatExtensions on DeviceType {
  /// The formatted label for this device type.
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

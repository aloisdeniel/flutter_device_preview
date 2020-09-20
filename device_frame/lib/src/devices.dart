import 'package:flutter/foundation.dart';

/// A unique identifier that represents a device.
///
/// See also :
///
/// * [loadDeviceInfo] to load information store in assets.
/// * [DeviceFrame] to display the frame associated to one of identifiers.
class DeviceIdentifier {
  final String name;
  final String type;
  final TargetPlatform platform;

  String get assetKey {
    final platformKey =
        platform.toString().replaceAll('${TargetPlatform}.', '').toLowerCase();
    return 'packages/device_frame/assets/${platformKey}_${type}_${name}.svg';
  }

  const DeviceIdentifier._(
    this.platform,
    this.type,
    this.name,
  )   : assert(name != null),
        assert(type != null),
        assert(platform != null);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeviceIdentifier &&
            other.name == name &&
            other.type == type &&
            other.platform == platform);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ type.hashCode ^ platform.hashCode;
}

/// A list of common device specifications sorted by target platform.
abstract class Devices {
  static final ios = const IosDevices._();
  static final android = const AndroidDevices._();
  static final macos = const MacOsDevices._();
  static final windows = const WindowsDevices._();
}

class IosDevices {
  const IosDevices._();

  final iPhoneSE = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'iphone',
    'se',
  );

  final iPhone11 = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'iphone',
    '11',
  );

  final iPhone11Pro = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'iphone',
    '11pro',
  );

  final iPhone11ProMax = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'iphone',
    '11promax',
  );

  final iPadMini = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'ipad',
    'mini',
  );

  final iPadPro129 = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'ipad',
    'pro12-9',
  );

  final iPadiPad = const DeviceIdentifier._(
    TargetPlatform.iOS,
    'ipad',
    'ipad',
  );

  List<DeviceIdentifier> get all => [
        iPadMini,
        iPadPro129,
        iPadiPad,
        iPhoneSE,
        iPhone11,
        iPhone11Pro,
        iPhone11ProMax,
      ];
}

class AndroidDevices {
  const AndroidDevices._();

  final small = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'small',
  );

  final medium = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'medium',
  );

  final large = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'large',
  );

  final pixel3 = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'pixel3',
  );

  final samsungS8 = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'samsung-s8',
  );

  final samsungS20 = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'samsung-s20',
  );

  final samsungNote10Plus = const DeviceIdentifier._(
    TargetPlatform.android,
    'phone',
    'samsung-note10plus',
  );

  final nexus9 = const DeviceIdentifier._(
    TargetPlatform.android,
    'tablet',
    'nexus9',
  );

  List<DeviceIdentifier> get all => [
        small,
        medium,
        large,
        pixel3,
        samsungS8,
        samsungS20,
        samsungNote10Plus,
        nexus9,
      ];
}

class MacOsDevices {
  const MacOsDevices._();

  final iMacPro = const DeviceIdentifier._(
    TargetPlatform.macOS,
    'imac',
    'pro',
  );

  final macbook = const DeviceIdentifier._(
    TargetPlatform.macOS,
    'macbook',
    'macbook',
  );

  List<DeviceIdentifier> get all => [
        iMacPro,
        macbook,
      ];
}

class WindowsDevices {
  const WindowsDevices._();

  final surface3 = const DeviceIdentifier._(
    TargetPlatform.windows,
    'tablet',
    'surface3',
  );

  final screenWide = const DeviceIdentifier._(
    TargetPlatform.windows,
    'screen',
    'wide',
  );

  final screenSquare = const DeviceIdentifier._(
    TargetPlatform.windows,
    'screen',
    'square',
  );

  List<DeviceIdentifier> get all => [
        surface3,
        screenWide,
        screenSquare,
      ];
}

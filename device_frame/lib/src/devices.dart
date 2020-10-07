import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';

enum DeviceType {
  unknown,
  phone,
  tablet,
  tv,
  desktop,
  laptop,
}

/// A unique identifier that represents a device.
///
/// See also :
///
/// * [loadDeviceInfo] to load information store in assets.
/// * [DeviceFrame] to display the frame associated to one of identifiers.
class DeviceIdentifier {
  final String name;
  final DeviceType type;
  final TargetPlatform platform;

  String get assetKey {
    final platformKey =
        platform.toString().replaceAll('${TargetPlatform}.', '').toLowerCase();
    final typeKey =
        type.toString().replaceAll('${DeviceType}.', '').toLowerCase();
    return 'packages/device_frame/assets/${platformKey}_${typeKey}_${name}.svg';
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
  static final linux = const LinuxDevices._();
}

class IosDevices {
  const IosDevices._();

  final iPhoneSE = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-se',
  );

  final iPhone11 = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11',
  );

  final iPhone11Pro = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11pro',
  );

  final iPhone11ProMax = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11promax',
  );

  final iPadMini = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.tablet,
    'ipad-mini',
  );

  final iPadPro129 = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.tablet,
    'ipad-pro12-9',
  );

  final iPadiPad = const DeviceIdentifier._(
    TargetPlatform.iOS,
    DeviceType.tablet,
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
    DeviceType.phone,
    'small',
  );

  final medium = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'medium',
  );

  final large = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'large',
  );

  final pixel3 = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'pixel3',
  );

  final samsungS8 = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-s8',
  );

  final samsungS20 = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-s20',
  );

  final samsungNote10Plus = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-note10plus',
  );

  final nexus9 = const DeviceIdentifier._(
    TargetPlatform.android,
    DeviceType.tablet,
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
    DeviceType.desktop,
    'imac-pro',
  );

  final macbook = const DeviceIdentifier._(
    TargetPlatform.macOS,
    DeviceType.laptop,
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
    DeviceType.tablet,
    'surface3',
  );

  final screen = const DeviceIdentifier._(
    TargetPlatform.windows,
    DeviceType.desktop,
    'screen',
  );

  final dellXps13 = const DeviceIdentifier._(
    TargetPlatform.windows,
    DeviceType.laptop,
    'dell-xps13',
  );

  List<DeviceIdentifier> get all => [
        surface3,
        screen,
        dellXps13,
      ];
}

class LinuxDevices {
  const LinuxDevices._();

  final screen = const DeviceIdentifier._(
    TargetPlatform.linux,
    DeviceType.desktop,
    'screen',
  );

  List<DeviceIdentifier> get all => [
        screen,
      ];
}

import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart';

import 'info/info.dart';

part 'devices.g.dart';

/// A device form factor.
enum DeviceType {
  /// Unknown type
  unknown,

  /// Smartphone
  phone,

  /// Tablet
  tablet,

  /// TV
  tv,

  /// Desktop computer
  desktop,

  /// Laptop
  laptop,
}

/// A unique identifier that represents a device.
///
/// See also :
///
/// * [loadDeviceInfo] to load information store in assets.
/// * [DeviceFrame] to display the frame associated to one of identifiers.
class DeviceIdentifier {
  /// The unique name of the device (preferably in snake case).
  final String name;

  /// The device form factor.
  final DeviceType type;

  /// The target platform supported by this device.
  final TargetPlatform platform;

  /// Private constructor.
  const DeviceIdentifier._(
    this.platform,
    this.type,
    this.name,
  );

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

  @override
  String toString() {
    final platformKey =
        platform.toString().replaceAll('${TargetPlatform}.', '').toLowerCase();
    final typeKey =
        type.toString().replaceAll('${DeviceType}.', '').toLowerCase();
    return '${platformKey}_${typeKey}_${name}';
  }
}

/// A list of common device specifications sorted by target platform.
abstract class Devices {
  static final ios = IosDevices._();
  static final android = AndroidDevices._();
  static final macos = MacOsDevices._();
  static final windows = WindowsDevices._();
  static final linux = LinuxDevices._();

  static List<DeviceInfo> get all => _allDevices;
}

DeviceInfo _find(TargetPlatform platform, DeviceType type, String name) =>
    _allDevices.firstWhere(
      (x) =>
          x.identifier.platform == platform &&
          x.identifier.type == type &&
          x.identifier.name == name,
    );

/// A set of iOS devices.
class IosDevices {
  IosDevices._();

  final iPhoneSE = _find(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-se',
  );

  final iPhone11 = _find(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11',
  );

  final iPhone11Pro = _find(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11pro',
  );

  final iPhone11ProMax = _find(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-11promax',
  );

  final iPadMini = _find(
    TargetPlatform.iOS,
    DeviceType.tablet,
    'ipad-mini',
  );

  final iPadPro129 = _find(
    TargetPlatform.iOS,
    DeviceType.tablet,
    'ipad-pro12-9',
  );

  final iPadiPad = _find(
    TargetPlatform.iOS,
    DeviceType.tablet,
    'ipad',
  );

  List<DeviceInfo> get all => [
        iPadMini,
        iPadPro129,
        iPadiPad,
        iPhoneSE,
        iPhone11,
        iPhone11Pro,
        iPhone11ProMax,
      ];
}

/// A set of Android devices.
class AndroidDevices {
  AndroidDevices._();

  final small = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'small',
  );

  final medium = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'medium',
  );

  final large = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'large',
  );

  final pixel3 = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'pixel3',
  );

  final samsungS8 = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-s8',
  );

  final samsungS20 = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-s20',
  );

  final samsungNote10Plus = _find(
    TargetPlatform.android,
    DeviceType.phone,
    'samsung-note10plus',
  );

  final nexus9 = _find(
    TargetPlatform.android,
    DeviceType.tablet,
    'nexus9',
  );

  List<DeviceInfo> get all => [
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

/// A set of macOS devices.
class MacOsDevices {
  MacOsDevices._();

  final iMacPro = _find(
    TargetPlatform.macOS,
    DeviceType.desktop,
    'imac-pro',
  );

  final macbook = _find(
    TargetPlatform.macOS,
    DeviceType.laptop,
    'macbook',
  );

  List<DeviceInfo> get all => [
        iMacPro,
        macbook,
      ];
}

class WindowsDevices {
  WindowsDevices._();

  final surface3 = _find(
    TargetPlatform.windows,
    DeviceType.tablet,
    'surface3',
  );

  final screen = _find(
    TargetPlatform.windows,
    DeviceType.desktop,
    'screen',
  );

  final dellXps13 = _find(
    TargetPlatform.windows,
    DeviceType.laptop,
    'dell-xps13',
  );

  List<DeviceInfo> get all => [
        surface3,
        screen,
        dellXps13,
      ];
}

class LinuxDevices {
  LinuxDevices._();

  final screen = _find(
    TargetPlatform.linux,
    DeviceType.desktop,
    'screen',
  );

  List<DeviceInfo> get all => [
        screen,
      ];
}

import 'package:device_frame/src/info/info.dart';

import 'android/devices.dart';
import 'ios/devices.dart';
import 'linux/devices.dart';
import 'windows/devices.dart';
import 'macos/devices.dart';

/// A list of common device specifications sorted by target platform.
abstract class Devices {
  static const ios = IosDevices();
  static const macOS = MacOSDevices();
  static const android = AndroidDevices();
  static const windows = WindowsDevices();
  static const linux = LinuxDevices();

  static List<DeviceInfo> get all => [
        ...ios.all,
        ...android.all,
        ...windows.all,
        ...macOS.all,
        ...linux.all,
      ];
}

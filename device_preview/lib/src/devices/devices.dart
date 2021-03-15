import 'package:device_preview/src/devices/devices/android/pixel_4.dart';
import 'package:device_preview/src/devices/devices/ios/iphone_x.dart';
import 'package:device_preview/src/devices/devices/macos/default.dart';

import 'device.dart';

final defaultDevices = [
  DeviceCategory(
    name: 'iOS',
    devices: [
      [
        iphoneX,
      ]
    ],
  ),
  DeviceCategory(
    name: 'Android',
    devices: [
      [
        pixel4,
      ]
    ],
  ),
  DeviceCategory(
    name: 'macOS',
    devices: [
      [
        macos,
      ]
    ],
  ),
];

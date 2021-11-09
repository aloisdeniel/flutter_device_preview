import 'package:device_frame/src/info/info.dart';

import 'package:device_frame/src/devices/ios/iphone_12_mini/device.dart'
    as i_iphone_12_mini;
import 'package:device_frame/src/devices/ios/iphone_12/device.dart'
    as i_iphone_12;
import 'package:device_frame/src/devices/ios/iphone_12_pro_max/device.dart'
    as i_iphone_12_pro_max;
import 'package:device_frame/src/devices/ios/iphone_se/device.dart'
    as i_iphone_se;

/// A set of iOS devices.
class IosDevices {
  const IosDevices();

  DeviceInfo get iPhone12Mini => i_iphone_12_mini.info;
  DeviceInfo get iPhone12 => i_iphone_12.info;
  DeviceInfo get iPhone12ProMax => i_iphone_12_pro_max.info;
  DeviceInfo get iPhoneSE => i_iphone_se.info;

  List<DeviceInfo> get all => [
        iPhone12Mini,
        iPhone12,
        iPhone12ProMax,
        iPhoneSE,
      ];
}

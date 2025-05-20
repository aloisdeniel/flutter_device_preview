import 'package:device_frame/src/info/info.dart';

import 'package:device_frame/src/devices/ios/iphone_11_pro_max/device.dart'
    as i_iphone_11_pro_max;
import 'package:device_frame/src/devices/ios/iphone_12_mini/device.dart'
    as i_iphone_12_mini;
import 'package:device_frame/src/devices/ios/iphone_12/device.dart'
    as i_iphone_12;
import 'package:device_frame/src/devices/ios/iphone_12_pro_max/device.dart'
    as i_iphone_12_pro_max;
import 'package:device_frame/src/devices/ios/iphone_13_mini/device.dart'
    as i_iphone_13_mini;
import 'package:device_frame/src/devices/ios/iphone_13/device.dart'
    as i_iphone_13;
import 'package:device_frame/src/devices/ios/iphone_13_pro_max/device.dart'
    as i_iphone_13_pro_max;
import 'package:device_frame/src/devices/ios/iphone_se/device.dart'
    as i_iphone_se;
import 'package:device_frame/src/devices/ios/iphone_15_pro/device.dart'
    as i_iphone_15_pro;
import 'package:device_frame/src/devices/ios/iphone_15_pro_max/device.dart'
    as i_iphone_15_pro_max;
import 'package:device_frame/src/devices/ios/iphone_16/device.dart'
    as i_iphone_16;
import 'package:device_frame/src/devices/ios/iphone_16_plus/device.dart'
    as i_iphone_16_plus;
import 'package:device_frame/src/devices/ios/iphone_16_pro/device.dart'
    as i_iphone_16_pro;
import 'package:device_frame/src/devices/ios/iphone_16_pro_max/device.dart'
    as i_iphone_16_pro_max;
import 'package:device_frame/src/devices/ios/ipad_air_4/device.dart'
    as i_ipad_air_4;
import 'package:device_frame/src/devices/ios/ipad/device.dart' as i_ipad;
import 'package:device_frame/src/devices/ios/ipad_pro_11inches/device.dart'
    as i_ipad_pro_11inches;
import 'package:device_frame/src/devices/ios/ipad_pro_12Inches_gen2/device.dart'
    as i_ipad_12inches_gen2;
import 'package:device_frame/src/devices/ios/ipad_pro_12Inches_gen4/device.dart'
    as i_ipad_12inches_gen4;
import 'package:device_frame/src/devices/ios/ipad_pro_11_inches_m4/device.dart'
    as i_ipad_pro_11_inches_m4;
import 'package:device_frame/src/devices/ios/ipad_pro_13_inches_m4/device.dart'
    as i_ipad_pro_13_inches_m4;

/// A set of iOS devices.
class IosDevices {
  const IosDevices();

  DeviceInfo get iPhone11ProMax => i_iphone_11_pro_max.info;
  DeviceInfo get iPhone12Mini => i_iphone_12_mini.info;
  DeviceInfo get iPhone12 => i_iphone_12.info;
  DeviceInfo get iPhone12ProMax => i_iphone_12_pro_max.info;
  DeviceInfo get iPhone13Mini => i_iphone_13_mini.info;
  DeviceInfo get iPhone13 => i_iphone_13.info;
  DeviceInfo get iPhone13ProMax => i_iphone_13_pro_max.info;
  DeviceInfo get iPhoneSE => i_iphone_se.info;
  DeviceInfo get iPhone15Pro => i_iphone_15_pro.info;
  DeviceInfo get iPhone15ProMax => i_iphone_15_pro_max.info;
  DeviceInfo get iPhone16 => i_iphone_16.info;
  DeviceInfo get iPhone16Plus => i_iphone_16_plus.info;
  DeviceInfo get iPhone16Pro => i_iphone_16_pro.info;
  DeviceInfo get iPhone16ProMax => i_iphone_16_pro_max.info;
  DeviceInfo get iPadAir4 => i_ipad_air_4.info;
  DeviceInfo get iPad => i_ipad.info;
  DeviceInfo get iPadPro11Inches => i_ipad_pro_11inches.info;
  DeviceInfo get iPad12InchesGen2 => i_ipad_12inches_gen2.info;
  DeviceInfo get iPad12InchesGen4 => i_ipad_12inches_gen4.info;
  DeviceInfo get iPadPro11InchesM4 => i_ipad_pro_11_inches_m4.info;
  DeviceInfo get iPadPro13InchesM4 => i_ipad_pro_13_inches_m4.info;

  /// All devices.
  List<DeviceInfo> get all => [
        // Phones
        iPhone11ProMax,
        iPhone12Mini,
        iPhone12,
        iPhone12ProMax,
        iPhone13Mini,
        iPhone13,
        iPhone13ProMax,
        iPhoneSE,
        iPhone15Pro,
        iPhone15ProMax,
        iPhone16,
        iPhone16Plus,
        iPhone16Pro,
        iPhone16ProMax,
        //Tablets
        iPadAir4,
        iPad,
        iPadPro11Inches,
        iPad12InchesGen2,
        iPad12InchesGen4,
        iPadPro11InchesM4,
        iPadPro13InchesM4,
      ];
}

import 'dart:ui';

import 'package:device_frame/src/info/info.dart';

import 'package:device_frame/src/devices/android/samsung_s20/device.dart'
    as i_samsung_s20;
import 'package:device_frame/src/devices/android/oneplus_8_pro/device.dart'
    as i_oneplus_8_pro;
import 'package:flutter/material.dart';

/// A set of iOS devices.
class AndroidDevices {
  const AndroidDevices();

  DeviceInfo get samsungS20 => i_samsung_s20.info;

  DeviceInfo get onePlus8Pro => i_oneplus_8_pro.info;

  DeviceInfo get smallPhone => _smallPhone;
  static final _smallPhone = DeviceInfo.genericPhone(
    platform: TargetPlatform.android,
    name: 'Small',
    id: 'small',
    screenSize: const Size(360, 640),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  DeviceInfo get mediumPhone => _mediumPhone;
  static final _mediumPhone = DeviceInfo.genericPhone(
    platform: TargetPlatform.android,
    name: 'Medium',
    id: 'medium',
    screenSize: const Size(412, 732),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  DeviceInfo get bigPhone => _bigPhone;
  static final _bigPhone = DeviceInfo.genericPhone(
    platform: TargetPlatform.android,
    name: 'Big',
    id: 'big',
    screenSize: const Size(480, 853),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  DeviceInfo get smallTablet => _smallTablet;
  static final _smallTablet = DeviceInfo.genericTablet(
    platform: TargetPlatform.android,
    name: 'Small',
    id: 'small',
    screenSize: const Size(800, 1280),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  DeviceInfo get mediumTablet => _mediumTablet;
  static final _mediumTablet = DeviceInfo.genericTablet(
    platform: TargetPlatform.android,
    name: 'Medium',
    id: 'medium',
    screenSize: const Size(1024, 1350),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  DeviceInfo get largeTablet => _largeTablet;
  static final _largeTablet = DeviceInfo.genericTablet(
    platform: TargetPlatform.android,
    name: 'Large',
    id: 'large',
    screenSize: const Size(1280, 1880),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
  );

  List<DeviceInfo> get all => [
        //Phones
        samsungS20,
        onePlus8Pro,
        smallPhone,
        mediumPhone,
        bigPhone,
        // Tablets
        smallTablet,
        mediumTablet,
        largeTablet,
      ];
}

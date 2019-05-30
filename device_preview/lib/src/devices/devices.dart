import 'package:flutter/widgets.dart';

import 'apple.dart' as apple;
import '../device_frame.dart';

export 'apple.dart';

enum DeviceType {
  phone,
  tablet,
  desktop,
  watch,
  tv,
}

class Device {
  final String name;
  final DeviceFrame frame;
  final TargetPlatform platform;
  final DeviceType type;
  final MediaQueryData landscape;
  final MediaQueryData portrait;

  const Device(
      {@required this.name,
      @required this.type,
      @required this.platform,
      @required this.landscape,
      @required this.portrait,
      @required this.frame});

  const Device.iOS(
      {@required this.name,
      @required this.type,
      @required this.landscape,
      @required this.portrait,
      @required this.frame})
      : this.platform = TargetPlatform.iOS;

  const Device.android(
      {@required this.name,
      @required this.type,
      @required this.landscape,
      @required this.portrait,
      @required this.frame})
      : this.platform = TargetPlatform.android;

  const Device.fushia(
      {@required this.name,
      @required this.type,
      @required this.landscape,
      @required this.portrait,
      @required this.frame})
      : this.platform = TargetPlatform.fuchsia;
}

abstract class Devices {
  static final all = <Device>[
    apple.iPhone8,
    apple.iPhoneXr,
    apple.iPhoneXs,
    apple.iPadAir2,
    apple.iPadPro_129_2,
    apple.watch40mm,
  ];
}

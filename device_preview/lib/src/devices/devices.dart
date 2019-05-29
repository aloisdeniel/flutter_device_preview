import 'package:flutter/widgets.dart';

import 'apple.dart' as apple;
import '../device_frame.dart';

export 'apple.dart';

class Device {
  final String name;
  final MediaQueryData query;
  final DeviceFrame frame;
  final TargetPlatform platform;

  const Device(
      {@required this.name,
      @required this.platform,
      @required this.query,
      @required this.frame});

  const Device.iOS(
      {@required this.name, @required this.query, @required this.frame})
      : this.platform = TargetPlatform.iOS;

  const Device.android(
      {@required this.name, @required this.query, @required this.frame})
      : this.platform = TargetPlatform.android;

  const Device.fushia(
      {@required this.name, @required this.query, @required this.frame})
      : this.platform = TargetPlatform.fuchsia;
}

abstract class Devices {
  static final all = <Device>[
    apple.iPhone8,
    apple.iPhoneXr,
    apple.iPhoneXs,
    apple.iPadAir,
    apple.iPadPro129,
    apple.watch40mm,
  ];
}

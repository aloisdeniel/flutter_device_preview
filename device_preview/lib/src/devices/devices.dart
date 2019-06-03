import 'package:flutter/widgets.dart';

import 'ios.dart' as iosDevice;
import 'android.dart' as androidDevice;
import '../device_frame.dart';

export 'ios.dart';

enum DeviceType {
  phone,
  tablet,
  desktop,
  watch,
  tv,
  freeform,
}

class Device {
  final String name;
  final DeviceFrame frame;
  final TargetPlatform platform;
  final DeviceType type;
  final MediaQueryData landscape;
  final MediaQueryData portrait;

  bool get canRotate => this.landscape != null && this.portrait != null;

  const Device(
      {@required this.name,
      @required this.type,
      @required this.platform,
      this.landscape,
      this.portrait,
      @required this.frame})
      : assert(landscape != null || portrait != null);

  const Device.iOS(
      {@required this.name,
      @required this.type,
      this.landscape,
      this.portrait,
      @required this.frame})
      : assert(landscape != null || portrait != null),
        this.platform = TargetPlatform.iOS;

  const Device.android(
      {@required this.name,
      @required this.type,
      this.landscape,
      this.portrait,
      @required this.frame})
      : assert(landscape != null || portrait != null),
        this.platform = TargetPlatform.android;

  const Device.fushia(
      {@required this.name,
      @required this.type,
      this.landscape,
      this.portrait,
      @required this.frame})
      : assert(landscape != null || portrait != null),
        this.platform = TargetPlatform.fuchsia;

  Device copyWith(
          {String name,
          DeviceFrame frame,
          TargetPlatform platform,
          DeviceType type,
          MediaQueryData landscape,
          MediaQueryData portrait}) =>
      Device(
        name: name ?? this.name,
        frame: frame ?? this.frame,
        platform: platform ?? this.platform,
        type: type ?? this.type,
        landscape: landscape ?? this.landscape,
        portrait: portrait ?? this.portrait,
      );
}

abstract class Devices {
  static final all = <Device>[]..addAll(ios)..addAll(android);

  static final ios = <Device>[
    iosDevice.iPhone8,
    iosDevice.iPhoneXr,
    iosDevice.iPhoneXs,
    iosDevice.iPadAir2,
    iosDevice.iPadPro_129_2,
    iosDevice.watch40mm,
    iosDevice.iosFreeform,
  ];

  static final android = <Device>[
    androidDevice.freeform,
  ];
}

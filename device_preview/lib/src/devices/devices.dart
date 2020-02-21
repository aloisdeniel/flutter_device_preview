import 'package:flutter/widgets.dart';

import 'ios.dart' as ios_device;
import 'android.dart' as android_device;

export 'ios.dart';

enum DeviceType {
  phone,
  tablet,
  desktop,
  watch,
  tv,
  freeform,
}

typedef FrameWidgetBuilder = Widget Function(
  BuildContext context,
  Widget screen,
  Size screenSize,
  bool isRotated,
);

class Device {
  final String name;
  final FrameWidgetBuilder frameBuilder;
  final TargetPlatform platform;
  final DeviceType type;
  final MediaQueryData landscape;
  final MediaQueryData portrait;

  bool get canRotate => landscape != null && portrait != null;

  const Device(
      {@required this.name,
      @required this.type,
      @required this.platform,
      this.landscape,
      this.portrait,
      @required this.frameBuilder})
      : assert(landscape != null || portrait != null);

  const Device.iOS({
    @required this.name,
    @required this.type,
    this.landscape,
    this.portrait,
    @required this.frameBuilder,
  })  : assert(landscape != null || portrait != null),
        platform = TargetPlatform.iOS;

  const Device.android({
    @required this.name,
    @required this.type,
    this.landscape,
    this.portrait,
    @required this.frameBuilder,
  })  : assert(landscape != null || portrait != null),
        platform = TargetPlatform.android;

  const Device.fuchsia({
    @required this.name,
    @required this.type,
    this.landscape,
    this.portrait,
    @required this.frameBuilder,
  })  : assert(landscape != null || portrait != null),
        platform = TargetPlatform.fuchsia;

  Device copyWith(
          {String name,
          FrameWidgetBuilder frameBuilder,
          TargetPlatform platform,
          DeviceType type,
          MediaQueryData landscape,
          MediaQueryData portrait}) =>
      Device(
        name: name ?? this.name,
        frameBuilder: frameBuilder ?? this.frameBuilder,
        platform: platform ?? this.platform,
        type: type ?? this.type,
        landscape: landscape ?? this.landscape,
        portrait: portrait ?? this.portrait,
      );
}

abstract class Devices {
  static final all = <Device>[...ios, ...android];

  static final ios = <Device>[
    ios_device.iPhone8,
    ios_device.iPhoneXr,
    ios_device.iPhoneXs,
    ios_device.iPadAir2,
    ios_device.iPadPro_129_2,
    ios_device.watch40mm,
    ios_device.iosFreeform,
  ];

  static final android = <Device>[
    android_device.smallPhone,
    android_device.mediumPhone,
    android_device.largePhone,
    android_device.smallTablet,
    android_device.mediumTablet,
    android_device.watch,
    android_device.freeform,
  ];
}

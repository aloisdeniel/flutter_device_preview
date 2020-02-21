import 'package:flutter/widgets.dart';

import 'ios.dart' as iosDevice;
import 'android.dart' as androidDevice;

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
    iosDevice.iPhone8,
    iosDevice.iPhoneXr,
    iosDevice.iPhoneXs,
    iosDevice.iPadAir2,
    iosDevice.iPadPro_129_2,
    iosDevice.watch40mm,
    iosDevice.iosFreeform,
  ];

  static final android = <Device>[
    androidDevice.smallPhone,
    androidDevice.mediumPhone,
    androidDevice.largePhone,
    androidDevice.smallTablet,
    androidDevice.mediumTablet,
    androidDevice.watch,
    androidDevice.freeform,
  ];
}

import 'package:flutter/widgets.dart';

import 'ios.dart' as ios_device;
import 'android.dart' as android_device;

export 'ios.dart';

/// A simulated device type.
enum DeviceType {
  phone,
  tablet,
  desktop,
  watch,
  tv,
  freeform,
}

// A device orientation.
enum DeviceOrientation {
  landscape,
  portrait,
}

/// A builder that creates the frame that represents the physical part of
/// the device for a given [screen], its [screenSize], and the device
/// [orientation].
typedef FrameWidgetBuilder = Widget Function(
  BuildContext context,
  Widget screen,
  Size screenSize,
  DeviceOrientation orientation,
);

/// A simulated device.
class Device {
  /// The display name associated to the device.
  final String name;

  /// A builder that creates the frame that represents the physical part of
  /// the device.
  final FrameWidgetBuilder frameBuilder;

  /// The target platform of the device.
  final TargetPlatform platform;

  /// The device type.
  final DeviceType type;

  /// The media query associated to the landscape mode.
  final MediaQueryData landscape;

  /// The media query associated to the portrait mode.
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
    ios_device.iPhone5,
    ios_device.iPhone8,
    ios_device.iPhoneX,
    ios_device.iPhoneXs,
    ios_device.iPhoneXr,
    ios_device.iPhoneXsMax,
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

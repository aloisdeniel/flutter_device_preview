import 'package:flutter/widgets.dart';
import 'package:device_frame/src/helpers/orientation.dart';

import '../../device_frame.dart';
import 'phones.dart';
import 'tablets.dart';

enum CupertinoDevice {
  // Phones
  iPhoneX,
  iPhoneXr,
  iPhoneXs,
  iPhoneXsMax,
  iPhone8,
  iPhone5,

  // Tablets
  iPadAir2,
  iPadPro129gen2,
}

class CupertinoDeviceFrame extends StatelessWidget {
  final CupertinoDevice device;
  final Orientation orientation;
  final Widget child;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  const CupertinoDeviceFrame({
    CupertinoDevice device,
    this.orientation,
    @required this.child,
    this.style,
    this.isKeyboardVisible = false,
    this.keyboardTransitionDuration = const Duration(milliseconds: 500),
  })  : assert(child != null),
        this.device = device ?? CupertinoDevice.iPhoneX;

  @override
  Widget build(BuildContext context) {
    switch (device) {
      case CupertinoDevice.iPadAir2:
        return CupertinoTabletFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(768, 1024),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(top: 20),
          ),
        );
      case CupertinoDevice.iPadPro129gen2:
        return CupertinoTabletWithThinBordersFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(1024, 1336),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(top: 20),
          ),
        );
      case CupertinoDevice.iPhone8:
        return CupertinoPhoneFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(375, 667),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(top: 20),
          ),
        );
      case CupertinoDevice.iPhone5:
        return CupertinoPhoneFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(320, 568),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(top: 20),
          ),
        );
      case CupertinoDevice.iPhoneXr:
        return CupertinoPhoneWithNotchFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(414, 896),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(
              top: 44,
              bottom: 34,
            ),
            landscape: const EdgeInsets.only(
              left: 44,
              right: 44,
              bottom: 21,
            ),
          ),
        );
      case CupertinoDevice.iPhoneXs:
        return CupertinoPhoneWithNotchFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(375, 812),
            pixelRatio: 3.0,
            portrait: const EdgeInsets.only(
              top: 44,
              bottom: 34,
            ),
            landscape: const EdgeInsets.only(
              left: 44,
              right: 44,
              bottom: 21,
            ),
          ),
        );
      case CupertinoDevice.iPhoneXsMax:
        return CupertinoPhoneWithNotchFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(414, 896),
            pixelRatio: 3.0,
            portrait: const EdgeInsets.only(
              top: 44,
              bottom: 34,
            ),
            landscape: const EdgeInsets.only(
              left: 44,
              right: 44,
              bottom: 21,
            ),
          ),
        );
      case CupertinoDevice.iPhoneX:
      default:
        return CupertinoPhoneWithNotchFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(375, 812),
            pixelRatio: 3.0,
            portrait: const EdgeInsets.only(
              top: 44,
              bottom: 34,
            ),
            landscape: const EdgeInsets.only(
              left: 44,
              right: 44,
              bottom: 21,
            ),
          ),
        );
    }
  }
}

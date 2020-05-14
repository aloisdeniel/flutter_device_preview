import 'package:flutter/widgets.dart';
import 'package:device_frame/src/helpers/orientation.dart';

import '../../device_frame.dart';
import 'phones.dart';
import 'tablets.dart';

enum AndroidDevice {
  // Phones
  smallPhone,
  mediumPhone,
  largePhone,

  // Tablets
  smallTablet,
  mediumTablet,
}

class AndroidDeviceFrame extends StatelessWidget {
  final AndroidDevice device;
  final Orientation orientation;
  final Widget child;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  const AndroidDeviceFrame({
    AndroidDevice device,
    this.orientation,
    this.isKeyboardVisible = false,
    this.keyboardTransitionDuration = const Duration(milliseconds: 500),
    this.style,
    @required this.child,
  })  : assert(child != null),
        this.device = device ?? AndroidDevice.mediumPhone;

  @override
  Widget build(BuildContext context) {
    switch (device) {
      case AndroidDevice.smallTablet:
        return AndroidTabletFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(600, 960),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(
              top: 20,
            ),
          ),
        );
      case AndroidDevice.mediumTablet:
        return AndroidTabletFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(800, 1280),
            pixelRatio: 2.0,
            portrait: const EdgeInsets.only(
              top: 20,
            ),
            landscape: EdgeInsets.zero,
          ),
        );
      case AndroidDevice.smallPhone:
        return AndroidPhoneFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(320, 569),
            pixelRatio: 1.5,
            portrait: const EdgeInsets.only(
              top: 20,
            ),
          ),
        );
      case AndroidDevice.largePhone:
        return AndroidPhoneFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(480, 853),
            pixelRatio: 3.0,
            portrait: const EdgeInsets.only(
              top: 20,
            ),
          ),
        );
      case AndroidDevice.mediumPhone:
      default:
        return AndroidPhoneFrame(
          child: child,
          style: style,
          isKeyboardVisible: isKeyboardVisible,
          keyboardTransitionDuration: keyboardTransitionDuration,
          orientation: orientation,
          mediaQueryData: orientation.toMediaQuery(
            size: const Size(360, 740),
            pixelRatio: 4.0,
            portrait: const EdgeInsets.only(
              top: 20,
            ),
          ),
        );
    }
  }
}

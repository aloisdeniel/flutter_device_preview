import 'package:device_frame/src/generic/mobile_frame.dart';
import 'package:flutter/widgets.dart';

import '../../device_frame.dart';

class CupertinoPhoneFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  CupertinoPhoneFrame({
    Key key,
    @required this.orientation,
    @required this.mediaQueryData,
    @required this.child,
    this.style,
    this.isKeyboardVisible = false,
    this.keyboardTransitionDuration = const Duration(milliseconds: 500),
  })  : assert(mediaQueryData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileDeviceFrame(
      platform: TargetPlatform.iOS,
      style: style,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
      isKeyboardVisible: isKeyboardVisible,
      keyboardTransitionDuration: keyboardTransitionDuration,
      child: child,
      body: EdgeInsets.only(
        top: 96,
        right: 18,
        left: 18,
        bottom: 96,
      ),
      edgeRadius: BorderRadius.all(Radius.circular(56)),
      screenRadius: BorderRadius.all(Radius.circular(2)),
      sideButtons: [
        DeviceSideButton.left(
          fromTop: 96,
          size: 35,
          thickness: 6,
        ),
        DeviceSideButton.left(
          fromTop: 156,
          size: 60,
          thickness: 6,
        ),
        DeviceSideButton.left(
          fromTop: 220,
          size: 60,
          thickness: 6,
        ),
        DeviceSideButton.right(
          fromTop: 156,
          size: 60,
          thickness: 6,
        ),
      ],
    );
  }
}

class CupertinoPhoneWithNotchFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  CupertinoPhoneWithNotchFrame({
    Key key,
    @required this.orientation,
    @required this.mediaQueryData,
    @required this.child,
    this.style,
    this.isKeyboardVisible = false,
    this.keyboardTransitionDuration = const Duration(milliseconds: 500),
  })  : assert(mediaQueryData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileDeviceFrame(
      platform: TargetPlatform.iOS,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
      isKeyboardVisible: isKeyboardVisible,
      keyboardTransitionDuration: keyboardTransitionDuration,
      child: child,
      body: EdgeInsets.only(
        top: 18,
        right: 18,
        left: 18,
        bottom: 18,
      ),
      edgeRadius: BorderRadius.all(Radius.circular(56)),
      screenRadius: BorderRadius.all(Radius.circular(38)),
      sideButtons: [
        DeviceSideButton.left(
          fromTop: 116,
          size: 35,
          thickness: 6,
        ),
        DeviceSideButton.left(
          fromTop: 176,
          size: 60,
          thickness: 6,
        ),
        DeviceSideButton.left(
          fromTop: 240,
          size: 60,
          thickness: 6,
        ),
        DeviceSideButton.right(
          fromTop: 176,
          size: 90,
          thickness: 6,
        ),
      ],
      notch: DeviceNotch(
        width: 210,
        height: 28,
        joinRadius: Radius.circular(12),
        radius: Radius.circular(24),
      ),
    );
  }
}

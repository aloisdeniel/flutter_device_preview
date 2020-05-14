import 'package:device_frame/src/generic/mobile_frame.dart';
import 'package:flutter/widgets.dart';

import '../../device_frame.dart';

class AndroidPhoneFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  AndroidPhoneFrame({
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
      platform: TargetPlatform.android,
      orientation: orientation,
      style: style,
      mediaQueryData: mediaQueryData,
      isKeyboardVisible: isKeyboardVisible,
      keyboardTransitionDuration: keyboardTransitionDuration,
      child: child,
      body: EdgeInsets.only(
        top: 64,
        right: 8,
        left: 8,
        bottom: 38,
      ),
      edgeRadius: BorderRadius.all(Radius.circular(56)),
      screenRadius: BorderRadius.all(Radius.circular(24)),
      sideButtons: [
        DeviceSideButton.right(
          fromTop: 156,
          size: 60,
          thickness: 3,
        ),
        DeviceSideButton.right(
          fromTop: 236,
          size: 100,
          thickness: 3,
        ),
      ],
    );
  }
}

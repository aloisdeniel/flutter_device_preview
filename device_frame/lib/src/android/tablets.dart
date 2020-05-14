import 'package:device_frame/src/generic/mobile_frame.dart';
import 'package:flutter/widgets.dart';

import '../../device_frame.dart';

class AndroidTabletFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;
  final DeviceFrameStyle style;

  const AndroidTabletFrame({
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
      style: style,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
      isKeyboardVisible: isKeyboardVisible,
      keyboardTransitionDuration: keyboardTransitionDuration,
      child: child,
      body: EdgeInsets.only(
        top: 32,
        right: 12,
        left: 12,
        bottom: 48,
      ),
      edgeRadius: BorderRadius.all(Radius.circular(32)),
      screenRadius: BorderRadius.all(Radius.circular(16)),
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

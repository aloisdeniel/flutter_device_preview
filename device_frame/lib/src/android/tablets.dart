import 'package:device_frame/src/generic/mobile_frame.dart';
import 'package:flutter/widgets.dart';

class AndroidTabletFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;

  const AndroidTabletFrame({
    Key key,
    @required this.orientation,
    @required this.mediaQueryData,
    @required this.child,
  })  : assert(mediaQueryData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileDeviceFrame(
      platform: TargetPlatform.android,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
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

import 'package:device_frame/src/generic/mobile_frame.dart';
import 'package:flutter/widgets.dart';

class CupertinoTabletFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;

  const CupertinoTabletFrame({
    Key key,
    @required this.orientation,
    @required this.mediaQueryData,
    @required this.child,
  })  : assert(mediaQueryData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileDeviceFrame(
      platform: TargetPlatform.iOS,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
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

class CupertinoTabletWithThinBordersFrame extends StatelessWidget {
  final Orientation orientation;
  final Widget child;
  final MediaQueryData mediaQueryData;

  const CupertinoTabletWithThinBordersFrame({
    Key key,
    @required this.orientation,
    @required this.mediaQueryData,
    @required this.child,
  })  : assert(mediaQueryData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileDeviceFrame(
      platform: TargetPlatform.iOS,
      orientation: orientation,
      mediaQueryData: mediaQueryData,
      child: child,
      body: EdgeInsets.only(
        top: 36,
        right: 36,
        left: 36,
        bottom: 36,
      ),
      edgeRadius: BorderRadius.all(Radius.circular(56)),
      screenRadius: BorderRadius.all(Radius.circular(16)),
      sideButtons: [
        DeviceSideButton.right(
          fromTop: 96,
          size: 42,
          thickness: 6,
        ),
        DeviceSideButton.right(
          fromTop: 146,
          size: 42,
          thickness: 6,
        ),
        DeviceSideButton.top(
          fromLeft: mediaQueryData.size.width + 36 * 2 - 24,
          size: 40,
          thickness: 6,
        ),
      ],
    );
  }
}

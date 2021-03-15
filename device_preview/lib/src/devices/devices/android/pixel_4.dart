import 'package:device_preview/src/devices/device.dart';
import 'package:flutter/widgets.dart';

final pixel4 = Device(
  name: 'Pixel 4',
  platform: TargetPlatform.android,
  physicalSize: Size(400, 600),
  pixelRatio: 3,
  padding: const {
    Orientation.portrait: EdgeInsets.only(top: 40),
    Orientation.landscape: EdgeInsets.only(
      right: 40,
      left: 40,
    ),
  },
);

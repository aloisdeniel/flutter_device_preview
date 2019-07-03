import 'package:flutter/widgets.dart';

import '../device_frame.dart';
import 'devices.dart';

const freeform = const Device.android(
  name: "Android Freeform",
  type: DeviceType.freeform,
  frame: DeviceFrame(),
  landscape: MediaQueryData(
      padding: EdgeInsets.only(top: 20.0),
      size: Size(0, 0),
      devicePixelRatio: 2.0),
);

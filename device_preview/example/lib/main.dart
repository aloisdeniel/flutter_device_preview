import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic/basic.dart';

void main() {
  DevicePreview().initialize();
  runApp(BasicApp());
}

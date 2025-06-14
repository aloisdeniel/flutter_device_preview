import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic.dart';
import 'custom_plugin.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      enableQuickDevicesTools: true,
      tools: const [
        ...DevicePreview.defaultTools,
        CustomPlugin(),
      ],
      quickDevices: [
        Devices.ios.iPhone13ProMax,
        Devices.ios.iPadPro11Inches,
      ],
      builder: (context) => const BasicApp(),
    ),
  );
}

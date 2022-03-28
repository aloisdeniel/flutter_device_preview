import 'package:device_preview_community/device_preview.dart';
import 'package:flutter/widgets.dart';

typedef ScreenshotProcessor = Future<void> Function(
  BuildContext context,
  DeviceScreenshot screenshot,
);

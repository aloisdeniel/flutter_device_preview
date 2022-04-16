import 'dart:convert';
import 'dart:developer';

import 'package:device_preview_community/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Prints screenshot in the console as base 64 strings.
///
/// The image can then be decoded with tools like [this one](https://codebeautify.org/base64-to-image-converter).
Future<void> screenshotAsBase64(
  BuildContext context,
  DeviceScreenshot screenshot,
) async {
  var result = base64.encode(screenshot.bytes);
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  log('Screenshot ${screenshot.device.identifier} $timestamp (also in clipboard) -> $result');
  await Clipboard.setData(
    ClipboardData(text: result),
  );
}

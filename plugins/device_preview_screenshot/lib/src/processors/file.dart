import 'dart:io';
import 'dart:ui';

import 'package:path/path.dart';

import 'processor.dart';

/// Saves the received screenshots to the given [directory].
///
/// The output file image format is `<deviceId>_<timestamp>.<png|bmp>`.
ScreenshotProcessor screenshotAsFiles(Directory directory) {
  return (context, screenshot) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = () {
      switch (screenshot.format) {
        case ImageByteFormat.png:
          return '.png';
        case ImageByteFormat.rawUnmodified:
        case ImageByteFormat.rawRgba:
          return '.bmp';
      }
    }();
    final file = File(
      join(
        directory.path,
        '${screenshot.device.identifier}_$timestamp$extension',
      ),
    );

    await file.writeAsBytes(screenshot.bytes);
  };
}

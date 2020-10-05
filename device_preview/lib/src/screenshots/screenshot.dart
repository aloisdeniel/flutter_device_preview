import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:device_frame/device_frame.dart';
import 'package:meta/meta.dart';

/// A screenshot from a [device].
class DeviceScreenshot {
  /// The device from which the screenshot was taken from.
  final DeviceInfo device;

  /// The binary content of the resulting image file.
  final Uint8List bytes;

  /// The format in which image bytes should be returned when using.
  final ui.ImageByteFormat format;

  DeviceScreenshot({
    @required this.device,
    @required this.bytes,
    @required this.format,
  });
}

/// Process a given [screenshot] and returns a displayed message.
///
/// See also :
///   * [DevicePreview] uses it to process all the screenshots taken by the user.
typedef ScreenshotProcessor = Future<String> Function(
  DeviceScreenshot screenshot,
);

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:meta/meta.dart';
import '../devices/devices.dart';

/// A screenshot from a [device].
class DeviceScreenshot {
  /// The device from which the screenshot was taken from.
  final Device device;

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

/// Process a given [screenshot].
///
/// See also :
///   * [DevicePreview] uses it to process all the screenshots taken by the user.
typedef ScreenshotProcessor = Future<void> Function(
  DeviceScreenshot screenshot,
);

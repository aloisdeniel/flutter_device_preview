import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:meta/meta.dart';
import '../devices/devices.dart';

class DeviceScreenshot {
  final Device device;
  final Uint8List bytes;
  final ui.ImageByteFormat format;
  DeviceScreenshot(
      {@required this.device, @required this.bytes, @required this.format});
}

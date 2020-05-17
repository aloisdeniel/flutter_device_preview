import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';

const String host = 'https://file.io/?expires=1';

Future<String> onScreenshot(DeviceScreenshot screenshot) async {
  var shot = decodeImage(screenshot.bytes);

  var size = screenshot.device.portrait.size;
  var acpect = screenshot.device.portrait.size.aspectRatio;
  var ratio = screenshot.device.portrait.devicePixelRatio;

  if (shot.width > shot.height) {
    size = screenshot.device.landscape.size;
    acpect = screenshot.device.landscape.size.aspectRatio;
    ratio = screenshot.device.landscape.devicePixelRatio;
  }

  final width = (size.width * ratio).round();
  final heigth = (size.height * ratio).round();

  final image = Image(width, heigth);

  shot = copyResize(
    dropShadow(shot, 0, 0, 0),
    height: acpect >= 0.5 ? heigth : null,
    width: acpect <= 0.5 ? width : null,
  );

  image.fill(getColor(255, 255, 255));

  final x = ((image.width - shot.width) / 2).round();
  final y = ((image.height - shot.height) / 2).round();

  copyInto(
    image,
    shot,
    dstX: x,
    dstY: y,
  );

  var request = http.MultipartRequest('POST', Uri.parse(host));
  request.files.add(
    http.MultipartFile.fromBytes(
      'file',
      encodeJpg(image),
      filename: 'screenshot.jpg',
    ),
  );

  final response = await request.send();

  if (response.statusCode != 200) {
    throw Error();
  }

  final bodyString = await response.stream.transform(utf8.decoder).join();
  final body = jsonDecode(bodyString);

  if (!body['success']) {
    throw Error();
  }

  final link = body['link'];
  print('[DevicePreview] Screenshot available here : $link');

  return 'Your screenshot is available here : $link';
}

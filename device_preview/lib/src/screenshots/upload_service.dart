import 'dart:convert';
import 'package:http/http.dart' as http;

import 'screenshot.dart';

abstract class ScreenshotUploader {
  const ScreenshotUploader();

  Future<String> upload(DeviceScreenshot screenshot);
}

class FileioScreenshotUploader extends ScreenshotUploader {
  const FileioScreenshotUploader();

  @override
  Future<String> upload(DeviceScreenshot screenshot) async {
    var request = http.MultipartRequest("POST", Uri.parse("https://file.io/?expires=1"));
    request.files.add(http.MultipartFile.fromBytes("file", screenshot.bytes,
        filename: "screenshot.png"));
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Error();
    }

    final bodyString = await response.stream.transform(utf8.decoder).join();
    final body = jsonDecode(bodyString);

    if (!body["success"]) {
      throw Error();
    }

    return body["link"];
  }
}

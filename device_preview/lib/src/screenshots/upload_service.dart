import 'dart:convert';
import 'package:http/http.dart' as http;

import 'screenshot.dart';

/// An uploader that sends screenshots to the the `https://file.io/` hosting
/// service and print the resulting url in the debugging console.
class FileioScreenshotUploader {
  const FileioScreenshotUploader();

  /// The host address used to post binaries.
  static const String host = 'https://file.io/?expires=1';

  /// Upload a given [screenshot] and print the resulting url in the debugging console.
  Future<String> upload(DeviceScreenshot screenshot) async {
    var request = http.MultipartRequest('POST', Uri.parse(host));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        screenshot.bytes,
        filename: 'screenshot.png',
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
}

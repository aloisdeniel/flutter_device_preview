import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:device_preview/src/device_preview.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../device_preview.dart';
import 'plugin.dart';

/// A plugin for device preview that allows to capture a screenshot from the
/// device (with its frame included).
///
/// An instance should be provided the the [plugins] constructor property of
/// a [DevicePreview].
class ScreenshotPlugin extends DevicePreviewPlugin {
  const ScreenshotPlugin({
    this.processor,
  }) : super(
          identifier: 'screenshot',
          name: 'Screenshot',
          icon: Icons.photo_camera,
          windowSize: const Size(220, 220),
        );

  /// A screenshot that processes a screenshot and returns the result as a display message.
  final ScreenshotProcessor? processor;

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    updateData,
  ) {
    return _Screenshot(
      processor: processor,
    );
  }
}

/// Process a given [screenshot] and returns a displayed message.
///
/// See also :
///   * [DevicePreview] uses it to process all the screenshots taken by the user.
typedef ScreenshotProcessor = Future<String> Function(
  DeviceScreenshot screenshot,
);

class _Screenshot extends StatefulWidget {
  const _Screenshot({
    Key? key,
    required this.processor,
  }) : super(key: key);

  final ScreenshotProcessor? processor;

  @override
  _ScreenshotState createState() => _ScreenshotState();
}

class _ScreenshotState extends State<_Screenshot> {
  String? link;
  dynamic error;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _take();
    });
    super.initState();
  }

  Future<void> _take() async {
    try {
      final screenshot = await DevicePreview.screenshot(context);

      final processor =
          widget.processor ?? const FileioScreenshotUploader().upload;

      final link = await processor(screenshot);
      await Clipboard.setData(ClipboardData(text: link));
      setState(() {
        this.link = link;
      });
    } catch (e) {
      setState(() {
        error = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = DevicePreviewTheme.of(context);
    if (error != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Text(
            'Error while processing screenshot : $error',
            style: theme.toolBar.fontStyles.body.copyWith(
              color: theme.toolBar.foregroundColor,
            ),
          ),
        ),
      );
    }
    if (link != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Text(
            'Your screenshot is available here: $link and in your clipboard!',
            style: theme.toolBar.fontStyles.body.copyWith(
              color: theme.toolBar.foregroundColor,
            ),
          ),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(theme.toolBar.foregroundColor),
      ),
    );
  }
}

/// An uploader that sends screenshots to the the `https://file.io/` hosting
/// service and print the resulting url in the debugging console.
class FileioScreenshotUploader {
  const FileioScreenshotUploader();

  /// The host address used to post binaries.
  static const String host = 'https://file.io/?expires=1d';

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
    print('[DevicePreview] Screenshot available here: $link');

    return link;
  }
}

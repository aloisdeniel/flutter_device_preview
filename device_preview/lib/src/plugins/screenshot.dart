import 'package:device_preview/src/device_preview.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'plugin.dart';

class ScreenshotPlugin extends DevicePreviewPlugin {
  const ScreenshotPlugin()
      : super(
          identifier: 'screenshot',
          name: 'Screenshot',
          icon: Icons.photo_camera,
          windowSize: const Size(220, 220),
        );

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    updateData,
  ) {
    return _Screenshot();
  }
}

class _Screenshot extends StatefulWidget {
  const _Screenshot({
    Key key,
  }) : super(key: key);

  @override
  _ScreenshotState createState() => _ScreenshotState();
}

class _ScreenshotState extends State<_Screenshot> {
  String link;
  dynamic error;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _take();
    });
    super.initState();
  }

  Future<void> _take() async {
    try {
      final screenshot = await DevicePreview.screenshot(context);
      final link = await DevicePreview.processScreenshot(context, screenshot);
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
          child: Text('Error while processing screenshot : $error'),
        ),
      );
    }
    if (link != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Text(
              'Your screenshot is available here: $link and in your clipboard!'),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

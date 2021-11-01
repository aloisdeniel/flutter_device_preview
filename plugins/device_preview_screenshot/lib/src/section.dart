import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'processors/base64.dart';
import 'processors/processor.dart';

/// A plugin that allows the user to take screenshots of its preview.
///
/// To activate the plugin, add a [DevicePreviewScreenshot] instance to
/// the `tools` property of the [DevicePreview].
///
/// This sample shows how to define an app with the plugin.
///
/// ```dart
/// DevicePreview(
///   builder: (context) => MaterialApp(
///      useInheritedMediaQuery: true,
///      locale: DevicePreview.locale(context),
///      builder: DevicePreview.appBuilder,
///      theme: ThemeData.light(),
///      darkTheme: ThemeData.dark(),
///      home: const Home(),
///    ),
///   tools: [
///      ...DevicePreview.defaultTools,
///      const DevicePreviewScreenshot(),
///   ]
/// )
/// ```
class DevicePreviewScreenshot extends StatefulWidget {
  const DevicePreviewScreenshot({
    Key? key,
    this.onScreenshot = screenshotAsBase64,
  }) : super(key: key);

  final ScreenshotProcessor onScreenshot;

  @override
  State<DevicePreviewScreenshot> createState() =>
      _DevicePreviewScreenshotState();
}

class _DevicePreviewScreenshotState extends State<DevicePreviewScreenshot> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ToolPanelSection(
      title: 'Screenshot',
      children: [
        ListTile(
          title: const Text('Take a screenshot'),
          subtitle: const Text('Currently selected device'),
          trailing: _isLoading ? const CircularProgressIndicator() : null,
          onTap: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final result = await DevicePreview.screenshot(context);
                    await widget.onScreenshot(
                      this.context,
                      result,
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
        ),
        ListTile(
          title: const Text('Take multiple screenshots'),
          subtitle: const Text('All available devices'),
          trailing: _isLoading ? const CircularProgressIndicator() : null,
          onTap: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final initialDevice = DevicePreview.selectedDevice(context);
                    for (var device
                        in DevicePreview.availableDeviceIdentifiers(context)) {
                      DevicePreview.selectDevice(
                        context,
                        device,
                      );
                      await Future.delayed(const Duration(milliseconds: 500));
                      final result = await DevicePreview.screenshot(context);
                      await widget.onScreenshot(this.context, result);
                    }
                    DevicePreview.selectDevice(
                      context,
                      initialDevice.identifier,
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
        ),
      ],
    );
  }
}

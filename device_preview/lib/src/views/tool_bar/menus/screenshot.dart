import 'package:flutter/widgets.dart';

import '../../device_preview_style.dart';

class ScreenshotPopOver extends StatelessWidget {
  final String message;

  const ScreenshotPopOver(this.message);

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(
          color: toolBarStyle.foregroundColor,
        ),
      ),
    );
  }
}

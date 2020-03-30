import 'package:flutter/widgets.dart';

import '../tool_bar_theme.dart';

class ScreenshotPopOver extends StatelessWidget {
  final String message;

  const ScreenshotPopOver(this.message);

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewToolBarTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        message,
        style: TextStyle(
          color: toolBarStyle.foregroundColor,
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../device_preview_style.dart';
import '../button.dart';

class ScreenshotPopOver extends StatelessWidget {
  final String message;

  const ScreenshotPopOver(this.message);

  void launchUrl() async {
    String url = message.split(' ')[6];
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void copyToClipboard() {
    String url = message.split(' ')[6];
    FlutterClipboardManager.copyToClipBoard(url);
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: launchUrl,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: toolBarStyle.foregroundColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToolBarButton(
                    title: 'Copy To Clipboard',
                    icon: FontAwesomeIcons.clipboard,
                    onTap: copyToClipboard,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

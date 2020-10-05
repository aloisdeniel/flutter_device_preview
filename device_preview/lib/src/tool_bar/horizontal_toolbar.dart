import 'dart:math' as math;
import 'package:device_preview/src/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/tool_bar/menus/devices.dart';
import 'package:device_preview/src/tool_bar/menus/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../device_preview.dart';
import '../utilities/spacing.dart';

import 'button.dart';
import 'format.dart';
import 'menus/locales.dart';
import 'menus/popover.dart';
import 'menus/screenshot.dart';

class DevicePreviewHorizontalToolBar extends StatefulWidget {
  DevicePreviewHorizontalToolBar({
    Key key,
  }) : super(key: key);

  static double height(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return 60 +
        12 +
        (toolBarStyle.position == DevicePreviewToolBarPosition.bottom
            ? mediaQuery.padding.bottom
            : mediaQuery.padding.top);
  }

  @override
  _DevicePreviewToolBarState createState() => _DevicePreviewToolBarState();
}

class _DevicePreviewToolBarState extends State<DevicePreviewHorizontalToolBar> {
  String screenShotmessage;

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final mediaQuery = MediaQuery.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final deviceButton = Popover(
      title: 'Devices',
      icon: Icons.devices,
      builder: (context, _) => DevicesPopOver(),
      child: Builder(
        builder: (context) => ToolBarButton(
          isRounded: true,
          title: preview.deviceInfo?.name,
          icon: preview.deviceInfo?.identifier?.typeIcon(),
          onTap: () => Popover.open(context),
        ),
      ),
    );
    final isBottom =
        toolBarStyle.position == DevicePreviewToolBarPosition.bottom;
    return ClipPath(
      clipper: _ToolBarClipper(
        position: toolBarStyle.position,
      ),
      child: Container(
        color: toolBarStyle.backgroundColor,
        height: DevicePreviewHorizontalToolBar.height(context),
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
            left: 12.0 + mediaQuery.padding.left,
            right: 12.0 + mediaQuery.padding.right,
            top: 12.0 + (!isBottom ? mediaQuery.padding.top : 12.0),
            bottom: 12.0 + (isBottom ? mediaQuery.padding.bottom : 12.0),
          ),
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Switch(
                value: preview.isEnabled ?? true,
                onChanged: (v) => preview.isEnabled = v,
                activeColor: toolBarStyle.foregroundColor.withOpacity(1),
                inactiveTrackColor:
                    toolBarStyle.foregroundColor.withOpacity(0.22),
              ),
            ),
            if (!preview.isEnabled)
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Device preview disabled',
                  style: TextStyle(
                    color: toolBarStyle.foregroundColor.withOpacity(0.4),
                  ),
                ),
              ),
            if (preview.isEnabled)
              ...[
                SizedBox(
                  width: 4,
                ),
                deviceButton,
                Popover(
                  title: 'Locales',
                  icon: Icons.language,
                  builder: (context, _) => LocalesPopOver(),
                  child: Builder(
                    builder: (context) => ToolBarButton(
                      isRounded: true,
                      title: preview.locale?.toString(),
                      icon: Icons.language,
                      onTap: () => Popover.open(context),
                    ),
                  ),
                ),
                if (preview.deviceInfo?.rotatedSafeAreas != null)
                  ToolBarButton(
                    title: 'Rotate',
                    icon: Icons.screen_rotation,
                    onTap: () => preview.rotate(),
                  ),
                ToolBarButton(
                  title:
                      !preview.isFrameVisible ? 'Display frame' : 'Hide frame',
                  icon: Icons.border_outer,
                  onTap: () => preview.toggleFrame(),
                ),
                ToolBarButton(
                  title: preview.isVirtualKeyboardVisible
                      ? 'Hide keyboard'
                      : 'Show keyboard',
                  icon: preview.isVirtualKeyboardVisible
                      ? Icons.keyboard_hide
                      : Icons.keyboard,
                  onTap: () => preview.isVirtualKeyboardVisible =
                      !preview.isVirtualKeyboardVisible,
                ),
                ToolBarButton(
                  title: preview.isDarkMode ? 'Dark' : 'Light',
                  icon: preview.isDarkMode
                      ? Icons.brightness_3
                      : Icons.brightness_high,
                  onTap: () => preview.isDarkMode = !preview.isDarkMode,
                ),
                Popover(
                  title: 'Screenshot',
                  size: Size(300, 300),
                  icon: Icons.photo_camera,
                  builder: (context, _) =>
                      ScreenshotPopOver(screenShotmessage ?? ''),
                  child: Builder(
                    builder: (context) => ToolBarButton(
                      title: 'Screenshot',
                      icon: Icons.photo_camera,
                      onTap: () async {
                        try {
                          final screenshot = await preview.screenshot();
                          var link =
                              await preview.processScreenshot(screenshot);
                          screenShotmessage =
                              'Your screenshot is available here: $link and in your clipboard!';
                          await Clipboard.setData(ClipboardData(text: link));
                        } catch (e) {
                          screenShotmessage =
                              'Error while processing screenshot : $e';
                          print(
                              '[DevicePreview] Error while processing screenshot : $e');
                        }
                        Popover.open(context);
                      },
                    ),
                  ),
                ),
                Popover(
                  title: 'Accessibility',
                  size: Size(280, 300),
                  icon: Icons.accessibility_new,
                  builder: (context, _) => AccessibilityPopOver(),
                  child: Builder(
                    builder: (context) => ToolBarButton(
                      title: 'Accessibility',
                      icon: Icons.accessibility_new,
                      onTap: () => Popover.open(context),
                    ),
                  ),
                ),
                Popover(
                  title: 'Settings',
                  size: Size(280, 320),
                  icon: Icons.tune,
                  builder: (context, close) => StylePopOver(close),
                  child: Builder(
                    builder: (context) => ToolBarButton(
                      icon: Icons.tune,
                      onTap: () => Popover.open(context),
                    ),
                  ),
                ),
              ].spaced(
                horizontal: 12,
              ),
          ],
        ),
      ),
    );
  }
}

class _ToolBarClipper extends CustomClipper<Path> {
  final double radius;
  final DevicePreviewToolBarPosition position;

  const _ToolBarClipper({
    @required this.position,
    this.radius = 12.0,
  });

  @override
  Path getClip(Size size) {
    final inverted = DevicePreviewToolBarPosition.top == position;
    final width = size.width;
    final height = size.height;
    var result = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, 0, 0, radius, radius, radius)
      ..lineTo(width - radius, radius)
      ..cubicTo(width, radius, width, 0, width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    if (inverted) {
      final transform = Matrix4.translationValues(width / 2, height / 2, 0) *
          Matrix4.rotationZ(math.pi) *
          Matrix4.translationValues(-width / 2, -height / 2, 0);
      result = result.transform(transform.storage);
    }

    return result;
  }

  @override
  bool shouldReclip(covariant _ToolBarClipper oldClipper) {
    return radius != oldClipper?.radius || position != oldClipper?.position;
  }
}

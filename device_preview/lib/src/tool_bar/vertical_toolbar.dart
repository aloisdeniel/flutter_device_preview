import 'dart:math' as math;

import 'package:device_preview/src/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/tool_bar/menus/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../device_preview.dart';
import '../utilities/spacing.dart';

import 'button.dart';
import 'menus/locales.dart';
import 'menus/popover.dart';
import 'menus/screenshot.dart';
import 'menus/style.dart';

class DevicePreviewVerticalToolBar extends StatefulWidget {
  DevicePreviewVerticalToolBar({
    Key key,
  }) : super(key: key);

  static double width(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return 180 +
        12 +
        (toolBarStyle.position == DevicePreviewToolBarPosition.left
            ? mediaQuery.padding.left
            : mediaQuery.padding.right);
  }

  @override
  _DevicePreviewToolBarState createState() => _DevicePreviewToolBarState();
}

class _DevicePreviewToolBarState extends State<DevicePreviewVerticalToolBar> {
  String screenShotmessage;

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final mediaQuery = MediaQuery.of(context);
    final showTitles = mediaQuery.size.width > 500;
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    final deviceButton = Popover(
      title: 'Devices',
      icon: Icons.devices,
      builder: (context, _) => DevicesPopOver(),
      child: Builder(
        builder: (context) => ToolBarButton(
          title: preview.deviceInfo?.name,
          icon: Icons.phone_android,
          onTap: () => Popover.open(context),
        ),
      ),
    );

    final isLeft = toolBarStyle.position == DevicePreviewToolBarPosition.left;
    return ClipPath(
      clipper: _ToolBarClipper(
        position: toolBarStyle.position,
      ),
      child: Container(
        color: toolBarStyle.backgroundColor,
        child: SizedBox(
          width: DevicePreviewVerticalToolBar.width(context),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(
              top: 12.0 + mediaQuery.padding.top,
              bottom: 12.0 + mediaQuery.padding.bottom,
              left: 12.0 + (isLeft ? mediaQuery.padding.left : 12.0),
              right: 12.0 + (!isLeft ? mediaQuery.padding.right : 12.0),
            ),
            children: <Widget>[
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Switch(
                    value: preview.isEnabled ?? true,
                    onChanged: (v) => preview.isEnabled = v,
                    activeColor: toolBarStyle.foregroundColor.withOpacity(1),
                    inactiveTrackColor:
                        toolBarStyle.foregroundColor.withOpacity(0.22),
                  ),
                ),
              ),
              if (!preview.isEnabled)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Device preview disabled',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: toolBarStyle.foregroundColor.withOpacity(0.4),
                    ),
                  ),
                ),
              if (preview.isEnabled)
                ...[
                  deviceButton,
                  Popover(
                    title: 'Locales',
                    icon: Icons.language,
                    builder: (context, _) => LocalesPopOver(),
                    child: Builder(
                      builder: (context) => ToolBarButton(
                        isRounded: true,
                        title: showTitles ? preview.locale?.toString() : null,
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
                    title: !preview.isFrameVisible
                        ? 'Display frame'
                        : 'Hide frame',
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
                    title: showTitles
                        ? (preview.isDarkMode ? 'Light' : 'Dark')
                        : null,
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
                        title: showTitles ? 'Take screenshot' : null,
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
                    title: 'Accesibility',
                    icon: Icons.accessibility_new,
                    size: Size(280, 300),
                    builder: (context, _) => AccessibilityPopOver(),
                    child: Builder(
                      builder: (context) => ToolBarButton(
                        title: showTitles ? 'Accesibility' : null,
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
                        title: showTitles ? 'Settings' : null,
                        icon: Icons.tune,
                        onTap: () => Popover.open(context),
                      ),
                    ),
                  ),
                ].spaced(
                  vertical: 12,
                ),
            ],
          ),
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
    final inverted = DevicePreviewToolBarPosition.right == position;
    final width = size.height;
    final height = size.width;
    var result = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, 0, 0, radius, radius, radius)
      ..lineTo(width - radius, radius)
      ..cubicTo(width, radius, width, 0, width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    final transform = Matrix4.translationValues(height / 2, width / 2, 0) *
        Matrix4.rotationZ(math.pi / 2 + (inverted ? math.pi : 0)) *
        Matrix4.translationValues(-width / 2, -height / 2, 0);
    result = result.transform(transform.storage);

    return result;
  }

  @override
  bool shouldReclip(covariant _ToolBarClipper oldClipper) {
    return radius != oldClipper?.radius || position != oldClipper?.position;
  }
}

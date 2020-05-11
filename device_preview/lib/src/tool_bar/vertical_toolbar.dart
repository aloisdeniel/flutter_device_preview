import 'package:device_preview/src/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/tool_bar/menus/devices.dart';
import 'package:device_preview/src/tool_bar/menus/size.dart';
import 'package:flutter/material.dart';
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
          isRoundedTop: true,
          title: preview.device?.name,
          icon: Icons.phone_android,
          onTap: () => Popover.open(context),
        ),
      ),
    );

    final widthButton = Popover(
      title: 'Screen width',
      icon: Icons.border_horizontal,
      builder: (context, _) => SizePopOver(
        value: preview.freeformSize.width,
        onChanged: (v) =>
            preview.freeformSize = Size(v, preview.freeformSize.height),
      ),
      child: Builder(
        builder: (context) => ToolBarButton(
          isRoundedBottomLeft: true,
          title: showTitles
              ? (preview.device?.portrait?.size?.width ??
                      preview.freeformSize.width)
                  ?.toInt()
                  ?.toString()
              : null,
          icon: Icons.border_horizontal,
          onTap: preview.device.type == DeviceType.freeform
              ? () => Popover.open(context)
              : null,
        ),
      ),
    );

    final heightButton = Popover(
      title: 'Screen height',
      icon: Icons.border_horizontal,
      builder: (context, _) => SizePopOver(
        value: preview.freeformSize.height,
        onChanged: (v) => preview.freeformSize = Size(
          preview.freeformSize.width,
          v,
        ),
      ),
      child: Builder(
        builder: (context) => ToolBarButton(
          isRoundedBottomRight: true,
          title: showTitles
              ? (preview.device?.portrait?.size?.height ??
                      preview.freeformSize.height)
                  ?.toInt()
                  ?.toString()
              : null,
          icon: Icons.border_vertical,
          onTap: preview.device.type == DeviceType.freeform
              ? () => Popover.open(context)
              : null,
        ),
      ),
    );

    final space = const SizedBox(
      width: 1,
      height: 1,
    );

    return Container(
      color: toolBarStyle.backgroundColor,
      child: SizedBox(
        width: 180 +
            (toolBarStyle.position == DevicePreviewToolBarPosition.left
                ? mediaQuery.padding.left
                : mediaQuery.padding.right),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
            top: 12.0 + mediaQuery.padding.top,
            bottom: 12.0 + mediaQuery.padding.bottom,
            left: 12.0 +
                (toolBarStyle.position == DevicePreviewToolBarPosition.left
                    ? mediaQuery.padding.left
                    : 0.0),
            right: 12.0 +
                (toolBarStyle.position == DevicePreviewToolBarPosition.right
                    ? mediaQuery.padding.right
                    : 0.0),
          ),
          children: <Widget>[
            Column(
              children: <Widget>[
                deviceButton,
                space,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: widthButton),
                    space,
                    Expanded(child: heightButton),
                  ],
                ),
              ],
            ),
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
            ToolBarButton(
              title: 'Rotate',
              icon: Icons.screen_rotation,
              onTap: preview.device.type == DeviceType.freeform
                  ? null
                  : () => preview.rotate(),
            ),
            ToolBarButton(
              title: showTitles ? 'Restart' : null,
              icon: Icons.refresh,
              onTap: () => preview.restart(),
            ),
            ToolBarButton(
              title: !preview.isFrameVisible ? 'Display frame' : 'Hide frame',
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
              title:
                  showTitles ? (preview.isDarkMode ? 'Light' : 'Dark') : null,
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
                      screenShotmessage =
                          await preview.processScreenshot(screenshot);
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
            vertical: 12.0,
          ),
        ),
      ),
    );
  }
}

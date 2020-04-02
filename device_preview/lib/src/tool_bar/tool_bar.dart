import 'package:device_preview/src/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/tool_bar/menus/devices.dart';
import 'package:device_preview/src/tool_bar/menus/size.dart';
import 'package:device_preview/src/tool_bar/tool_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../device_preview.dart';
import '../utilities/spacing.dart';

import 'button.dart';
import 'menus/locales.dart';
import 'menus/popover.dart';
import 'menus/screenshot.dart';

class DevicePreviewToolBar extends StatefulWidget {
  DevicePreviewToolBar({
    Key key,
  }) : super(key: key);

  @override
  _DevicePreviewToolBarState createState() => _DevicePreviewToolBarState();
}

class _DevicePreviewToolBarState extends State<DevicePreviewToolBar> {
  String screenShotmessage;

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final mediaQuery = MediaQuery.of(context);
    final showTitles = mediaQuery.size.width > 500;
    final toolBarStyle = DevicePreviewToolBarTheme.of(context);
    return Container(
      color: toolBarStyle.backgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: mediaQuery.padding.bottom,
          left: mediaQuery.padding.left,
          right: mediaQuery.padding.right,
        ),
        child: SizedBox(
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12.0),
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Popover(
                    title: 'Devices',
                    icon: Icons.devices,
                    builder: (context) => DevicesPopOver(),
                    child: Builder(
                      builder: (context) => ToolBarButton(
                        isRoundedLeft: true,
                        title: preview.device?.name,
                        icon: Icons.phone_android,
                        onTap: () => Popover.open(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Popover(
                    title: 'Screen width',
                    icon: Icons.border_horizontal,
                    builder: (context) => SizePopOver(
                      value: preview.freeformSize.width,
                      onChanged: (v) => preview.freeformSize =
                          Size(v, preview.freeformSize.height),
                    ),
                    child: Builder(
                      builder: (context) => ToolBarButton(
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
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Popover(
                    title: 'Screen height',
                    icon: Icons.border_horizontal,
                    builder: (context) => SizePopOver(
                      value: preview.freeformSize.height,
                      onChanged: (v) => preview.freeformSize = Size(
                        preview.freeformSize.width,
                        v,
                      ),
                    ),
                    child: Builder(
                      builder: (context) => ToolBarButton(
                        isRoundedRight: true,
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
                  ),
                ],
              ),
              Popover(
                title: 'Locales',
                icon: Icons.language,
                builder: (context) => LocalesPopOver(),
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
                builder: (context) =>
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
                builder: (context) => AccessibilityPopOver(),
                child: Builder(
                  builder: (context) => ToolBarButton(
                    title: showTitles ? 'Accesibility' : null,
                    icon: Icons.accessibility_new,
                    onTap: () => Popover.open(context),
                  ),
                ),
              ),
            ].spaced(horizontal: 12.0),
          ),
        ),
      ),
    );
  }
}

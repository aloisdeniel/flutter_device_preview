import 'dart:math' as math;
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../device_preview.dart';
import '../../utilities/spacing.dart';

import 'button.dart';
import 'format.dart';
import 'menus/accessibility.dart';
import 'menus/devices.dart';
import 'menus/locales.dart';
import 'menus/popover.dart';
import 'menus/screenshot.dart';
import 'menus/style.dart';

class DevicePreviewHorizontalToolBar extends StatefulWidget {
  final Rect overlayPosition;
  const DevicePreviewHorizontalToolBar({
    Key key,
    @required this.overlayPosition,
  }) : super(key: key);

  static double height(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return 60 +
        12 +
        (toolBarStyle.position == DevicePreviewToolBarPosition.bottom
            ? WidgetsBinding.instance.window.padding.bottom
            : WidgetsBinding.instance.window.padding.top);
  }

  @override
  _DevicePreviewToolBarState createState() => _DevicePreviewToolBarState();
}

class _DevicePreviewToolBarState extends State<DevicePreviewHorizontalToolBar> {
  String screenShotmessage;

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );

    final isFrameVisible = context.select(
      (DevicePreviewStore store) => store.data.isFrameVisible,
    );

    final name = context.select(
      (DevicePreviewStore store) => store.deviceInfo.name,
    );

    final deviceType = context.select(
      (DevicePreviewStore store) => store.deviceInfo.identifier.type,
    );

    final locale = context.select(
      (DevicePreviewStore store) => store.data.locale,
    );

    final rotatedSafeAreas = context.select(
      (DevicePreviewStore store) => store.deviceInfo.rotatedSafeAreas,
    );

    final isVirtualKeyboardVisible = context.select(
      (DevicePreviewStore store) => store.data.isVirtualKeyboardVisible,
    );

    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

    final mediaQuery = MediaQuery.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final deviceButton = Popover(
      title: 'Devices',
      parentBounds: widget.overlayPosition,
      icon: Icons.devices,
      builder: (context, _) => DevicesPopOver(),
      child: Builder(
        builder: (context) => ToolBarButton(
          isRounded: true,
          title: name,
          icon: deviceType.typeIcon(),
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
                value: isEnabled ?? true,
                onChanged: (v) {
                  final state = context.read<DevicePreviewStore>();
                  state.data = state.data.copyWith(isEnabled: v);
                },
                activeColor: toolBarStyle.foregroundColor.withOpacity(1),
                inactiveTrackColor:
                    toolBarStyle.foregroundColor.withOpacity(0.22),
              ),
            ),
            if (!isEnabled)
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Device preview disabled',
                  style: TextStyle(
                    color: toolBarStyle.foregroundColor.withOpacity(0.4),
                  ),
                ),
              ),
            if (isEnabled)
              ...[
                SizedBox(
                  width: 4,
                ),
                deviceButton,
                Popover(
                  title: 'Locales',
                  icon: Icons.language,
                  builder: (context, _) => LocalesPopOver(),
                  parentBounds: widget.overlayPosition,
                  child: Builder(
                    builder: (context) => ToolBarButton(
                      isRounded: true,
                      title: locale,
                      icon: Icons.language,
                      onTap: () => Popover.open(context),
                    ),
                  ),
                ),
                if (rotatedSafeAreas != null)
                  ToolBarButton(
                    title: 'Rotate',
                    icon: Icons.screen_rotation,
                    onTap: () {
                      final state = context.read<DevicePreviewStore>();
                      state.rotate();
                    },
                  ),
                ToolBarButton(
                  title: !isFrameVisible ? 'Display frame' : 'Hide frame',
                  icon: Icons.border_outer,
                  onTap: () {
                    final state = context.read<DevicePreviewStore>();
                    state.toggleFrame();
                  },
                ),
                ToolBarButton(
                  title: isVirtualKeyboardVisible
                      ? 'Hide keyboard'
                      : 'Show keyboard',
                  icon: isVirtualKeyboardVisible
                      ? Icons.keyboard_hide
                      : Icons.keyboard,
                  onTap: () {
                    final state = context.read<DevicePreviewStore>();
                    state.toggleVirtualKeyboard();
                  },
                ),
                ToolBarButton(
                  title: isDarkMode ? 'Dark' : 'Light',
                  icon: isDarkMode ? Icons.brightness_3 : Icons.brightness_high,
                  onTap: () {
                    final state = context.read<DevicePreviewStore>();
                    state.toggleDarkMode();
                  },
                ),
                Popover(
                  title: 'Screenshot',
                  parentBounds: widget.overlayPosition,
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
                          final screenshot =
                              await DevicePreview.screenshot(context);
                          var link = await DevicePreview.processScreenshot(
                              context, screenshot);
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
                  parentBounds: widget.overlayPosition,
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
                  parentBounds: widget.overlayPosition,
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

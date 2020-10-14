import 'dart:math' as math;
import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../device_preview.dart';
import '../../utilities/spacing.dart';

import 'format.dart';
import 'button.dart';
import 'menus/accessibility.dart';
import 'menus/devices.dart';
import 'menus/locales.dart';
import 'menus/popover.dart';
import 'menus/style.dart';

class DevicePreviewToolBar extends StatefulWidget {
  final Rect overlayPosition;
  const DevicePreviewToolBar({
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

  static double width(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return 180 +
        12 +
        (toolBarStyle.position == DevicePreviewToolBarPosition.left
            ? WidgetsBinding.instance.window.padding.left
            : WidgetsBinding.instance.window.padding.right);
  }

  @override
  _DevicePreviewToolBarState createState() => _DevicePreviewToolBarState();
}

class _DevicePreviewToolBarState extends State<DevicePreviewToolBar> {
  String screenShotmessage;

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );
    final canRotate = context.select(
      (DevicePreviewStore store) => store.deviceInfo.rotatedSafeAreas != null,
    );

    final mediaQuery = MediaQuery.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final deviceButton = Popover(
      title: 'Devices',
      parentBounds: widget.overlayPosition,
      icon: Icons.devices,
      builder: (context, _) => DevicesPopOver(),
      child: Builder(
        builder: (context) => Selector(
          selector: (context, DevicePreviewStore store) =>
              store.deviceInfo.name,
          builder: (context, name, _) => Selector(
            selector: (context, DevicePreviewStore store) =>
                store.deviceInfo.identifier.type,
            builder: (context, DeviceType deviceType, _) => ToolBarButton(
              isRounded: true,
              title: name,
              icon: deviceType.typeIcon(),
              onTap: () => Popover.open(context),
            ),
          ),
        ),
      ),
    );

    final isVertical =
        toolBarStyle.position == DevicePreviewToolBarPosition.left ||
            toolBarStyle.position == DevicePreviewToolBarPosition.right;
    return ClipPath(
      clipper: _ToolBarClipper(
        position: toolBarStyle.position,
      ),
      child: Container(
        color: toolBarStyle.backgroundColor,
        height: isVertical ? null : DevicePreviewToolBar.height(context),
        width: !isVertical ? null : DevicePreviewToolBar.width(context),
        child: ListView(
          scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
          padding: EdgeInsets.only(
            left: 12.0 +
                (toolBarStyle.position != DevicePreviewToolBarPosition.right
                    ? mediaQuery.padding.left
                    : 12.0),
            right: 12.0 +
                (toolBarStyle.position != DevicePreviewToolBarPosition.left
                    ? mediaQuery.padding.right
                    : 12.0),
            top: 12.0 +
                (toolBarStyle.position != DevicePreviewToolBarPosition.bottom
                    ? mediaQuery.padding.top
                    : 12.0),
            bottom: 12.0 +
                (toolBarStyle.position != DevicePreviewToolBarPosition.top
                    ? mediaQuery.padding.bottom
                    : 12.0),
          ),
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Center(
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
                Selector(
                  selector: (context, DevicePreviewStore store) =>
                      store.data.locale,
                  builder: (context, locale, _) => Popover(
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
                ),
                if (canRotate)
                  ToolBarButton(
                    title: 'Rotate',
                    icon: Icons.screen_rotation,
                    onTap: () {
                      final state = context.read<DevicePreviewStore>();
                      state.rotate();
                    },
                  ),
                Selector(
                  selector: (context, DevicePreviewStore store) =>
                      store.data.isFrameVisible,
                  builder: (context, isFrameVisible, _) => ToolBarButton(
                    title: !isFrameVisible ? 'Display frame' : 'Hide frame',
                    icon: Icons.border_outer,
                    onTap: () {
                      final state = context.read<DevicePreviewStore>();
                      state.toggleFrame();
                    },
                  ),
                ),
                Selector(
                  selector: (context, DevicePreviewStore store) =>
                      store.data.isVirtualKeyboardVisible,
                  builder: (context, isVirtualKeyboardVisible, _) =>
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
                ),
                Selector(
                  selector: (context, DevicePreviewStore store) =>
                      store.data.isDarkMode,
                  builder: (context, isDarkMode, _) => ToolBarButton(
                    title: isDarkMode ? 'Dark' : 'Light',
                    icon:
                        isDarkMode ? Icons.brightness_3 : Icons.brightness_high,
                    onTap: () {
                      final state = context.read<DevicePreviewStore>();
                      state.toggleDarkMode();
                    },
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
                ...DevicePreview.pluginsOf(context).map(
                  (plugin) => Popover(
                    key: Key(plugin.identifier),
                    title: plugin.name,
                    parentBounds: widget.overlayPosition,
                    size: plugin.windowSize ?? Size(280, 300),
                    icon: plugin.icon,
                    builder: (context, _) => plugin.build(context),
                    child: Builder(
                      builder: (context) => ToolBarButton(
                        title: plugin.name,
                        icon: plugin.icon,
                        onTap: () => Popover.open(context),
                      ),
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
                      title: isVertical ? 'Settings' : null,
                      icon: Icons.tune,
                      onTap: () => Popover.open(context),
                    ),
                  ),
                ),
              ].spaced(
                vertical: isVertical ? 12 : 0,
                horizontal: !isVertical ? 12 : 0,
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
    if ([
      DevicePreviewToolBarPosition.top,
      DevicePreviewToolBarPosition.bottom,
    ].contains(position)) {
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

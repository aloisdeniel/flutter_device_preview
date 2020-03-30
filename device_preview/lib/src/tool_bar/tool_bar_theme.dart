import 'package:device_preview/src/tool_bar/tool_bar_style.dart';
import 'package:flutter/material.dart';

class DevicePreviewToolBarTheme extends InheritedWidget {
  final DevicePreviewToolBarStyle style;

  DevicePreviewToolBarTheme({
    @required this.style,
    @required Widget child,
  }) : super(child: child);

  static DevicePreviewToolBarStyle of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewToolBarTheme>();
    return widget?.style ?? DevicePreviewToolBarStyle.dark();
  }

  @override
  bool updateShouldNotify(DevicePreviewToolBarTheme oldWidget) {
    return style != style;
  }
}

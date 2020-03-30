import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class DevicePreviewToolBarStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color buttonBackgroundColor;
  final Color buttonHoverBackgroundColor;

  const DevicePreviewToolBarStyle({
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.buttonBackgroundColor,
    @required this.buttonHoverBackgroundColor,
  })  : assert(backgroundColor != null),
        assert(foregroundColor != null),
        assert(buttonBackgroundColor != null),
        assert(buttonHoverBackgroundColor != null);

  const DevicePreviewToolBarStyle.dark()
      : backgroundColor = const Color(0xFF111111),
        buttonBackgroundColor = const Color(0xFF2F2F2F),
        buttonHoverBackgroundColor = const Color(0xFF555555),
        foregroundColor = const Color(0xFFFEFEFE);

  const DevicePreviewToolBarStyle.light()
      : backgroundColor = const Color(0xFFFEFEFE),
        buttonBackgroundColor = const Color(0xFFF0F0F0),
        buttonHoverBackgroundColor = const Color(0xFFFAFAFA),
        foregroundColor = const Color(0xFF333333);
}

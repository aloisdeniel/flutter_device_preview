import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

class DeviceFrameTheme extends InheritedWidget {
  final DeviceFrameStyle style;

  const DeviceFrameTheme({
    @required this.style,
    @required Widget child,
  }) : super(child: child);

  static DeviceFrameStyle of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<DeviceFrameTheme>();

    return widget?.style ?? DeviceFrameStyle.dark();
  }

  @override
  bool updateShouldNotify(DeviceFrameTheme oldWidget) {
    return oldWidget.style != style;
  }
}

@freezed
abstract class DeviceFrameStyle with _$DeviceFrameStyle {
  const factory DeviceFrameStyle({
    @required Color bodyColor,
    @required Color borderColor,
    @required Color buttonColor,
    @required Color shadowColor,
    @required DeviceKeyboardStyle keyboardStyle,
  }) = _DeviceFrameStyle;

  factory DeviceFrameStyle.dark({DeviceKeyboardStyle keyboardStyle}) =>
      DeviceFrameStyle(
        bodyColor: const Color(0xFF1A1A1A),
        buttonColor: const Color(0xFF2A2A2A),
        borderColor: const Color(0xFF5A5A5A),
        shadowColor: const Color(0x55000000),
        keyboardStyle: keyboardStyle ?? DeviceKeyboardStyle.dark(),
      );

  factory DeviceFrameStyle.light({DeviceKeyboardStyle keyboardStyle}) =>
      DeviceFrameStyle(
        bodyColor: const Color(0xFFFDFDFD),
        buttonColor: const Color(0xFF7C7C7C),
        borderColor: const Color(0xFFA5A5A5),
        shadowColor: const Color(0x55000000),
        keyboardStyle: keyboardStyle ?? DeviceKeyboardStyle.dark(),
      );
}

@freezed
abstract class DeviceKeyboardStyle with _$DeviceKeyboardStyle {
  const factory DeviceKeyboardStyle({
    @required Color backgroundColor,
    @required Color button1BackgroundColor,
    @required Color button1ForegroundColor,
    @required Color button2BackgroundColor,
    @required Color button2ForegroundColor,
  }) = _DeviceKeyboardStyle;

  factory DeviceKeyboardStyle.dark() => const DeviceKeyboardStyle(
        backgroundColor: Color(0xDD2B2B2D),
        button1BackgroundColor: Color(0xFF6D6D6E),
        button1ForegroundColor: Colors.white,
        button2BackgroundColor: Color(0xFF4A4A4B),
        button2ForegroundColor: Colors.white,
      );
}

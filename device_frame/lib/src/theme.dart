import 'package:flutter/foundation.dart';
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
  }) = _DeviceFrameStyle;

  factory DeviceFrameStyle.dark() => DeviceFrameStyle(
        bodyColor: const Color(0xFF1A1A1A),
        buttonColor: const Color(0xFF2A2A2A),
        borderColor: const Color(0xFF5A5A5A),
        shadowColor: const Color(0x55000000),
      );

  factory DeviceFrameStyle.light() => DeviceFrameStyle(
        bodyColor: const Color(0xFFFDFDFD),
        buttonColor: const Color(0xFF7C7C7C),
        borderColor: const Color(0xFFA5A5A5),
        shadowColor: const Color(0x55000000),
      );
}

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'device_preview_style.freezed.dart';

enum DevicePreviewToolBarPosition {
  bottom,
  top,
  left,
  right,
}

class DevicePreviewTheme extends InheritedWidget {
  final DevicePreviewStyle style;

  static bool isPositionAvailableForWidth(
      DevicePreviewToolBarPosition position, double width) {
    if (width < 600 &&
        (position == DevicePreviewToolBarPosition.left ||
            position == DevicePreviewToolBarPosition.right)) {
      return false;
    }
    return true;
  }

  DevicePreviewTheme({
    @required this.style,
    @required Widget child,
  }) : super(child: child);

  static DevicePreviewStyle of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewTheme>();

    var result = widget?.style ?? DevicePreviewStyle.light();

    // If toolbar position isn't supported, fallback to bottom.
    final media = MediaQuery.of(context);
    if (!DevicePreviewTheme.isPositionAvailableForWidth(
        result.toolBar.position, media.size.width)) {
      result = result.copyWith(
          toolBar: result.toolBar
              .copyWith(position: DevicePreviewToolBarPosition.bottom));
    }

    return result;
  }

  @override
  bool updateShouldNotify(DevicePreviewTheme oldWidget) {
    return oldWidget.style != style;
  }
}

@freezed
abstract class DevicePreviewStyle with _$DevicePreviewStyle {
  const factory DevicePreviewStyle({
    @required BoxDecoration background,
    @required DevicePreviewToolBarStyle toolBar,
  }) = _DevicePreviewStyle;

  factory DevicePreviewStyle.light({
    DevicePreviewToolBarPosition position,
  }) =>
      DevicePreviewStyle(
        toolBar: DevicePreviewToolBarStyle.dark(position: position),
        background: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf5f7fa),
              Color(0xFFc3cfe2),
            ],
          ),
        ),
      );

  factory DevicePreviewStyle.dark({
    DevicePreviewToolBarPosition position,
  }) =>
      DevicePreviewStyle(
        toolBar: DevicePreviewToolBarStyle.light(position: position),
        background: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF111111),
              Color(0xFF222222),
            ],
          ),
        ),
      );
}

@freezed
abstract class DevicePreviewToolBarStyle with _$DevicePreviewToolBarStyle {
  const factory DevicePreviewToolBarStyle({
    @required Color backgroundColor,
    @required Color foregroundColor,
    @required Color buttonBackgroundColor,
    @required Color buttonHoverBackgroundColor,
    @required DevicePreviewToolBarPosition position,
  }) = _DevicePreviewToolBarStyle;

  factory DevicePreviewToolBarStyle.dark({
    DevicePreviewToolBarPosition position,
  }) =>
      DevicePreviewToolBarStyle(
        position: position ?? DevicePreviewToolBarPosition.bottom,
        backgroundColor: const Color(0xFF111111),
        buttonBackgroundColor: const Color(0xFF2F2F2F),
        buttonHoverBackgroundColor: const Color(0xFF555555),
        foregroundColor: const Color(0xFFFEFEFE),
      );

  factory DevicePreviewToolBarStyle.light({
    DevicePreviewToolBarPosition position,
  }) =>
      DevicePreviewToolBarStyle(
        position: position ?? DevicePreviewToolBarPosition.bottom,
        backgroundColor: const Color(0xFFFEFEFE),
        buttonBackgroundColor: const Color(0xFFF0F0F0),
        buttonHoverBackgroundColor: const Color(0xFFFAFAFA),
        foregroundColor: const Color(0xFF333333),
      );
}

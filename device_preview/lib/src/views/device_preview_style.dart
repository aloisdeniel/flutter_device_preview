import 'package:device_preview/src/state/state.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

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

  const DevicePreviewTheme({
    @required this.style,
    @required Widget child,
  }) : super(child: child);

  static DevicePreviewStyle of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewTheme>();

    var result = widget?.style;

    /// If no theme, the tool preferences are used.
    if (result == null) {
      final settings = context.select(
        (DevicePreviewStore store) => store.settings,
      );

      final position = () {
        switch (settings.toolbarPosition) {
          case DevicePreviewToolBarPositionData.top:
            return DevicePreviewToolBarPosition.top;

          case DevicePreviewToolBarPositionData.left:
            return DevicePreviewToolBarPosition.left;
          case DevicePreviewToolBarPositionData.right:
            return DevicePreviewToolBarPosition.right;
          default:
            return DevicePreviewToolBarPosition.bottom;
        }
      }();

      result = DevicePreviewStyle(
        toolBar: settings.toolbarTheme == DevicePreviewToolBarThemeData.dark
            ? DevicePreviewToolBarStyle.dark(position: position)
            : DevicePreviewToolBarStyle.light(position: position),
        background: BoxDecoration(
          color:
              settings.backgroundTheme == DevicePreviewBackgroundThemeData.dark
                  ? Color(0xff000000)
                  : Color(0xFFFFFFFF),
        ),
      );
    }

    // If toolbar position isn't supported, fallback to bottom.
    final media = MediaQuery.of(context) ??
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
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
    DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
  }) =>
      DevicePreviewStyle(
        toolBar: DevicePreviewToolBarStyle.dark(
          position: position,
          buttonsVisibility:
              buttonsVisibility ?? DevicePreviewButtonsVisibilityStyleData(),
        ),
        background: BoxDecoration(color: Color(0xFFFFFFFF)),
      );

  factory DevicePreviewStyle.dark({
    DevicePreviewToolBarPosition position,
    DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
  }) =>
      DevicePreviewStyle(
        toolBar: DevicePreviewToolBarStyle.light(
          position: position,
          buttonsVisibility:
              buttonsVisibility ?? DevicePreviewButtonsVisibilityStyleData(),
        ),
        background: BoxDecoration(color: Color(0xff000000)),
      );
}

@freezed
abstract class DevicePreviewToolBarStyle with _$DevicePreviewToolBarStyle {
  const factory DevicePreviewToolBarStyle({
    @required DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
    @required Color backgroundColor,
    @required Color foregroundColor,
    @required Color buttonBackgroundColor,
    @required Color buttonHoverBackgroundColor,
    @required DevicePreviewToolBarPosition position,
    @required DevicePreviewToolBarSpacingData spacing,
    @required DevicePreviewToolBarTextStyleData fontStyles,
  }) = _DevicePreviewToolBarStyle;

  factory DevicePreviewToolBarStyle.dark({
    DevicePreviewToolBarPosition position,
    DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
  }) =>
      DevicePreviewToolBarStyle(
        buttonsVisibility:
            buttonsVisibility ?? DevicePreviewButtonsVisibilityStyleData(),
        position: position ?? DevicePreviewToolBarPosition.bottom,
        backgroundColor: const Color(0xFF111111),
        buttonBackgroundColor: const Color(0xFF2F2F2F),
        buttonHoverBackgroundColor: const Color(0xFF555555),
        foregroundColor: const Color(0xFFFEFEFE),
        spacing: DevicePreviewToolBarSpacingData(
          small: const EdgeInsets.all(4),
          regular: const EdgeInsets.all(10),
          big: const EdgeInsets.all(14),
        ),
        fontStyles: DevicePreviewToolBarTextStyleData(
          smallBody: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 9,
          ),
          body: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 11,
          ),
          title: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
          fieldLabel: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 11,
          ),
        ),
      );

  factory DevicePreviewToolBarStyle.light({
    DevicePreviewToolBarPosition position,
    DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
  }) =>
      DevicePreviewToolBarStyle(
        buttonsVisibility:
            buttonsVisibility ?? DevicePreviewButtonsVisibilityStyleData(),
        position: position ?? DevicePreviewToolBarPosition.bottom,
        backgroundColor: const Color(0xFFFEFEFE),
        buttonBackgroundColor: const Color(0xFFF0F0F0),
        buttonHoverBackgroundColor: const Color(0xFFFAFAFA),
        foregroundColor: const Color(0xFF333333),
        spacing: DevicePreviewToolBarSpacingData(
          small: const EdgeInsets.all(4),
          regular: const EdgeInsets.all(10),
          big: const EdgeInsets.all(14),
        ),
        fontStyles: DevicePreviewToolBarTextStyleData(
          smallBody: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 9,
          ),
          body: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
          title: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
          fieldLabel: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 11,
          ),
        ),
      );
}

@freezed
abstract class DevicePreviewToolBarSpacingData
    with _$DevicePreviewToolBarSpacingData {
  const factory DevicePreviewToolBarSpacingData({
    @required EdgeInsets small,
    @required EdgeInsets regular,
    @required EdgeInsets big,
  }) = _DevicePreviewToolBarSpacingData;
}

@freezed
abstract class DevicePreviewToolBarTextStyleData
    with _$DevicePreviewToolBarTextStyleData {
  const factory DevicePreviewToolBarTextStyleData({
    @required TextStyle smallBody,
    @required TextStyle body,
    @required TextStyle title,
    @required TextStyle fieldLabel,
  }) = _DevicePreviewToolBarTextStyleData;
}

@freezed
abstract class DevicePreviewButtonsVisibilityStyleData
    with _$DevicePreviewButtonsVisibilityStyleData {
  const factory DevicePreviewButtonsVisibilityStyleData({
    @Default(true) bool togglePreview,
    @Default(true) bool device,
    @Default(true) bool language,
    @Default(true) bool rotate,
    @Default(true) bool toggleFrame,
    @Default(true) bool toggleKeyboard,
    @Default(true) bool darkMode,
    @Default(true) bool accessibility,
    @Default(true) bool settings,
  }) = _DevicePreviewButtonsVisibilityStyleData;
}

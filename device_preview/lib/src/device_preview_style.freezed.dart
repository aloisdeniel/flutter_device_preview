// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'device_preview_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$DevicePreviewStyleTearOff {
  const _$DevicePreviewStyleTearOff();

  _DevicePreviewStyle call(
      {@required BoxDecoration background,
      @required DevicePreviewToolBarStyle toolBar}) {
    return _DevicePreviewStyle(
      background: background,
      toolBar: toolBar,
    );
  }
}

// ignore: unused_element
const $DevicePreviewStyle = _$DevicePreviewStyleTearOff();

mixin _$DevicePreviewStyle {
  BoxDecoration get background;
  DevicePreviewToolBarStyle get toolBar;

  $DevicePreviewStyleCopyWith<DevicePreviewStyle> get copyWith;
}

abstract class $DevicePreviewStyleCopyWith<$Res> {
  factory $DevicePreviewStyleCopyWith(
          DevicePreviewStyle value, $Res Function(DevicePreviewStyle) then) =
      _$DevicePreviewStyleCopyWithImpl<$Res>;
  $Res call({BoxDecoration background, DevicePreviewToolBarStyle toolBar});

  $DevicePreviewToolBarStyleCopyWith<$Res> get toolBar;
}

class _$DevicePreviewStyleCopyWithImpl<$Res>
    implements $DevicePreviewStyleCopyWith<$Res> {
  _$DevicePreviewStyleCopyWithImpl(this._value, this._then);

  final DevicePreviewStyle _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewStyle) _then;

  @override
  $Res call({
    Object background = freezed,
    Object toolBar = freezed,
  }) {
    return _then(_value.copyWith(
      background: background == freezed
          ? _value.background
          : background as BoxDecoration,
      toolBar: toolBar == freezed
          ? _value.toolBar
          : toolBar as DevicePreviewToolBarStyle,
    ));
  }

  @override
  $DevicePreviewToolBarStyleCopyWith<$Res> get toolBar {
    if (_value.toolBar == null) {
      return null;
    }
    return $DevicePreviewToolBarStyleCopyWith<$Res>(_value.toolBar, (value) {
      return _then(_value.copyWith(toolBar: value));
    });
  }
}

abstract class _$DevicePreviewStyleCopyWith<$Res>
    implements $DevicePreviewStyleCopyWith<$Res> {
  factory _$DevicePreviewStyleCopyWith(
          _DevicePreviewStyle value, $Res Function(_DevicePreviewStyle) then) =
      __$DevicePreviewStyleCopyWithImpl<$Res>;
  @override
  $Res call({BoxDecoration background, DevicePreviewToolBarStyle toolBar});

  @override
  $DevicePreviewToolBarStyleCopyWith<$Res> get toolBar;
}

class __$DevicePreviewStyleCopyWithImpl<$Res>
    extends _$DevicePreviewStyleCopyWithImpl<$Res>
    implements _$DevicePreviewStyleCopyWith<$Res> {
  __$DevicePreviewStyleCopyWithImpl(
      _DevicePreviewStyle _value, $Res Function(_DevicePreviewStyle) _then)
      : super(_value, (v) => _then(v as _DevicePreviewStyle));

  @override
  _DevicePreviewStyle get _value => super._value as _DevicePreviewStyle;

  @override
  $Res call({
    Object background = freezed,
    Object toolBar = freezed,
  }) {
    return _then(_DevicePreviewStyle(
      background: background == freezed
          ? _value.background
          : background as BoxDecoration,
      toolBar: toolBar == freezed
          ? _value.toolBar
          : toolBar as DevicePreviewToolBarStyle,
    ));
  }
}

class _$_DevicePreviewStyle
    with DiagnosticableTreeMixin
    implements _DevicePreviewStyle {
  const _$_DevicePreviewStyle(
      {@required this.background, @required this.toolBar})
      : assert(background != null),
        assert(toolBar != null);

  @override
  final BoxDecoration background;
  @override
  final DevicePreviewToolBarStyle toolBar;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewStyle(background: $background, toolBar: $toolBar)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewStyle'))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('toolBar', toolBar));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewStyle &&
            (identical(other.background, background) ||
                const DeepCollectionEquality()
                    .equals(other.background, background)) &&
            (identical(other.toolBar, toolBar) ||
                const DeepCollectionEquality().equals(other.toolBar, toolBar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(background) ^
      const DeepCollectionEquality().hash(toolBar);

  @override
  _$DevicePreviewStyleCopyWith<_DevicePreviewStyle> get copyWith =>
      __$DevicePreviewStyleCopyWithImpl<_DevicePreviewStyle>(this, _$identity);
}

abstract class _DevicePreviewStyle implements DevicePreviewStyle {
  const factory _DevicePreviewStyle(
      {@required BoxDecoration background,
      @required DevicePreviewToolBarStyle toolBar}) = _$_DevicePreviewStyle;

  @override
  BoxDecoration get background;
  @override
  DevicePreviewToolBarStyle get toolBar;
  @override
  _$DevicePreviewStyleCopyWith<_DevicePreviewStyle> get copyWith;
}

class _$DevicePreviewToolBarStyleTearOff {
  const _$DevicePreviewToolBarStyleTearOff();

  _DevicePreviewToolBarStyle call(
      {@required Color backgroundColor,
      @required Color foregroundColor,
      @required Color buttonBackgroundColor,
      @required Color buttonHoverBackgroundColor,
      @required DevicePreviewToolBarPosition position}) {
    return _DevicePreviewToolBarStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      buttonBackgroundColor: buttonBackgroundColor,
      buttonHoverBackgroundColor: buttonHoverBackgroundColor,
      position: position,
    );
  }
}

// ignore: unused_element
const $DevicePreviewToolBarStyle = _$DevicePreviewToolBarStyleTearOff();

mixin _$DevicePreviewToolBarStyle {
  Color get backgroundColor;
  Color get foregroundColor;
  Color get buttonBackgroundColor;
  Color get buttonHoverBackgroundColor;
  DevicePreviewToolBarPosition get position;

  $DevicePreviewToolBarStyleCopyWith<DevicePreviewToolBarStyle> get copyWith;
}

abstract class $DevicePreviewToolBarStyleCopyWith<$Res> {
  factory $DevicePreviewToolBarStyleCopyWith(DevicePreviewToolBarStyle value,
          $Res Function(DevicePreviewToolBarStyle) then) =
      _$DevicePreviewToolBarStyleCopyWithImpl<$Res>;
  $Res call(
      {Color backgroundColor,
      Color foregroundColor,
      Color buttonBackgroundColor,
      Color buttonHoverBackgroundColor,
      DevicePreviewToolBarPosition position});
}

class _$DevicePreviewToolBarStyleCopyWithImpl<$Res>
    implements $DevicePreviewToolBarStyleCopyWith<$Res> {
  _$DevicePreviewToolBarStyleCopyWithImpl(this._value, this._then);

  final DevicePreviewToolBarStyle _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewToolBarStyle) _then;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object foregroundColor = freezed,
    Object buttonBackgroundColor = freezed,
    Object buttonHoverBackgroundColor = freezed,
    Object position = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      foregroundColor: foregroundColor == freezed
          ? _value.foregroundColor
          : foregroundColor as Color,
      buttonBackgroundColor: buttonBackgroundColor == freezed
          ? _value.buttonBackgroundColor
          : buttonBackgroundColor as Color,
      buttonHoverBackgroundColor: buttonHoverBackgroundColor == freezed
          ? _value.buttonHoverBackgroundColor
          : buttonHoverBackgroundColor as Color,
      position: position == freezed
          ? _value.position
          : position as DevicePreviewToolBarPosition,
    ));
  }
}

abstract class _$DevicePreviewToolBarStyleCopyWith<$Res>
    implements $DevicePreviewToolBarStyleCopyWith<$Res> {
  factory _$DevicePreviewToolBarStyleCopyWith(_DevicePreviewToolBarStyle value,
          $Res Function(_DevicePreviewToolBarStyle) then) =
      __$DevicePreviewToolBarStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color backgroundColor,
      Color foregroundColor,
      Color buttonBackgroundColor,
      Color buttonHoverBackgroundColor,
      DevicePreviewToolBarPosition position});
}

class __$DevicePreviewToolBarStyleCopyWithImpl<$Res>
    extends _$DevicePreviewToolBarStyleCopyWithImpl<$Res>
    implements _$DevicePreviewToolBarStyleCopyWith<$Res> {
  __$DevicePreviewToolBarStyleCopyWithImpl(_DevicePreviewToolBarStyle _value,
      $Res Function(_DevicePreviewToolBarStyle) _then)
      : super(_value, (v) => _then(v as _DevicePreviewToolBarStyle));

  @override
  _DevicePreviewToolBarStyle get _value =>
      super._value as _DevicePreviewToolBarStyle;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object foregroundColor = freezed,
    Object buttonBackgroundColor = freezed,
    Object buttonHoverBackgroundColor = freezed,
    Object position = freezed,
  }) {
    return _then(_DevicePreviewToolBarStyle(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      foregroundColor: foregroundColor == freezed
          ? _value.foregroundColor
          : foregroundColor as Color,
      buttonBackgroundColor: buttonBackgroundColor == freezed
          ? _value.buttonBackgroundColor
          : buttonBackgroundColor as Color,
      buttonHoverBackgroundColor: buttonHoverBackgroundColor == freezed
          ? _value.buttonHoverBackgroundColor
          : buttonHoverBackgroundColor as Color,
      position: position == freezed
          ? _value.position
          : position as DevicePreviewToolBarPosition,
    ));
  }
}

class _$_DevicePreviewToolBarStyle
    with DiagnosticableTreeMixin
    implements _DevicePreviewToolBarStyle {
  const _$_DevicePreviewToolBarStyle(
      {@required this.backgroundColor,
      @required this.foregroundColor,
      @required this.buttonBackgroundColor,
      @required this.buttonHoverBackgroundColor,
      @required this.position})
      : assert(backgroundColor != null),
        assert(foregroundColor != null),
        assert(buttonBackgroundColor != null),
        assert(buttonHoverBackgroundColor != null),
        assert(position != null);

  @override
  final Color backgroundColor;
  @override
  final Color foregroundColor;
  @override
  final Color buttonBackgroundColor;
  @override
  final Color buttonHoverBackgroundColor;
  @override
  final DevicePreviewToolBarPosition position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewToolBarStyle(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, buttonBackgroundColor: $buttonBackgroundColor, buttonHoverBackgroundColor: $buttonHoverBackgroundColor, position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewToolBarStyle'))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty('buttonBackgroundColor', buttonBackgroundColor))
      ..add(DiagnosticsProperty(
          'buttonHoverBackgroundColor', buttonHoverBackgroundColor))
      ..add(DiagnosticsProperty('position', position));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewToolBarStyle &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.foregroundColor, foregroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.foregroundColor, foregroundColor)) &&
            (identical(other.buttonBackgroundColor, buttonBackgroundColor) ||
                const DeepCollectionEquality().equals(
                    other.buttonBackgroundColor, buttonBackgroundColor)) &&
            (identical(other.buttonHoverBackgroundColor,
                    buttonHoverBackgroundColor) ||
                const DeepCollectionEquality().equals(
                    other.buttonHoverBackgroundColor,
                    buttonHoverBackgroundColor)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(foregroundColor) ^
      const DeepCollectionEquality().hash(buttonBackgroundColor) ^
      const DeepCollectionEquality().hash(buttonHoverBackgroundColor) ^
      const DeepCollectionEquality().hash(position);

  @override
  _$DevicePreviewToolBarStyleCopyWith<_DevicePreviewToolBarStyle>
      get copyWith =>
          __$DevicePreviewToolBarStyleCopyWithImpl<_DevicePreviewToolBarStyle>(
              this, _$identity);
}

abstract class _DevicePreviewToolBarStyle implements DevicePreviewToolBarStyle {
  const factory _DevicePreviewToolBarStyle(
          {@required Color backgroundColor,
          @required Color foregroundColor,
          @required Color buttonBackgroundColor,
          @required Color buttonHoverBackgroundColor,
          @required DevicePreviewToolBarPosition position}) =
      _$_DevicePreviewToolBarStyle;

  @override
  Color get backgroundColor;
  @override
  Color get foregroundColor;
  @override
  Color get buttonBackgroundColor;
  @override
  Color get buttonHoverBackgroundColor;
  @override
  DevicePreviewToolBarPosition get position;
  @override
  _$DevicePreviewToolBarStyleCopyWith<_DevicePreviewToolBarStyle> get copyWith;
}

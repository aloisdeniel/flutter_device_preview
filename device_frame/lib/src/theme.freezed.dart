// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$DeviceFrameStyleTearOff {
  const _$DeviceFrameStyleTearOff();

  _DeviceFrameStyle call(
      {@required Color bodyColor,
      @required Color borderColor,
      @required Color buttonColor,
      @required Color shadowColor,
      @required DeviceKeyboardStyle keyboardStyle}) {
    return _DeviceFrameStyle(
      bodyColor: bodyColor,
      borderColor: borderColor,
      buttonColor: buttonColor,
      shadowColor: shadowColor,
      keyboardStyle: keyboardStyle,
    );
  }
}

// ignore: unused_element
const $DeviceFrameStyle = _$DeviceFrameStyleTearOff();

mixin _$DeviceFrameStyle {
  Color get bodyColor;
  Color get borderColor;
  Color get buttonColor;
  Color get shadowColor;
  DeviceKeyboardStyle get keyboardStyle;

  $DeviceFrameStyleCopyWith<DeviceFrameStyle> get copyWith;
}

abstract class $DeviceFrameStyleCopyWith<$Res> {
  factory $DeviceFrameStyleCopyWith(
          DeviceFrameStyle value, $Res Function(DeviceFrameStyle) then) =
      _$DeviceFrameStyleCopyWithImpl<$Res>;
  $Res call(
      {Color bodyColor,
      Color borderColor,
      Color buttonColor,
      Color shadowColor,
      DeviceKeyboardStyle keyboardStyle});

  $DeviceKeyboardStyleCopyWith<$Res> get keyboardStyle;
}

class _$DeviceFrameStyleCopyWithImpl<$Res>
    implements $DeviceFrameStyleCopyWith<$Res> {
  _$DeviceFrameStyleCopyWithImpl(this._value, this._then);

  final DeviceFrameStyle _value;
  // ignore: unused_field
  final $Res Function(DeviceFrameStyle) _then;

  @override
  $Res call({
    Object bodyColor = freezed,
    Object borderColor = freezed,
    Object buttonColor = freezed,
    Object shadowColor = freezed,
    Object keyboardStyle = freezed,
  }) {
    return _then(_value.copyWith(
      bodyColor: bodyColor == freezed ? _value.bodyColor : bodyColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      buttonColor:
          buttonColor == freezed ? _value.buttonColor : buttonColor as Color,
      shadowColor:
          shadowColor == freezed ? _value.shadowColor : shadowColor as Color,
      keyboardStyle: keyboardStyle == freezed
          ? _value.keyboardStyle
          : keyboardStyle as DeviceKeyboardStyle,
    ));
  }

  @override
  $DeviceKeyboardStyleCopyWith<$Res> get keyboardStyle {
    if (_value.keyboardStyle == null) {
      return null;
    }
    return $DeviceKeyboardStyleCopyWith<$Res>(_value.keyboardStyle, (value) {
      return _then(_value.copyWith(keyboardStyle: value));
    });
  }
}

abstract class _$DeviceFrameStyleCopyWith<$Res>
    implements $DeviceFrameStyleCopyWith<$Res> {
  factory _$DeviceFrameStyleCopyWith(
          _DeviceFrameStyle value, $Res Function(_DeviceFrameStyle) then) =
      __$DeviceFrameStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color bodyColor,
      Color borderColor,
      Color buttonColor,
      Color shadowColor,
      DeviceKeyboardStyle keyboardStyle});

  @override
  $DeviceKeyboardStyleCopyWith<$Res> get keyboardStyle;
}

class __$DeviceFrameStyleCopyWithImpl<$Res>
    extends _$DeviceFrameStyleCopyWithImpl<$Res>
    implements _$DeviceFrameStyleCopyWith<$Res> {
  __$DeviceFrameStyleCopyWithImpl(
      _DeviceFrameStyle _value, $Res Function(_DeviceFrameStyle) _then)
      : super(_value, (v) => _then(v as _DeviceFrameStyle));

  @override
  _DeviceFrameStyle get _value => super._value as _DeviceFrameStyle;

  @override
  $Res call({
    Object bodyColor = freezed,
    Object borderColor = freezed,
    Object buttonColor = freezed,
    Object shadowColor = freezed,
    Object keyboardStyle = freezed,
  }) {
    return _then(_DeviceFrameStyle(
      bodyColor: bodyColor == freezed ? _value.bodyColor : bodyColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      buttonColor:
          buttonColor == freezed ? _value.buttonColor : buttonColor as Color,
      shadowColor:
          shadowColor == freezed ? _value.shadowColor : shadowColor as Color,
      keyboardStyle: keyboardStyle == freezed
          ? _value.keyboardStyle
          : keyboardStyle as DeviceKeyboardStyle,
    ));
  }
}

class _$_DeviceFrameStyle
    with DiagnosticableTreeMixin
    implements _DeviceFrameStyle {
  const _$_DeviceFrameStyle(
      {@required this.bodyColor,
      @required this.borderColor,
      @required this.buttonColor,
      @required this.shadowColor,
      @required this.keyboardStyle})
      : assert(bodyColor != null),
        assert(borderColor != null),
        assert(buttonColor != null),
        assert(shadowColor != null),
        assert(keyboardStyle != null);

  @override
  final Color bodyColor;
  @override
  final Color borderColor;
  @override
  final Color buttonColor;
  @override
  final Color shadowColor;
  @override
  final DeviceKeyboardStyle keyboardStyle;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceFrameStyle(bodyColor: $bodyColor, borderColor: $borderColor, buttonColor: $buttonColor, shadowColor: $shadowColor, keyboardStyle: $keyboardStyle)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceFrameStyle'))
      ..add(DiagnosticsProperty('bodyColor', bodyColor))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DiagnosticsProperty('buttonColor', buttonColor))
      ..add(DiagnosticsProperty('shadowColor', shadowColor))
      ..add(DiagnosticsProperty('keyboardStyle', keyboardStyle));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeviceFrameStyle &&
            (identical(other.bodyColor, bodyColor) ||
                const DeepCollectionEquality()
                    .equals(other.bodyColor, bodyColor)) &&
            (identical(other.borderColor, borderColor) ||
                const DeepCollectionEquality()
                    .equals(other.borderColor, borderColor)) &&
            (identical(other.buttonColor, buttonColor) ||
                const DeepCollectionEquality()
                    .equals(other.buttonColor, buttonColor)) &&
            (identical(other.shadowColor, shadowColor) ||
                const DeepCollectionEquality()
                    .equals(other.shadowColor, shadowColor)) &&
            (identical(other.keyboardStyle, keyboardStyle) ||
                const DeepCollectionEquality()
                    .equals(other.keyboardStyle, keyboardStyle)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bodyColor) ^
      const DeepCollectionEquality().hash(borderColor) ^
      const DeepCollectionEquality().hash(buttonColor) ^
      const DeepCollectionEquality().hash(shadowColor) ^
      const DeepCollectionEquality().hash(keyboardStyle);

  @override
  _$DeviceFrameStyleCopyWith<_DeviceFrameStyle> get copyWith =>
      __$DeviceFrameStyleCopyWithImpl<_DeviceFrameStyle>(this, _$identity);
}

abstract class _DeviceFrameStyle implements DeviceFrameStyle {
  const factory _DeviceFrameStyle(
      {@required Color bodyColor,
      @required Color borderColor,
      @required Color buttonColor,
      @required Color shadowColor,
      @required DeviceKeyboardStyle keyboardStyle}) = _$_DeviceFrameStyle;

  @override
  Color get bodyColor;
  @override
  Color get borderColor;
  @override
  Color get buttonColor;
  @override
  Color get shadowColor;
  @override
  DeviceKeyboardStyle get keyboardStyle;
  @override
  _$DeviceFrameStyleCopyWith<_DeviceFrameStyle> get copyWith;
}

class _$DeviceKeyboardStyleTearOff {
  const _$DeviceKeyboardStyleTearOff();

  _DeviceKeyboardStyle call(
      {@required Color backgroundColor,
      @required Color button1BackgroundColor,
      @required Color button1ForegroundColor,
      @required Color button2BackgroundColor,
      @required Color button2ForegroundColor}) {
    return _DeviceKeyboardStyle(
      backgroundColor: backgroundColor,
      button1BackgroundColor: button1BackgroundColor,
      button1ForegroundColor: button1ForegroundColor,
      button2BackgroundColor: button2BackgroundColor,
      button2ForegroundColor: button2ForegroundColor,
    );
  }
}

// ignore: unused_element
const $DeviceKeyboardStyle = _$DeviceKeyboardStyleTearOff();

mixin _$DeviceKeyboardStyle {
  Color get backgroundColor;
  Color get button1BackgroundColor;
  Color get button1ForegroundColor;
  Color get button2BackgroundColor;
  Color get button2ForegroundColor;

  $DeviceKeyboardStyleCopyWith<DeviceKeyboardStyle> get copyWith;
}

abstract class $DeviceKeyboardStyleCopyWith<$Res> {
  factory $DeviceKeyboardStyleCopyWith(
          DeviceKeyboardStyle value, $Res Function(DeviceKeyboardStyle) then) =
      _$DeviceKeyboardStyleCopyWithImpl<$Res>;
  $Res call(
      {Color backgroundColor,
      Color button1BackgroundColor,
      Color button1ForegroundColor,
      Color button2BackgroundColor,
      Color button2ForegroundColor});
}

class _$DeviceKeyboardStyleCopyWithImpl<$Res>
    implements $DeviceKeyboardStyleCopyWith<$Res> {
  _$DeviceKeyboardStyleCopyWithImpl(this._value, this._then);

  final DeviceKeyboardStyle _value;
  // ignore: unused_field
  final $Res Function(DeviceKeyboardStyle) _then;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object button1BackgroundColor = freezed,
    Object button1ForegroundColor = freezed,
    Object button2BackgroundColor = freezed,
    Object button2ForegroundColor = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      button1BackgroundColor: button1BackgroundColor == freezed
          ? _value.button1BackgroundColor
          : button1BackgroundColor as Color,
      button1ForegroundColor: button1ForegroundColor == freezed
          ? _value.button1ForegroundColor
          : button1ForegroundColor as Color,
      button2BackgroundColor: button2BackgroundColor == freezed
          ? _value.button2BackgroundColor
          : button2BackgroundColor as Color,
      button2ForegroundColor: button2ForegroundColor == freezed
          ? _value.button2ForegroundColor
          : button2ForegroundColor as Color,
    ));
  }
}

abstract class _$DeviceKeyboardStyleCopyWith<$Res>
    implements $DeviceKeyboardStyleCopyWith<$Res> {
  factory _$DeviceKeyboardStyleCopyWith(_DeviceKeyboardStyle value,
          $Res Function(_DeviceKeyboardStyle) then) =
      __$DeviceKeyboardStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color backgroundColor,
      Color button1BackgroundColor,
      Color button1ForegroundColor,
      Color button2BackgroundColor,
      Color button2ForegroundColor});
}

class __$DeviceKeyboardStyleCopyWithImpl<$Res>
    extends _$DeviceKeyboardStyleCopyWithImpl<$Res>
    implements _$DeviceKeyboardStyleCopyWith<$Res> {
  __$DeviceKeyboardStyleCopyWithImpl(
      _DeviceKeyboardStyle _value, $Res Function(_DeviceKeyboardStyle) _then)
      : super(_value, (v) => _then(v as _DeviceKeyboardStyle));

  @override
  _DeviceKeyboardStyle get _value => super._value as _DeviceKeyboardStyle;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object button1BackgroundColor = freezed,
    Object button1ForegroundColor = freezed,
    Object button2BackgroundColor = freezed,
    Object button2ForegroundColor = freezed,
  }) {
    return _then(_DeviceKeyboardStyle(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      button1BackgroundColor: button1BackgroundColor == freezed
          ? _value.button1BackgroundColor
          : button1BackgroundColor as Color,
      button1ForegroundColor: button1ForegroundColor == freezed
          ? _value.button1ForegroundColor
          : button1ForegroundColor as Color,
      button2BackgroundColor: button2BackgroundColor == freezed
          ? _value.button2BackgroundColor
          : button2BackgroundColor as Color,
      button2ForegroundColor: button2ForegroundColor == freezed
          ? _value.button2ForegroundColor
          : button2ForegroundColor as Color,
    ));
  }
}

class _$_DeviceKeyboardStyle
    with DiagnosticableTreeMixin
    implements _DeviceKeyboardStyle {
  const _$_DeviceKeyboardStyle(
      {@required this.backgroundColor,
      @required this.button1BackgroundColor,
      @required this.button1ForegroundColor,
      @required this.button2BackgroundColor,
      @required this.button2ForegroundColor})
      : assert(backgroundColor != null),
        assert(button1BackgroundColor != null),
        assert(button1ForegroundColor != null),
        assert(button2BackgroundColor != null),
        assert(button2ForegroundColor != null);

  @override
  final Color backgroundColor;
  @override
  final Color button1BackgroundColor;
  @override
  final Color button1ForegroundColor;
  @override
  final Color button2BackgroundColor;
  @override
  final Color button2ForegroundColor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceKeyboardStyle(backgroundColor: $backgroundColor, button1BackgroundColor: $button1BackgroundColor, button1ForegroundColor: $button1ForegroundColor, button2BackgroundColor: $button2BackgroundColor, button2ForegroundColor: $button2ForegroundColor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceKeyboardStyle'))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(
          DiagnosticsProperty('button1BackgroundColor', button1BackgroundColor))
      ..add(
          DiagnosticsProperty('button1ForegroundColor', button1ForegroundColor))
      ..add(
          DiagnosticsProperty('button2BackgroundColor', button2BackgroundColor))
      ..add(DiagnosticsProperty(
          'button2ForegroundColor', button2ForegroundColor));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeviceKeyboardStyle &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.button1BackgroundColor, button1BackgroundColor) ||
                const DeepCollectionEquality().equals(
                    other.button1BackgroundColor, button1BackgroundColor)) &&
            (identical(other.button1ForegroundColor, button1ForegroundColor) ||
                const DeepCollectionEquality().equals(
                    other.button1ForegroundColor, button1ForegroundColor)) &&
            (identical(other.button2BackgroundColor, button2BackgroundColor) ||
                const DeepCollectionEquality().equals(
                    other.button2BackgroundColor, button2BackgroundColor)) &&
            (identical(other.button2ForegroundColor, button2ForegroundColor) ||
                const DeepCollectionEquality().equals(
                    other.button2ForegroundColor, button2ForegroundColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(button1BackgroundColor) ^
      const DeepCollectionEquality().hash(button1ForegroundColor) ^
      const DeepCollectionEquality().hash(button2BackgroundColor) ^
      const DeepCollectionEquality().hash(button2ForegroundColor);

  @override
  _$DeviceKeyboardStyleCopyWith<_DeviceKeyboardStyle> get copyWith =>
      __$DeviceKeyboardStyleCopyWithImpl<_DeviceKeyboardStyle>(
          this, _$identity);
}

abstract class _DeviceKeyboardStyle implements DeviceKeyboardStyle {
  const factory _DeviceKeyboardStyle(
      {@required Color backgroundColor,
      @required Color button1BackgroundColor,
      @required Color button1ForegroundColor,
      @required Color button2BackgroundColor,
      @required Color button2ForegroundColor}) = _$_DeviceKeyboardStyle;

  @override
  Color get backgroundColor;
  @override
  Color get button1BackgroundColor;
  @override
  Color get button1ForegroundColor;
  @override
  Color get button2BackgroundColor;
  @override
  Color get button2ForegroundColor;
  @override
  _$DeviceKeyboardStyleCopyWith<_DeviceKeyboardStyle> get copyWith;
}

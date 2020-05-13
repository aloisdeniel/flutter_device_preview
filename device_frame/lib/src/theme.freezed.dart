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
      @required Color shadowColor}) {
    return _DeviceFrameStyle(
      bodyColor: bodyColor,
      borderColor: borderColor,
      buttonColor: buttonColor,
      shadowColor: shadowColor,
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
      Color shadowColor});
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
  }) {
    return _then(_value.copyWith(
      bodyColor: bodyColor == freezed ? _value.bodyColor : bodyColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      buttonColor:
          buttonColor == freezed ? _value.buttonColor : buttonColor as Color,
      shadowColor:
          shadowColor == freezed ? _value.shadowColor : shadowColor as Color,
    ));
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
      Color shadowColor});
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
  }) {
    return _then(_DeviceFrameStyle(
      bodyColor: bodyColor == freezed ? _value.bodyColor : bodyColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      buttonColor:
          buttonColor == freezed ? _value.buttonColor : buttonColor as Color,
      shadowColor:
          shadowColor == freezed ? _value.shadowColor : shadowColor as Color,
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
      @required this.shadowColor})
      : assert(bodyColor != null),
        assert(borderColor != null),
        assert(buttonColor != null),
        assert(shadowColor != null);

  @override
  final Color bodyColor;
  @override
  final Color borderColor;
  @override
  final Color buttonColor;
  @override
  final Color shadowColor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceFrameStyle(bodyColor: $bodyColor, borderColor: $borderColor, buttonColor: $buttonColor, shadowColor: $shadowColor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceFrameStyle'))
      ..add(DiagnosticsProperty('bodyColor', bodyColor))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DiagnosticsProperty('buttonColor', buttonColor))
      ..add(DiagnosticsProperty('shadowColor', shadowColor));
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
                    .equals(other.shadowColor, shadowColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bodyColor) ^
      const DeepCollectionEquality().hash(borderColor) ^
      const DeepCollectionEquality().hash(buttonColor) ^
      const DeepCollectionEquality().hash(shadowColor);

  @override
  _$DeviceFrameStyleCopyWith<_DeviceFrameStyle> get copyWith =>
      __$DeviceFrameStyleCopyWithImpl<_DeviceFrameStyle>(this, _$identity);
}

abstract class _DeviceFrameStyle implements DeviceFrameStyle {
  const factory _DeviceFrameStyle(
      {@required Color bodyColor,
      @required Color borderColor,
      @required Color buttonColor,
      @required Color shadowColor}) = _$_DeviceFrameStyle;

  @override
  Color get bodyColor;
  @override
  Color get borderColor;
  @override
  Color get buttonColor;
  @override
  Color get shadowColor;
  @override
  _$DeviceFrameStyleCopyWith<_DeviceFrameStyle> get copyWith;
}

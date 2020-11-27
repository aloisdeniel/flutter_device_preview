// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'device_preview_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DevicePreviewStyleTearOff {
  const _$DevicePreviewStyleTearOff();

// ignore: unused_element
  _DevicePreviewStyle call(
      {@required BoxDecoration background,
      @required DevicePreviewToolBarStyle toolBar}) {
    return _DevicePreviewStyle(
      background: background,
      toolBar: toolBar,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewStyle = _$DevicePreviewStyleTearOff();

/// @nodoc
mixin _$DevicePreviewStyle {
  BoxDecoration get background;
  DevicePreviewToolBarStyle get toolBar;

  $DevicePreviewStyleCopyWith<DevicePreviewStyle> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewStyleCopyWith<$Res> {
  factory $DevicePreviewStyleCopyWith(
          DevicePreviewStyle value, $Res Function(DevicePreviewStyle) then) =
      _$DevicePreviewStyleCopyWithImpl<$Res>;
  $Res call({BoxDecoration background, DevicePreviewToolBarStyle toolBar});

  $DevicePreviewToolBarStyleCopyWith<$Res> get toolBar;
}

/// @nodoc
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

/// @nodoc
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

/// @nodoc
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

/// @nodoc
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

/// @nodoc
class _$DevicePreviewToolBarStyleTearOff {
  const _$DevicePreviewToolBarStyleTearOff();

// ignore: unused_element
  _DevicePreviewToolBarStyle call(
      {@required DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
      @required Color backgroundColor,
      @required Color foregroundColor,
      @required Color buttonBackgroundColor,
      @required Color buttonHoverBackgroundColor,
      @required DevicePreviewToolBarPosition position,
      @required DevicePreviewToolBarSpacingData spacing,
      @required DevicePreviewToolBarTextStyleData fontStyles}) {
    return _DevicePreviewToolBarStyle(
      buttonsVisibility: buttonsVisibility,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      buttonBackgroundColor: buttonBackgroundColor,
      buttonHoverBackgroundColor: buttonHoverBackgroundColor,
      position: position,
      spacing: spacing,
      fontStyles: fontStyles,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewToolBarStyle = _$DevicePreviewToolBarStyleTearOff();

/// @nodoc
mixin _$DevicePreviewToolBarStyle {
  DevicePreviewButtonsVisibilityStyleData get buttonsVisibility;
  Color get backgroundColor;
  Color get foregroundColor;
  Color get buttonBackgroundColor;
  Color get buttonHoverBackgroundColor;
  DevicePreviewToolBarPosition get position;
  DevicePreviewToolBarSpacingData get spacing;
  DevicePreviewToolBarTextStyleData get fontStyles;

  $DevicePreviewToolBarStyleCopyWith<DevicePreviewToolBarStyle> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewToolBarStyleCopyWith<$Res> {
  factory $DevicePreviewToolBarStyleCopyWith(DevicePreviewToolBarStyle value,
          $Res Function(DevicePreviewToolBarStyle) then) =
      _$DevicePreviewToolBarStyleCopyWithImpl<$Res>;
  $Res call(
      {DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
      Color backgroundColor,
      Color foregroundColor,
      Color buttonBackgroundColor,
      Color buttonHoverBackgroundColor,
      DevicePreviewToolBarPosition position,
      DevicePreviewToolBarSpacingData spacing,
      DevicePreviewToolBarTextStyleData fontStyles});

  $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> get buttonsVisibility;
  $DevicePreviewToolBarSpacingDataCopyWith<$Res> get spacing;
  $DevicePreviewToolBarTextStyleDataCopyWith<$Res> get fontStyles;
}

/// @nodoc
class _$DevicePreviewToolBarStyleCopyWithImpl<$Res>
    implements $DevicePreviewToolBarStyleCopyWith<$Res> {
  _$DevicePreviewToolBarStyleCopyWithImpl(this._value, this._then);

  final DevicePreviewToolBarStyle _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewToolBarStyle) _then;

  @override
  $Res call({
    Object buttonsVisibility = freezed,
    Object backgroundColor = freezed,
    Object foregroundColor = freezed,
    Object buttonBackgroundColor = freezed,
    Object buttonHoverBackgroundColor = freezed,
    Object position = freezed,
    Object spacing = freezed,
    Object fontStyles = freezed,
  }) {
    return _then(_value.copyWith(
      buttonsVisibility: buttonsVisibility == freezed
          ? _value.buttonsVisibility
          : buttonsVisibility as DevicePreviewButtonsVisibilityStyleData,
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
      spacing: spacing == freezed
          ? _value.spacing
          : spacing as DevicePreviewToolBarSpacingData,
      fontStyles: fontStyles == freezed
          ? _value.fontStyles
          : fontStyles as DevicePreviewToolBarTextStyleData,
    ));
  }

  @override
  $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> get buttonsVisibility {
    if (_value.buttonsVisibility == null) {
      return null;
    }
    return $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res>(
        _value.buttonsVisibility, (value) {
      return _then(_value.copyWith(buttonsVisibility: value));
    });
  }

  @override
  $DevicePreviewToolBarSpacingDataCopyWith<$Res> get spacing {
    if (_value.spacing == null) {
      return null;
    }
    return $DevicePreviewToolBarSpacingDataCopyWith<$Res>(_value.spacing,
        (value) {
      return _then(_value.copyWith(spacing: value));
    });
  }

  @override
  $DevicePreviewToolBarTextStyleDataCopyWith<$Res> get fontStyles {
    if (_value.fontStyles == null) {
      return null;
    }
    return $DevicePreviewToolBarTextStyleDataCopyWith<$Res>(_value.fontStyles,
        (value) {
      return _then(_value.copyWith(fontStyles: value));
    });
  }
}

/// @nodoc
abstract class _$DevicePreviewToolBarStyleCopyWith<$Res>
    implements $DevicePreviewToolBarStyleCopyWith<$Res> {
  factory _$DevicePreviewToolBarStyleCopyWith(_DevicePreviewToolBarStyle value,
          $Res Function(_DevicePreviewToolBarStyle) then) =
      __$DevicePreviewToolBarStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
      Color backgroundColor,
      Color foregroundColor,
      Color buttonBackgroundColor,
      Color buttonHoverBackgroundColor,
      DevicePreviewToolBarPosition position,
      DevicePreviewToolBarSpacingData spacing,
      DevicePreviewToolBarTextStyleData fontStyles});

  @override
  $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> get buttonsVisibility;
  @override
  $DevicePreviewToolBarSpacingDataCopyWith<$Res> get spacing;
  @override
  $DevicePreviewToolBarTextStyleDataCopyWith<$Res> get fontStyles;
}

/// @nodoc
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
    Object buttonsVisibility = freezed,
    Object backgroundColor = freezed,
    Object foregroundColor = freezed,
    Object buttonBackgroundColor = freezed,
    Object buttonHoverBackgroundColor = freezed,
    Object position = freezed,
    Object spacing = freezed,
    Object fontStyles = freezed,
  }) {
    return _then(_DevicePreviewToolBarStyle(
      buttonsVisibility: buttonsVisibility == freezed
          ? _value.buttonsVisibility
          : buttonsVisibility as DevicePreviewButtonsVisibilityStyleData,
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
      spacing: spacing == freezed
          ? _value.spacing
          : spacing as DevicePreviewToolBarSpacingData,
      fontStyles: fontStyles == freezed
          ? _value.fontStyles
          : fontStyles as DevicePreviewToolBarTextStyleData,
    ));
  }
}

/// @nodoc
class _$_DevicePreviewToolBarStyle
    with DiagnosticableTreeMixin
    implements _DevicePreviewToolBarStyle {
  const _$_DevicePreviewToolBarStyle(
      {@required this.buttonsVisibility,
      @required this.backgroundColor,
      @required this.foregroundColor,
      @required this.buttonBackgroundColor,
      @required this.buttonHoverBackgroundColor,
      @required this.position,
      @required this.spacing,
      @required this.fontStyles})
      : assert(buttonsVisibility != null),
        assert(backgroundColor != null),
        assert(foregroundColor != null),
        assert(buttonBackgroundColor != null),
        assert(buttonHoverBackgroundColor != null),
        assert(position != null),
        assert(spacing != null),
        assert(fontStyles != null);

  @override
  final DevicePreviewButtonsVisibilityStyleData buttonsVisibility;
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
  final DevicePreviewToolBarSpacingData spacing;
  @override
  final DevicePreviewToolBarTextStyleData fontStyles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewToolBarStyle(buttonsVisibility: $buttonsVisibility, backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, buttonBackgroundColor: $buttonBackgroundColor, buttonHoverBackgroundColor: $buttonHoverBackgroundColor, position: $position, spacing: $spacing, fontStyles: $fontStyles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewToolBarStyle'))
      ..add(DiagnosticsProperty('buttonsVisibility', buttonsVisibility))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty('buttonBackgroundColor', buttonBackgroundColor))
      ..add(DiagnosticsProperty(
          'buttonHoverBackgroundColor', buttonHoverBackgroundColor))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(DiagnosticsProperty('fontStyles', fontStyles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewToolBarStyle &&
            (identical(other.buttonsVisibility, buttonsVisibility) ||
                const DeepCollectionEquality()
                    .equals(other.buttonsVisibility, buttonsVisibility)) &&
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
                    .equals(other.position, position)) &&
            (identical(other.spacing, spacing) ||
                const DeepCollectionEquality()
                    .equals(other.spacing, spacing)) &&
            (identical(other.fontStyles, fontStyles) ||
                const DeepCollectionEquality()
                    .equals(other.fontStyles, fontStyles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(buttonsVisibility) ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(foregroundColor) ^
      const DeepCollectionEquality().hash(buttonBackgroundColor) ^
      const DeepCollectionEquality().hash(buttonHoverBackgroundColor) ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(spacing) ^
      const DeepCollectionEquality().hash(fontStyles);

  @override
  _$DevicePreviewToolBarStyleCopyWith<_DevicePreviewToolBarStyle>
      get copyWith =>
          __$DevicePreviewToolBarStyleCopyWithImpl<_DevicePreviewToolBarStyle>(
              this, _$identity);
}

abstract class _DevicePreviewToolBarStyle implements DevicePreviewToolBarStyle {
  const factory _DevicePreviewToolBarStyle(
          {@required DevicePreviewButtonsVisibilityStyleData buttonsVisibility,
          @required Color backgroundColor,
          @required Color foregroundColor,
          @required Color buttonBackgroundColor,
          @required Color buttonHoverBackgroundColor,
          @required DevicePreviewToolBarPosition position,
          @required DevicePreviewToolBarSpacingData spacing,
          @required DevicePreviewToolBarTextStyleData fontStyles}) =
      _$_DevicePreviewToolBarStyle;

  @override
  DevicePreviewButtonsVisibilityStyleData get buttonsVisibility;
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
  DevicePreviewToolBarSpacingData get spacing;
  @override
  DevicePreviewToolBarTextStyleData get fontStyles;
  @override
  _$DevicePreviewToolBarStyleCopyWith<_DevicePreviewToolBarStyle> get copyWith;
}

/// @nodoc
class _$DevicePreviewToolBarSpacingDataTearOff {
  const _$DevicePreviewToolBarSpacingDataTearOff();

// ignore: unused_element
  _DevicePreviewToolBarSpacingData call(
      {@required EdgeInsets small,
      @required EdgeInsets regular,
      @required EdgeInsets big}) {
    return _DevicePreviewToolBarSpacingData(
      small: small,
      regular: regular,
      big: big,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewToolBarSpacingData =
    _$DevicePreviewToolBarSpacingDataTearOff();

/// @nodoc
mixin _$DevicePreviewToolBarSpacingData {
  EdgeInsets get small;
  EdgeInsets get regular;
  EdgeInsets get big;

  $DevicePreviewToolBarSpacingDataCopyWith<DevicePreviewToolBarSpacingData>
      get copyWith;
}

/// @nodoc
abstract class $DevicePreviewToolBarSpacingDataCopyWith<$Res> {
  factory $DevicePreviewToolBarSpacingDataCopyWith(
          DevicePreviewToolBarSpacingData value,
          $Res Function(DevicePreviewToolBarSpacingData) then) =
      _$DevicePreviewToolBarSpacingDataCopyWithImpl<$Res>;
  $Res call({EdgeInsets small, EdgeInsets regular, EdgeInsets big});
}

/// @nodoc
class _$DevicePreviewToolBarSpacingDataCopyWithImpl<$Res>
    implements $DevicePreviewToolBarSpacingDataCopyWith<$Res> {
  _$DevicePreviewToolBarSpacingDataCopyWithImpl(this._value, this._then);

  final DevicePreviewToolBarSpacingData _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewToolBarSpacingData) _then;

  @override
  $Res call({
    Object small = freezed,
    Object regular = freezed,
    Object big = freezed,
  }) {
    return _then(_value.copyWith(
      small: small == freezed ? _value.small : small as EdgeInsets,
      regular: regular == freezed ? _value.regular : regular as EdgeInsets,
      big: big == freezed ? _value.big : big as EdgeInsets,
    ));
  }
}

/// @nodoc
abstract class _$DevicePreviewToolBarSpacingDataCopyWith<$Res>
    implements $DevicePreviewToolBarSpacingDataCopyWith<$Res> {
  factory _$DevicePreviewToolBarSpacingDataCopyWith(
          _DevicePreviewToolBarSpacingData value,
          $Res Function(_DevicePreviewToolBarSpacingData) then) =
      __$DevicePreviewToolBarSpacingDataCopyWithImpl<$Res>;
  @override
  $Res call({EdgeInsets small, EdgeInsets regular, EdgeInsets big});
}

/// @nodoc
class __$DevicePreviewToolBarSpacingDataCopyWithImpl<$Res>
    extends _$DevicePreviewToolBarSpacingDataCopyWithImpl<$Res>
    implements _$DevicePreviewToolBarSpacingDataCopyWith<$Res> {
  __$DevicePreviewToolBarSpacingDataCopyWithImpl(
      _DevicePreviewToolBarSpacingData _value,
      $Res Function(_DevicePreviewToolBarSpacingData) _then)
      : super(_value, (v) => _then(v as _DevicePreviewToolBarSpacingData));

  @override
  _DevicePreviewToolBarSpacingData get _value =>
      super._value as _DevicePreviewToolBarSpacingData;

  @override
  $Res call({
    Object small = freezed,
    Object regular = freezed,
    Object big = freezed,
  }) {
    return _then(_DevicePreviewToolBarSpacingData(
      small: small == freezed ? _value.small : small as EdgeInsets,
      regular: regular == freezed ? _value.regular : regular as EdgeInsets,
      big: big == freezed ? _value.big : big as EdgeInsets,
    ));
  }
}

/// @nodoc
class _$_DevicePreviewToolBarSpacingData
    with DiagnosticableTreeMixin
    implements _DevicePreviewToolBarSpacingData {
  const _$_DevicePreviewToolBarSpacingData(
      {@required this.small, @required this.regular, @required this.big})
      : assert(small != null),
        assert(regular != null),
        assert(big != null);

  @override
  final EdgeInsets small;
  @override
  final EdgeInsets regular;
  @override
  final EdgeInsets big;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewToolBarSpacingData(small: $small, regular: $regular, big: $big)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewToolBarSpacingData'))
      ..add(DiagnosticsProperty('small', small))
      ..add(DiagnosticsProperty('regular', regular))
      ..add(DiagnosticsProperty('big', big));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewToolBarSpacingData &&
            (identical(other.small, small) ||
                const DeepCollectionEquality().equals(other.small, small)) &&
            (identical(other.regular, regular) ||
                const DeepCollectionEquality()
                    .equals(other.regular, regular)) &&
            (identical(other.big, big) ||
                const DeepCollectionEquality().equals(other.big, big)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(small) ^
      const DeepCollectionEquality().hash(regular) ^
      const DeepCollectionEquality().hash(big);

  @override
  _$DevicePreviewToolBarSpacingDataCopyWith<_DevicePreviewToolBarSpacingData>
      get copyWith => __$DevicePreviewToolBarSpacingDataCopyWithImpl<
          _DevicePreviewToolBarSpacingData>(this, _$identity);
}

abstract class _DevicePreviewToolBarSpacingData
    implements DevicePreviewToolBarSpacingData {
  const factory _DevicePreviewToolBarSpacingData(
      {@required EdgeInsets small,
      @required EdgeInsets regular,
      @required EdgeInsets big}) = _$_DevicePreviewToolBarSpacingData;

  @override
  EdgeInsets get small;
  @override
  EdgeInsets get regular;
  @override
  EdgeInsets get big;
  @override
  _$DevicePreviewToolBarSpacingDataCopyWith<_DevicePreviewToolBarSpacingData>
      get copyWith;
}

/// @nodoc
class _$DevicePreviewToolBarTextStyleDataTearOff {
  const _$DevicePreviewToolBarTextStyleDataTearOff();

// ignore: unused_element
  _DevicePreviewToolBarTextStyleData call(
      {@required TextStyle smallBody,
      @required TextStyle body,
      @required TextStyle title,
      @required TextStyle fieldLabel}) {
    return _DevicePreviewToolBarTextStyleData(
      smallBody: smallBody,
      body: body,
      title: title,
      fieldLabel: fieldLabel,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewToolBarTextStyleData =
    _$DevicePreviewToolBarTextStyleDataTearOff();

/// @nodoc
mixin _$DevicePreviewToolBarTextStyleData {
  TextStyle get smallBody;
  TextStyle get body;
  TextStyle get title;
  TextStyle get fieldLabel;

  $DevicePreviewToolBarTextStyleDataCopyWith<DevicePreviewToolBarTextStyleData>
      get copyWith;
}

/// @nodoc
abstract class $DevicePreviewToolBarTextStyleDataCopyWith<$Res> {
  factory $DevicePreviewToolBarTextStyleDataCopyWith(
          DevicePreviewToolBarTextStyleData value,
          $Res Function(DevicePreviewToolBarTextStyleData) then) =
      _$DevicePreviewToolBarTextStyleDataCopyWithImpl<$Res>;
  $Res call(
      {TextStyle smallBody,
      TextStyle body,
      TextStyle title,
      TextStyle fieldLabel});
}

/// @nodoc
class _$DevicePreviewToolBarTextStyleDataCopyWithImpl<$Res>
    implements $DevicePreviewToolBarTextStyleDataCopyWith<$Res> {
  _$DevicePreviewToolBarTextStyleDataCopyWithImpl(this._value, this._then);

  final DevicePreviewToolBarTextStyleData _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewToolBarTextStyleData) _then;

  @override
  $Res call({
    Object smallBody = freezed,
    Object body = freezed,
    Object title = freezed,
    Object fieldLabel = freezed,
  }) {
    return _then(_value.copyWith(
      smallBody:
          smallBody == freezed ? _value.smallBody : smallBody as TextStyle,
      body: body == freezed ? _value.body : body as TextStyle,
      title: title == freezed ? _value.title : title as TextStyle,
      fieldLabel:
          fieldLabel == freezed ? _value.fieldLabel : fieldLabel as TextStyle,
    ));
  }
}

/// @nodoc
abstract class _$DevicePreviewToolBarTextStyleDataCopyWith<$Res>
    implements $DevicePreviewToolBarTextStyleDataCopyWith<$Res> {
  factory _$DevicePreviewToolBarTextStyleDataCopyWith(
          _DevicePreviewToolBarTextStyleData value,
          $Res Function(_DevicePreviewToolBarTextStyleData) then) =
      __$DevicePreviewToolBarTextStyleDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {TextStyle smallBody,
      TextStyle body,
      TextStyle title,
      TextStyle fieldLabel});
}

/// @nodoc
class __$DevicePreviewToolBarTextStyleDataCopyWithImpl<$Res>
    extends _$DevicePreviewToolBarTextStyleDataCopyWithImpl<$Res>
    implements _$DevicePreviewToolBarTextStyleDataCopyWith<$Res> {
  __$DevicePreviewToolBarTextStyleDataCopyWithImpl(
      _DevicePreviewToolBarTextStyleData _value,
      $Res Function(_DevicePreviewToolBarTextStyleData) _then)
      : super(_value, (v) => _then(v as _DevicePreviewToolBarTextStyleData));

  @override
  _DevicePreviewToolBarTextStyleData get _value =>
      super._value as _DevicePreviewToolBarTextStyleData;

  @override
  $Res call({
    Object smallBody = freezed,
    Object body = freezed,
    Object title = freezed,
    Object fieldLabel = freezed,
  }) {
    return _then(_DevicePreviewToolBarTextStyleData(
      smallBody:
          smallBody == freezed ? _value.smallBody : smallBody as TextStyle,
      body: body == freezed ? _value.body : body as TextStyle,
      title: title == freezed ? _value.title : title as TextStyle,
      fieldLabel:
          fieldLabel == freezed ? _value.fieldLabel : fieldLabel as TextStyle,
    ));
  }
}

/// @nodoc
class _$_DevicePreviewToolBarTextStyleData
    with DiagnosticableTreeMixin
    implements _DevicePreviewToolBarTextStyleData {
  const _$_DevicePreviewToolBarTextStyleData(
      {@required this.smallBody,
      @required this.body,
      @required this.title,
      @required this.fieldLabel})
      : assert(smallBody != null),
        assert(body != null),
        assert(title != null),
        assert(fieldLabel != null);

  @override
  final TextStyle smallBody;
  @override
  final TextStyle body;
  @override
  final TextStyle title;
  @override
  final TextStyle fieldLabel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewToolBarTextStyleData(smallBody: $smallBody, body: $body, title: $title, fieldLabel: $fieldLabel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewToolBarTextStyleData'))
      ..add(DiagnosticsProperty('smallBody', smallBody))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('fieldLabel', fieldLabel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewToolBarTextStyleData &&
            (identical(other.smallBody, smallBody) ||
                const DeepCollectionEquality()
                    .equals(other.smallBody, smallBody)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.fieldLabel, fieldLabel) ||
                const DeepCollectionEquality()
                    .equals(other.fieldLabel, fieldLabel)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(smallBody) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(fieldLabel);

  @override
  _$DevicePreviewToolBarTextStyleDataCopyWith<
          _DevicePreviewToolBarTextStyleData>
      get copyWith => __$DevicePreviewToolBarTextStyleDataCopyWithImpl<
          _DevicePreviewToolBarTextStyleData>(this, _$identity);
}

abstract class _DevicePreviewToolBarTextStyleData
    implements DevicePreviewToolBarTextStyleData {
  const factory _DevicePreviewToolBarTextStyleData(
      {@required TextStyle smallBody,
      @required TextStyle body,
      @required TextStyle title,
      @required TextStyle fieldLabel}) = _$_DevicePreviewToolBarTextStyleData;

  @override
  TextStyle get smallBody;
  @override
  TextStyle get body;
  @override
  TextStyle get title;
  @override
  TextStyle get fieldLabel;
  @override
  _$DevicePreviewToolBarTextStyleDataCopyWith<
      _DevicePreviewToolBarTextStyleData> get copyWith;
}

/// @nodoc
class _$DevicePreviewButtonsVisibilityStyleDataTearOff {
  const _$DevicePreviewButtonsVisibilityStyleDataTearOff();

// ignore: unused_element
  _DevicePreviewButtonsVisibilityStyleData call(
      {bool togglePreview = true,
      bool device = true,
      bool language = true,
      bool rotate = true,
      bool toggleFrame = true,
      bool toggleKeyboard = true,
      bool darkMode = true,
      bool accessibility = true,
      bool settings = true}) {
    return _DevicePreviewButtonsVisibilityStyleData(
      togglePreview: togglePreview,
      device: device,
      language: language,
      rotate: rotate,
      toggleFrame: toggleFrame,
      toggleKeyboard: toggleKeyboard,
      darkMode: darkMode,
      accessibility: accessibility,
      settings: settings,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewButtonsVisibilityStyleData =
    _$DevicePreviewButtonsVisibilityStyleDataTearOff();

/// @nodoc
mixin _$DevicePreviewButtonsVisibilityStyleData {
  bool get togglePreview;
  bool get device;
  bool get language;
  bool get rotate;
  bool get toggleFrame;
  bool get toggleKeyboard;
  bool get darkMode;
  bool get accessibility;
  bool get settings;

  $DevicePreviewButtonsVisibilityStyleDataCopyWith<
      DevicePreviewButtonsVisibilityStyleData> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> {
  factory $DevicePreviewButtonsVisibilityStyleDataCopyWith(
          DevicePreviewButtonsVisibilityStyleData value,
          $Res Function(DevicePreviewButtonsVisibilityStyleData) then) =
      _$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<$Res>;
  $Res call(
      {bool togglePreview,
      bool device,
      bool language,
      bool rotate,
      bool toggleFrame,
      bool toggleKeyboard,
      bool darkMode,
      bool accessibility,
      bool settings});
}

/// @nodoc
class _$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<$Res>
    implements $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> {
  _$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl(
      this._value, this._then);

  final DevicePreviewButtonsVisibilityStyleData _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewButtonsVisibilityStyleData) _then;

  @override
  $Res call({
    Object togglePreview = freezed,
    Object device = freezed,
    Object language = freezed,
    Object rotate = freezed,
    Object toggleFrame = freezed,
    Object toggleKeyboard = freezed,
    Object darkMode = freezed,
    Object accessibility = freezed,
    Object settings = freezed,
  }) {
    return _then(_value.copyWith(
      togglePreview: togglePreview == freezed
          ? _value.togglePreview
          : togglePreview as bool,
      device: device == freezed ? _value.device : device as bool,
      language: language == freezed ? _value.language : language as bool,
      rotate: rotate == freezed ? _value.rotate : rotate as bool,
      toggleFrame:
          toggleFrame == freezed ? _value.toggleFrame : toggleFrame as bool,
      toggleKeyboard: toggleKeyboard == freezed
          ? _value.toggleKeyboard
          : toggleKeyboard as bool,
      darkMode: darkMode == freezed ? _value.darkMode : darkMode as bool,
      accessibility: accessibility == freezed
          ? _value.accessibility
          : accessibility as bool,
      settings: settings == freezed ? _value.settings : settings as bool,
    ));
  }
}

/// @nodoc
abstract class _$DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res>
    implements $DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> {
  factory _$DevicePreviewButtonsVisibilityStyleDataCopyWith(
          _DevicePreviewButtonsVisibilityStyleData value,
          $Res Function(_DevicePreviewButtonsVisibilityStyleData) then) =
      __$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool togglePreview,
      bool device,
      bool language,
      bool rotate,
      bool toggleFrame,
      bool toggleKeyboard,
      bool darkMode,
      bool accessibility,
      bool settings});
}

/// @nodoc
class __$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<$Res>
    extends _$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<$Res>
    implements _$DevicePreviewButtonsVisibilityStyleDataCopyWith<$Res> {
  __$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl(
      _DevicePreviewButtonsVisibilityStyleData _value,
      $Res Function(_DevicePreviewButtonsVisibilityStyleData) _then)
      : super(_value,
            (v) => _then(v as _DevicePreviewButtonsVisibilityStyleData));

  @override
  _DevicePreviewButtonsVisibilityStyleData get _value =>
      super._value as _DevicePreviewButtonsVisibilityStyleData;

  @override
  $Res call({
    Object togglePreview = freezed,
    Object device = freezed,
    Object language = freezed,
    Object rotate = freezed,
    Object toggleFrame = freezed,
    Object toggleKeyboard = freezed,
    Object darkMode = freezed,
    Object accessibility = freezed,
    Object settings = freezed,
  }) {
    return _then(_DevicePreviewButtonsVisibilityStyleData(
      togglePreview: togglePreview == freezed
          ? _value.togglePreview
          : togglePreview as bool,
      device: device == freezed ? _value.device : device as bool,
      language: language == freezed ? _value.language : language as bool,
      rotate: rotate == freezed ? _value.rotate : rotate as bool,
      toggleFrame:
          toggleFrame == freezed ? _value.toggleFrame : toggleFrame as bool,
      toggleKeyboard: toggleKeyboard == freezed
          ? _value.toggleKeyboard
          : toggleKeyboard as bool,
      darkMode: darkMode == freezed ? _value.darkMode : darkMode as bool,
      accessibility: accessibility == freezed
          ? _value.accessibility
          : accessibility as bool,
      settings: settings == freezed ? _value.settings : settings as bool,
    ));
  }
}

/// @nodoc
class _$_DevicePreviewButtonsVisibilityStyleData
    with DiagnosticableTreeMixin
    implements _DevicePreviewButtonsVisibilityStyleData {
  const _$_DevicePreviewButtonsVisibilityStyleData(
      {this.togglePreview = true,
      this.device = true,
      this.language = true,
      this.rotate = true,
      this.toggleFrame = true,
      this.toggleKeyboard = true,
      this.darkMode = true,
      this.accessibility = true,
      this.settings = true})
      : assert(togglePreview != null),
        assert(device != null),
        assert(language != null),
        assert(rotate != null),
        assert(toggleFrame != null),
        assert(toggleKeyboard != null),
        assert(darkMode != null),
        assert(accessibility != null),
        assert(settings != null);

  @JsonKey(defaultValue: true)
  @override
  final bool togglePreview;
  @JsonKey(defaultValue: true)
  @override
  final bool device;
  @JsonKey(defaultValue: true)
  @override
  final bool language;
  @JsonKey(defaultValue: true)
  @override
  final bool rotate;
  @JsonKey(defaultValue: true)
  @override
  final bool toggleFrame;
  @JsonKey(defaultValue: true)
  @override
  final bool toggleKeyboard;
  @JsonKey(defaultValue: true)
  @override
  final bool darkMode;
  @JsonKey(defaultValue: true)
  @override
  final bool accessibility;
  @JsonKey(defaultValue: true)
  @override
  final bool settings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewButtonsVisibilityStyleData(togglePreview: $togglePreview, device: $device, language: $language, rotate: $rotate, toggleFrame: $toggleFrame, toggleKeyboard: $toggleKeyboard, darkMode: $darkMode, accessibility: $accessibility, settings: $settings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'DevicePreviewButtonsVisibilityStyleData'))
      ..add(DiagnosticsProperty('togglePreview', togglePreview))
      ..add(DiagnosticsProperty('device', device))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('rotate', rotate))
      ..add(DiagnosticsProperty('toggleFrame', toggleFrame))
      ..add(DiagnosticsProperty('toggleKeyboard', toggleKeyboard))
      ..add(DiagnosticsProperty('darkMode', darkMode))
      ..add(DiagnosticsProperty('accessibility', accessibility))
      ..add(DiagnosticsProperty('settings', settings));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewButtonsVisibilityStyleData &&
            (identical(other.togglePreview, togglePreview) ||
                const DeepCollectionEquality()
                    .equals(other.togglePreview, togglePreview)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.rotate, rotate) ||
                const DeepCollectionEquality().equals(other.rotate, rotate)) &&
            (identical(other.toggleFrame, toggleFrame) ||
                const DeepCollectionEquality()
                    .equals(other.toggleFrame, toggleFrame)) &&
            (identical(other.toggleKeyboard, toggleKeyboard) ||
                const DeepCollectionEquality()
                    .equals(other.toggleKeyboard, toggleKeyboard)) &&
            (identical(other.darkMode, darkMode) ||
                const DeepCollectionEquality()
                    .equals(other.darkMode, darkMode)) &&
            (identical(other.accessibility, accessibility) ||
                const DeepCollectionEquality()
                    .equals(other.accessibility, accessibility)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(togglePreview) ^
      const DeepCollectionEquality().hash(device) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(rotate) ^
      const DeepCollectionEquality().hash(toggleFrame) ^
      const DeepCollectionEquality().hash(toggleKeyboard) ^
      const DeepCollectionEquality().hash(darkMode) ^
      const DeepCollectionEquality().hash(accessibility) ^
      const DeepCollectionEquality().hash(settings);

  @override
  _$DevicePreviewButtonsVisibilityStyleDataCopyWith<
          _DevicePreviewButtonsVisibilityStyleData>
      get copyWith => __$DevicePreviewButtonsVisibilityStyleDataCopyWithImpl<
          _DevicePreviewButtonsVisibilityStyleData>(this, _$identity);
}

abstract class _DevicePreviewButtonsVisibilityStyleData
    implements DevicePreviewButtonsVisibilityStyleData {
  const factory _DevicePreviewButtonsVisibilityStyleData(
      {bool togglePreview,
      bool device,
      bool language,
      bool rotate,
      bool toggleFrame,
      bool toggleKeyboard,
      bool darkMode,
      bool accessibility,
      bool settings}) = _$_DevicePreviewButtonsVisibilityStyleData;

  @override
  bool get togglePreview;
  @override
  bool get device;
  @override
  bool get language;
  @override
  bool get rotate;
  @override
  bool get toggleFrame;
  @override
  bool get toggleKeyboard;
  @override
  bool get darkMode;
  @override
  bool get accessibility;
  @override
  bool get settings;
  @override
  _$DevicePreviewButtonsVisibilityStyleDataCopyWith<
      _DevicePreviewButtonsVisibilityStyleData> get copyWith;
}

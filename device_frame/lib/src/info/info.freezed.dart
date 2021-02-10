// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DeviceInfoTearOff {
  const _$DeviceInfoTearOff();

  _DeviceInfo call(
      {required DeviceIdentifier identifier,
      required String name,
      EdgeInsets? rotatedSafeAreas = null,
      required EdgeInsets safeAreas,
      required Path screenPath,
      required double pixelRatio,
      required String svgFrame,
      required Size frameSize,
      required Size screenSize}) {
    return _DeviceInfo(
      identifier: identifier,
      name: name,
      rotatedSafeAreas: rotatedSafeAreas,
      safeAreas: safeAreas,
      screenPath: screenPath,
      pixelRatio: pixelRatio,
      svgFrame: svgFrame,
      frameSize: frameSize,
      screenSize: screenSize,
    );
  }
}

/// @nodoc
const $DeviceInfo = _$DeviceInfoTearOff();

/// @nodoc
mixin _$DeviceInfo {
  /// Identifier of the device.
  DeviceIdentifier get identifier;

  /// The display name of the device.
  String get name;

  /// The safe areas when the device is in landscape orientation.
  EdgeInsets? get rotatedSafeAreas;

  /// The safe areas when the device is in portrait orientation.
  EdgeInsets get safeAreas;

  /// A shape representing the screen.
  Path get screenPath;

  /// The screen pixel density of the device.
  double get pixelRatio;

  /// The safe areas when the device is in portrait orientation.
  String get svgFrame;

  /// The frame size in pixels.
  Size get frameSize;

  /// The size in points of the screen content.
  Size get screenSize;

  @JsonKey(ignore: true)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res>;
  $Res call(
      {DeviceIdentifier identifier,
      String name,
      EdgeInsets? rotatedSafeAreas,
      EdgeInsets safeAreas,
      Path screenPath,
      double pixelRatio,
      String svgFrame,
      Size frameSize,
      Size screenSize});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res> implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  final DeviceInfo _value;
  // ignore: unused_field
  final $Res Function(DeviceInfo) _then;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? name = freezed,
    Object? rotatedSafeAreas = freezed,
    Object? safeAreas = freezed,
    Object? screenPath = freezed,
    Object? pixelRatio = freezed,
    Object? svgFrame = freezed,
    Object? frameSize = freezed,
    Object? screenSize = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: identifier == freezed
          ? _value.identifier
          : identifier as DeviceIdentifier,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets?,
      safeAreas:
          safeAreas == freezed ? _value.safeAreas : safeAreas as EdgeInsets,
      screenPath:
          screenPath == freezed ? _value.screenPath : screenPath as Path,
      pixelRatio:
          pixelRatio == freezed ? _value.pixelRatio : pixelRatio as double,
      svgFrame: svgFrame == freezed ? _value.svgFrame : svgFrame as String,
      frameSize: frameSize == freezed ? _value.frameSize : frameSize as Size,
      screenSize:
          screenSize == freezed ? _value.screenSize : screenSize as Size,
    ));
  }
}

/// @nodoc
abstract class _$DeviceInfoCopyWith<$Res> implements $DeviceInfoCopyWith<$Res> {
  factory _$DeviceInfoCopyWith(
          _DeviceInfo value, $Res Function(_DeviceInfo) then) =
      __$DeviceInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {DeviceIdentifier identifier,
      String name,
      EdgeInsets? rotatedSafeAreas,
      EdgeInsets safeAreas,
      Path screenPath,
      double pixelRatio,
      String svgFrame,
      Size frameSize,
      Size screenSize});
}

/// @nodoc
class __$DeviceInfoCopyWithImpl<$Res> extends _$DeviceInfoCopyWithImpl<$Res>
    implements _$DeviceInfoCopyWith<$Res> {
  __$DeviceInfoCopyWithImpl(
      _DeviceInfo _value, $Res Function(_DeviceInfo) _then)
      : super(_value, (v) => _then(v as _DeviceInfo));

  @override
  _DeviceInfo get _value => super._value as _DeviceInfo;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? name = freezed,
    Object? rotatedSafeAreas = freezed,
    Object? safeAreas = freezed,
    Object? screenPath = freezed,
    Object? pixelRatio = freezed,
    Object? svgFrame = freezed,
    Object? frameSize = freezed,
    Object? screenSize = freezed,
  }) {
    return _then(_DeviceInfo(
      identifier: identifier == freezed
          ? _value.identifier
          : identifier as DeviceIdentifier,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets?,
      safeAreas:
          safeAreas == freezed ? _value.safeAreas : safeAreas as EdgeInsets,
      screenPath:
          screenPath == freezed ? _value.screenPath : screenPath as Path,
      pixelRatio:
          pixelRatio == freezed ? _value.pixelRatio : pixelRatio as double,
      svgFrame: svgFrame == freezed ? _value.svgFrame : svgFrame as String,
      frameSize: frameSize == freezed ? _value.frameSize : frameSize as Size,
      screenSize:
          screenSize == freezed ? _value.screenSize : screenSize as Size,
    ));
  }
}

/// @nodoc
class _$_DeviceInfo with DiagnosticableTreeMixin implements _DeviceInfo {
  const _$_DeviceInfo(
      {required this.identifier,
      required this.name,
      this.rotatedSafeAreas = null,
      required this.safeAreas,
      required this.screenPath,
      required this.pixelRatio,
      required this.svgFrame,
      required this.frameSize,
      required this.screenSize});

  @override

  /// Identifier of the device.
  final DeviceIdentifier identifier;
  @override

  /// The display name of the device.
  final String name;
  @JsonKey(defaultValue: null)
  @override

  /// The safe areas when the device is in landscape orientation.
  final EdgeInsets? rotatedSafeAreas;
  @override

  /// The safe areas when the device is in portrait orientation.
  final EdgeInsets safeAreas;
  @override

  /// A shape representing the screen.
  final Path screenPath;
  @override

  /// The screen pixel density of the device.
  final double pixelRatio;
  @override

  /// The safe areas when the device is in portrait orientation.
  final String svgFrame;
  @override

  /// The frame size in pixels.
  final Size frameSize;
  @override

  /// The size in points of the screen content.
  final Size screenSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceInfo(identifier: $identifier, name: $name, rotatedSafeAreas: $rotatedSafeAreas, safeAreas: $safeAreas, screenPath: $screenPath, pixelRatio: $pixelRatio, svgFrame: $svgFrame, frameSize: $frameSize, screenSize: $screenSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceInfo'))
      ..add(DiagnosticsProperty('identifier', identifier))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('rotatedSafeAreas', rotatedSafeAreas))
      ..add(DiagnosticsProperty('safeAreas', safeAreas))
      ..add(DiagnosticsProperty('screenPath', screenPath))
      ..add(DiagnosticsProperty('pixelRatio', pixelRatio))
      ..add(DiagnosticsProperty('svgFrame', svgFrame))
      ..add(DiagnosticsProperty('frameSize', frameSize))
      ..add(DiagnosticsProperty('screenSize', screenSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeviceInfo &&
            (identical(other.identifier, identifier) ||
                const DeepCollectionEquality()
                    .equals(other.identifier, identifier)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.rotatedSafeAreas, rotatedSafeAreas) ||
                const DeepCollectionEquality()
                    .equals(other.rotatedSafeAreas, rotatedSafeAreas)) &&
            (identical(other.safeAreas, safeAreas) ||
                const DeepCollectionEquality()
                    .equals(other.safeAreas, safeAreas)) &&
            (identical(other.screenPath, screenPath) ||
                const DeepCollectionEquality()
                    .equals(other.screenPath, screenPath)) &&
            (identical(other.pixelRatio, pixelRatio) ||
                const DeepCollectionEquality()
                    .equals(other.pixelRatio, pixelRatio)) &&
            (identical(other.svgFrame, svgFrame) ||
                const DeepCollectionEquality()
                    .equals(other.svgFrame, svgFrame)) &&
            (identical(other.frameSize, frameSize) ||
                const DeepCollectionEquality()
                    .equals(other.frameSize, frameSize)) &&
            (identical(other.screenSize, screenSize) ||
                const DeepCollectionEquality()
                    .equals(other.screenSize, screenSize)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(identifier) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(rotatedSafeAreas) ^
      const DeepCollectionEquality().hash(safeAreas) ^
      const DeepCollectionEquality().hash(screenPath) ^
      const DeepCollectionEquality().hash(pixelRatio) ^
      const DeepCollectionEquality().hash(svgFrame) ^
      const DeepCollectionEquality().hash(frameSize) ^
      const DeepCollectionEquality().hash(screenSize);

  @JsonKey(ignore: true)
  @override
  _$DeviceInfoCopyWith<_DeviceInfo> get copyWith =>
      __$DeviceInfoCopyWithImpl<_DeviceInfo>(this, _$identity);
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo(
      {required DeviceIdentifier identifier,
      required String name,
      EdgeInsets? rotatedSafeAreas,
      required EdgeInsets safeAreas,
      required Path screenPath,
      required double pixelRatio,
      required String svgFrame,
      required Size frameSize,
      required Size screenSize}) = _$_DeviceInfo;

  @override

  /// Identifier of the device.
  DeviceIdentifier get identifier;
  @override

  /// The display name of the device.
  String get name;
  @override

  /// The safe areas when the device is in landscape orientation.
  EdgeInsets? get rotatedSafeAreas;
  @override

  /// The safe areas when the device is in portrait orientation.
  EdgeInsets get safeAreas;
  @override

  /// A shape representing the screen.
  Path get screenPath;
  @override

  /// The screen pixel density of the device.
  double get pixelRatio;
  @override

  /// The safe areas when the device is in portrait orientation.
  String get svgFrame;
  @override

  /// The frame size in pixels.
  Size get frameSize;
  @override

  /// The size in points of the screen content.
  Size get screenSize;
  @override
  @JsonKey(ignore: true)
  _$DeviceInfoCopyWith<_DeviceInfo> get copyWith;
}

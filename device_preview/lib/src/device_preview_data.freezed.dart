// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'device_preview_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
DevicePreviewData _$DevicePreviewDataFromJson(Map<String, dynamic> json) {
  return _DevicePreviewData.fromJson(json);
}

/// @nodoc
class _$DevicePreviewDataTearOff {
  const _$DevicePreviewDataTearOff();

// ignore: unused_element
  _DevicePreviewData call(
      {bool isEnabled = true,
      Orientation orientation = Orientation.portrait,
      @nullable String deviceIdentifier,
      String locale = 'en-US',
      bool isFrameVisible = true,
      bool isDarkMode = false,
      bool boldText = false,
      bool disableAnimations = false,
      bool highContrast = false,
      bool accessibleNavigation = false,
      bool invertColors = false,
      double textScaleFactor = 1.0,
      @nullable CustomDeviceInfoData customDevice}) {
    return _DevicePreviewData(
      isEnabled: isEnabled,
      orientation: orientation,
      deviceIdentifier: deviceIdentifier,
      locale: locale,
      isFrameVisible: isFrameVisible,
      isDarkMode: isDarkMode,
      boldText: boldText,
      disableAnimations: disableAnimations,
      highContrast: highContrast,
      accessibleNavigation: accessibleNavigation,
      invertColors: invertColors,
      textScaleFactor: textScaleFactor,
      customDevice: customDevice,
    );
  }

// ignore: unused_element
  DevicePreviewData fromJson(Map<String, Object> json) {
    return DevicePreviewData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $DevicePreviewData = _$DevicePreviewDataTearOff();

/// @nodoc
mixin _$DevicePreviewData {
  /// Indicate whether the device simulation is enabled.
  bool get isEnabled;

  /// The current orientation of the device
  Orientation get orientation;

  /// The currently selected device.
  @nullable
  String get deviceIdentifier;

  /// The currently selected device locale.
  String get locale;

  /// Indicate whether the frame is currently visible.
  bool get isFrameVisible;

  /// Indicate whether the mode is currently dark.
  bool get isDarkMode;

  /// Indicate whether texts are forced to bold.
  bool get boldText;

  /// Indicate whether animations are disabled.
  bool get disableAnimations;

  /// Indicate whether the highcontrast mode is activated.
  bool get highContrast;

  /// Indicate whether the navigation is in accessible mode.
  bool get accessibleNavigation;

  /// Indicate whether image colors are inverted.
  bool get invertColors;

  /// The current text scaling factor.
  double get textScaleFactor;

  /// The custom device configuration
  @nullable
  CustomDeviceInfoData get customDevice;

  Map<String, dynamic> toJson();
  $DevicePreviewDataCopyWith<DevicePreviewData> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewDataCopyWith<$Res> {
  factory $DevicePreviewDataCopyWith(
          DevicePreviewData value, $Res Function(DevicePreviewData) then) =
      _$DevicePreviewDataCopyWithImpl<$Res>;
  $Res call(
      {bool isEnabled,
      Orientation orientation,
      @nullable String deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      double textScaleFactor,
      @nullable CustomDeviceInfoData customDevice});

  $CustomDeviceInfoDataCopyWith<$Res> get customDevice;
}

/// @nodoc
class _$DevicePreviewDataCopyWithImpl<$Res>
    implements $DevicePreviewDataCopyWith<$Res> {
  _$DevicePreviewDataCopyWithImpl(this._value, this._then);

  final DevicePreviewData _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewData) _then;

  @override
  $Res call({
    Object isEnabled = freezed,
    Object orientation = freezed,
    Object deviceIdentifier = freezed,
    Object locale = freezed,
    Object isFrameVisible = freezed,
    Object isDarkMode = freezed,
    Object boldText = freezed,
    Object disableAnimations = freezed,
    Object highContrast = freezed,
    Object accessibleNavigation = freezed,
    Object invertColors = freezed,
    Object textScaleFactor = freezed,
    Object customDevice = freezed,
  }) {
    return _then(_value.copyWith(
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation as Orientation,
      deviceIdentifier: deviceIdentifier == freezed
          ? _value.deviceIdentifier
          : deviceIdentifier as String,
      locale: locale == freezed ? _value.locale : locale as String,
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible as bool,
      isDarkMode:
          isDarkMode == freezed ? _value.isDarkMode : isDarkMode as bool,
      boldText: boldText == freezed ? _value.boldText : boldText as bool,
      disableAnimations: disableAnimations == freezed
          ? _value.disableAnimations
          : disableAnimations as bool,
      highContrast:
          highContrast == freezed ? _value.highContrast : highContrast as bool,
      accessibleNavigation: accessibleNavigation == freezed
          ? _value.accessibleNavigation
          : accessibleNavigation as bool,
      invertColors:
          invertColors == freezed ? _value.invertColors : invertColors as bool,
      textScaleFactor: textScaleFactor == freezed
          ? _value.textScaleFactor
          : textScaleFactor as double,
      customDevice: customDevice == freezed
          ? _value.customDevice
          : customDevice as CustomDeviceInfoData,
    ));
  }

  @override
  $CustomDeviceInfoDataCopyWith<$Res> get customDevice {
    if (_value.customDevice == null) {
      return null;
    }
    return $CustomDeviceInfoDataCopyWith<$Res>(_value.customDevice, (value) {
      return _then(_value.copyWith(customDevice: value));
    });
  }
}

/// @nodoc
abstract class _$DevicePreviewDataCopyWith<$Res>
    implements $DevicePreviewDataCopyWith<$Res> {
  factory _$DevicePreviewDataCopyWith(
          _DevicePreviewData value, $Res Function(_DevicePreviewData) then) =
      __$DevicePreviewDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isEnabled,
      Orientation orientation,
      @nullable String deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      double textScaleFactor,
      @nullable CustomDeviceInfoData customDevice});

  @override
  $CustomDeviceInfoDataCopyWith<$Res> get customDevice;
}

/// @nodoc
class __$DevicePreviewDataCopyWithImpl<$Res>
    extends _$DevicePreviewDataCopyWithImpl<$Res>
    implements _$DevicePreviewDataCopyWith<$Res> {
  __$DevicePreviewDataCopyWithImpl(
      _DevicePreviewData _value, $Res Function(_DevicePreviewData) _then)
      : super(_value, (v) => _then(v as _DevicePreviewData));

  @override
  _DevicePreviewData get _value => super._value as _DevicePreviewData;

  @override
  $Res call({
    Object isEnabled = freezed,
    Object orientation = freezed,
    Object deviceIdentifier = freezed,
    Object locale = freezed,
    Object isFrameVisible = freezed,
    Object isDarkMode = freezed,
    Object boldText = freezed,
    Object disableAnimations = freezed,
    Object highContrast = freezed,
    Object accessibleNavigation = freezed,
    Object invertColors = freezed,
    Object textScaleFactor = freezed,
    Object customDevice = freezed,
  }) {
    return _then(_DevicePreviewData(
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation as Orientation,
      deviceIdentifier: deviceIdentifier == freezed
          ? _value.deviceIdentifier
          : deviceIdentifier as String,
      locale: locale == freezed ? _value.locale : locale as String,
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible as bool,
      isDarkMode:
          isDarkMode == freezed ? _value.isDarkMode : isDarkMode as bool,
      boldText: boldText == freezed ? _value.boldText : boldText as bool,
      disableAnimations: disableAnimations == freezed
          ? _value.disableAnimations
          : disableAnimations as bool,
      highContrast:
          highContrast == freezed ? _value.highContrast : highContrast as bool,
      accessibleNavigation: accessibleNavigation == freezed
          ? _value.accessibleNavigation
          : accessibleNavigation as bool,
      invertColors:
          invertColors == freezed ? _value.invertColors : invertColors as bool,
      textScaleFactor: textScaleFactor == freezed
          ? _value.textScaleFactor
          : textScaleFactor as double,
      customDevice: customDevice == freezed
          ? _value.customDevice
          : customDevice as CustomDeviceInfoData,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_DevicePreviewData
    with DiagnosticableTreeMixin
    implements _DevicePreviewData {
  const _$_DevicePreviewData(
      {this.isEnabled = true,
      this.orientation = Orientation.portrait,
      @nullable this.deviceIdentifier,
      this.locale = 'en-US',
      this.isFrameVisible = true,
      this.isDarkMode = false,
      this.boldText = false,
      this.disableAnimations = false,
      this.highContrast = false,
      this.accessibleNavigation = false,
      this.invertColors = false,
      this.textScaleFactor = 1.0,
      @nullable this.customDevice})
      : assert(isEnabled != null),
        assert(orientation != null),
        assert(locale != null),
        assert(isFrameVisible != null),
        assert(isDarkMode != null),
        assert(boldText != null),
        assert(disableAnimations != null),
        assert(highContrast != null),
        assert(accessibleNavigation != null),
        assert(invertColors != null),
        assert(textScaleFactor != null);

  factory _$_DevicePreviewData.fromJson(Map<String, dynamic> json) =>
      _$_$_DevicePreviewDataFromJson(json);

  @JsonKey(defaultValue: true)
  @override

  /// Indicate whether the device simulation is enabled.
  final bool isEnabled;
  @JsonKey(defaultValue: Orientation.portrait)
  @override

  /// The current orientation of the device
  final Orientation orientation;
  @override

  /// The currently selected device.
  @nullable
  final String deviceIdentifier;
  @JsonKey(defaultValue: 'en-US')
  @override

  /// The currently selected device locale.
  final String locale;
  @JsonKey(defaultValue: true)
  @override

  /// Indicate whether the frame is currently visible.
  final bool isFrameVisible;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether the mode is currently dark.
  final bool isDarkMode;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether texts are forced to bold.
  final bool boldText;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether animations are disabled.
  final bool disableAnimations;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether the highcontrast mode is activated.
  final bool highContrast;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether the navigation is in accessible mode.
  final bool accessibleNavigation;
  @JsonKey(defaultValue: false)
  @override

  /// Indicate whether image colors are inverted.
  final bool invertColors;
  @JsonKey(defaultValue: 1.0)
  @override

  /// The current text scaling factor.
  final double textScaleFactor;
  @override

  /// The custom device configuration
  @nullable
  final CustomDeviceInfoData customDevice;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewData(isEnabled: $isEnabled, orientation: $orientation, deviceIdentifier: $deviceIdentifier, locale: $locale, isFrameVisible: $isFrameVisible, isDarkMode: $isDarkMode, boldText: $boldText, disableAnimations: $disableAnimations, highContrast: $highContrast, accessibleNavigation: $accessibleNavigation, invertColors: $invertColors, textScaleFactor: $textScaleFactor, customDevice: $customDevice)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewData'))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('orientation', orientation))
      ..add(DiagnosticsProperty('deviceIdentifier', deviceIdentifier))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('isFrameVisible', isFrameVisible))
      ..add(DiagnosticsProperty('isDarkMode', isDarkMode))
      ..add(DiagnosticsProperty('boldText', boldText))
      ..add(DiagnosticsProperty('disableAnimations', disableAnimations))
      ..add(DiagnosticsProperty('highContrast', highContrast))
      ..add(DiagnosticsProperty('accessibleNavigation', accessibleNavigation))
      ..add(DiagnosticsProperty('invertColors', invertColors))
      ..add(DiagnosticsProperty('textScaleFactor', textScaleFactor))
      ..add(DiagnosticsProperty('customDevice', customDevice));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewData &&
            (identical(other.isEnabled, isEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.isEnabled, isEnabled)) &&
            (identical(other.orientation, orientation) ||
                const DeepCollectionEquality()
                    .equals(other.orientation, orientation)) &&
            (identical(other.deviceIdentifier, deviceIdentifier) ||
                const DeepCollectionEquality()
                    .equals(other.deviceIdentifier, deviceIdentifier)) &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.isFrameVisible, isFrameVisible) ||
                const DeepCollectionEquality()
                    .equals(other.isFrameVisible, isFrameVisible)) &&
            (identical(other.isDarkMode, isDarkMode) ||
                const DeepCollectionEquality()
                    .equals(other.isDarkMode, isDarkMode)) &&
            (identical(other.boldText, boldText) ||
                const DeepCollectionEquality()
                    .equals(other.boldText, boldText)) &&
            (identical(other.disableAnimations, disableAnimations) ||
                const DeepCollectionEquality()
                    .equals(other.disableAnimations, disableAnimations)) &&
            (identical(other.highContrast, highContrast) ||
                const DeepCollectionEquality()
                    .equals(other.highContrast, highContrast)) &&
            (identical(other.accessibleNavigation, accessibleNavigation) ||
                const DeepCollectionEquality().equals(
                    other.accessibleNavigation, accessibleNavigation)) &&
            (identical(other.invertColors, invertColors) ||
                const DeepCollectionEquality()
                    .equals(other.invertColors, invertColors)) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                const DeepCollectionEquality()
                    .equals(other.textScaleFactor, textScaleFactor)) &&
            (identical(other.customDevice, customDevice) ||
                const DeepCollectionEquality()
                    .equals(other.customDevice, customDevice)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isEnabled) ^
      const DeepCollectionEquality().hash(orientation) ^
      const DeepCollectionEquality().hash(deviceIdentifier) ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(isFrameVisible) ^
      const DeepCollectionEquality().hash(isDarkMode) ^
      const DeepCollectionEquality().hash(boldText) ^
      const DeepCollectionEquality().hash(disableAnimations) ^
      const DeepCollectionEquality().hash(highContrast) ^
      const DeepCollectionEquality().hash(accessibleNavigation) ^
      const DeepCollectionEquality().hash(invertColors) ^
      const DeepCollectionEquality().hash(textScaleFactor) ^
      const DeepCollectionEquality().hash(customDevice);

  @override
  _$DevicePreviewDataCopyWith<_DevicePreviewData> get copyWith =>
      __$DevicePreviewDataCopyWithImpl<_DevicePreviewData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DevicePreviewDataToJson(this);
  }
}

abstract class _DevicePreviewData implements DevicePreviewData {
  const factory _DevicePreviewData(
      {bool isEnabled,
      Orientation orientation,
      @nullable String deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      double textScaleFactor,
      @nullable CustomDeviceInfoData customDevice}) = _$_DevicePreviewData;

  factory _DevicePreviewData.fromJson(Map<String, dynamic> json) =
      _$_DevicePreviewData.fromJson;

  @override

  /// Indicate whether the device simulation is enabled.
  bool get isEnabled;
  @override

  /// The current orientation of the device
  Orientation get orientation;
  @override

  /// The currently selected device.
  @nullable
  String get deviceIdentifier;
  @override

  /// The currently selected device locale.
  String get locale;
  @override

  /// Indicate whether the frame is currently visible.
  bool get isFrameVisible;
  @override

  /// Indicate whether the mode is currently dark.
  bool get isDarkMode;
  @override

  /// Indicate whether texts are forced to bold.
  bool get boldText;
  @override

  /// Indicate whether animations are disabled.
  bool get disableAnimations;
  @override

  /// Indicate whether the highcontrast mode is activated.
  bool get highContrast;
  @override

  /// Indicate whether the navigation is in accessible mode.
  bool get accessibleNavigation;
  @override

  /// Indicate whether image colors are inverted.
  bool get invertColors;
  @override

  /// The current text scaling factor.
  double get textScaleFactor;
  @override

  /// The custom device configuration
  @nullable
  CustomDeviceInfoData get customDevice;
  @override
  _$DevicePreviewDataCopyWith<_DevicePreviewData> get copyWith;
}

CustomDeviceInfoData _$CustomDeviceInfoDataFromJson(Map<String, dynamic> json) {
  return _CustomDeviceInfoData.fromJson(json);
}

/// @nodoc
class _$CustomDeviceInfoDataTearOff {
  const _$CustomDeviceInfoDataTearOff();

// ignore: unused_element
  _CustomDeviceInfoData call(
      {@required String id,
      @required DeviceType type,
      @required TargetPlatform platform,
      @required String name,
      @nullable @EdgeInsetsJsonConverter() EdgeInsets rotatedSafeAreas = null,
      @required @EdgeInsetsJsonConverter() EdgeInsets safeAreas,
      @required double pixelRatio,
      @required @SizeJsonConverter() Size screenSize}) {
    return _CustomDeviceInfoData(
      id: id,
      type: type,
      platform: platform,
      name: name,
      rotatedSafeAreas: rotatedSafeAreas,
      safeAreas: safeAreas,
      pixelRatio: pixelRatio,
      screenSize: screenSize,
    );
  }

// ignore: unused_element
  CustomDeviceInfoData fromJson(Map<String, Object> json) {
    return CustomDeviceInfoData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CustomDeviceInfoData = _$CustomDeviceInfoDataTearOff();

/// @nodoc
mixin _$CustomDeviceInfoData {
  /// Identifier of the device.
  String get id;

  /// The device type.
  DeviceType get type;

  /// The device operating system.
  TargetPlatform get platform;

  /// The display name of the device.
  String get name;

  /// The safe areas when the device is in landscape orientation.
  @nullable
  @EdgeInsetsJsonConverter()
  EdgeInsets get rotatedSafeAreas;

  /// The safe areas when the device is in portrait orientation.
  @EdgeInsetsJsonConverter()
  EdgeInsets get safeAreas;

  /// The screen pixel density of the device.
  double get pixelRatio;

  /// The size in points of the screen content.
  @SizeJsonConverter()
  Size get screenSize;

  Map<String, dynamic> toJson();
  $CustomDeviceInfoDataCopyWith<CustomDeviceInfoData> get copyWith;
}

/// @nodoc
abstract class $CustomDeviceInfoDataCopyWith<$Res> {
  factory $CustomDeviceInfoDataCopyWith(CustomDeviceInfoData value,
          $Res Function(CustomDeviceInfoData) then) =
      _$CustomDeviceInfoDataCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DeviceType type,
      TargetPlatform platform,
      String name,
      @nullable @EdgeInsetsJsonConverter() EdgeInsets rotatedSafeAreas,
      @EdgeInsetsJsonConverter() EdgeInsets safeAreas,
      double pixelRatio,
      @SizeJsonConverter() Size screenSize});
}

/// @nodoc
class _$CustomDeviceInfoDataCopyWithImpl<$Res>
    implements $CustomDeviceInfoDataCopyWith<$Res> {
  _$CustomDeviceInfoDataCopyWithImpl(this._value, this._then);

  final CustomDeviceInfoData _value;
  // ignore: unused_field
  final $Res Function(CustomDeviceInfoData) _then;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object platform = freezed,
    Object name = freezed,
    Object rotatedSafeAreas = freezed,
    Object safeAreas = freezed,
    Object pixelRatio = freezed,
    Object screenSize = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as DeviceType,
      platform:
          platform == freezed ? _value.platform : platform as TargetPlatform,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets,
      safeAreas:
          safeAreas == freezed ? _value.safeAreas : safeAreas as EdgeInsets,
      pixelRatio:
          pixelRatio == freezed ? _value.pixelRatio : pixelRatio as double,
      screenSize:
          screenSize == freezed ? _value.screenSize : screenSize as Size,
    ));
  }
}

/// @nodoc
abstract class _$CustomDeviceInfoDataCopyWith<$Res>
    implements $CustomDeviceInfoDataCopyWith<$Res> {
  factory _$CustomDeviceInfoDataCopyWith(_CustomDeviceInfoData value,
          $Res Function(_CustomDeviceInfoData) then) =
      __$CustomDeviceInfoDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DeviceType type,
      TargetPlatform platform,
      String name,
      @nullable @EdgeInsetsJsonConverter() EdgeInsets rotatedSafeAreas,
      @EdgeInsetsJsonConverter() EdgeInsets safeAreas,
      double pixelRatio,
      @SizeJsonConverter() Size screenSize});
}

/// @nodoc
class __$CustomDeviceInfoDataCopyWithImpl<$Res>
    extends _$CustomDeviceInfoDataCopyWithImpl<$Res>
    implements _$CustomDeviceInfoDataCopyWith<$Res> {
  __$CustomDeviceInfoDataCopyWithImpl(
      _CustomDeviceInfoData _value, $Res Function(_CustomDeviceInfoData) _then)
      : super(_value, (v) => _then(v as _CustomDeviceInfoData));

  @override
  _CustomDeviceInfoData get _value => super._value as _CustomDeviceInfoData;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object platform = freezed,
    Object name = freezed,
    Object rotatedSafeAreas = freezed,
    Object safeAreas = freezed,
    Object pixelRatio = freezed,
    Object screenSize = freezed,
  }) {
    return _then(_CustomDeviceInfoData(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as DeviceType,
      platform:
          platform == freezed ? _value.platform : platform as TargetPlatform,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets,
      safeAreas:
          safeAreas == freezed ? _value.safeAreas : safeAreas as EdgeInsets,
      pixelRatio:
          pixelRatio == freezed ? _value.pixelRatio : pixelRatio as double,
      screenSize:
          screenSize == freezed ? _value.screenSize : screenSize as Size,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CustomDeviceInfoData
    with DiagnosticableTreeMixin
    implements _CustomDeviceInfoData {
  const _$_CustomDeviceInfoData(
      {@required this.id,
      @required this.type,
      @required this.platform,
      @required this.name,
      @nullable @EdgeInsetsJsonConverter() this.rotatedSafeAreas = null,
      @required @EdgeInsetsJsonConverter() this.safeAreas,
      @required this.pixelRatio,
      @required @SizeJsonConverter() this.screenSize})
      : assert(id != null),
        assert(type != null),
        assert(platform != null),
        assert(name != null),
        assert(safeAreas != null),
        assert(pixelRatio != null),
        assert(screenSize != null);

  factory _$_CustomDeviceInfoData.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomDeviceInfoDataFromJson(json);

  @override

  /// Identifier of the device.
  final String id;
  @override

  /// The device type.
  final DeviceType type;
  @override

  /// The device operating system.
  final TargetPlatform platform;
  @override

  /// The display name of the device.
  final String name;
  @JsonKey(defaultValue: null)
  @override

  /// The safe areas when the device is in landscape orientation.
  @nullable
  @EdgeInsetsJsonConverter()
  final EdgeInsets rotatedSafeAreas;
  @override

  /// The safe areas when the device is in portrait orientation.
  @EdgeInsetsJsonConverter()
  final EdgeInsets safeAreas;
  @override

  /// The screen pixel density of the device.
  final double pixelRatio;
  @override

  /// The size in points of the screen content.
  @SizeJsonConverter()
  final Size screenSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomDeviceInfoData(id: $id, type: $type, platform: $platform, name: $name, rotatedSafeAreas: $rotatedSafeAreas, safeAreas: $safeAreas, pixelRatio: $pixelRatio, screenSize: $screenSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomDeviceInfoData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('platform', platform))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('rotatedSafeAreas', rotatedSafeAreas))
      ..add(DiagnosticsProperty('safeAreas', safeAreas))
      ..add(DiagnosticsProperty('pixelRatio', pixelRatio))
      ..add(DiagnosticsProperty('screenSize', screenSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomDeviceInfoData &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.platform, platform) ||
                const DeepCollectionEquality()
                    .equals(other.platform, platform)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.rotatedSafeAreas, rotatedSafeAreas) ||
                const DeepCollectionEquality()
                    .equals(other.rotatedSafeAreas, rotatedSafeAreas)) &&
            (identical(other.safeAreas, safeAreas) ||
                const DeepCollectionEquality()
                    .equals(other.safeAreas, safeAreas)) &&
            (identical(other.pixelRatio, pixelRatio) ||
                const DeepCollectionEquality()
                    .equals(other.pixelRatio, pixelRatio)) &&
            (identical(other.screenSize, screenSize) ||
                const DeepCollectionEquality()
                    .equals(other.screenSize, screenSize)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(platform) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(rotatedSafeAreas) ^
      const DeepCollectionEquality().hash(safeAreas) ^
      const DeepCollectionEquality().hash(pixelRatio) ^
      const DeepCollectionEquality().hash(screenSize);

  @override
  _$CustomDeviceInfoDataCopyWith<_CustomDeviceInfoData> get copyWith =>
      __$CustomDeviceInfoDataCopyWithImpl<_CustomDeviceInfoData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomDeviceInfoDataToJson(this);
  }
}

abstract class _CustomDeviceInfoData implements CustomDeviceInfoData {
  const factory _CustomDeviceInfoData(
          {@required String id,
          @required DeviceType type,
          @required TargetPlatform platform,
          @required String name,
          @nullable @EdgeInsetsJsonConverter() EdgeInsets rotatedSafeAreas,
          @required @EdgeInsetsJsonConverter() EdgeInsets safeAreas,
          @required double pixelRatio,
          @required @SizeJsonConverter() Size screenSize}) =
      _$_CustomDeviceInfoData;

  factory _CustomDeviceInfoData.fromJson(Map<String, dynamic> json) =
      _$_CustomDeviceInfoData.fromJson;

  @override

  /// Identifier of the device.
  String get id;
  @override

  /// The device type.
  DeviceType get type;
  @override

  /// The device operating system.
  TargetPlatform get platform;
  @override

  /// The display name of the device.
  String get name;
  @override

  /// The safe areas when the device is in landscape orientation.
  @nullable
  @EdgeInsetsJsonConverter()
  EdgeInsets get rotatedSafeAreas;
  @override

  /// The safe areas when the device is in portrait orientation.
  @EdgeInsetsJsonConverter()
  EdgeInsets get safeAreas;
  @override

  /// The screen pixel density of the device.
  double get pixelRatio;
  @override

  /// The size in points of the screen content.
  @SizeJsonConverter()
  Size get screenSize;
  @override
  _$CustomDeviceInfoDataCopyWith<_CustomDeviceInfoData> get copyWith;
}

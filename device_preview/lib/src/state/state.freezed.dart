// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DevicePreviewStateTearOff {
  const _$DevicePreviewStateTearOff();

  _NotInitializedDevicePreviewState notInitialized() {
    return const _NotInitializedDevicePreviewState();
  }

  _InitializingDevicePreviewState initializing() {
    return const _InitializingDevicePreviewState();
  }

  _InitializedDevicePreviewState initialized(
      {required List<DeviceInfo> devices,
      required List<NamedLocale> locales,
      required DevicePreviewData data}) {
    return _InitializedDevicePreviewState(
      devices: devices,
      locales: locales,
      data: data,
    );
  }
}

/// @nodoc
const $DevicePreviewState = _$DevicePreviewStateTearOff();

/// @nodoc
mixin _$DevicePreviewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function() initializing,
    required TResult Function(List<DeviceInfo> devices,
            List<NamedLocale> locales, DevicePreviewData data)
        initialized,
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function()? initializing,
    TResult Function(List<DeviceInfo> devices, List<NamedLocale> locales,
            DevicePreviewData data)?
        initialized,
    required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotInitializedDevicePreviewState value)
        notInitialized,
    required TResult Function(_InitializingDevicePreviewState value)
        initializing,
    required TResult Function(_InitializedDevicePreviewState value) initialized,
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotInitializedDevicePreviewState value)? notInitialized,
    TResult Function(_InitializingDevicePreviewState value)? initializing,
    TResult Function(_InitializedDevicePreviewState value)? initialized,
    required TResult orElse(),
  });
}

/// @nodoc
abstract class $DevicePreviewStateCopyWith<$Res> {
  factory $DevicePreviewStateCopyWith(
          DevicePreviewState value, $Res Function(DevicePreviewState) then) =
      _$DevicePreviewStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$DevicePreviewStateCopyWithImpl<$Res>
    implements $DevicePreviewStateCopyWith<$Res> {
  _$DevicePreviewStateCopyWithImpl(this._value, this._then);

  final DevicePreviewState _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewState) _then;
}

/// @nodoc
abstract class _$NotInitializedDevicePreviewStateCopyWith<$Res> {
  factory _$NotInitializedDevicePreviewStateCopyWith(
          _NotInitializedDevicePreviewState value,
          $Res Function(_NotInitializedDevicePreviewState) then) =
      __$NotInitializedDevicePreviewStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$NotInitializedDevicePreviewStateCopyWithImpl<$Res>
    extends _$DevicePreviewStateCopyWithImpl<$Res>
    implements _$NotInitializedDevicePreviewStateCopyWith<$Res> {
  __$NotInitializedDevicePreviewStateCopyWithImpl(
      _NotInitializedDevicePreviewState _value,
      $Res Function(_NotInitializedDevicePreviewState) _then)
      : super(_value, (v) => _then(v as _NotInitializedDevicePreviewState));

  @override
  _NotInitializedDevicePreviewState get _value =>
      super._value as _NotInitializedDevicePreviewState;
}

/// @nodoc
class _$_NotInitializedDevicePreviewState
    with DiagnosticableTreeMixin
    implements _NotInitializedDevicePreviewState {
  const _$_NotInitializedDevicePreviewState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewState.notInitialized()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewState.notInitialized'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotInitializedDevicePreviewState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function() initializing,
    required TResult Function(List<DeviceInfo> devices,
            List<NamedLocale> locales, DevicePreviewData data)
        initialized,
  }) {
    return notInitialized();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function()? initializing,
    TResult Function(List<DeviceInfo> devices, List<NamedLocale> locales,
            DevicePreviewData data)?
        initialized,
    required TResult orElse(),
  }) {
    if (notInitialized != null) {
      return notInitialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotInitializedDevicePreviewState value)
        notInitialized,
    required TResult Function(_InitializingDevicePreviewState value)
        initializing,
    required TResult Function(_InitializedDevicePreviewState value) initialized,
  }) {
    return notInitialized(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotInitializedDevicePreviewState value)? notInitialized,
    TResult Function(_InitializingDevicePreviewState value)? initializing,
    TResult Function(_InitializedDevicePreviewState value)? initialized,
    required TResult orElse(),
  }) {
    if (notInitialized != null) {
      return notInitialized(this);
    }
    return orElse();
  }
}

abstract class _NotInitializedDevicePreviewState implements DevicePreviewState {
  const factory _NotInitializedDevicePreviewState() =
      _$_NotInitializedDevicePreviewState;
}

/// @nodoc
abstract class _$InitializingDevicePreviewStateCopyWith<$Res> {
  factory _$InitializingDevicePreviewStateCopyWith(
          _InitializingDevicePreviewState value,
          $Res Function(_InitializingDevicePreviewState) then) =
      __$InitializingDevicePreviewStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitializingDevicePreviewStateCopyWithImpl<$Res>
    extends _$DevicePreviewStateCopyWithImpl<$Res>
    implements _$InitializingDevicePreviewStateCopyWith<$Res> {
  __$InitializingDevicePreviewStateCopyWithImpl(
      _InitializingDevicePreviewState _value,
      $Res Function(_InitializingDevicePreviewState) _then)
      : super(_value, (v) => _then(v as _InitializingDevicePreviewState));

  @override
  _InitializingDevicePreviewState get _value =>
      super._value as _InitializingDevicePreviewState;
}

/// @nodoc
class _$_InitializingDevicePreviewState
    with DiagnosticableTreeMixin
    implements _InitializingDevicePreviewState {
  const _$_InitializingDevicePreviewState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewState.initializing()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewState.initializing'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InitializingDevicePreviewState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function() initializing,
    required TResult Function(List<DeviceInfo> devices,
            List<NamedLocale> locales, DevicePreviewData data)
        initialized,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function()? initializing,
    TResult Function(List<DeviceInfo> devices, List<NamedLocale> locales,
            DevicePreviewData data)?
        initialized,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotInitializedDevicePreviewState value)
        notInitialized,
    required TResult Function(_InitializingDevicePreviewState value)
        initializing,
    required TResult Function(_InitializedDevicePreviewState value) initialized,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotInitializedDevicePreviewState value)? notInitialized,
    TResult Function(_InitializingDevicePreviewState value)? initializing,
    TResult Function(_InitializedDevicePreviewState value)? initialized,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class _InitializingDevicePreviewState implements DevicePreviewState {
  const factory _InitializingDevicePreviewState() =
      _$_InitializingDevicePreviewState;
}

/// @nodoc
abstract class _$InitializedDevicePreviewStateCopyWith<$Res> {
  factory _$InitializedDevicePreviewStateCopyWith(
          _InitializedDevicePreviewState value,
          $Res Function(_InitializedDevicePreviewState) then) =
      __$InitializedDevicePreviewStateCopyWithImpl<$Res>;
  $Res call(
      {List<DeviceInfo> devices,
      List<NamedLocale> locales,
      DevicePreviewData data});

  $DevicePreviewDataCopyWith<$Res> get data;
}

/// @nodoc
class __$InitializedDevicePreviewStateCopyWithImpl<$Res>
    extends _$DevicePreviewStateCopyWithImpl<$Res>
    implements _$InitializedDevicePreviewStateCopyWith<$Res> {
  __$InitializedDevicePreviewStateCopyWithImpl(
      _InitializedDevicePreviewState _value,
      $Res Function(_InitializedDevicePreviewState) _then)
      : super(_value, (v) => _then(v as _InitializedDevicePreviewState));

  @override
  _InitializedDevicePreviewState get _value =>
      super._value as _InitializedDevicePreviewState;

  @override
  $Res call({
    Object? devices = freezed,
    Object? locales = freezed,
    Object? data = freezed,
  }) {
    return _then(_InitializedDevicePreviewState(
      devices:
          devices == freezed ? _value.devices : devices as List<DeviceInfo>,
      locales:
          locales == freezed ? _value.locales : locales as List<NamedLocale>,
      data: data == freezed ? _value.data : data as DevicePreviewData,
    ));
  }

  @override
  $DevicePreviewDataCopyWith<$Res> get data {
    return $DevicePreviewDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc
class _$_InitializedDevicePreviewState
    with DiagnosticableTreeMixin
    implements _InitializedDevicePreviewState {
  const _$_InitializedDevicePreviewState(
      {required this.devices, required this.locales, required this.data});

  @override

  /// The list of all available devices.
  final List<DeviceInfo> devices;
  @override

  /// The list of all available locales.
  final List<NamedLocale> locales;
  @override

  /// The user settings of the preview.
  final DevicePreviewData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewState.initialized(devices: $devices, locales: $locales, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewState.initialized'))
      ..add(DiagnosticsProperty('devices', devices))
      ..add(DiagnosticsProperty('locales', locales))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InitializedDevicePreviewState &&
            (identical(other.devices, devices) ||
                const DeepCollectionEquality()
                    .equals(other.devices, devices)) &&
            (identical(other.locales, locales) ||
                const DeepCollectionEquality()
                    .equals(other.locales, locales)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(devices) ^
      const DeepCollectionEquality().hash(locales) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$InitializedDevicePreviewStateCopyWith<_InitializedDevicePreviewState>
      get copyWith => __$InitializedDevicePreviewStateCopyWithImpl<
          _InitializedDevicePreviewState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function() initializing,
    required TResult Function(List<DeviceInfo> devices,
            List<NamedLocale> locales, DevicePreviewData data)
        initialized,
  }) {
    return initialized(devices, locales, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function()? initializing,
    TResult Function(List<DeviceInfo> devices, List<NamedLocale> locales,
            DevicePreviewData data)?
        initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(devices, locales, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotInitializedDevicePreviewState value)
        notInitialized,
    required TResult Function(_InitializingDevicePreviewState value)
        initializing,
    required TResult Function(_InitializedDevicePreviewState value) initialized,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotInitializedDevicePreviewState value)? notInitialized,
    TResult Function(_InitializingDevicePreviewState value)? initializing,
    TResult Function(_InitializedDevicePreviewState value)? initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class _InitializedDevicePreviewState implements DevicePreviewState {
  const factory _InitializedDevicePreviewState(
      {required List<DeviceInfo> devices,
      required List<NamedLocale> locales,
      required DevicePreviewData data}) = _$_InitializedDevicePreviewState;

  /// The list of all available devices.
  List<DeviceInfo> get devices;

  /// The list of all available locales.
  List<NamedLocale> get locales;

  /// The user settings of the preview.
  DevicePreviewData get data;
  @JsonKey(ignore: true)
  _$InitializedDevicePreviewStateCopyWith<_InitializedDevicePreviewState>
      get copyWith;
}

DevicePreviewData _$DevicePreviewDataFromJson(Map<String, dynamic> json) {
  return _DevicePreviewData.fromJson(json);
}

/// @nodoc
class _$DevicePreviewDataTearOff {
  const _$DevicePreviewDataTearOff();

  _DevicePreviewData call(
      {bool isToolbarVisible = true,
      bool isEnabled = true,
      Orientation orientation = Orientation.portrait,
      String? deviceIdentifier,
      String locale = 'en-US',
      bool isFrameVisible = true,
      bool isDarkMode = false,
      bool boldText = false,
      bool isVirtualKeyboardVisible = false,
      bool disableAnimations = false,
      bool highContrast = false,
      bool accessibleNavigation = false,
      bool invertColors = false,
      Map<String, Map<String, dynamic>> pluginData =
          const <String, Map<String, dynamic>>{},
      double textScaleFactor = 1.0,
      DevicePreviewSettingsData? settings,
      required CustomDeviceInfoData customDevice}) {
    return _DevicePreviewData(
      isToolbarVisible: isToolbarVisible,
      isEnabled: isEnabled,
      orientation: orientation,
      deviceIdentifier: deviceIdentifier,
      locale: locale,
      isFrameVisible: isFrameVisible,
      isDarkMode: isDarkMode,
      boldText: boldText,
      isVirtualKeyboardVisible: isVirtualKeyboardVisible,
      disableAnimations: disableAnimations,
      highContrast: highContrast,
      accessibleNavigation: accessibleNavigation,
      invertColors: invertColors,
      pluginData: pluginData,
      textScaleFactor: textScaleFactor,
      settings: settings,
      customDevice: customDevice,
    );
  }

  DevicePreviewData fromJson(Map<String, Object> json) {
    return DevicePreviewData.fromJson(json);
  }
}

/// @nodoc
const $DevicePreviewData = _$DevicePreviewDataTearOff();

/// @nodoc
mixin _$DevicePreviewData {
  /// Indicate whether the toolbar is visible.
  bool get isToolbarVisible;

  /// Indicate whether the device simulation is enabled.
  bool get isEnabled;

  /// The current orientation of the device
  Orientation get orientation;

  /// The currently selected device.
  String? get deviceIdentifier;

  /// The currently selected device locale.
  String get locale;

  /// Indicate whether the frame is currently visible.
  bool get isFrameVisible;

  /// Indicate whether the mode is currently dark.
  bool get isDarkMode;

  /// Indicate whether texts are forced to bold.
  bool get boldText;

  /// Indicate whether the virtual keyboard is visible.
  bool get isVirtualKeyboardVisible;

  /// Indicate whether animations are disabled.
  bool get disableAnimations;

  /// Indicate whether the highcontrast mode is activated.
  bool get highContrast;

  /// Indicate whether the navigation is in accessible mode.
  bool get accessibleNavigation;

  /// Indicate whether image colors are inverted.
  bool get invertColors;

  /// Indicate whether image colors are inverted.
  Map<String, Map<String, dynamic>> get pluginData;

  /// The current text scaling factor.
  double get textScaleFactor;
  DevicePreviewSettingsData? get settings;

  /// The custom device configuration
  CustomDeviceInfoData get customDevice;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $DevicePreviewDataCopyWith<DevicePreviewData> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewDataCopyWith<$Res> {
  factory $DevicePreviewDataCopyWith(
          DevicePreviewData value, $Res Function(DevicePreviewData) then) =
      _$DevicePreviewDataCopyWithImpl<$Res>;
  $Res call(
      {bool isToolbarVisible,
      bool isEnabled,
      Orientation orientation,
      String? deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool isVirtualKeyboardVisible,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      Map<String, Map<String, dynamic>> pluginData,
      double textScaleFactor,
      DevicePreviewSettingsData? settings,
      CustomDeviceInfoData customDevice});

  $DevicePreviewSettingsDataCopyWith<$Res>? get settings;
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
    Object? isToolbarVisible = freezed,
    Object? isEnabled = freezed,
    Object? orientation = freezed,
    Object? deviceIdentifier = freezed,
    Object? locale = freezed,
    Object? isFrameVisible = freezed,
    Object? isDarkMode = freezed,
    Object? boldText = freezed,
    Object? isVirtualKeyboardVisible = freezed,
    Object? disableAnimations = freezed,
    Object? highContrast = freezed,
    Object? accessibleNavigation = freezed,
    Object? invertColors = freezed,
    Object? pluginData = freezed,
    Object? textScaleFactor = freezed,
    Object? settings = freezed,
    Object? customDevice = freezed,
  }) {
    return _then(_value.copyWith(
      isToolbarVisible: isToolbarVisible == freezed
          ? _value.isToolbarVisible
          : isToolbarVisible as bool,
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation as Orientation,
      deviceIdentifier: deviceIdentifier == freezed
          ? _value.deviceIdentifier
          : deviceIdentifier as String?,
      locale: locale == freezed ? _value.locale : locale as String,
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible as bool,
      isDarkMode:
          isDarkMode == freezed ? _value.isDarkMode : isDarkMode as bool,
      boldText: boldText == freezed ? _value.boldText : boldText as bool,
      isVirtualKeyboardVisible: isVirtualKeyboardVisible == freezed
          ? _value.isVirtualKeyboardVisible
          : isVirtualKeyboardVisible as bool,
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
      pluginData: pluginData == freezed
          ? _value.pluginData
          : pluginData as Map<String, Map<String, dynamic>>,
      textScaleFactor: textScaleFactor == freezed
          ? _value.textScaleFactor
          : textScaleFactor as double,
      settings: settings == freezed
          ? _value.settings
          : settings as DevicePreviewSettingsData?,
      customDevice: customDevice == freezed
          ? _value.customDevice
          : customDevice as CustomDeviceInfoData,
    ));
  }

  @override
  $DevicePreviewSettingsDataCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $DevicePreviewSettingsDataCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }

  @override
  $CustomDeviceInfoDataCopyWith<$Res> get customDevice {
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
      {bool isToolbarVisible,
      bool isEnabled,
      Orientation orientation,
      String? deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool isVirtualKeyboardVisible,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      Map<String, Map<String, dynamic>> pluginData,
      double textScaleFactor,
      DevicePreviewSettingsData? settings,
      CustomDeviceInfoData customDevice});

  @override
  $DevicePreviewSettingsDataCopyWith<$Res>? get settings;
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
    Object? isToolbarVisible = freezed,
    Object? isEnabled = freezed,
    Object? orientation = freezed,
    Object? deviceIdentifier = freezed,
    Object? locale = freezed,
    Object? isFrameVisible = freezed,
    Object? isDarkMode = freezed,
    Object? boldText = freezed,
    Object? isVirtualKeyboardVisible = freezed,
    Object? disableAnimations = freezed,
    Object? highContrast = freezed,
    Object? accessibleNavigation = freezed,
    Object? invertColors = freezed,
    Object? pluginData = freezed,
    Object? textScaleFactor = freezed,
    Object? settings = freezed,
    Object? customDevice = freezed,
  }) {
    return _then(_DevicePreviewData(
      isToolbarVisible: isToolbarVisible == freezed
          ? _value.isToolbarVisible
          : isToolbarVisible as bool,
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation as Orientation,
      deviceIdentifier: deviceIdentifier == freezed
          ? _value.deviceIdentifier
          : deviceIdentifier as String?,
      locale: locale == freezed ? _value.locale : locale as String,
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible as bool,
      isDarkMode:
          isDarkMode == freezed ? _value.isDarkMode : isDarkMode as bool,
      boldText: boldText == freezed ? _value.boldText : boldText as bool,
      isVirtualKeyboardVisible: isVirtualKeyboardVisible == freezed
          ? _value.isVirtualKeyboardVisible
          : isVirtualKeyboardVisible as bool,
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
      pluginData: pluginData == freezed
          ? _value.pluginData
          : pluginData as Map<String, Map<String, dynamic>>,
      textScaleFactor: textScaleFactor == freezed
          ? _value.textScaleFactor
          : textScaleFactor as double,
      settings: settings == freezed
          ? _value.settings
          : settings as DevicePreviewSettingsData?,
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
      {this.isToolbarVisible = true,
      this.isEnabled = true,
      this.orientation = Orientation.portrait,
      this.deviceIdentifier,
      this.locale = 'en-US',
      this.isFrameVisible = true,
      this.isDarkMode = false,
      this.boldText = false,
      this.isVirtualKeyboardVisible = false,
      this.disableAnimations = false,
      this.highContrast = false,
      this.accessibleNavigation = false,
      this.invertColors = false,
      this.pluginData = const <String, Map<String, dynamic>>{},
      this.textScaleFactor = 1.0,
      this.settings,
      required this.customDevice});

  factory _$_DevicePreviewData.fromJson(Map<String, dynamic> json) =>
      _$_$_DevicePreviewDataFromJson(json);

  @JsonKey(defaultValue: true)
  @override

  /// Indicate whether the toolbar is visible.
  final bool isToolbarVisible;
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
  final String? deviceIdentifier;
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

  /// Indicate whether the virtual keyboard is visible.
  final bool isVirtualKeyboardVisible;
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
  @JsonKey(defaultValue: const <String, Map<String, dynamic>>{})
  @override

  /// Indicate whether image colors are inverted.
  final Map<String, Map<String, dynamic>> pluginData;
  @JsonKey(defaultValue: 1.0)
  @override

  /// The current text scaling factor.
  final double textScaleFactor;
  @override
  final DevicePreviewSettingsData? settings;
  @override

  /// The custom device configuration
  final CustomDeviceInfoData customDevice;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewData(isToolbarVisible: $isToolbarVisible, isEnabled: $isEnabled, orientation: $orientation, deviceIdentifier: $deviceIdentifier, locale: $locale, isFrameVisible: $isFrameVisible, isDarkMode: $isDarkMode, boldText: $boldText, isVirtualKeyboardVisible: $isVirtualKeyboardVisible, disableAnimations: $disableAnimations, highContrast: $highContrast, accessibleNavigation: $accessibleNavigation, invertColors: $invertColors, pluginData: $pluginData, textScaleFactor: $textScaleFactor, settings: $settings, customDevice: $customDevice)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewData'))
      ..add(DiagnosticsProperty('isToolbarVisible', isToolbarVisible))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('orientation', orientation))
      ..add(DiagnosticsProperty('deviceIdentifier', deviceIdentifier))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('isFrameVisible', isFrameVisible))
      ..add(DiagnosticsProperty('isDarkMode', isDarkMode))
      ..add(DiagnosticsProperty('boldText', boldText))
      ..add(DiagnosticsProperty(
          'isVirtualKeyboardVisible', isVirtualKeyboardVisible))
      ..add(DiagnosticsProperty('disableAnimations', disableAnimations))
      ..add(DiagnosticsProperty('highContrast', highContrast))
      ..add(DiagnosticsProperty('accessibleNavigation', accessibleNavigation))
      ..add(DiagnosticsProperty('invertColors', invertColors))
      ..add(DiagnosticsProperty('pluginData', pluginData))
      ..add(DiagnosticsProperty('textScaleFactor', textScaleFactor))
      ..add(DiagnosticsProperty('settings', settings))
      ..add(DiagnosticsProperty('customDevice', customDevice));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewData &&
            (identical(other.isToolbarVisible, isToolbarVisible) ||
                const DeepCollectionEquality()
                    .equals(other.isToolbarVisible, isToolbarVisible)) &&
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
            (identical(
                    other.isVirtualKeyboardVisible, isVirtualKeyboardVisible) ||
                const DeepCollectionEquality().equals(
                    other.isVirtualKeyboardVisible,
                    isVirtualKeyboardVisible)) &&
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
            (identical(other.pluginData, pluginData) ||
                const DeepCollectionEquality()
                    .equals(other.pluginData, pluginData)) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                const DeepCollectionEquality()
                    .equals(other.textScaleFactor, textScaleFactor)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)) &&
            (identical(other.customDevice, customDevice) ||
                const DeepCollectionEquality()
                    .equals(other.customDevice, customDevice)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isToolbarVisible) ^
      const DeepCollectionEquality().hash(isEnabled) ^
      const DeepCollectionEquality().hash(orientation) ^
      const DeepCollectionEquality().hash(deviceIdentifier) ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(isFrameVisible) ^
      const DeepCollectionEquality().hash(isDarkMode) ^
      const DeepCollectionEquality().hash(boldText) ^
      const DeepCollectionEquality().hash(isVirtualKeyboardVisible) ^
      const DeepCollectionEquality().hash(disableAnimations) ^
      const DeepCollectionEquality().hash(highContrast) ^
      const DeepCollectionEquality().hash(accessibleNavigation) ^
      const DeepCollectionEquality().hash(invertColors) ^
      const DeepCollectionEquality().hash(pluginData) ^
      const DeepCollectionEquality().hash(textScaleFactor) ^
      const DeepCollectionEquality().hash(settings) ^
      const DeepCollectionEquality().hash(customDevice);

  @JsonKey(ignore: true)
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
      {bool isToolbarVisible,
      bool isEnabled,
      Orientation orientation,
      String? deviceIdentifier,
      String locale,
      bool isFrameVisible,
      bool isDarkMode,
      bool boldText,
      bool isVirtualKeyboardVisible,
      bool disableAnimations,
      bool highContrast,
      bool accessibleNavigation,
      bool invertColors,
      Map<String, Map<String, dynamic>> pluginData,
      double textScaleFactor,
      DevicePreviewSettingsData? settings,
      required CustomDeviceInfoData customDevice}) = _$_DevicePreviewData;

  factory _DevicePreviewData.fromJson(Map<String, dynamic> json) =
      _$_DevicePreviewData.fromJson;

  @override

  /// Indicate whether the toolbar is visible.
  bool get isToolbarVisible;
  @override

  /// Indicate whether the device simulation is enabled.
  bool get isEnabled;
  @override

  /// The current orientation of the device
  Orientation get orientation;
  @override

  /// The currently selected device.
  String? get deviceIdentifier;
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

  /// Indicate whether the virtual keyboard is visible.
  bool get isVirtualKeyboardVisible;
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

  /// Indicate whether image colors are inverted.
  Map<String, Map<String, dynamic>> get pluginData;
  @override

  /// The current text scaling factor.
  double get textScaleFactor;
  @override
  DevicePreviewSettingsData? get settings;
  @override

  /// The custom device configuration
  CustomDeviceInfoData get customDevice;
  @override
  @JsonKey(ignore: true)
  _$DevicePreviewDataCopyWith<_DevicePreviewData> get copyWith;
}

CustomDeviceInfoData _$CustomDeviceInfoDataFromJson(Map<String, dynamic> json) {
  return _CustomDeviceInfoData.fromJson(json);
}

/// @nodoc
class _$CustomDeviceInfoDataTearOff {
  const _$CustomDeviceInfoDataTearOff();

  _CustomDeviceInfoData call(
      {required String id,
      required DeviceType type,
      required TargetPlatform platform,
      required String name,
      @EdgeInsetsJsonConverter() EdgeInsets? rotatedSafeAreas = null,
      @EdgeInsetsJsonConverter() required EdgeInsets safeAreas,
      required double pixelRatio,
      @SizeJsonConverter() required Size screenSize}) {
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

  CustomDeviceInfoData fromJson(Map<String, Object> json) {
    return CustomDeviceInfoData.fromJson(json);
  }
}

/// @nodoc
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
  @EdgeInsetsJsonConverter()
  EdgeInsets? get rotatedSafeAreas;

  /// The safe areas when the device is in portrait orientation.
  @EdgeInsetsJsonConverter()
  EdgeInsets get safeAreas;

  /// The screen pixel density of the device.
  double get pixelRatio;

  /// The size in points of the screen content.
  @SizeJsonConverter()
  Size get screenSize;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
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
      @EdgeInsetsJsonConverter() EdgeInsets? rotatedSafeAreas,
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
    Object? id = freezed,
    Object? type = freezed,
    Object? platform = freezed,
    Object? name = freezed,
    Object? rotatedSafeAreas = freezed,
    Object? safeAreas = freezed,
    Object? pixelRatio = freezed,
    Object? screenSize = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as DeviceType,
      platform:
          platform == freezed ? _value.platform : platform as TargetPlatform,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets?,
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
      @EdgeInsetsJsonConverter() EdgeInsets? rotatedSafeAreas,
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
    Object? id = freezed,
    Object? type = freezed,
    Object? platform = freezed,
    Object? name = freezed,
    Object? rotatedSafeAreas = freezed,
    Object? safeAreas = freezed,
    Object? pixelRatio = freezed,
    Object? screenSize = freezed,
  }) {
    return _then(_CustomDeviceInfoData(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as DeviceType,
      platform:
          platform == freezed ? _value.platform : platform as TargetPlatform,
      name: name == freezed ? _value.name : name as String,
      rotatedSafeAreas: rotatedSafeAreas == freezed
          ? _value.rotatedSafeAreas
          : rotatedSafeAreas as EdgeInsets?,
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
      {required this.id,
      required this.type,
      required this.platform,
      required this.name,
      @EdgeInsetsJsonConverter() this.rotatedSafeAreas = null,
      @EdgeInsetsJsonConverter() required this.safeAreas,
      required this.pixelRatio,
      @SizeJsonConverter() required this.screenSize});

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
  @EdgeInsetsJsonConverter()
  final EdgeInsets? rotatedSafeAreas;
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

  @JsonKey(ignore: true)
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
      {required String id,
      required DeviceType type,
      required TargetPlatform platform,
      required String name,
      @EdgeInsetsJsonConverter() EdgeInsets? rotatedSafeAreas,
      @EdgeInsetsJsonConverter() required EdgeInsets safeAreas,
      required double pixelRatio,
      @SizeJsonConverter() required Size screenSize}) = _$_CustomDeviceInfoData;

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
  @EdgeInsetsJsonConverter()
  EdgeInsets? get rotatedSafeAreas;
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
  @JsonKey(ignore: true)
  _$CustomDeviceInfoDataCopyWith<_CustomDeviceInfoData> get copyWith;
}

DevicePreviewSettingsData _$DevicePreviewSettingsDataFromJson(
    Map<String, dynamic> json) {
  return _DevicePreviewSettingsData.fromJson(json);
}

/// @nodoc
class _$DevicePreviewSettingsDataTearOff {
  const _$DevicePreviewSettingsDataTearOff();

  _DevicePreviewSettingsData call(
      {DevicePreviewToolBarPositionData toolbarPosition =
          DevicePreviewToolBarPositionData.bottom,
      DevicePreviewToolBarThemeData toolbarTheme =
          DevicePreviewToolBarThemeData.dark,
      DevicePreviewBackgroundThemeData backgroundTheme =
          DevicePreviewBackgroundThemeData.light}) {
    return _DevicePreviewSettingsData(
      toolbarPosition: toolbarPosition,
      toolbarTheme: toolbarTheme,
      backgroundTheme: backgroundTheme,
    );
  }

  DevicePreviewSettingsData fromJson(Map<String, Object> json) {
    return DevicePreviewSettingsData.fromJson(json);
  }
}

/// @nodoc
const $DevicePreviewSettingsData = _$DevicePreviewSettingsDataTearOff();

/// @nodoc
mixin _$DevicePreviewSettingsData {
  /// The toolbar position.
  DevicePreviewToolBarPositionData get toolbarPosition;

  /// The theme of the toolbar.
  DevicePreviewToolBarThemeData get toolbarTheme;

  /// The theme of the background.
  DevicePreviewBackgroundThemeData get backgroundTheme;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $DevicePreviewSettingsDataCopyWith<DevicePreviewSettingsData> get copyWith;
}

/// @nodoc
abstract class $DevicePreviewSettingsDataCopyWith<$Res> {
  factory $DevicePreviewSettingsDataCopyWith(DevicePreviewSettingsData value,
          $Res Function(DevicePreviewSettingsData) then) =
      _$DevicePreviewSettingsDataCopyWithImpl<$Res>;
  $Res call(
      {DevicePreviewToolBarPositionData toolbarPosition,
      DevicePreviewToolBarThemeData toolbarTheme,
      DevicePreviewBackgroundThemeData backgroundTheme});
}

/// @nodoc
class _$DevicePreviewSettingsDataCopyWithImpl<$Res>
    implements $DevicePreviewSettingsDataCopyWith<$Res> {
  _$DevicePreviewSettingsDataCopyWithImpl(this._value, this._then);

  final DevicePreviewSettingsData _value;
  // ignore: unused_field
  final $Res Function(DevicePreviewSettingsData) _then;

  @override
  $Res call({
    Object? toolbarPosition = freezed,
    Object? toolbarTheme = freezed,
    Object? backgroundTheme = freezed,
  }) {
    return _then(_value.copyWith(
      toolbarPosition: toolbarPosition == freezed
          ? _value.toolbarPosition
          : toolbarPosition as DevicePreviewToolBarPositionData,
      toolbarTheme: toolbarTheme == freezed
          ? _value.toolbarTheme
          : toolbarTheme as DevicePreviewToolBarThemeData,
      backgroundTheme: backgroundTheme == freezed
          ? _value.backgroundTheme
          : backgroundTheme as DevicePreviewBackgroundThemeData,
    ));
  }
}

/// @nodoc
abstract class _$DevicePreviewSettingsDataCopyWith<$Res>
    implements $DevicePreviewSettingsDataCopyWith<$Res> {
  factory _$DevicePreviewSettingsDataCopyWith(_DevicePreviewSettingsData value,
          $Res Function(_DevicePreviewSettingsData) then) =
      __$DevicePreviewSettingsDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {DevicePreviewToolBarPositionData toolbarPosition,
      DevicePreviewToolBarThemeData toolbarTheme,
      DevicePreviewBackgroundThemeData backgroundTheme});
}

/// @nodoc
class __$DevicePreviewSettingsDataCopyWithImpl<$Res>
    extends _$DevicePreviewSettingsDataCopyWithImpl<$Res>
    implements _$DevicePreviewSettingsDataCopyWith<$Res> {
  __$DevicePreviewSettingsDataCopyWithImpl(_DevicePreviewSettingsData _value,
      $Res Function(_DevicePreviewSettingsData) _then)
      : super(_value, (v) => _then(v as _DevicePreviewSettingsData));

  @override
  _DevicePreviewSettingsData get _value =>
      super._value as _DevicePreviewSettingsData;

  @override
  $Res call({
    Object? toolbarPosition = freezed,
    Object? toolbarTheme = freezed,
    Object? backgroundTheme = freezed,
  }) {
    return _then(_DevicePreviewSettingsData(
      toolbarPosition: toolbarPosition == freezed
          ? _value.toolbarPosition
          : toolbarPosition as DevicePreviewToolBarPositionData,
      toolbarTheme: toolbarTheme == freezed
          ? _value.toolbarTheme
          : toolbarTheme as DevicePreviewToolBarThemeData,
      backgroundTheme: backgroundTheme == freezed
          ? _value.backgroundTheme
          : backgroundTheme as DevicePreviewBackgroundThemeData,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_DevicePreviewSettingsData
    with DiagnosticableTreeMixin
    implements _DevicePreviewSettingsData {
  const _$_DevicePreviewSettingsData(
      {this.toolbarPosition = DevicePreviewToolBarPositionData.bottom,
      this.toolbarTheme = DevicePreviewToolBarThemeData.dark,
      this.backgroundTheme = DevicePreviewBackgroundThemeData.light});

  factory _$_DevicePreviewSettingsData.fromJson(Map<String, dynamic> json) =>
      _$_$_DevicePreviewSettingsDataFromJson(json);

  @JsonKey(defaultValue: DevicePreviewToolBarPositionData.bottom)
  @override

  /// The toolbar position.
  final DevicePreviewToolBarPositionData toolbarPosition;
  @JsonKey(defaultValue: DevicePreviewToolBarThemeData.dark)
  @override

  /// The theme of the toolbar.
  final DevicePreviewToolBarThemeData toolbarTheme;
  @JsonKey(defaultValue: DevicePreviewBackgroundThemeData.light)
  @override

  /// The theme of the background.
  final DevicePreviewBackgroundThemeData backgroundTheme;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevicePreviewSettingsData(toolbarPosition: $toolbarPosition, toolbarTheme: $toolbarTheme, backgroundTheme: $backgroundTheme)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevicePreviewSettingsData'))
      ..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))
      ..add(DiagnosticsProperty('toolbarTheme', toolbarTheme))
      ..add(DiagnosticsProperty('backgroundTheme', backgroundTheme));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DevicePreviewSettingsData &&
            (identical(other.toolbarPosition, toolbarPosition) ||
                const DeepCollectionEquality()
                    .equals(other.toolbarPosition, toolbarPosition)) &&
            (identical(other.toolbarTheme, toolbarTheme) ||
                const DeepCollectionEquality()
                    .equals(other.toolbarTheme, toolbarTheme)) &&
            (identical(other.backgroundTheme, backgroundTheme) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundTheme, backgroundTheme)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(toolbarPosition) ^
      const DeepCollectionEquality().hash(toolbarTheme) ^
      const DeepCollectionEquality().hash(backgroundTheme);

  @JsonKey(ignore: true)
  @override
  _$DevicePreviewSettingsDataCopyWith<_DevicePreviewSettingsData>
      get copyWith =>
          __$DevicePreviewSettingsDataCopyWithImpl<_DevicePreviewSettingsData>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DevicePreviewSettingsDataToJson(this);
  }
}

abstract class _DevicePreviewSettingsData implements DevicePreviewSettingsData {
  const factory _DevicePreviewSettingsData(
          {DevicePreviewToolBarPositionData toolbarPosition,
          DevicePreviewToolBarThemeData toolbarTheme,
          DevicePreviewBackgroundThemeData backgroundTheme}) =
      _$_DevicePreviewSettingsData;

  factory _DevicePreviewSettingsData.fromJson(Map<String, dynamic> json) =
      _$_DevicePreviewSettingsData.fromJson;

  @override

  /// The toolbar position.
  DevicePreviewToolBarPositionData get toolbarPosition;
  @override

  /// The theme of the toolbar.
  DevicePreviewToolBarThemeData get toolbarTheme;
  @override

  /// The theme of the background.
  DevicePreviewBackgroundThemeData get backgroundTheme;
  @override
  @JsonKey(ignore: true)
  _$DevicePreviewSettingsDataCopyWith<_DevicePreviewSettingsData> get copyWith;
}

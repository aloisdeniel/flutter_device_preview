// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DevicePreviewData _$_$_DevicePreviewDataFromJson(Map<String, dynamic> json) {
  return _$_DevicePreviewData(
    isToolbarVisible: json['isToolbarVisible'] as bool? ?? true,
    isEnabled: json['isEnabled'] as bool? ?? true,
    orientation:
        _$enumDecodeNullable(_$OrientationEnumMap, json['orientation']) ??
            Orientation.portrait,
    deviceIdentifier: json['deviceIdentifier'] as String?,
    locale: json['locale'] as String? ?? 'en-US',
    isFrameVisible: json['isFrameVisible'] as bool? ?? true,
    isDarkMode: json['isDarkMode'] as bool? ?? false,
    boldText: json['boldText'] as bool? ?? false,
    isVirtualKeyboardVisible:
        json['isVirtualKeyboardVisible'] as bool? ?? false,
    disableAnimations: json['disableAnimations'] as bool? ?? false,
    highContrast: json['highContrast'] as bool? ?? false,
    accessibleNavigation: json['accessibleNavigation'] as bool? ?? false,
    invertColors: json['invertColors'] as bool? ?? false,
    pluginData: (json['pluginData'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e as Map<String, dynamic>),
        ) ??
        {},
    textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble() ?? 1.0,
    settings: json['settings'] == null
        ? null
        : DevicePreviewSettingsData.fromJson(
            json['settings'] as Map<String, dynamic>),
    customDevice: json['customDevice'] == null
        ? null
        : CustomDeviceInfoData.fromJson(
            json['customDevice'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_DevicePreviewDataToJson(
        _$_DevicePreviewData instance) =>
    <String, dynamic>{
      'isToolbarVisible': instance.isToolbarVisible,
      'isEnabled': instance.isEnabled,
      'orientation': _$OrientationEnumMap[instance.orientation],
      'deviceIdentifier': instance.deviceIdentifier,
      'locale': instance.locale,
      'isFrameVisible': instance.isFrameVisible,
      'isDarkMode': instance.isDarkMode,
      'boldText': instance.boldText,
      'isVirtualKeyboardVisible': instance.isVirtualKeyboardVisible,
      'disableAnimations': instance.disableAnimations,
      'highContrast': instance.highContrast,
      'accessibleNavigation': instance.accessibleNavigation,
      'invertColors': instance.invertColors,
      'pluginData': instance.pluginData,
      'textScaleFactor': instance.textScaleFactor,
      'settings': instance.settings,
      'customDevice': instance.customDevice,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};

_$_CustomDeviceInfoData _$_$_CustomDeviceInfoDataFromJson(
    Map<String, dynamic> json) {
  return _$_CustomDeviceInfoData(
    id: json['id'] as String,
    type: _$enumDecode(_$DeviceTypeEnumMap, json['type']),
    platform: _$enumDecode(_$TargetPlatformEnumMap, json['platform']),
    name: json['name'] as String,
    rotatedSafeAreas: const NullableEdgeInsetsJsonConverter()
        .fromJson(json['rotatedSafeAreas']),
    safeAreas: const EdgeInsetsJsonConverter().fromJson(json['safeAreas']),
    pixelRatio: (json['pixelRatio'] as num).toDouble(),
    screenSize: const SizeJsonConverter().fromJson(json['screenSize']),
  );
}

Map<String, dynamic> _$_$_CustomDeviceInfoDataToJson(
        _$_CustomDeviceInfoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DeviceTypeEnumMap[instance.type],
      'platform': _$TargetPlatformEnumMap[instance.platform],
      'name': instance.name,
      'rotatedSafeAreas': const NullableEdgeInsetsJsonConverter()
          .toJson(instance.rotatedSafeAreas),
      'safeAreas': const EdgeInsetsJsonConverter().toJson(instance.safeAreas),
      'pixelRatio': instance.pixelRatio,
      'screenSize': const SizeJsonConverter().toJson(instance.screenSize),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.unknown: 'unknown',
  DeviceType.phone: 'phone',
  DeviceType.tablet: 'tablet',
  DeviceType.tv: 'tv',
  DeviceType.desktop: 'desktop',
  DeviceType.laptop: 'laptop',
};

const _$TargetPlatformEnumMap = {
  TargetPlatform.android: 'android',
  TargetPlatform.fuchsia: 'fuchsia',
  TargetPlatform.iOS: 'iOS',
  TargetPlatform.linux: 'linux',
  TargetPlatform.macOS: 'macOS',
  TargetPlatform.windows: 'windows',
};

_$_DevicePreviewSettingsData _$_$_DevicePreviewSettingsDataFromJson(
    Map<String, dynamic> json) {
  return _$_DevicePreviewSettingsData(
    toolbarPosition: _$enumDecodeNullable(
            _$DevicePreviewToolBarPositionDataEnumMap,
            json['toolbarPosition']) ??
        DevicePreviewToolBarPositionData.bottom,
    toolbarTheme: _$enumDecodeNullable(
            _$DevicePreviewToolBarThemeDataEnumMap, json['toolbarTheme']) ??
        DevicePreviewToolBarThemeData.dark,
    backgroundTheme: _$enumDecodeNullable(
            _$DevicePreviewBackgroundThemeDataEnumMap,
            json['backgroundTheme']) ??
        DevicePreviewBackgroundThemeData.light,
  );
}

Map<String, dynamic> _$_$_DevicePreviewSettingsDataToJson(
        _$_DevicePreviewSettingsData instance) =>
    <String, dynamic>{
      'toolbarPosition':
          _$DevicePreviewToolBarPositionDataEnumMap[instance.toolbarPosition],
      'toolbarTheme':
          _$DevicePreviewToolBarThemeDataEnumMap[instance.toolbarTheme],
      'backgroundTheme':
          _$DevicePreviewBackgroundThemeDataEnumMap[instance.backgroundTheme],
    };

const _$DevicePreviewToolBarPositionDataEnumMap = {
  DevicePreviewToolBarPositionData.bottom: 'bottom',
  DevicePreviewToolBarPositionData.top: 'top',
  DevicePreviewToolBarPositionData.left: 'left',
  DevicePreviewToolBarPositionData.right: 'right',
};

const _$DevicePreviewToolBarThemeDataEnumMap = {
  DevicePreviewToolBarThemeData.dark: 'dark',
  DevicePreviewToolBarThemeData.light: 'light',
};

const _$DevicePreviewBackgroundThemeDataEnumMap = {
  DevicePreviewBackgroundThemeData.dark: 'dark',
  DevicePreviewBackgroundThemeData.light: 'light',
};

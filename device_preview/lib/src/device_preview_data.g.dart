// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DevicePreviewData _$_$_DevicePreviewDataFromJson(Map<String, dynamic> json) {
  return _$_DevicePreviewData(
    orientation:
        _$enumDecodeNullable(_$OrientationEnumMap, json['orientation']) ??
            Orientation.portrait,
    deviceIndex: json['deviceIndex'] as int ?? 0,
    locale: json['locale'] as String,
    isEnabled: json['isEnabled'] as bool ?? true,
    isFrameVisible: json['isFrameVisible'] as bool ?? true,
    isDarkMode: json['isDarkMode'] as bool ?? false,
    boldText: json['boldText'] as bool ?? false,
    disableAnimations: json['disableAnimations'] as bool ?? false,
    highContrast: json['highContrast'] as bool ?? false,
    accessibleNavigation: json['accessibleNavigation'] as bool ?? false,
    invertColors: json['invertColors'] as bool ?? false,
    textScaleFactor: (json['textScaleFactor'] as num)?.toDouble() ?? 1.0,
    freeformSize: const SizeJsonConverter().fromJson(json['freeformSize']),
  );
}

Map<String, dynamic> _$_$_DevicePreviewDataToJson(
        _$_DevicePreviewData instance) =>
    <String, dynamic>{
      'orientation': _$OrientationEnumMap[instance.orientation],
      'deviceIndex': instance.deviceIndex,
      'locale': instance.locale,
      'isEnabled': instance.isEnabled,
      'isFrameVisible': instance.isFrameVisible,
      'isDarkMode': instance.isDarkMode,
      'boldText': instance.boldText,
      'disableAnimations': instance.disableAnimations,
      'highContrast': instance.highContrast,
      'accessibleNavigation': instance.accessibleNavigation,
      'invertColors': instance.invertColors,
      'textScaleFactor': instance.textScaleFactor,
      'freeformSize': const SizeJsonConverter().toJson(instance.freeformSize),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};

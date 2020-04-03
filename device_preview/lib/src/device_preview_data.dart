import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utilities/json_converters.dart';
import 'package:flutter/foundation.dart';

part 'device_preview_data.freezed.dart';
part 'device_preview_data.g.dart';

@freezed

/// A [DevicePreview] configuration snapshot that can be
/// serialized to be persisted between session.
abstract class DevicePreviewData with _$DevicePreviewData {
  /// Creates a new [DevicePreviewData] configuration from all
  /// properties.
  const factory DevicePreviewData({
    @Default(Orientation.portrait) Orientation orientation,
    @Default(0) int deviceIndex,
    String locale,
    @Default(true) bool isFrameVisible,
    @Default(false) bool isDarkMode,
    @Default(false) bool boldText,
    @Default(false) bool disableAnimations,
    @Default(false) bool highContrast,
    @Default(false) bool accessibleNavigation,
    @Default(false) bool invertColors,
    @Default(1.0) double textScaleFactor,
    @SizeJsonConverter() Size freeformSize,
  }) = _DevicePreviewData;

  factory DevicePreviewData.fromJson(Map<String, dynamic> json) =>
      _$DevicePreviewDataFromJson(json);
}

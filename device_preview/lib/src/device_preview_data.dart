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

abstract class DevicePreviewStorage {
  /// Save the current preferences (until [ignore] is `true`).
  static Future<void> save(DevicePreviewData data,
      [bool ignore = false]) async {
    if (!ignore) {
      _saveData = data;
      _saveTask ??= _save();
      await _saveTask;
    }
  }

  static const String _preferencesKey = 'device_preview.config';
  static Future _saveTask;
  static DevicePreviewData _saveData;

  static Future _save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_saveData != null) {
      final shared = await SharedPreferences.getInstance();
      await shared.setString(_preferencesKey, jsonEncode(_saveData.toJson()));
    }
    _saveTask = null;
  }

  /// Load the last saved preferences (until [ignore] is `true`).
  static Future<DevicePreviewData> load([bool ignore = false]) async {
    if (!ignore) {
      final shared = await SharedPreferences.getInstance();
      final json = shared.getString(_preferencesKey);
      if (json == null || json.isEmpty) return null;
      return DevicePreviewData.fromJson(jsonDecode(json));
    }
    return null;
  }
}

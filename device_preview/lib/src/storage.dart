import 'dart:convert';

import 'package:device_preview/src/state/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const String _preferencesKey = 'device_preview.settings';
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

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../device_preview.dart';

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

abstract class DevicePreviewStyleStorage {
  /// Save the current preferences (until [ignore] is `true`).
  static Future<void> save(DevicePreviewStyle data,
      [bool ignore = false]) async {
    if (!ignore) {
      _saveData = data;
      _saveTask ??= _save();
      await _saveTask;
    }
  }

  static const String _preferencesKey = 'device_preview.style';
  static Future _saveTask;
  static DevicePreviewStyle _saveData;

  static Future _save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_saveData != null) {
      final shared = await SharedPreferences.getInstance();
      final map = <String, dynamic>{};

      final light = DevicePreviewStyle.light();
      final dark = DevicePreviewStyle.dark();

      if (_saveData.background == light.background) {
        map['background'] = 'light';
      } else if (_saveData.background == dark.background) {
        map['background'] = 'dark';
      }

      if (_saveData.toolBar.backgroundColor == light.toolBar.backgroundColor) {
        map['toolBar.theme'] = 'dark';
      } else if (_saveData.toolBar.backgroundColor ==
          dark.toolBar.backgroundColor) {
        map['toolBar.theme'] = 'light';
      }

      map['toolBar.position'] = _saveData.toolBar.position.index;

      await shared.setString(_preferencesKey, jsonEncode(map));
    }
    _saveTask = null;
  }

  /// Load the last saved preferences (until [ignore] is `true`).
  static Future<DevicePreviewStyle> load([bool ignore = false]) async {
    if (!ignore) {
      final shared = await SharedPreferences.getInstance();
      final json = shared.getString(_preferencesKey);

      if (json == null || json.isEmpty) return null;
      final map = jsonDecode(json);

      final background = map['background'];
      final toolBar = map['toolBar.theme'];
      final toolBarPosition = map['toolBar.position'];

      final light = DevicePreviewStyle.light();
      final dark = DevicePreviewStyle.dark();

      var result = DevicePreviewStyle.light();
      if (background == 'light') {
        result = result.copyWith(background: light.background);
      } else if (background == 'dark') {
        result = result.copyWith(background: dark.background);
      }
      if (toolBar == 'light') {
        result = result.copyWith(toolBar: dark.toolBar);
      } else if (toolBar == 'dark') {
        result = result.copyWith(toolBar: light.toolBar);
      }
      if (toolBarPosition != null) {
        final position = DevicePreviewToolBarPosition.values
            .firstWhere((x) => x.index == toolBarPosition);
        result = result.copyWith(
            toolBar: result.toolBar.copyWith(position: position));
      }

      return result;
    }
    return null;
  }
}

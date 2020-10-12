import 'dart:convert';

import 'package:device_preview/src/state/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DevicePreviewStorage {
  const DevicePreviewStorage();

  factory DevicePreviewStorage.none() => NoDevicePreviewStorage();

  factory DevicePreviewStorage.preferences({
    String preferenceKey =
        PreferencesDevicePreviewStorage.defaultPreferencesKey,
  }) =>
      PreferencesDevicePreviewStorage(
        preferenceKey: preferenceKey,
      );

  Future<void> save(DevicePreviewData data);

  Future<DevicePreviewData> load();
}

class NoDevicePreviewStorage extends DevicePreviewStorage {
  const NoDevicePreviewStorage();

  @override
  Future<DevicePreviewData> load() => Future<DevicePreviewData>.value(null);

  @override
  Future<void> save(DevicePreviewData data) => Future.value();
}

class PreferencesDevicePreviewStorage extends DevicePreviewStorage {
  PreferencesDevicePreviewStorage({
    this.preferenceKey = defaultPreferencesKey,
  }) : assert(preferenceKey != null);

  final String preferenceKey;

  /// Save the current preferences (until [ignore] is `true`).
  @override
  Future<void> save(DevicePreviewData data) async {
    _saveData = data;
    _saveTask ??= _save();
    await _saveTask;
  }

  static const String defaultPreferencesKey = 'device_preview.settings';
  Future _saveTask;
  DevicePreviewData _saveData;

  Future _save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_saveData != null) {
      final shared = await SharedPreferences.getInstance();
      await shared.setString(preferenceKey, jsonEncode(_saveData.toJson()));
    }
    _saveTask = null;
  }

  /// Load the last saved preferences (until [ignore] is `true`).
  @override
  Future<DevicePreviewData> load() async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(preferenceKey);
    print(json);
    if (json == null || json.isEmpty) return null;
    return DevicePreviewData.fromJson(jsonDecode(json));
  }
}

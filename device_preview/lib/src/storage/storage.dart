import 'dart:convert';

import 'package:device_preview/src/state/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A storage for device preview user's preferences.
abstract class DevicePreviewStorage {
  const DevicePreviewStorage();

  /// A storage that keep preferences only in memory : they are reset on each
  /// fresh start of the app.
  factory DevicePreviewStorage.none() => NoDevicePreviewStorage();

  /// A storage that keeps all preferences stored as json in a single
  /// preferences entry with the [preferenceKey] key.
  ///
  /// If you're using many plugins, it may be better to use the [FileDevicePreviewStorage].
  factory DevicePreviewStorage.preferences({
    String preferenceKey =
        PreferencesDevicePreviewStorage.defaultPreferencesKey,
  }) =>
      PreferencesDevicePreviewStorage(
        preferenceKey: preferenceKey,
      );

  /// Save the given [data] to the storage so that it can be loaded
  /// later with the [load] method.
  Future<void> save(DevicePreviewData data);

  /// Load data from the storage that has been saved previously with
  /// the [save] method.
  Future<DevicePreviewData> load();
}

/// A storage that keep preferences only in memory : they are reset on each
/// fresh start of the app.
class NoDevicePreviewStorage extends DevicePreviewStorage {
  const NoDevicePreviewStorage();

  @override
  Future<DevicePreviewData> load() => Future<DevicePreviewData>.value(null);

  @override
  Future<void> save(DevicePreviewData data) => Future.value();
}

/// A storage that keeps all preferences stored as json in a single
/// preferences entry with the [preferenceKey] key.
///
/// If you're using many plugins, it may be better to use the [FileDevicePreviewStorage].
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
    if (json == null || json.isEmpty) return null;
    return DevicePreviewData.fromJson(jsonDecode(json));
  }
}

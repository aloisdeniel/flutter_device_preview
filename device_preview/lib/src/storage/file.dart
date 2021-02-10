import 'dart:convert';
import 'dart:io';

import 'package:device_preview/src/state/state.dart';

import 'storage.dart';

/// A storage that saves device preview user preferences into
/// a single [file] as a json content.
class FileDevicePreviewStorage extends DevicePreviewStorage {
  FileDevicePreviewStorage({
    required this.file,
  }) : assert(file != null);

  /// The file the json content is saved to.
  final File file;

  /// Save the current preferences.
  @override
  Future<void> save(DevicePreviewData data) async {
    _saveData = data;
    _saveTask ??= _save();
    await _saveTask;
  }

  Future? _saveTask;

  DevicePreviewData? _saveData;

  Future _save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_saveData != null) {
      await file.writeAsString(jsonEncode(_saveData!.toJson()));
    }
    _saveTask = null;
  }

  /// Load the last saved preferences.
  @override
  Future<DevicePreviewData?> load() async {
    final json = await file.readAsString();
    if (json.isEmpty) return null;
    return DevicePreviewData.fromJson(jsonDecode(json));
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:device_preview/presets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/generate_presets.dart' as tool;

/// The generated preset catalog is a checked-in build artifact: this guard
/// fails the suite when a device spec is edited without regenerating it, and
/// proves each generated constant is exactly its spec decoded at runtime.
void main() {
  final specs = Directory('../device_specs');
  final generated = File('lib/src/presets.g.dart');

  test('the generated preset catalog is up to date with device_specs/', () {
    expect(
      specs.existsSync(),
      isTrue,
      reason: 'run this suite from the package root',
    );
    expect(
      generated.readAsStringSync(),
      tool.generatePresets(specs),
      reason: 'device_specs changed — run: dart run tool/generate_presets.dart',
    );
  });

  test(
    'every preset equals its spec decoded through DevicePreset.fromJson',
    () {
      final specFiles = specs
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.json'))
          .toList();
      expect(DevicePresets.all, hasLength(specFiles.length));
      for (final file in specFiles) {
        final decoded = DevicePreset.fromJson(
          jsonDecode(file.readAsStringSync()) as Map<String, Object?>,
        );
        expect(DevicePresets.byId(decoded.id), decoded, reason: file.path);
      }
    },
  );

  test('every preset carries its frame, and system UI on mobile devices', () {
    for (final preset in DevicePresets.all) {
      expect(preset.frame, isNotNull, reason: preset.id);
      expect(preset.frame!.body, isNotEmpty, reason: preset.id);
      if (preset.kind != DeviceKind.desktop) {
        expect(preset.systemUi, isNotNull, reason: preset.id);
      }
    }
  });
}

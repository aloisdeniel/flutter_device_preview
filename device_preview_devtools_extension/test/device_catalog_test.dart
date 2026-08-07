import 'dart:io';

import 'package:device_preview_devtools_extension/src/devices/device_catalog.g.dart';
import 'package:device_preview_devtools_extension/src/panel_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tool/generate_device_catalog.dart' as tool;

/// The generated catalog is a checked-in build artifact: this guard fails the
/// suite when a device spec is edited without regenerating it.
void main() {
  final specs = Directory('../device_specs');
  final generated = File('lib/src/devices/device_catalog.g.dart');

  test('the generated catalog is up to date with device_specs/', () {
    expect(
      specs.existsSync(),
      isTrue,
      reason: 'run this suite from the package root',
    );
    expect(
      generated.readAsStringSync(),
      tool.generateDeviceCatalog(specs),
      reason:
          'device_specs changed — run: dart run tool/generate_device_catalog.dart',
    );
  });

  test('every spec file produces one catalog entry', () {
    final specFiles = specs
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'));
    expect(kDeviceSpecs, hasLength(specFiles.length));
    expect(kDeviceSpecs, isNotEmpty);
  });

  test('catalog entries carry the fields the panel reads', () {
    for (final device in kDeviceSpecs) {
      final preset = PresetView(device);
      expect(preset.id, isNotEmpty);
      expect(preset.name, isNotEmpty);
      expect(preset.brand, isNotEmpty);
      expect(preset.platform, isNot('unknown'));
      expect(preset.portraitSize, isNotNull);
      expect(preset.devicePixelRatio, isNotNull);
    }
  });

  test('ids are unique', () {
    final ids = kDeviceSpecs.map((device) => device['id']).toList();
    expect(ids.toSet(), hasLength(ids.length));
  });

  test('frames declare a body large enough for the screen', () {
    for (final device in kDeviceSpecs) {
      final frame = device['frame'] as Map<String, Object?>?;
      if (frame == null) continue;
      final screen = device['portraitSize']! as Map<String, Object?>;
      final size = frame['size']! as Map<String, Object?>;
      final offset =
          frame['screenOffset'] as Map<String, Object?>? ??
          const <String, Object?>{'x': 0, 'y': 0};
      double value(Map<String, Object?> map, String key) =>
          (map[key]! as num).toDouble();
      expect(
        value(offset, 'x') + value(screen, 'width'),
        lessThanOrEqualTo(value(size, 'width')),
        reason: '${device['id']}: the screen overflows the body horizontally',
      );
      expect(
        value(offset, 'y') + value(screen, 'height'),
        lessThanOrEqualTo(value(size, 'height')),
        reason: '${device['id']}: the screen overflows the body vertically',
      );
    }
  });
}

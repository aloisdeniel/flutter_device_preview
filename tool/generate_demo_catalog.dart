// Bundles the JSON device specs into the single catalog file the landing
// page's demo panel fetches.
//
//     dart tool/generate_demo_catalog.dart
//
// The panel in `docs/index.html` plays the part the DevTools extension plays
// for a real app: it owns the device catalog and pushes the selected device —
// metrics, screen outline and body artwork — to the embedded app. So it needs
// the same data the extension's generated catalog holds, in a form a page can
// fetch: `docs/device_catalog.json`, `{"presets": [ <spec>, … ]}`, each entry
// exactly one `device_specs/<id>.json`.
//
// `body` and system-UI artwork stay as the line arrays the spec files use —
// `DeviceFrame.fromJson` joins them app-side.

import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) {
  final Directory root = Directory.current;
  final Directory specs = Directory('${root.path}/device_specs');
  if (!specs.existsSync()) {
    stderr.writeln(
      'Run this from the root of the repository: ${specs.path} not found.',
    );
    exitCode = 1;
    return;
  }

  final List<File> files =
      specs
          .listSync()
          .whereType<File>()
          .where((File file) => file.path.endsWith('.json'))
          .toList()
        ..sort((File a, File b) => a.path.compareTo(b.path));

  final List<Object?> presets = <Object?>[];
  for (final File file in files) {
    final Object? spec = jsonDecode(file.readAsStringSync());
    if (spec is! Map<String, Object?>) {
      stderr.writeln('${file.path}: expected a JSON object.');
      exitCode = 1;
      return;
    }
    final String name = file.uri.pathSegments.last.replaceAll('.json', '');
    if (spec['id'] != name) {
      stderr.writeln('${file.path}: "id" must match the file name ($name).');
      exitCode = 1;
      return;
    }
    presets.add(spec);
  }

  final File out = File('${root.path}/docs/device_catalog.json');
  out.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(<String, Object?>{
      'presets': presets,
    })}\n',
  );
  stdout.writeln(
    'Wrote ${presets.length} devices to ${out.path} '
    '(${(out.lengthSync() / 1024).toStringAsFixed(0)} KB).',
  );
}

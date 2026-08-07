// Generates the DevTools extension's device catalog from the JSON device
// specs at the root of the repository.
//
//     dart run tool/generate_device_catalog.dart
//     dart run tool/generate_device_catalog.dart --check
//
// One `device_specs/<id>.json` file in, one Dart file out
// (`lib/src/devices/device_catalog.g.dart`): a plain `const` list of JSON maps
// the panel wraps in `PresetView` and pushes to the inspected app over the
// simulation protocol. The app itself never sees these files — device bodies
// travel on the wire, so nothing but the selected device's artwork is ever
// loaded, and `package:device_preview` stays artwork-free.
//
// The `--check` mode fails when the checked-in output is stale; it is what the
// `device_catalog_test.dart` guard runs.

import 'dart:convert';
import 'dart:io';

/// Top-level keys a device spec may declare. Anything else is a typo.
const Set<String> kSpecKeys = <String>{
  'id',
  'name',
  'brand',
  'platform',
  'kind',
  'portraitSize',
  'devicePixelRatio',
  'portraitPadding',
  'portraitViewPadding',
  'landscapePadding',
  'landscapeViewPadding',
  'systemGestureInsets',
  'displayFeatures',
  'frame',
};

/// Keys of the optional `frame` object.
const Set<String> kFrameKeys = <String>{
  'size',
  'screenOffset',
  'screenPath',
  'body',
};

/// `TargetPlatform` member names, as serialized by the protocol.
const Set<String> kPlatforms = <String>{
  'android',
  'fuchsia',
  'iOS',
  'linux',
  'macOS',
  'windows',
};

/// `DeviceKind` member names.
const Set<String> kKinds = <String>{'phone', 'tablet', 'foldable', 'desktop'};

Future<void> main(List<String> arguments) async {
  final bool check = arguments.contains('--check');
  final Directory specs = Directory(
    _option(arguments, '--specs') ?? _defaultSpecsPath(),
  );
  final File output = File(
    _option(arguments, '--output') ?? _defaultOutputPath(),
  );

  if (!specs.existsSync()) {
    stderr.writeln('No device specs directory at ${specs.path}');
    exit(2);
  }

  final String generated;
  try {
    generated = generateDeviceCatalog(specs);
  } on FormatException catch (error) {
    stderr.writeln('Invalid device spec: ${error.message}');
    exit(2);
  }

  if (check) {
    final String current = output.existsSync() ? output.readAsStringSync() : '';
    if (current != generated) {
      stderr.writeln(
        '${output.path} is out of date.\n'
        'Run: dart run tool/generate_device_catalog.dart',
      );
      exit(1);
    }
    stdout.writeln('${output.path} is up to date.');
    return;
  }

  output.parent.createSync(recursive: true);
  output.writeAsStringSync(generated);
  stdout.writeln(
    'Wrote ${output.path} from ${_specFiles(specs).length} device specs.',
  );
}

/// Builds the generated library source from every spec file in [specs].
///
/// Throws a [FormatException] describing the first invalid spec.
String generateDeviceCatalog(Directory specs) {
  final List<File> files = _specFiles(specs);
  final List<Map<String, Object?>> devices = <Map<String, Object?>>[];
  final Set<String> ids = <String>{};
  for (final File file in files) {
    final String name = file.uri.pathSegments.last;
    final Object? decoded;
    try {
      decoded = jsonDecode(file.readAsStringSync());
    } on FormatException catch (error) {
      throw FormatException('$name is not valid JSON: ${error.message}');
    }
    if (decoded is! Map) {
      throw FormatException('$name must contain a JSON object');
    }
    final Map<String, Object?> spec = Map<String, Object?>.from(decoded);
    _validate(spec, name);
    if (!ids.add(spec['id']! as String)) {
      throw FormatException('Duplicate device id "${spec['id']}" in $name');
    }
    if ('${spec['id']}.json' != name) {
      throw FormatException(
        '$name declares id "${spec['id']}"; the file must be named '
        '"${spec['id']}.json"',
      );
    }
    devices.add(_normalize(spec));
  }
  if (devices.isEmpty) {
    throw const FormatException('No device specs found');
  }

  final StringBuffer buffer = StringBuffer()
    ..writeln('// GENERATED — DO NOT EDIT.')
    ..writeln('//')
    ..writeln('// Source: device_specs/*.json at the root of the repository.')
    ..writeln('// Regenerate: dart run tool/generate_device_catalog.dart')
    ..writeln()
    ..writeln('/// The built-in device catalog, in `DevicePreset` JSON form:')
    ..writeln('/// exactly what the panel pushes to the inspected app, frame')
    ..writeln('/// artwork included.')
    ..writeln('///')
    ..writeln('/// ${devices.length} devices.')
    ..writeln('const List<Map<String, Object?>> kDeviceSpecs =');
  buffer.writeln('    <Map<String, Object?>>[');
  for (final Map<String, Object?> device in devices) {
    buffer.write(_emitValue(device, 6));
    buffer.writeln(',');
  }
  buffer.writeln('    ];');
  return buffer.toString();
}

List<File> _specFiles(Directory specs) =>
    specs
        .listSync()
        .whereType<File>()
        .where((File file) => file.path.endsWith('.json'))
        .toList()
      ..sort((File a, File b) => a.path.compareTo(b.path));

void _validate(Map<String, Object?> spec, String name) {
  for (final String key in spec.keys) {
    if (!kSpecKeys.contains(key)) {
      throw FormatException('$name: unknown key "$key"');
    }
  }
  for (final String key in <String>['id', 'name', 'platform']) {
    if (spec[key] is! String || (spec[key]! as String).isEmpty) {
      throw FormatException('$name: "$key" must be a non-empty string');
    }
  }
  if (spec['brand'] != null && spec['brand'] is! String) {
    throw FormatException('$name: "brand" must be a string');
  }
  if (!kPlatforms.contains(spec['platform'])) {
    throw FormatException(
      '$name: unknown platform "${spec['platform']}" '
      '(expected one of ${kPlatforms.join(', ')})',
    );
  }
  if (spec['kind'] != null && !kKinds.contains(spec['kind'])) {
    throw FormatException(
      '$name: unknown kind "${spec['kind']}" '
      '(expected one of ${kKinds.join(', ')})',
    );
  }
  _validateSize(spec['portraitSize'], '$name: portraitSize');
  if (spec['devicePixelRatio'] is! num ||
      (spec['devicePixelRatio']! as num) <= 0) {
    throw FormatException('$name: "devicePixelRatio" must be a positive number');
  }
  for (final String key in <String>[
    'portraitPadding',
    'portraitViewPadding',
    'landscapePadding',
    'landscapeViewPadding',
    'systemGestureInsets',
  ]) {
    if (spec[key] != null) {
      _validateInsets(spec[key], '$name: $key');
    }
  }
  if (spec['displayFeatures'] != null) {
    final Object? features = spec['displayFeatures'];
    if (features is! List) {
      throw FormatException('$name: "displayFeatures" must be an array');
    }
    for (final Object? feature in features) {
      if (feature is! Map ||
          feature['bounds'] is! Map ||
          feature['type'] is! String ||
          feature['state'] is! String) {
        throw FormatException(
          '$name: every display feature needs "bounds", "type" and "state"',
        );
      }
    }
  }
  if (spec['frame'] != null) {
    _validateFrame(spec['frame'], name);
  }
}

void _validateFrame(Object? frame, String name) {
  if (frame is! Map) {
    throw FormatException('$name: "frame" must be an object');
  }
  for (final Object? key in frame.keys) {
    if (!kFrameKeys.contains(key)) {
      throw FormatException('$name: unknown frame key "$key"');
    }
  }
  _validateSize(frame['size'], '$name: frame.size');
  final Object? offset = frame['screenOffset'];
  if (offset != null) {
    if (offset is! Map || offset['x'] is! num || offset['y'] is! num) {
      throw FormatException('$name: frame.screenOffset needs numeric x and y');
    }
  }
  if (frame['screenPath'] != null && frame['screenPath'] is! String) {
    throw FormatException('$name: frame.screenPath must be a string');
  }
  final Object? body = frame['body'];
  if (body != null && body is! String && body is! List) {
    throw FormatException(
      '$name: frame.body must be a string or an array of strings',
    );
  }
  final String source = body == null ? '' : _joinLines(body, '$name: body');
  if (source.isNotEmpty && !source.trimLeft().startsWith('<svg')) {
    throw FormatException('$name: frame.body must be an <svg> document');
  }
}

void _validateSize(Object? value, String context) {
  if (value is! Map ||
      value['width'] is! num ||
      value['height'] is! num ||
      (value['width']! as num) <= 0 ||
      (value['height']! as num) <= 0) {
    throw FormatException('$context must be an object of positive width and '
        'height');
  }
}

void _validateInsets(Object? value, String context) {
  if (value is! Map) {
    throw FormatException('$context must be an object');
  }
  for (final String side in <String>['left', 'top', 'right', 'bottom']) {
    if (value[side] is! num) {
      throw FormatException('$context.$side must be a number');
    }
  }
}

String _joinLines(Object? value, String context) {
  if (value is String) {
    return value;
  }
  if (value is List) {
    return value.map((Object? line) {
      if (line is! String) {
        throw FormatException('$context must only contain strings');
      }
      return line;
    }).join('\n');
  }
  throw FormatException('$context must be a string or an array of strings');
}

/// Normalizes a spec into the wire shape: multi-line artwork joined, numbers
/// left as authored, key order stabilized.
Map<String, Object?> _normalize(Map<String, Object?> spec) {
  final Map<String, Object?> result = <String, Object?>{};
  for (final String key in kSpecKeys) {
    if (!spec.containsKey(key) || spec[key] == null) {
      continue;
    }
    if (key == 'frame') {
      final Map<String, Object?> frame = Map<String, Object?>.from(
        spec['frame']! as Map,
      );
      final Map<String, Object?> normalized = <String, Object?>{};
      for (final String frameKey in kFrameKeys) {
        final Object? value = frame[frameKey];
        if (value == null) {
          continue;
        }
        if (frameKey == 'body') {
          final String body = _joinLines(value, 'body');
          if (body.isNotEmpty) {
            normalized[frameKey] = body;
          }
        } else if (frameKey == 'screenPath') {
          if ((value as String).isNotEmpty) {
            normalized[frameKey] = value;
          }
        } else {
          normalized[frameKey] = value;
        }
      }
      result[key] = normalized;
      continue;
    }
    result[key] = spec[key];
  }
  return result;
}

/// Emits a JSON value as a `const`-compatible Dart literal.
String _emitValue(Object? value, int indent) {
  final String pad = ' ' * indent;
  if (value == null) {
    return '${pad}null';
  }
  if (value is String) {
    return '$pad${_emitString(value)}';
  }
  if (value is bool) {
    return '$pad$value';
  }
  if (value is num) {
    return '$pad${_emitNumber(value)}';
  }
  if (value is List) {
    if (value.isEmpty) {
      return '$pad<Object?>[]';
    }
    final StringBuffer buffer = StringBuffer('$pad<Object?>[\n');
    for (final Object? entry in value) {
      buffer
        ..write(_emitValue(entry, indent + 2))
        ..writeln(',');
    }
    buffer.write('$pad]');
    return buffer.toString();
  }
  if (value is Map) {
    if (value.isEmpty) {
      return '$pad<String, Object?>{}';
    }
    final StringBuffer buffer = StringBuffer('$pad<String, Object?>{\n');
    value.forEach((Object? key, Object? entry) {
      final String child = _emitValue(entry, indent + 2).trimLeft();
      buffer
        ..write('$pad  ${_emitString('$key')}: $child')
        ..writeln(',');
    });
    buffer.write('$pad}');
    return buffer.toString();
  }
  throw FormatException('Cannot emit ${value.runtimeType} as a Dart literal');
}

/// Doubles stay doubles (`2.0`), integers stay integers — the app decodes both
/// through `num`, and keeping the authored form makes diffs readable.
String _emitNumber(num value) => value is int ? '$value' : '$value';

String _emitString(String value) {
  final StringBuffer buffer = StringBuffer("'");
  for (final int rune in value.runes) {
    switch (rune) {
      case 0x27: // '
        buffer.write(r"\'");
      case 0x5C: // \
        buffer.write(r'\\');
      case 0x24: // $
        buffer.write(r'\$');
      case 0x0A:
        buffer.write(r'\n');
      case 0x0D:
        buffer.write(r'\r');
      case 0x09:
        buffer.write(r'\t');
      default:
        buffer.writeCharCode(rune);
    }
  }
  buffer.write("'");
  return buffer.toString();
}

String? _option(List<String> arguments, String name) {
  for (final String argument in arguments) {
    if (argument.startsWith('$name=')) {
      return argument.substring(name.length + 1);
    }
  }
  return null;
}

/// `<repo>/device_specs`, resolved from this script's own location so the
/// defaults work from any working directory.
String _defaultSpecsPath() =>
    Directory.fromUri(Platform.script.resolve('../../device_specs')).path;

/// `<package>/lib/src/devices/device_catalog.g.dart`.
String _defaultOutputPath() =>
    File.fromUri(
      Platform.script.resolve('../lib/src/devices/device_catalog.g.dart'),
    ).path;

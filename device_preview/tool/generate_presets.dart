// Generates the package's built-in `DevicePresets` catalog from the JSON
// device specs at the root of the repository.
//
//     dart run tool/generate_presets.dart
//     dart run tool/generate_presets.dart --check
//
// One `device_specs/<id>.json` file in, one Dart file out
// (`lib/src/presets.g.dart`): a `static const DevicePreset` per device —
// the complete spec, frame artwork and system UI included, exactly what
// `DevicePreset.fromJson` would decode from the same file. The guard test
// (`test/model/presets_generated_test.dart`) verifies both that the
// checked-in output is current and that every emitted constant equals its
// runtime-decoded spec.
//
// The DevTools extension has the deep spec validator
// (`device_preview_devtools_extension/tool/generate_device_catalog.dart`);
// this generator only checks what it needs to emit valid Dart.
//
// The `--check` mode fails when the checked-in output is stale.

import 'dart:convert';
import 'dart:io';

/// `TargetPlatform` member names, as spelled in the specs.
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

/// `ui.DisplayFeatureType` member names.
const Set<String> kFeatureTypes = <String>{'fold', 'hinge', 'cutout'};

/// `ui.DisplayFeatureState` member names.
const Set<String> kFeatureStates = <String>{
  'unknown',
  'postureFlat',
  'postureHalfOpened',
};

/// Ids whose Dart name cannot be derived from the id itself.
const Map<String, String> kNameOverrides = <String, String>{
  'desktop-small': 'smallDesktopWindow',
  'desktop-large': 'largeDesktopWindow',
};

/// Id tokens with a spelling other than plain capitalization.
const Map<String, String> kTokenSpellings = <String, String>{
  'iphone': 'iPhone',
  'ipad': 'iPad',
};

/// Doc comment for each preset, keyed by device id.
///
/// A new device without an entry gets a plain "«name» («brand», «year»)."
/// line; add its entry here when there is more to say (display size, notch
/// vs. island, fold orientation, …).
const Map<String, String> kDescriptions = <String, String>{
  'apple-iphone-16': 'iPhone 16 — Dynamic Island.',
  'apple-iphone-16-plus': 'iPhone 16 Plus — Dynamic Island, 6.7" display.',
  'apple-iphone-16-pro': 'iPhone 16 Pro — Dynamic Island.',
  'apple-iphone-16-pro-max': 'iPhone 16 Pro Max — Dynamic Island.',
  'apple-iphone-17': 'iPhone 17 — Dynamic Island, 6.3" display.',
  'apple-iphone-17-pro': 'iPhone 17 Pro — Dynamic Island, 6.3" display.',
  'apple-iphone-17-pro-max':
      'iPhone 17 Pro Max — Dynamic Island, 6.9" display.',
  'apple-iphone-17e': 'iPhone 17e — notch, the 6.1" entry model.',
  'apple-iphone-air': 'iPhone Air — Dynamic Island, 6.5" display.',
  'apple-iphone-se-3':
      'iPhone SE (3rd generation) — Home button, 4.7" display, no safe area '
      'beyond the 20 pt status bar.',
  'apple-ipad-pro-13-m5': 'iPad Pro 13" (M5).',
  'apple-ipad-pro-11-m5': 'iPad Pro 11" (M5).',
  'apple-ipad-pro-13-m4': 'iPad Pro 13" (M4).',
  'apple-ipad-pro-11-m4': 'iPad Pro 11" (M4).',
  'apple-ipad-air-13-m4': 'iPad Air 13" (M4).',
  'apple-ipad-air-11-m4': 'iPad Air 11" (M4).',
  'apple-ipad-air-13-m2': 'iPad Air 13" (M2).',
  'apple-ipad-air-11-m2': 'iPad Air 11" (M2).',
  'apple-ipad-a16': 'iPad (A16) — 11" entry model.',
  'apple-ipad-10': 'iPad (10th generation).',
  'apple-ipad-mini': 'iPad mini (A17 Pro).',
  'google-pixel-9': 'Google Pixel 9 — gesture navigation.',
  'google-pixel-10': 'Google Pixel 10 — gesture navigation.',
  'google-pixel-10-pro-fold':
      'Google Pixel 10 Pro Fold — 8" inner display, book-style fold with a '
      'vertical crease at mid-width.',
  'samsung-galaxy-s24': 'Samsung Galaxy S24 — punch-hole, gesture navigation.',
  'samsung-galaxy-s25': 'Samsung Galaxy S25 — punch-hole, gesture navigation.',
  'samsung-galaxy-z-flip-8':
      'Samsung Galaxy Z Flip8 — clamshell fold, horizontal crease at '
      'mid-height.',
  'samsung-galaxy-z-fold-8':
      'Samsung Galaxy Z Fold8 — 7.6" inner display; the wide-format fold '
      'opens vertically, so the crease is horizontal at mid-height.',
  'samsung-galaxy-z-fold-8-ultra':
      'Samsung Galaxy Z Fold8 Ultra — 8" inner display, book-style fold '
      'with a vertical crease at mid-width.',
  'samsung-galaxy-tab-s10-plus': 'Samsung Galaxy Tab S10+.',
  'samsung-galaxy-tab-s11': 'Samsung Galaxy Tab S11.',
  'desktop-small': 'A small desktop window: 1024×640 at 1x.',
  'desktop-large': 'A large desktop window: 1920×1080 at 2x.',
};

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
    generated = generatePresets(specs);
  } on FormatException catch (error) {
    stderr.writeln('Invalid device spec: ${error.message}');
    exit(2);
  }

  if (check) {
    final String current = output.existsSync() ? output.readAsStringSync() : '';
    if (current != generated) {
      stderr.writeln(
        '${output.path} is out of date.\n'
        'Run: dart run tool/generate_presets.dart',
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
String generatePresets(Directory specs) {
  final List<Map<String, Object?>> devices = <Map<String, Object?>>[];
  final Map<String, String> names = <String, String>{};
  final Set<String> ids = <String>{};
  for (final File file in _specFiles(specs)) {
    final String fileName = file.uri.pathSegments.last;
    final Object? decoded;
    try {
      decoded = jsonDecode(file.readAsStringSync());
    } on FormatException catch (error) {
      throw FormatException('$fileName is not valid JSON: ${error.message}');
    }
    if (decoded is! Map) {
      throw FormatException('$fileName must contain a JSON object');
    }
    final Map<String, Object?> spec = Map<String, Object?>.from(decoded);
    final String id = _string(spec, 'id', fileName);
    if ('$id.json' != fileName) {
      throw FormatException(
        '$fileName declares id "$id"; the file must be named "$id.json"',
      );
    }
    if (!ids.add(id)) {
      throw FormatException('Duplicate device id "$id" in $fileName');
    }
    final String name = _dartName(spec, fileName);
    final String? clash = names[name];
    if (clash != null) {
      throw FormatException(
        '$fileName: Dart name "$name" collides with $clash',
      );
    }
    names[name] = id;
    devices.add(spec);
  }
  if (devices.isEmpty) {
    throw const FormatException('No device specs found');
  }

  final StringBuffer buffer = StringBuffer()
    ..writeln('// GENERATED — DO NOT EDIT.')
    ..writeln('//')
    ..writeln('// Source: device_specs/*.json at the root of the repository.')
    ..writeln('// Regenerate: dart run tool/generate_presets.dart')
    ..writeln('//')
    ..writeln('// dart format off')
    ..writeln()
    ..writeln("part of '../presets.dart';")
    ..writeln()
    ..writeln('/// The built-in device preset catalog, generated from the')
    ..writeln('/// device specs (`device_specs/` at the root of the')
    ..writeln('/// repository) — the same catalog the DevTools panel offers,')
    ..writeln('/// frame artwork and system UI included.')
    ..writeln('///')
    ..writeln('/// Static const entries: unreferenced presets — artwork')
    ..writeln('/// included — tree-shake away from apps that never mention')
    ..writeln('/// them. Metrics are logical pixels; iOS landscape insets')
    ..writeln('/// follow real UIKit behavior (notch/island mirrored to the')
    ..writeln('/// sides, 21px home indicator).')
    ..writeln('///')
    ..writeln('/// ${devices.length} devices.')
    ..writeln('abstract final class DevicePresets {');
  for (final Map<String, Object?> spec in devices) {
    buffer.write(_emitPreset(spec));
  }
  buffer
    ..writeln('  /// All built-in presets.')
    ..writeln('  static const List<DevicePreset> all = <DevicePreset>[');
  for (final Map<String, Object?> spec in devices) {
    buffer.writeln('    ${_dartName(spec, '')},');
  }
  buffer
    ..writeln('  ];')
    ..writeln()
    ..writeln('  /// Returns the built-in preset with the given [id], or null.')
    ..writeln('  static DevicePreset? byId(String id) {')
    ..writeln('    for (final DevicePreset preset in all) {')
    ..writeln('      if (preset.id == id) {')
    ..writeln('        return preset;')
    ..writeln('      }')
    ..writeln('    }')
    ..writeln('    return null;')
    ..writeln('  }')
    ..writeln('}');
  return buffer.toString();
}

/// The spec files, sorted by device id (the file name without `.json`) so
/// `fold-8` precedes `fold-8-ultra` the way it does in the id namespace.
List<File> _specFiles(Directory specs) =>
    specs
        .listSync()
        .whereType<File>()
        .where((File file) => file.path.endsWith('.json'))
        .toList()
      ..sort((File a, File b) => _specId(a).compareTo(_specId(b)));

String _specId(File file) {
  final String name = file.uri.pathSegments.last;
  return name.substring(0, name.length - '.json'.length);
}

/// The Dart identifier of a spec's `DevicePresets` member.
///
/// Derived from the id: the brand token is dropped, the rest is camel-cased
/// with [kTokenSpellings] applied (`apple-iphone-16-pro` → `iPhone16Pro`,
/// `samsung-galaxy-z-fold-8` → `galaxyZFold8`). [kNameOverrides] wins over
/// derivation.
String _dartName(Map<String, Object?> spec, String fileName) {
  final String id = spec['id']! as String;
  final String? override = kNameOverrides[id];
  if (override != null) {
    return override;
  }
  List<String> tokens = id.split('-');
  final String? brand = (spec['brand'] as String?)?.toLowerCase();
  if (tokens.length > 1 && tokens.first == brand) {
    tokens = tokens.sublist(1);
  }
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < tokens.length; i++) {
    final String token = kTokenSpellings[tokens[i]] ?? tokens[i];
    if (token.isEmpty) {
      throw FormatException('$fileName: id "$id" has an empty token');
    }
    buffer.write(i == 0 ? token : token[0].toUpperCase() + token.substring(1));
  }
  final String name = buffer.toString();
  if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(name)) {
    throw FormatException(
      '$fileName: derived Dart name "$name" is not a valid identifier; '
      'add the id to kNameOverrides in tool/generate_presets.dart',
    );
  }
  return name;
}

/// Emits one `static const DevicePreset` member, doc comment included.
String _emitPreset(Map<String, Object?> spec) {
  final String fileName = '${spec['id']}.json';
  final String id = _string(spec, 'id', fileName);
  final String name = _string(spec, 'name', fileName);
  final StringBuffer buffer = StringBuffer();

  String description = kDescriptions[id] ?? '$name.';
  final Object? brand = spec['brand'];
  final Object? year = spec['year'];
  if (!kDescriptions.containsKey(id) && brand is String) {
    description = year is int ? '$name ($brand, $year).' : '$name ($brand).';
  }
  for (final String line in _wrapDoc(description)) {
    buffer.writeln('  /// $line');
  }

  buffer
    ..writeln(
      '  static const DevicePreset ${_dartName(spec, fileName)} ='
      ' DevicePreset(',
    )
    ..writeln('    id: ${_emitString(id)},')
    ..writeln('    name: ${_emitString(name)},');
  if (brand != null) {
    buffer.writeln(
      '    brand: ${_emitString(_string(spec, 'brand', fileName))},',
    );
  }
  if (year != null) {
    if (year is! int) {
      throw FormatException('$fileName: "year" must be an integer');
    }
    buffer.writeln('    year: $year,');
  }
  final String platform = _string(spec, 'platform', fileName);
  if (!kPlatforms.contains(platform)) {
    throw FormatException('$fileName: unknown platform "$platform"');
  }
  buffer
    ..writeln('    platform: TargetPlatform.$platform,')
    ..writeln('    portraitSize: ${_emitSize(spec['portraitSize'], fileName)},')
    ..writeln(
      '    devicePixelRatio: '
      '${_emitNumber(spec['devicePixelRatio'], fileName)},',
    );
  for (final String key in <String>[
    'portraitPadding',
    'portraitViewPadding',
    'landscapePadding',
    'landscapeViewPadding',
    'systemGestureInsets',
  ]) {
    if (spec[key] != null) {
      buffer.writeln('    $key: ${_emitInsets(spec[key], fileName)},');
    }
  }
  final Object? features = spec['displayFeatures'];
  if (features != null) {
    if (features is! List) {
      throw FormatException('$fileName: "displayFeatures" must be an array');
    }
    buffer.writeln('    displayFeatures: <SimulatedDisplayFeature>[');
    for (final Object? feature in features) {
      buffer.write(_emitDisplayFeature(feature, fileName));
    }
    buffer.writeln('    ],');
  }
  final Object? kind = spec['kind'];
  if (kind != null && kind != 'phone') {
    if (!kKinds.contains(kind)) {
      throw FormatException('$fileName: unknown kind "$kind"');
    }
    buffer.writeln('    kind: DeviceKind.$kind,');
  }
  if (spec['frame'] != null) {
    buffer.write(_emitFrame(spec['frame'], fileName));
  }
  if (spec['systemUi'] != null) {
    buffer.write(_emitSystemUi(spec['systemUi'], fileName));
  }
  buffer
    ..writeln('  );')
    ..writeln();
  return buffer.toString();
}

String _emitFrame(Object? frame, String fileName) {
  if (frame is! Map) {
    throw FormatException('$fileName: "frame" must be an object');
  }
  final StringBuffer buffer = StringBuffer()
    ..writeln('    frame: DeviceFrame(')
    ..writeln('      size: ${_emitSize(frame['size'], fileName)},');
  if (frame['screenOffset'] != null) {
    final Object? offset = frame['screenOffset'];
    if (offset is! Map || offset['x'] is! num || offset['y'] is! num) {
      throw FormatException('$fileName: frame.screenOffset needs x and y');
    }
    buffer.writeln(
      '      screenOffset: ui.Offset('
      '${_emitNumber(offset['x'], fileName)}, '
      '${_emitNumber(offset['y'], fileName)}),',
    );
  }
  final Object? screenPath = frame['screenPath'];
  if (screenPath != null) {
    if (screenPath is! String) {
      throw FormatException('$fileName: frame.screenPath must be a string');
    }
    if (screenPath.isNotEmpty) {
      buffer
        ..writeln('      screenPath:')
        ..write(_emitMultiline(screenPath, 10))
        ..writeln(',');
    }
  }
  final Object? body = frame['body'];
  if (body != null) {
    final String joined = _joinLines(body, '$fileName: frame.body');
    if (joined.isNotEmpty) {
      buffer
        ..writeln('      body:')
        ..write(_emitMultiline(joined, 10))
        ..writeln(',');
    }
  }
  buffer.writeln('    ),');
  return buffer.toString();
}

String _emitSystemUi(Object? systemUi, String fileName) {
  if (systemUi is! Map) {
    throw FormatException('$fileName: "systemUi" must be an object');
  }
  final StringBuffer buffer = StringBuffer()
    ..writeln('    systemUi: SystemUiSimulation(');
  for (final String barName in <String>['statusBar', 'navigationBar']) {
    final Object? bar = systemUi[barName];
    if (bar == null) {
      continue;
    }
    if (bar is! Map) {
      throw FormatException('$fileName: systemUi.$barName must be an object');
    }
    buffer.writeln('      $barName: SystemUiBar(');
    for (final String slot in <String>['leading', 'center', 'trailing']) {
      final Object? artwork = bar[slot];
      if (artwork == null) {
        continue;
      }
      final String joined = _joinLines(artwork, '$fileName: $barName.$slot');
      if (joined.isNotEmpty) {
        buffer
          ..writeln('        $slot:')
          ..write(_emitMultiline(joined, 12))
          ..writeln(',');
      }
    }
    for (final String key in <String>['inset', 'bottomInset']) {
      if (bar[key] != null) {
        buffer.writeln('        $key: ${_emitNumber(bar[key], fileName)},');
      }
    }
    buffer.writeln('      ),');
  }
  buffer.writeln('    ),');
  return buffer.toString();
}

String _emitDisplayFeature(Object? feature, String fileName) {
  if (feature is! Map) {
    throw FormatException('$fileName: every display feature must be an object');
  }
  final Object? bounds = feature['bounds'];
  if (bounds is! Map) {
    throw FormatException(
      '$fileName: display feature "bounds" must be an '
      'object',
    );
  }
  final Object? type = feature['type'];
  final Object? state = feature['state'];
  if (!kFeatureTypes.contains(type)) {
    throw FormatException('$fileName: unknown display feature type "$type"');
  }
  if (!kFeatureStates.contains(state)) {
    throw FormatException('$fileName: unknown display feature state "$state"');
  }
  return '      SimulatedDisplayFeature(\n'
      '        bounds: ui.Rect.fromLTRB('
      '${_emitNumber(bounds['left'], fileName)}, '
      '${_emitNumber(bounds['top'], fileName)}, '
      '${_emitNumber(bounds['right'], fileName)}, '
      '${_emitNumber(bounds['bottom'], fileName)}),\n'
      '        type: ui.DisplayFeatureType.$type,\n'
      '        state: ui.DisplayFeatureState.$state,\n'
      '      ),\n';
}

String _emitSize(Object? value, String fileName) {
  if (value is! Map || value['width'] is! num || value['height'] is! num) {
    throw FormatException(
      '$fileName: a size must be an object of width and height',
    );
  }
  return 'ui.Size(${_emitNumber(value['width'], fileName)}, '
      '${_emitNumber(value['height'], fileName)})';
}

String _emitInsets(Object? value, String fileName) {
  if (value is! Map) {
    throw FormatException('$fileName: insets must be an object');
  }
  final Map<String, num> sides = <String, num>{};
  for (final String side in <String>['left', 'top', 'right', 'bottom']) {
    final Object? length = value[side];
    if (length is! num) {
      throw FormatException('$fileName: insets.$side must be a number');
    }
    if (length != 0) {
      sides[side] = length;
    }
  }
  if (sides.isEmpty) {
    return 'EdgeInsets.zero';
  }
  final String arguments = sides.entries
      .map(
        (MapEntry<String, num> side) =>
            '${side.key}: ${_emitNumber(side.value, fileName)}',
      )
      .join(', ');
  return 'EdgeInsets.only($arguments)';
}

/// Emits [value] as one indented single-quoted literal per line, `'\n'`
/// separators included — adjacent string literals concatenate back to the
/// exact source text.
String _emitMultiline(String value, int indent) {
  final String pad = ' ' * indent;
  final List<String> lines = value.split('\n');
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < lines.length; i++) {
    final String suffix = i == lines.length - 1 ? '' : r'\n';
    buffer.write('$pad${_emitString(lines[i], suffix: suffix)}');
    if (i < lines.length - 1) {
      buffer.writeln();
    }
  }
  return buffer.toString();
}

String _emitNumber(Object? value, String fileName) {
  if (value is! num) {
    throw FormatException('$fileName: expected a number, got $value');
  }
  return '$value';
}

String _emitString(String value, {String suffix = ''}) {
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
  buffer.write("$suffix'");
  return buffer.toString();
}

String _string(Map<String, Object?> spec, String key, String fileName) {
  final Object? value = spec[key];
  if (value is! String || value.isEmpty) {
    throw FormatException('$fileName: "$key" must be a non-empty string');
  }
  return value;
}

/// Wraps a doc sentence into lines that fit `  /// ` + 74 columns.
List<String> _wrapDoc(String text) {
  final List<String> lines = <String>[];
  final StringBuffer line = StringBuffer();
  for (final String word in text.split(' ')) {
    if (line.isNotEmpty && line.length + 1 + word.length > 72) {
      lines.add(line.toString());
      line.clear();
    }
    if (line.isNotEmpty) {
      line.write(' ');
    }
    line.write(word);
  }
  if (line.isNotEmpty) {
    lines.add(line.toString());
  }
  return lines;
}

String _joinLines(Object? value, String context) {
  if (value is String) {
    return value;
  }
  if (value is List) {
    return value
        .map((Object? line) {
          if (line is! String) {
            throw FormatException('$context must only contain strings');
          }
          return line;
        })
        .join('\n');
  }
  throw FormatException('$context must be a string or an array of strings');
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

/// `<package>/lib/src/presets.g.dart`.
String _defaultOutputPath() =>
    File.fromUri(Platform.script.resolve('../lib/src/presets.g.dart')).path;

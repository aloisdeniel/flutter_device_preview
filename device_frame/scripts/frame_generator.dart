import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

/// Parses all frame svg files from `assets` folder
/// and generate a dart class.
Future<void> main() async {
  final scriptDirectory = path.dirname(
      path.dirname(Platform.script.toString().replaceAll('file://', '')));
  final assetsDirectory = Directory(path.join(scriptDirectory, 'assets'));
  final files = await assetsDirectory.list().toList();
  final deviceInfos = <String>[];
  for (var file in files.where((x) => path.extension(x.path) == '.svg')) {
    final content = await File(file.path).readAsString();
    final name = path.basenameWithoutExtension(file.path);
    final deviceInfo = _generateDeviceInfo(name, content);
    deviceInfos.add(deviceInfo);
  }

  final outputFile = File(path.join(scriptDirectory, 'lib/src/devices.g.dart'));
  await outputFile.writeAsString('''
part of 'devices.dart';

final _allDevices = [${deviceInfos.join(',')}];
  ''');

  await Process.run('flutter', ['dartfmt', outputFile.path]);
}

/// Parse the [svgContent] associated to [identifier] and extract all
/// info contained inside it.
String _generateDeviceInfo(
  String name,
  String svgContent,
) {
  final document = XmlDocument.parse(svgContent);

  final infoNode = document.descendants.firstWhere(
    (node) =>
        node is XmlElement && node.name.toString().toLowerCase() == 'text',
    orElse: () => throw Exception(
      'The svg image should have a "text" node that defines device metadata',
    ),
  );
  final infoLines = infoNode.children
          .whereType<XmlElement>()
          .where((n) => n.name.toString() == 'tspan')
          .map((n) => n.text.trim())
          .toList() ??
      const <String>[];
  final info = Map<String, String>.fromEntries(
    infoLines.map(
      (x) {
        final split = x.split(':');
        return MapEntry(
          split.first.trim(),
          split.last.trim(),
        );
      },
    ),
  );

  String screen;
  var screenNode = document.descendants.firstWhere(
    (node) {
      return node is XmlElement &&
          node.name.toString().toLowerCase() == 'path' &&
          node.getAttribute('fill')?.toString() == '#FF0000';
    },
    orElse: () => null,
  );
  if (screenNode != null) {
    final data = screenNode.getAttribute('d');
    assert(data != null, 'The screen path should have a "d" property');
    screen = 'parseSvgPathData(\'$data\')..fillType = PathFillType.evenOdd';
  } else {
    screenNode = document.descendants.firstWhere(
      (node) {
        return node is XmlElement &&
            node.name.toString().toLowerCase() == 'rect' &&
            node.getAttribute('fill')?.toString() == '#FF0000';
      },
      orElse: () => throw Exception(
        'The svg image should have a path or rect filled with #FF0000 to represent the device\'s screen',
      ),
    );

    final width = screenNode.getAttribute('width');
    final height = screenNode.getAttribute('height');
    assert(width != null, 'The screen rect must have a width');
    assert(height != null, 'The screen rect must have a height');

    screen = '''Path()
      ..addRect(
        Rect.fromLTWH(
          ${double.tryParse(screenNode.getAttribute('x')) ?? 0},
          ${double.tryParse(screenNode.getAttribute('y')) ?? 0},
          ${double.parse(width)},
          ${double.parse(height)},
        ),
      )''';
  }

  // Moving defs at first position
  final defs = document.descendants.firstWhere(
    (node) {
      return node is XmlElement && node.name.toString() == 'defs';
    },
    orElse: () => null,
  );
  if (defs != null) {
    final parent = defs.parent;
    parent.children.remove(defs);
    parent.children.insert(0, defs);
  }

  // Removing the screen and info
  infoNode.parent.children.remove(infoNode);
  screenNode.parent.children.remove(screenNode);

  final width = document.rootElement.getAttribute('width');
  final height = document.rootElement.getAttribute('height');
  assert(width != null && height != null);

  final safeAreas = info.containsKey('safe_areas')
      ? info['safe_areas'].split('|').map(_parseInsets).toList()
      : const <String>[];
  final frame = document.toXmlString();

  return '''DeviceInfo(
    identifier: ${_parseIdentifier(name)},
    name: \'${info['name']}\',
    pixelRatio: ${double.parse(info['density'] ?? '1')},
    safeAreas: ${safeAreas.isEmpty ? 'EdgeInsets.zero' : safeAreas.first},
    rotatedSafeAreas: ${safeAreas.length < 2 ? null : safeAreas[1]},
    screenPath: $screen,
    svgFrame: \'\'\'${frame}\'\'\',
    frameSize: Size(
      ${double.parse(width)},
      ${double.parse(height)}
    ),
    screenSize: ${_parseScreenSize(info['screen_size'])},
  )''';
}

String _parseIdentifier(String fileName) {
  final splits = fileName.split('_');
  var platform = splits[0];
  switch (platform) {
    case 'ios':
      platform = 'iOS';
      break;
    case 'macos':
      platform = 'macOS';
      break;
    default:
  }

  final type = splits[1];
  final name = splits[2];

  return '''
  const DeviceIdentifier._(TargetPlatform.$platform, DeviceType.$type, \'$name\',)
  ''';
}

/// Parse an [EdgeInsets] where [text] is in the form `<left>,<top>,<right>,<bottom>`.
String _parseInsets(String text) {
  if (text == null) return 'EdgeInsets.zero';

  final splits = text.split(',').map((e) => double.parse(e.trim())).toList();

  final left = splits.length > 0 ? splits[0] : 0;
  final top = splits.length > 1 ? splits[1] : left;
  final right = splits.length > 2 ? splits[2] : left;
  final bottom = splits.length > 3 ? splits[3] : top;

  return '''EdgeInsets.only(
    left: $left,
    top: $top,
    right: $right,
    bottom: $bottom,
  )''';
}

/// Parse a [Size] where [text] is in the form `<width>x<height>`.
String _parseScreenSize(String text) {
  if (text == null) return 'Size.zero';

  final splits = text.split('x').map((e) => double.parse(e.trim())).toList();
  final width = splits.isEmpty ? 0 : splits.first;
  return '''Size(
    $width,
    ${splits.length > 1 ? splits[1] : width}
  )''';
}

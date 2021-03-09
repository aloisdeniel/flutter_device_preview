import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

import 'parsing.dart';

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
  final info = parseDevice(name, svgContent);

  final document = XmlDocument.parse(svgContent);
  String screen;
  var screenNode = findScreenNode(document);
  if (screenNode != null) {
    final data = screenNode.getAttribute('d');
    assert(data != null, 'The screen path should have a "d" property');
    screen = 'parseSvgPathData(\'$data\')..fillType = PathFillType.evenOdd';
  } else {
    screenNode = document.descendants.whereType<XmlElement>().firstWhere(
      (node) {
        return node.name.toString().toLowerCase() == 'rect' &&
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
          ${double.tryParse(screenNode.getAttribute('x') ?? '0')},
          ${double.tryParse(screenNode.getAttribute('y') ?? '0')},
          ${double.parse(width!)},
          ${double.parse(height!)},
        ),
      )''';
  }

  // Moving defs at first position
  final defs = document.descendants.cast<XmlNode?>().firstWhere(
    (node) {
      return node is XmlElement && node.name.toString() == 'defs';
    },
    orElse: () => null,
  );
  if (defs != null) {
    final parent = defs.parent;
    if (parent != null) {
      parent.children.remove(defs);
      parent.children.insert(0, defs);
    }
  }

  // Removing the screen and info
  final infoNode = findInfoNode(document);
  infoNode?.parent?.children.remove(infoNode);
  screenNode.parent?.children.remove(screenNode);
  final frame = document.toXmlString();

  return '''DeviceInfo(
    identifier: ${_formatIdentifier(info.identifier)},
    name: \'${info.name}\',
    pixelRatio: ${info.pixelRatio},
    safeAreas: ${info.safeAreas.isEmpty ? 'EdgeInsets.zero' : _formatEdgeInsets(info.safeAreas.first)},
    rotatedSafeAreas: ${info.safeAreas.length < 2 ? null : _formatEdgeInsets(info.safeAreas[1])},
    screenPath: $screen,
    svgFrame: \'\'\'$frame\'\'\',
    frameSize: ${_formatSize(info.frameSize)},
    screenSize: ${_formatSize(info.screenSize)},
  )''';
}

String _formatIdentifier(DeviceIdentifier identifier) {
  return '''
  const DeviceIdentifier._(TargetPlatform.${identifier.platform}, DeviceType.${identifier.type}, \'${identifier.name}\',)
  ''';
}

/// Parse an [EdgeInsets] where [text] is in the form `<left>,<top>,<right>,<bottom>`.
String _formatEdgeInsets(ScreenPadding insets) {
  return '''EdgeInsets.only(
    left: ${insets.left},
    top: ${insets.top},
    right: ${insets.right},
    bottom: ${insets.bottom},
  )''';
}

/// Parse a [Size] where [text] is in the form `<width>x<height>`.
String _formatSize(Size size) {
  return '''Size(
    ${size.width},
    ${size.height}
  )''';
}

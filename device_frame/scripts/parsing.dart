import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

DeviceInfo parseDevice(String fileName, String svgContent) {
  svgContent = svgContent.replaceAll('#FF0000', '#58B5F0');
  final document = XmlDocument.parse(svgContent);
  final infoNode = findInfoNode(document);
  final info = extractPropertiesFromSvg(infoNode);

  // Removing the screen and info
  infoNode.parent.children.remove(infoNode);

  final width = document.rootElement.getAttribute('width');
  final height = document.rootElement.getAttribute('height');
  assert(width != null && height != null);

  final safeAreas = info.containsKey('safe_areas')
      ? info['safe_areas'].split('|').map(parseInsets).toList()
      : const <ScreenPadding>[];

  return DeviceInfo(
    identifier: parseIdentifier(fileName),
    name: info['name'],
    fileName: fileName,
    frameSize: Size(
      width: double.parse(width),
      height: double.parse(height),
    ),
    pixelRatio: double.parse(info['density'] ?? '1'),
    svgContent: document.toXmlString(),
    safeAreas: safeAreas,
    screenSize: parseScreenSize(info['screen_size']),
  );
}

XmlElement findInfoNode(XmlDocument document) {
  return document.descendants.firstWhere(
    (node) =>
        node is XmlElement && node.name.toString().toLowerCase() == 'text',
    orElse: () => throw Exception(
      'The svg image should have a "text" node that defines device metadata',
    ),
  );
}

XmlElement findScreenNode(XmlDocument document) {
  return document.descendants.firstWhere(
    (node) {
      return node is XmlElement &&
          node.name.toString().toLowerCase() == 'path' &&
          node.getAttribute('fill')?.toString() == '#FF0000';
    },
    orElse: () => null,
  );
}

Map<String, String> extractPropertiesFromSvg(XmlElement infoNode) {
  final infoLines = infoNode.children
          .whereType<XmlElement>()
          .where((n) => n.name.toString() == 'tspan')
          .map((n) => n.text.trim())
          .toList() ??
      const <String>[];
  return Map<String, String>.fromEntries(
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
}

DeviceIdentifier parseIdentifier(String fileName) {
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

  return DeviceIdentifier(
    name: name,
    type: type,
    platform: platform,
  );
}

/// Parse an [ScreenPadding] where [text] is in the form `<left>,<top>,<right>,<bottom>`.
ScreenPadding parseInsets(String text) {
  if (text == null) return ScreenPadding(left: 0, top: 0, bottom: 0, right: 0);

  final splits = text.split(',').map((e) => double.parse(e.trim())).toList();

  final left = splits.isNotEmpty ? splits[0] : 0;
  final top = splits.length > 1 ? splits[1] : left;
  final right = splits.length > 2 ? splits[2] : left;
  final bottom = splits.length > 3 ? splits[3] : top;

  return ScreenPadding(left: left, right: right, top: top, bottom: bottom);
}

/// Parse a [ScreenSize] where [text] is in the form `<width>x<height>`.
Size parseScreenSize(String text) {
  if (text == null) return Size(width: 0, height: 0);
  final splits = text.split('x').map((e) => double.parse(e.trim())).toList();
  final width = splits.isEmpty ? 0 : splits.first;
  return Size(
    width: width,
    height: splits.length > 1 ? splits[1] : width,
  );
}

class Size {
  final double width;
  final double height;
  const Size({
    @required this.width,
    @required this.height,
  });
}

class ScreenPadding {
  final double top;
  final double left;
  final double right;
  final double bottom;
  const ScreenPadding({
    @required this.top,
    @required this.left,
    @required this.right,
    @required this.bottom,
  });
}

class DeviceInfo {
  final DeviceIdentifier identifier;
  final String name;
  final String fileName;
  final double pixelRatio;
  final String svgContent;
  final Size screenSize;
  final Size frameSize;
  final List<ScreenPadding> safeAreas;
  const DeviceInfo({
    @required this.identifier,
    @required this.name,
    @required this.fileName,
    @required this.pixelRatio,
    @required this.svgContent,
    @required this.screenSize,
    @required this.frameSize,
    @required this.safeAreas,
  });
}

class DeviceIdentifier {
  final String platform;
  final String type;
  final String name;
  const DeviceIdentifier({
    @required this.platform,
    @required this.type,
    @required this.name,
  });
}

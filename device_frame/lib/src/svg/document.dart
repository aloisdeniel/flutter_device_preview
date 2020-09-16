import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:xml/xml.dart';
import 'package:path_drawing/path_drawing.dart';

final iosFrameDocuments = [
  frameDocumentAssetKey(TargetPlatform.iOS, 'iphone', '11pro'),
];

final androidFrameDocuments = [];

String frameDocumentAssetKey(
  TargetPlatform platform,
  String deviceType,
  String deviceName,
) {
  final platformKey =
      platform.toString().replaceAll('${TargetPlatform}.', '').toLowerCase();
  return 'packages/device_frame/assets/${platformKey}_${deviceType}_${deviceName}.svg';
}

Future<List<SvgFrameDocument>> parseAllFrameDocuments(BuildContext context) {
  return parseFrameDocuments(
    context,
    [
      ...iosFrameDocuments,
      ...androidFrameDocuments,
    ],
  );
}

Future<List<SvgFrameDocument>> parseFrameDocuments(
    BuildContext context, List<String> assetKeys) {
  return Future.wait(
    assetKeys.map(
      (assetKey) => DefaultAssetBundle.of(context).loadString(assetKey).then(
            (content) => parseFrameDocument(content),
          ),
    ),
  );
}

Future<SvgFrameDocument> parseFrameDocument(String svgContent) async {
  final document = XmlDocument.parse(svgContent);

  final infoNode = document.descendants.firstWhere(
    (node) =>
        node is XmlElement && node.name.toString().toLowerCase() == "text",
    orElse: () => null,
  );
  final infoLines = infoNode?.text?.split('\n') ?? const <String>[];
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

  Path screen;
  var screenNode = document.descendants.firstWhere(
    (node) {
      return node is XmlElement &&
          node.name.toString().toLowerCase() == "path" &&
          node.getAttribute('fill')?.toString() == '#FF0000';
    },
    orElse: () => null,
  );
  if (screenNode != null) {
    final data = screenNode.getAttribute('d');
    assert(data != null);
    screen = parseSvgPathData(data);
  } else {
    screenNode = document.descendants.firstWhere(
      (node) {
        return node is XmlElement &&
            node.name.toString().toLowerCase() == "rect" &&
            node.getAttribute('fill')?.toString() == '#FF0000';
      },
    );
    screen = Path()
      ..addRect(
        Rect.fromLTWH(
          double.tryParse(screenNode.getAttribute('x')) ?? 0,
          double.tryParse(screenNode.getAttribute('y')) ?? 0,
          double.parse(screenNode.getAttribute('width')),
          double.parse(screenNode.getAttribute('height')),
        ),
      );
  }

  // Moving defs at first position
  final defs = document.descendants.firstWhere(
    (node) {
      return node is XmlElement && node.name.toString() == "defs";
    },
    orElse: () => null,
  );
  if (defs != null) {
    final parent = defs.parent;
    parent.children.remove(defs);
    parent.children.insert(0, defs);
  }

  // Removing the screen and info
  screenNode.parent.children.remove(screen);
  screenNode.parent.children.remove(infoNode);

  final width = document.rootElement.getAttribute('width');
  final height = document.rootElement.getAttribute('height');
  assert(width != null && height != null);

  final safeAreas = info['safe_areas'].split('|').map(_parseInsets).toList();
  return SvgFrameDocument(
    name: info['name'],
    density: double.parse(info['density'] ?? '1'),
    portrait: safeAreas.first,
    lanscape: safeAreas.last,
    screen: screen,
    frame: document.toXmlString(),
    width: double.parse(width),
    height: double.parse(height),
    screenSize: _parseScreenSize(info['screen_size']),
  );
}

class SvgFrameDocument {
  final String name;
  final EdgeInsets lanscape;
  final EdgeInsets portrait;
  final Path screen;
  final Size screenSize;
  final String frame;
  final double density;
  final double width;
  final double height;
  const SvgFrameDocument({
    @required this.name,
    @required this.lanscape,
    @required this.portrait,
    @required this.screen,
    @required this.density,
    @required this.frame,
    @required this.width,
    @required this.height,
    @required this.screenSize,
  });
}

EdgeInsets _parseInsets(String text) {
  final splits = text.split(',').map((e) => double.parse(e.trim())).toList();
  return EdgeInsets.only(
    left: splits[0],
    top: splits[1],
    right: splits[2],
    bottom: splits[3],
  );
}

Size _parseScreenSize(String text) {
  final splits = text.split('x').map((e) => double.parse(e.trim())).toList();
  return Size(
    splits.first,
    splits.last,
  );
}

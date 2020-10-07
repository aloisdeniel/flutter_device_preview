import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xml/xml.dart';
import 'package:path_drawing/path_drawing.dart';

import '../devices.dart';
import 'info.dart';

/// Parse svg file from assets with the [device] identifier and extract all
/// info contained inside it.
Future<DeviceInfo> loadDeviceInfo(
  BuildContext context,
  DeviceIdentifier device,
) {
  return DefaultAssetBundle.of(context).loadString(device.assetKey).then(
        (content) => parseFrameDocument(context, device, content),
      );
}

/// Parse all svg files from assets with [devices] identifiers and extract all
/// info contained inside them.
Future<List<DeviceInfo>> loadDevicesInfo(
  BuildContext context,
  List<DeviceIdentifier> devices,
) async {
  final result = <DeviceInfo>[];

  for (var device in devices) {
    result.add(await loadDeviceInfo(context, device));
  }
  return result;
}

/// Parse the [svgContent] associated to [identifier] and extract all
/// info contained inside it.
Future<DeviceInfo> parseFrameDocument(
  BuildContext context,
  DeviceIdentifier identifier,
  String svgContent,
) async {
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

  Path screen;
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
    screen = parseSvgPathData(data);
    screen.fillType = PathFillType.evenOdd;
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

    screen = Path()
      ..addRect(
        Rect.fromLTWH(
          double.tryParse(screenNode.getAttribute('x')) ?? 0,
          double.tryParse(screenNode.getAttribute('y')) ?? 0,
          double.parse(width),
          double.parse(height),
        ),
      );
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
      : const <EdgeInsets>[];
  final frame = document.toXmlString();
  await precachePicture(
    StringPicture(SvgPicture.svgStringDecoder, frame),
    context,
  );

  return DeviceInfo(
    identifier: identifier,
    name: info['name'],
    pixelRatio: double.parse(info['density'] ?? '1'),
    safeAreas: safeAreas.isEmpty ? EdgeInsets.zero : safeAreas.first,
    rotatedSafeAreas: safeAreas.length < 2 ? null : safeAreas[1],
    screenPath: screen,
    svgFrame: frame,
    frameSize: Size(
      double.parse(width),
      double.parse(height),
    ),
    screenSize: _parseScreenSize(info['screen_size']),
  );
}

/// Parse an [EdgeInsets] where [text] is in the form `<left>,<top>,<right>,<bottom>`.
EdgeInsets _parseInsets(String text) {
  if (text == null) return EdgeInsets.zero;

  final splits = text.split(',').map((e) => double.parse(e.trim())).toList();

  final left = splits.length > 0 ? splits[0] : 0;
  final top = splits.length > 1 ? splits[1] : left;
  final right = splits.length > 2 ? splits[2] : left;
  final bottom = splits.length > 3 ? splits[3] : top;

  return EdgeInsets.only(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

/// Parse a [Size] where [text] is in the form `<width>x<height>`.
Size _parseScreenSize(String text) {
  if (text == null) return Size.zero;

  final splits = text.split('x').map((e) => double.parse(e.trim())).toList();
  final width = splits.isEmpty ? 0 : splits.first;
  return Size(
    width,
    splits.length > 1 ? splits[1] : width,
  );
}

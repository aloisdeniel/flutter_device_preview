import 'dart:io';

import 'package:path/path.dart' as path;
import 'parsing.dart';

final platformLabels = {
  'ios': 'iOS',
  'android': 'Android',
  'linux': 'Linux',
  'windows': 'Windows',
  'macos': 'macOS',
};

/// Parses all frame svg files from `assets` folder
/// and generate a dart class.
Future<void> main() async {
  final scriptDirectory = path.dirname(
      path.dirname(Platform.script.toString().replaceAll('file://', '')));
  final assetsDirectory = Directory(path.join(scriptDirectory, 'assets'));
  final docDirectory =
      Directory(path.join(scriptDirectory, '..', 'docs', 'content', 'usage'));
  final files = await assetsDirectory.list().toList();
  final deviceInfos = <DeviceInfo>[];
  for (var file in files.where((x) => path.extension(x.path) == '.svg')) {
    final content = await File(file.path).readAsString();
    final name = path.basenameWithoutExtension(file.path);
    final deviceInfo = parseDevice(name, content);
    final illustrationFile = File(
        path.join(docDirectory.path, 'devices', path.basename(name) + '.svg'));
    await illustrationFile.writeAsString(deviceInfo.svgContent);
    deviceInfos.add(deviceInfo);
  }

  deviceInfos
    ..sort((x, y) {
      final compared = x.screenSize.width.compareTo(y.screenSize.width);
      if (compared == 0) {
        return x.screenSize.height.compareTo(y.screenSize.height);
      }
      return compared;
    });

  // Markdown section
  final markdown = StringBuffer();
  markdown.writeln('# Available devices');
  markdown.writeln('');
  markdown.writeln(
      'This section lists all simulated devices included with Device Preview.');
  markdown.writeln('');

  final platforms =
      deviceInfos.map((x) => x.identifier.platform).toSet().toList();
  for (var platform in platforms) {
    markdown.writeln('## ${platformLabels[platform.toLowerCase()]}');
    markdown.writeln('');
    final platformDevices =
        deviceInfos.where((x) => x.identifier.platform == platform).toList();
    for (var deviceInfo in platformDevices) {
      _addMarkdownDevice(markdown, deviceInfo);
    }
  }

  final markdownFile = File(path.join(docDirectory.path, 'devices.md'));
  await markdownFile.writeAsString(markdown.toString());
}

void _addMarkdownDevice(StringBuffer markdown, DeviceInfo info) {
  markdown.writeln('#### ${info.name}');
  markdown.writeln('');
  markdown.writeln('');
  markdown.writeln('<table>');
  markdown.writeln('<tr><td colspan="2">');

  markdown.writeln(
      '<img class="device-illustration" title="${info.name} illustration" src="content/usage/devices/${info.fileName}.svg" style="width:200px;" />');
  markdown.writeln('</td></tr>');

  markdown.writeln(
      '<tr><th>Platform</th><td>${info.identifier.platform}</td></tr>');
  markdown.writeln('<tr><th>Type</th><td>${info.identifier.type}</td></tr>');
  markdown.writeln('<tr><th>Pixel Ratio</th><td>${info.pixelRatio}</td></tr>');
  markdown.writeln(
      '<tr><th>Screen size</th><td>${info.screenSize.width} x ${info.screenSize.height}</td></tr>');
  if (info.safeAreas.isNotEmpty) {
    final area = info.safeAreas.first;
    markdown.writeln(
        '<tr><th>Safe Area (portrait)</th><td>left: ${area.left}, top: ${area.top}, right: ${area.right}, bottom: ${area.bottom}</td></tr>');
  }
  if (info.safeAreas.length > 1) {
    final area = info.safeAreas[1];
    markdown.writeln(
        '<tr><th>Safe Area (Landscape)</th><td>left: ${area.left}, top: ${area.top}, right: ${area.right}, bottom: ${area.bottom}</td></tr>');
  }
  markdown.writeln('</table>');
  markdown.writeln('');
}

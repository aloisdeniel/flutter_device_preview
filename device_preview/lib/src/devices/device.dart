import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'mockup.dart';

class Device {
  const Device({
    required this.id,
    required this.name,
    required this.pixelRatio,
    required this.platform,
    this.mockup,
    this.physicalSize,
    this.padding = const {
      Orientation.landscape: EdgeInsets.zero,
      Orientation.portrait: EdgeInsets.zero,
    },
  });
  final String id;
  final String name;
  final Map<Orientation, EdgeInsets> padding;
  final Size? physicalSize;
  final double pixelRatio;
  final TargetPlatform platform;

  /// The shape of the screen based on its rectangular [physicalSize].
  final DeviceMockup? mockup;

  Future<DeviceMockupRenderer?> createRenderer(String key) async {
    if (mockup == null) {
      return null;
    }
    final svgRoot = await svg.fromSvgString(mockup!.frame, key);
    return DeviceMockupRenderer(this, svgRoot);
  }
}

class DeviceCategory {
  const DeviceCategory({
    required this.name,
    required this.devices,
  });
  final String name;
  final List<List<Device>> devices;
}

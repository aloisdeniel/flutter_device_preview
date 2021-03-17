import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'renderer.dart';

class Device {
  Device({
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

  DeviceRenderer? _renderer;

  double get totalWidth =>
      _renderer?.drawable.viewport.width ??
      mockup?.screenShape.getBounds().width ??
      (physicalSize?.width ?? 0.0 * pixelRatio);

  Future<DeviceRenderer?> createRenderer(String key) async {
    if (mockup == null) {
      return null;
    }

    if (_renderer == null) {
      final svgRoot = await svg.fromSvgString(mockup!.frame, key);
      _renderer = DeviceRenderer(this, svgRoot);
    }
    return _renderer;
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

class DeviceMockup {
  const DeviceMockup({
    required this.frame,
    required this.frameSize,
    required this.screenShape,
    required this.screenOffset,
  });

  final String frame;
  final Size frameSize;
  final Path screenShape;
  final Offset screenOffset;
}

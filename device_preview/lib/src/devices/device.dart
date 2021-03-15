import 'package:flutter/widgets.dart';

class Device {
  const Device({
    required this.name,
    required this.pixelRatio,
    required this.platform,
    this.screenShape,
    this.physicalSize,
    this.padding = const {
      Orientation.landscape: EdgeInsets.zero,
      Orientation.portrait: EdgeInsets.zero,
    },
  });
  final String name;
  final Map<Orientation, EdgeInsets> padding;
  final Size? physicalSize;
  final double pixelRatio;
  final TargetPlatform platform;

  /// The shape of the screen based on its rectangular [physicalSize].
  final Path? screenShape;
}

class DeviceCategory {
  const DeviceCategory({
    required this.name,
    required this.devices,
  });
  final String name;
  final List<List<Device>> devices;
}

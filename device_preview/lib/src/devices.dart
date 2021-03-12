import 'package:flutter/widgets.dart';

final defaultDevices = [
  DeviceCategory(
    name: 'iOS',
    devices: [
      [
        Device(
          name: 'iPhone X',
          platform: TargetPlatform.iOS,
          physicalSize: Size(400, 600),
          pixelRatio: 3.0,
          padding: EdgeInsets.only(top: 40),
        )
      ]
    ],
  ),
  DeviceCategory(
    name: 'macOS',
    devices: [
      [
        Device(
          name: 'Default',
          pixelRatio: 2.0,
          platform: TargetPlatform.macOS,
          padding: EdgeInsets.zero,
        )
      ]
    ],
  ),
];

class Device {
  const Device({
    required this.name,
    required this.pixelRatio,
    required this.platform,
    this.physicalSize,
    this.padding = EdgeInsets.zero,
  });
  final String name;
  final EdgeInsets padding;
  final Size? physicalSize;
  final double pixelRatio;
  final TargetPlatform platform;
}

class DeviceCategory {
  const DeviceCategory({
    required this.name,
    required this.devices,
  });
  final String name;
  final List<List<Device>> devices;
}

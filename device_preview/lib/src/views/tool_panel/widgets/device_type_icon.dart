import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceTypeIcon extends StatelessWidget {
  const DeviceTypeIcon({
    Key? key,
    required this.type,
    this.color,
  }) : super(key: key);

  final Color? color;
  final DeviceType type;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? IconTheme.of(context).color ?? Colors.black;
    return Icon(
      () {
        switch (type) {
          case DeviceType.tablet:
            return Icons.tablet_android;
          case DeviceType.desktop:
            return Icons.desktop_mac;
          case DeviceType.laptop:
            return Icons.laptop_mac;
          case DeviceType.tv:
            return Icons.tv;
          default:
            return Icons.phone_android;
        }
      }(),
      color: color,
    );
  }
}

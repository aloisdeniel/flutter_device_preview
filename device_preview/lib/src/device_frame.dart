import 'package:flutter/widgets.dart';

class DeviceFrame {
  final EdgeInsets borders;

  final Color fillColor;

  final Color borderColor;

  final Color buttonColor;

  final BorderRadius edgeRadius;

  final BorderRadius screenRadius;

  final List<DeviceSideButton> sideButtons;

  final DeviceNotch notch;

  const DeviceFrame(
      {this.borders = const EdgeInsets.all(38.0),
      this.edgeRadius = const BorderRadius.all(Radius.circular(20.0)),
      this.screenRadius = const BorderRadius.all(Radius.circular(8.0)),
      this.notch,
      this.fillColor = const Color(0xFF1A1A1A),
      this.buttonColor = const Color(0xFF2A2A2A),
      this.borderColor = const Color(0xFF5A5A5A),
      this.sideButtons = const []});
}

enum DeviceEdge {
  top,
  left,
  right,
  bottom,
}

class DeviceSideButton {
  final DeviceEdge edge;
  final double position;
  final double size;
  final double thickness;
  final Radius radius;

  const DeviceSideButton({
    @required this.edge,
    @required this.position,
    @required this.thickness,
    @required this.size,
    @required this.radius,
  });

  const DeviceSideButton.left(
      {@required double fromTop,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : this.edge = DeviceEdge.left,
        this.position = fromTop;

  const DeviceSideButton.top(
      {double fromLeft,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : this.edge = DeviceEdge.top,
        this.position = fromLeft;

  const DeviceSideButton.right(
      {@required double fromTop,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : this.edge = DeviceEdge.right,
        this.position = fromTop;

  const DeviceSideButton.bottom(
      {@required double fromLeft,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : this.edge = DeviceEdge.bottom,
        this.position = fromLeft;
}

class DeviceNotch {
  final double width;
  final double height;
  final Radius radius;
  final Radius joinRadius;
  const DeviceNotch({
    @required this.width,
    @required this.height,
    @required this.radius,
    @required this.joinRadius,
  });
}

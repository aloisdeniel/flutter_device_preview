import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// A generic widget that renders a simulated mobile device frame.
///
/// It can simulate a [notch] too.
class MobileDeviceFrame extends StatelessWidget {
  final Widget child;

  final EdgeInsets borders;

  final Color fillColor;

  final Color borderColor;

  final double borderSize;

  final Color buttonColor;

  final BorderRadius edgeRadius;

  final BorderRadius screenRadius;

  final List<DeviceSideButton> sideButtons;

  final Size screenSize;

  final DeviceNotch notch;

  final DeviceOrientation orientation;

  MobileDeviceFrame({
    @required this.child,
    @required this.orientation,
    @required Size screenSize,
    this.borderSize = 4,
    this.borders = const EdgeInsets.all(38),
    this.edgeRadius = const BorderRadius.all(Radius.circular(20)),
    this.screenRadius = const BorderRadius.all(Radius.circular(8)),
    this.notch,
    this.fillColor = const Color(0xFF1A1A1A),
    this.buttonColor = const Color(0xFF2A2A2A),
    this.borderColor = const Color(0xFF5A5A5A),
    this.sideButtons = const [],
  }) : screenSize =
            orientation == DeviceOrientation.landscape && screenSize != null
                ? Size(screenSize.height, screenSize.width)
                : screenSize;

  @override
  Widget build(BuildContext context) {
    var padding = borders;

    if (orientation == DeviceOrientation.landscape) {
      padding = EdgeInsets.only(
        left: padding.bottom,
        top: padding.right,
        right: padding.top,
        bottom: padding.left,
      );
    }

    return Padding(
      padding: EdgeInsets.all(32),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: edgeRadius,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 70,
                      color: Color(0xFF000000).withOpacity(0.4)),
                ],
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: child,
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                  painter: _DeviceFramePainter(
                this,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceFramePainter extends CustomPainter {
  final MobileDeviceFrame device;

  const _DeviceFramePainter(
    this.device,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (device.orientation == DeviceOrientation.landscape) {
      canvas.translate(size.width / 2, size.height / 2);
    }

    size = Size(
      device.screenSize.width + device.borders.left + device.borders.right,
      device.screenSize.height + device.borders.top + device.borders.bottom,
    );

    if (device.orientation == DeviceOrientation.landscape) {
      canvas.rotate(math.pi / 2);
      canvas.translate(-size.width / 2, -size.height / 2);
    }

    final body = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset.zero & size,
          topLeft: device.edgeRadius.topLeft,
          topRight: device.edgeRadius.topRight,
          bottomLeft: device.edgeRadius.bottomLeft,
          bottomRight: device.edgeRadius.bottomRight,
        ),
      );

    var screen = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset(device.borders.left, device.borders.top) &
              Size(size.width - device.borders.left - device.borders.right,
                  size.height - device.borders.top - device.borders.bottom),
          topLeft: device.screenRadius.topLeft,
          topRight: device.screenRadius.topRight,
          bottomLeft: device.screenRadius.bottomLeft,
          bottomRight: device.screenRadius.bottomRight,
        ),
      );

    if (device.notch != null && device.notch.width > 0) {
      final notchRect = Offset((size.width / 2) - (device.notch.width / 2),
              device.borders.top - 1) &
          Size(
            device.notch.width,
            device.notch.height + 1,
          );

      final leftCornerMiniRect =
          Offset(notchRect.left - device.notch.joinRadius.x, notchRect.top) &
              Size(
                device.notch.joinRadius.x,
                device.notch.joinRadius.x,
              );
      final leftCorner = Path.combine(
        PathOperation.difference,
        Path()..addRect(leftCornerMiniRect),
        Path()
          ..addRRect(
            RRect.fromRectAndCorners(
              leftCornerMiniRect,
              topRight: Radius.circular(device.notch.joinRadius.x / 2),
            ),
          ),
      );

      final rightCornerMiniRect = Offset(notchRect.right, notchRect.top) &
          Size(device.notch.joinRadius.x, device.notch.joinRadius.x);
      final rightCorner = Path.combine(
        PathOperation.difference,
        Path()..addRect(rightCornerMiniRect),
        Path()
          ..addRRect(
            RRect.fromRectAndCorners(
              rightCornerMiniRect,
              topLeft: Radius.circular(device.notch.joinRadius.x / 2),
            ),
          ),
      );

      final notchPath = Path()
        ..addRRect(
          RRect.fromRectAndCorners(
            notchRect,
            bottomLeft: device.notch.radius,
            bottomRight: device.notch.radius,
          ),
        )
        ..addPath(
          leftCorner,
          Offset.zero,
        )
        ..addPath(
          rightCorner,
          Offset.zero,
        );

      screen = Path.combine(
        PathOperation.difference,
        screen,
        notchPath,
      );
    }

    final bodyWithoutScreen =
        Path.combine(PathOperation.difference, body, screen);

    canvas.drawPath(
      bodyWithoutScreen,
      Paint()
        ..style = PaintingStyle.fill
        ..color = device.fillColor,
    );

    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = device.borderSize
        ..color = device.borderColor,
    );

    final bodyBounds = body.getBounds();

    device.sideButtons.forEach((b) {
      final buttonPath = Path();
      switch (b.edge) {
        case DeviceEdge.left:
          final left = bodyBounds.left - b.thickness;
          final top = bodyBounds.top + b.position;
          final rect = Rect.fromLTWH(
            left,
            top,
            b.thickness,
            b.size,
          );
          buttonPath.addRRect(
            RRect.fromRectAndCorners(
              rect,
              topLeft: b.radius,
              bottomLeft: b.radius,
            ),
          );
          break;
        case DeviceEdge.right:
          final left = bodyBounds.right;
          final top = bodyBounds.top + b.position;
          final rect = Rect.fromLTWH(
            left,
            top,
            b.thickness,
            b.size,
          );
          buttonPath.addRRect(
            RRect.fromRectAndCorners(
              rect,
              topRight: b.radius,
              bottomRight: b.radius,
            ),
          );
          break;
        case DeviceEdge.top:
          final left = bodyBounds.left + b.position;
          final top = bodyBounds.top - b.thickness;
          final rect = Rect.fromLTWH(
            left,
            top,
            b.size,
            b.thickness,
          );
          buttonPath.addRRect(
            RRect.fromRectAndCorners(
              rect,
              topLeft: b.radius,
              topRight: b.radius,
            ),
          );
          break;
        case DeviceEdge.bottom:
          final left = bodyBounds.left + b.position;
          final top = bodyBounds.bottom;
          final rect = Rect.fromLTWH(left, top, b.size, b.thickness);
          buttonPath.addRRect(
            RRect.fromRectAndCorners(
              rect,
              bottomLeft: b.radius,
              bottomRight: b.radius,
            ),
          );
          break;
        default:
          break;
      }

      canvas.drawPath(
        buttonPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = device.buttonColor,
      );
    });
  }

  @override
  bool shouldRepaint(_DeviceFramePainter oldDelegate) =>
      device != oldDelegate.device ||
      device.orientation != oldDelegate.device.orientation;

  @override
  bool shouldRebuildSemantics(_DeviceFramePainter oldDelegate) => false;
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
      : edge = DeviceEdge.left,
        position = fromTop;

  const DeviceSideButton.top(
      {double fromLeft,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : edge = DeviceEdge.top,
        position = fromLeft;

  const DeviceSideButton.right(
      {@required double fromTop,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : edge = DeviceEdge.right,
        position = fromTop;

  const DeviceSideButton.bottom(
      {@required double fromLeft,
      @required this.size,
      @required this.thickness,
      this.radius = const Radius.circular(4)})
      : edge = DeviceEdge.bottom,
        position = fromLeft;
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

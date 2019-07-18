import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'device_frame.dart';
import 'devices/devices.dart';

class DeviceFramePreview extends StatelessWidget {
  final Widget child;

  final Device device;

  final Orientation orientation;

  const DeviceFramePreview(
      {@required this.child,
      @required this.orientation,
      @required this.device});

  @override
  Widget build(BuildContext context) {
    var padding = this.device.frame.borders;

    final shouldRotate =
        device.canRotate && orientation == Orientation.landscape;

    if (shouldRotate) {
      padding = EdgeInsets.only(
        left: padding.top,
        top: padding.right,
        right: padding.bottom,
        bottom: padding.left,
      );
    }

    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: device.frame.edgeRadius,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 70,
                      color: Color(0xFF000000).withOpacity(0.4)),
                ],
              ),
            ),
          ),
          Padding(padding: padding, child: this.child),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                  painter: _DeviceFramePainter(this.device, shouldRotate)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceFramePainter extends CustomPainter {
  final Device device;

  final bool shouldRotate;

  const _DeviceFramePainter(this.device, this.shouldRotate);

  @override
  void paint(Canvas canvas, Size size) {
    if (shouldRotate) {
      canvas.translate(size.width / 2, size.height / 2);
    }

    final frame = device.frame;
    final media = device.portrait ?? device.landscape;

    size = Size(media.size.width + frame.borders.left + frame.borders.right,
        media.size.height + frame.borders.top + frame.borders.bottom);

    if (shouldRotate) {
      canvas.rotate(math.pi / 2);
      canvas.translate(-size.width / 2, -size.height / 2);
    }

    final body = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Offset.zero & size,
        topLeft: frame.edgeRadius.topLeft,
        topRight: frame.edgeRadius.topRight,
        bottomLeft: frame.edgeRadius.bottomLeft,
        bottomRight: frame.edgeRadius.bottomRight,
      ));

    var screen = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Offset(frame.borders.left, frame.borders.top) &
            Size(size.width - frame.borders.left - frame.borders.right,
                size.height - frame.borders.top - frame.borders.bottom),
        topLeft: frame.screenRadius.topLeft,
        topRight: frame.screenRadius.topRight,
        bottomLeft: frame.screenRadius.bottomLeft,
        bottomRight: frame.screenRadius.bottomRight,
      ));

    if (frame.notch != null && frame.notch.width > 0) {
      final notchRect = Offset((size.width / 2) - (frame.notch.width / 2),
              frame.borders.top - 1) &
          Size(frame.notch.width, frame.notch.height + 1);

      final leftCornerMiniRect =
          Offset(notchRect.left - frame.notch.joinRadius.x, notchRect.top) &
              Size(frame.notch.joinRadius.x, frame.notch.joinRadius.x);
      final leftCorner = Path.combine(
          PathOperation.difference,
          Path()..addRect(leftCornerMiniRect),
          Path()
            ..addRRect(RRect.fromRectAndCorners(leftCornerMiniRect,
                topRight: Radius.circular(frame.notch.joinRadius.x / 2))));

      final rightCornerMiniRect = Offset(notchRect.right, notchRect.top) &
          Size(frame.notch.joinRadius.x, frame.notch.joinRadius.x);
      final rightCorner = Path.combine(
          PathOperation.difference,
          Path()..addRect(rightCornerMiniRect),
          Path()
            ..addRRect(RRect.fromRectAndCorners(rightCornerMiniRect,
                topLeft: Radius.circular(frame.notch.joinRadius.x / 2))));

      final notchPath = Path()
        ..addRRect(RRect.fromRectAndCorners(notchRect,
            bottomLeft: frame.notch.radius, bottomRight: frame.notch.radius))
        ..addPath(leftCorner, Offset.zero)
        ..addPath(rightCorner, Offset.zero);

      screen = Path.combine(PathOperation.difference, screen, notchPath);
    }

    final bodyWithoutScreen =
        Path.combine(PathOperation.difference, body, screen);

    canvas.drawPath(
      bodyWithoutScreen,
      Paint()
        ..style = PaintingStyle.fill
        ..color = frame.fillColor,
    );

    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..color = frame.borderColor,
    );

    final bodyBounds = body.getBounds();

    frame.sideButtons.forEach((b) {
      final buttonPath = Path();
      switch (b.edge) {
        case DeviceEdge.left:
          final left = bodyBounds.left - b.thickness;
          final top = bodyBounds.top + b.position;
          final rect = Rect.fromLTWH(left, top, b.thickness, b.size);
          buttonPath.addRRect(RRect.fromRectAndCorners(rect,
              topLeft: b.radius, bottomLeft: b.radius));
          break;
        case DeviceEdge.right:
          final left = bodyBounds.right;
          final top = bodyBounds.top + b.position;
          final rect = Rect.fromLTWH(left, top, b.thickness, b.size);
          buttonPath.addRRect(RRect.fromRectAndCorners(rect,
              topRight: b.radius, bottomRight: b.radius));
          break;
        case DeviceEdge.top:
          final left = bodyBounds.left + b.position;
          final top = bodyBounds.top - b.thickness;
          final rect = Rect.fromLTWH(left, top, b.size, b.thickness);
          buttonPath.addRRect(RRect.fromRectAndCorners(rect,
              topLeft: b.radius, topRight: b.radius));
          break;
        case DeviceEdge.bottom:
          final left = bodyBounds.left + b.position;
          final top = bodyBounds.bottom;
          final rect = Rect.fromLTWH(left, top, b.size, b.thickness);
          buttonPath.addRRect(RRect.fromRectAndCorners(rect,
              bottomLeft: b.radius, bottomRight: b.radius));
          break;
        default:
          break;
      }

      canvas.drawPath(
        buttonPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = frame.buttonColor,
      );
    });
  }

  @override
  bool shouldRepaint(_DeviceFramePainter oldDelegate) =>
      this.device != oldDelegate.device ||
      this.shouldRotate != oldDelegate.shouldRotate;

  @override
  bool shouldRebuildSemantics(_DeviceFramePainter oldDelegate) => false;
}

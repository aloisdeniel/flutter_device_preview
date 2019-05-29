import 'package:flutter/widgets.dart';

import 'device_frame.dart';

class DeviceFramePreview extends StatelessWidget {
  final Widget child;

  final DeviceFrame frame;

  const DeviceFramePreview(
      {@required this.child,
      @required this.frame});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(padding: this.frame.borders, child: this.child),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                  painter: _DeviceFramePainter(this.frame)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceFramePainter extends CustomPainter {
  final DeviceFrame frame;

  const _DeviceFramePainter(this.frame);

  @override
  void paint(Canvas canvas, Size size) {
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
      final notchRect =
          Offset((size.width / 2) - (frame.notch.width / 2), frame.borders.top - 1) &
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

      final rightCornerMiniRect =
          Offset(notchRect.right, notchRect.top) &
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
  bool shouldRepaint(_DeviceFramePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(_DeviceFramePainter oldDelegate) => false;
}

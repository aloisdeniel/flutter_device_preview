import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import '../theme.dart';

/// A generic widget that renders a simulated mobile device frame.
///
/// It can simulate a [notch] too.
class MobileDeviceFrame extends StatelessWidget {
  final Widget child;

  final DeviceFrameStyle style;

  final EdgeInsets body;

  final double borderSize;

  final BorderRadius edgeRadius;

  final BorderRadius screenRadius;

  final List<DeviceSideButton> sideButtons;

  final DeviceNotch notch;

  final Orientation orientation;

  final MediaQueryData mediaQueryData;

  final TargetPlatform platform;

  MobileDeviceFrame({
    @required this.platform,
    @required this.child,
    @required this.orientation,
    @required this.mediaQueryData,
    this.style,
    this.borderSize = 4,
    this.body = const EdgeInsets.all(38),
    this.edgeRadius = const BorderRadius.all(Radius.circular(20)),
    this.screenRadius = const BorderRadius.all(Radius.circular(8)),
    this.notch,
    this.sideButtons = const [],
  })  : assert(borderSize != null),
        assert(platform != null),
        assert(body != null);

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? DeviceFrameTheme.of(context);
    var padding = body;

    if (orientation == Orientation.landscape) {
      padding = EdgeInsets.only(
        left: padding.bottom,
        top: padding.right,
        right: padding.top,
        bottom: padding.left,
      );
    }

    return FittedBox(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: edgeRadius,
                  boxShadow: [
                    if (style.shadowColor != null)
                      BoxShadow(
                        blurRadius: 70,
                        color: style.shadowColor,
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: padding,
              child: MediaQuery(
                data: mediaQueryData,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    platform: platform,
                  ),
                  child: SizedBox(
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    child: child,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _DeviceFramePainter(
                    device: this,
                    style: style,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsets>('body', body));
    properties.add(DiagnosticsProperty<DeviceFrameStyle>('style', style));
    properties.add(DiagnosticsProperty<double>('borderSize', borderSize));
    properties.add(DiagnosticsProperty<DeviceNotch>('notch', notch));
    properties
        .add(DiagnosticsProperty<Orientation>('orientation', orientation));
    properties.add(DiagnosticsProperty<BorderRadius>('edgeRadius', edgeRadius));
    properties
        .add(DiagnosticsProperty<BorderRadius>('screenRadius', screenRadius));
    properties.add(DiagnosticsProperty<List<DeviceSideButton>>(
        'sideButtons', sideButtons));
  }
}

class _DeviceFramePainter extends CustomPainter {
  final MobileDeviceFrame device;
  final DeviceFrameStyle style;

  const _DeviceFramePainter({
    @required this.device,
    @required this.style,
  });

  Path _createBodyPath(Size size) {
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset.zero & size,
          topLeft: device.edgeRadius.topLeft,
          topRight: device.edgeRadius.topRight,
          bottomLeft: device.edgeRadius.bottomLeft,
          bottomRight: device.edgeRadius.bottomRight,
        ),
      );
  }

  Path _createScreenPath(Size size) {
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset(device.body.left, device.body.top) &
              Size(size.width - device.body.left - device.body.right,
                  size.height - device.body.top - device.body.bottom),
          topLeft: device.screenRadius.topLeft,
          topRight: device.screenRadius.topRight,
          bottomLeft: device.screenRadius.bottomLeft,
          bottomRight: device.screenRadius.bottomRight,
        ),
      );
  }

  Path _createButtonPath(DeviceSideButton b, Rect bodyBounds) {
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

    return buttonPath;
  }

  Path _createNotchPath(Size size) {
    final notchRect = Offset(
            (size.width / 2) - (device.notch.width / 2), device.body.top - 1) &
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

    return Path()
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
  }

  @override
  void paint(Canvas canvas, Size size) {
    Size size;

    if (device.orientation == Orientation.landscape) {
      size = Size(
        device.mediaQueryData.size.height +
            device.body.left +
            device.body.right,
        device.mediaQueryData.size.width + device.body.top + device.body.bottom,
      );

      final transform = Matrix4.rotationZ(math.pi * 0.5) *
          Matrix4.translationValues(0.0, -size.height, 0.0);
      canvas.transform(transform.storage);
    } else {
      size = Size(
        device.mediaQueryData.size.width + device.body.left + device.body.right,
        device.mediaQueryData.size.height +
            device.body.top +
            device.body.bottom,
      );
    }

    final body = _createBodyPath(size);
    var screen = _createScreenPath(size);

    if (device.notch != null && device.notch.width > 0) {
      final notchPath = _createNotchPath(size);
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
        ..color = style.bodyColor,
    );

    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = device.borderSize
        ..color = style.borderColor,
    );

    final bodyBounds = body.getBounds();

    device.sideButtons.forEach((b) {
      canvas.drawPath(
        _createButtonPath(b, bodyBounds),
        Paint()
          ..style = PaintingStyle.fill
          ..color = style.buttonColor,
      );
    });
  }

  @override
  bool shouldRepaint(_DeviceFramePainter oldDelegate) =>
      device.notch != oldDelegate.device.notch ||
      device.orientation != oldDelegate.device.orientation ||
      device.borderSize != oldDelegate.device.borderSize ||
      device.edgeRadius != oldDelegate.device.edgeRadius ||
      device.mediaQueryData != oldDelegate.device.mediaQueryData ||
      device.body != oldDelegate.device.body ||
      style != oldDelegate.style;

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

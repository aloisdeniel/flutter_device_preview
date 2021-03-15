import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'device.dart';

class DeviceMockup {
  const DeviceMockup({
    required this.frame,
    required this.screenShape,
    required this.screenOffset,
  });

  final String frame;
  final Path screenShape;
  final Offset screenOffset;
}

class DeviceMockupRenderer {
  const DeviceMockupRenderer(
    this.device,
    this.drawable,
  );

  final Device device;
  final DrawableRoot drawable;

  void paintFrame({
    required PaintingContext context,
    required Offset offset,
    required bool needsCompositing,
    required void Function(PaintingContext canvas, Offset offset) paintApp,
  }) {
    final mockup = device.mockup!;
    final screenBounds = mockup.screenShape.getBounds();
    final scale = screenBounds.width / device.physicalSize!.width;

    drawable.draw(context.canvas, null);

    final translateTransform = Matrix4.translationValues(
      mockup.screenOffset.dx,
      mockup.screenOffset.dy,
      0,
    );

    final scaleTransform = Matrix4.identity().scaled(scale);
    context.pushClipPath(
      needsCompositing,
      offset,
      screenBounds,
      mockup.screenShape.transform(translateTransform.storage),
      (context, offset) {
        context.pushTransform(
          needsCompositing,
          offset,
          Matrix4.identity() * translateTransform * scaleTransform,
          paintApp,
        );
      },
    );
  }
}

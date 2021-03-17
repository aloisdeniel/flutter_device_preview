import 'package:device_preview/src/helpers/transforms.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'device.dart';

class DeviceRenderer {
  const DeviceRenderer(
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

    context.pushTransform(
      needsCompositing,
      offset,
      PreviewTransforms.globalTransform(device),
      (context, offset) {
        drawable.draw(context.canvas, null);

        final screenTranslateTransform =
            PreviewTransforms.screenTranslateTransform(device);

        final screenScaleTransform =
            PreviewTransforms.screenScaleTransform(device);

        context.pushClipPath(
          needsCompositing,
          offset,
          screenBounds,
          mockup.screenShape.transform(screenTranslateTransform.storage),
          (context, offset) {
            context.pushTransform(
              needsCompositing,
              offset,
              Matrix4.identity() *
                  screenTranslateTransform *
                  screenScaleTransform,
              paintApp,
            );
          },
        );
      },
    );
  }
}

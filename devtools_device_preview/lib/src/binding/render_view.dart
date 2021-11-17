import 'dart:math';
import 'dart:ui' as ui;

import 'package:device_frame/device_frame.dart';
import 'package:devtools_device_preview/src/helpers/transforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PreviewRenderView extends RenderView {
  PreviewRenderView({
    RenderBox? child,
    required ViewConfiguration configuration,
    required ui.FlutterView window,
  }) : super(
          child: child,
          configuration: configuration,
          window: window,
        );

  DeviceInfo? _device;
  DeviceInfo? get device => _device;
  set device(DeviceInfo? value) {
    if (_device?.identifier != value?.identifier) {
      _device = value;
      markNeedsLayout();
      markNeedsPaint();
    }
  }

  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      _backgroundColor = value;
      markNeedsPaint();
    }
  }

  Orientation _orientation = Orientation.portrait;
  Orientation get orientation => _orientation;
  set orientation(Orientation value) {
    if (_orientation != value) {
      _orientation = value;
      markNeedsLayout();
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final device = this.device;
    if (device != null) {
      context.canvas.drawColor(
        _backgroundColor,
        BlendMode.color,
      );

      final screenBounds = device.screenPath.getBounds();

      context.pushTransform(
        needsCompositing,
        offset,
        PreviewTransforms.globalTransform(device, orientation),
        (context, offset) {
          var screenPath = device.screenPath.shift(-screenBounds.topLeft);
          if (orientation == Orientation.landscape) {
            final screenTransform = (Matrix4.rotationZ(pi * 0.5)
              ..translate(0.0, -screenBounds.height));
            screenPath = screenPath.transform(screenTransform.storage);
            final frameTransform = (Matrix4.rotationZ(pi * 0.5)
              ..translate(0.0, -device.frameSize.height));
            context.pushTransform(
              needsCompositing,
              offset,
              frameTransform,
              (context, offset) {
                device.framePainter.paint(
                  context.canvas,
                  device.frameSize,
                );
              },
            );
          } else {
            device.framePainter.paint(
              context.canvas,
              device.frameSize,
            );
          }

          context.pushClipPath(
            needsCompositing,
            screenBounds.topLeft,
            screenBounds.shift(-screenBounds.topLeft),
            screenPath,
            (context, offset) {
              context.pushTransform(
                needsCompositing,
                offset,
                PreviewTransforms.screenScaleTransform(device),
                super.paint,
              );
            },
          );
        },
      );
    } else {
      super.paint(context, offset);
    }
  }
}

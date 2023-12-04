import 'dart:math';

import 'package:device_preview/src/helpers/transforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flutter_view.dart';

class PreviewRenderView extends RenderView {
  PreviewRenderView({
    RenderBox? child,
    required PreviewFlutterView view,
  })  : _view = view,
        super(
          child: child,
          view: view,
        );

  final PreviewFlutterView _view;

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

  PointerEvent transformPointerEvent(PointerEvent event) {
    if (_view.previewConfiguration?.device.device.asNullable()
        case final device?) {
      final screenArea =
          PreviewTransforms.screenDestinationRect(device, orientation);
      if (screenArea.contains(event.position)) {
        final relativePosition = Offset(
          (event.position.dx - screenArea.left) / screenArea.width,
          (event.position.dy - screenArea.top) / screenArea.height,
        );

        final relativeDelta = Offset(
          event.delta.dx / screenArea.width,
          event.delta.dy / screenArea.height,
        );

        final screenSize = orientation == Orientation.portrait
            ? device.screenSize
            : device.screenSize.flipped;

        return event.copyWith(
          position: Offset(
            relativePosition.dx * screenSize.width,
            relativePosition.dy * screenSize.height,
          ),
          delta: Offset(
            relativeDelta.dx * screenSize.width,
            relativeDelta.dy * screenSize.height,
          ),
        );
      }
    }

    return event;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_view.previewConfiguration case final previewConfiguration?) {
      context.canvas.drawColor(
        _backgroundColor,
        BlendMode.color,
      );

      if (previewConfiguration.device.device.asNullable() case final device?) {
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
      }
    } else {
      super.paint(context, offset);
    }
  }
}

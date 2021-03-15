import 'dart:ui' as ui;

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

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawColor(Colors.white, BlendMode.color);

    context.pushTransform(
      needsCompositing,
      offset,
      Matrix4.translationValues(100, 100, 0),
      (context, offset) {
        context.pushClipRect(
            needsCompositing, offset, Rect.fromLTWH(0, 0, 1000, 1000),
            (context, offset) {
          super.paint(context, offset);
        });
      },
    );

    context.canvas.drawCircle(Offset(50, 50), 50, Paint()..color = Colors.red);
  }
}

import 'dart:ui' as ui;

import 'package:device_frame_community/device_frame_community.dart';
import 'package:flutter/material.dart';

abstract class PreviewTransforms {
  static Rect globalDestinationRect(
    DeviceInfo device,
    Orientation orientation,
  ) {
    final outputPadding = EdgeInsets.only(
              left: ui.window.padding.left,
              right: ui.window.padding.right,
              top: ui.window.padding.top,
              bottom: ui.window.padding.bottom,
            ) /
            device.pixelRatio +
        const EdgeInsets.all(10);
    final output = Size(
      (ui.window.physicalSize.width / device.pixelRatio) -
          outputPadding.horizontal,
      (ui.window.physicalSize.height / device.pixelRatio) -
          outputPadding.vertical,
    );
    final frameSize = orientation == Orientation.portrait
        ? device.frameSize
        : device.frameSize.flipped;
    final sizes = applyBoxFit(BoxFit.contain, frameSize, output);
    return Alignment.center.inscribe(
      sizes.destination,
      Offset(
            outputPadding.left,
            outputPadding.top,
          ) &
          output,
    );
  }

  static Matrix4 globalTransform(
    DeviceInfo device,
    Orientation orientation,
  ) {
    final destinationRect = globalDestinationRect(device, orientation);
    final frameSize = orientation == Orientation.portrait
        ? device.frameSize
        : device.frameSize.flipped;
    final scaleX = destinationRect.width / frameSize.width;
    final scaleY = destinationRect.height / frameSize.height;

    return Matrix4.translationValues(
      destinationRect.left,
      destinationRect.top,
      0.0,
    )..scale(
        scaleX,
        scaleY,
        1.0,
      );
  }

  static Offset globalScale(DeviceInfo device) {
    final output = ui.window.physicalSize * ui.window.devicePixelRatio;
    final frameSize = device.frameSize * device.pixelRatio;
    final sizes = applyBoxFit(BoxFit.contain, frameSize, output);
    final scaleX = sizes.destination.width / sizes.source.width;
    final scaleY = sizes.destination.height / sizes.source.height;
    return Offset(scaleX, scaleY);
  }

  static Matrix4 screenTranslateTransform(DeviceInfo device,
      [bool inverted = false]) {
    final translate = screenTranslate(device);
    return Matrix4.translationValues(
      translate.dx,
      translate.dy,
      0,
    );
  }

  static Rect screenDestinationRect(
    DeviceInfo device,
    Orientation orientation,
  ) {
    final destinationRect = globalDestinationRect(
      device,
      orientation,
    );
    final frameSize = orientation == Orientation.portrait
        ? device.frameSize
        : device.frameSize.flipped;
    final scaleX = destinationRect.width / frameSize.width;
    final scaleY = destinationRect.height / frameSize.height;

    var screenBounds = device.screenPath.getBounds();
    if (orientation == Orientation.landscape) {
      screenBounds = Offset(
            device.frameSize.height - screenBounds.bottom,
            screenBounds.left,
          ) &
          screenBounds.size.flipped;
    }
    return (destinationRect.topLeft +
            Offset(
              screenBounds.left * scaleX,
              screenBounds.top * scaleY,
            )) &
        Size(
          screenBounds.width * scaleX,
          screenBounds.height * scaleY,
        );
  }

  static Offset screenTranslate(DeviceInfo device, [bool inverted = false]) {
    final screenOffset = device.screenPath.getBounds().topLeft;
    return Offset(
      screenOffset.dx * (inverted ? -1 : 1),
      screenOffset.dy * (inverted ? -1 : 1),
    );
  }

  static Matrix4 screenScaleTransform(DeviceInfo device) {
    final scale = screenScale(device);
    return Matrix4.identity()..scale(scale);
  }

  static double screenScale(DeviceInfo device) {
    return (device.screenPath.getBounds().width / device.screenSize.width);
  }
}

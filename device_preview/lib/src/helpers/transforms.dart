import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../device_preview.dart';

abstract class PreviewTransforms {
  static Matrix4 globalTransform(Device device) {
    return Matrix4.identity().scaled(globalScale(device));
  }

  static double globalScale(Device device) {
    return (ui.window.physicalSize.width) /
        (device.pixelRatio * device.totalWidth);
  }

  static Matrix4 screenTranslateTransform(Device device,
      [bool inverted = false]) {
    final mockup = device.mockup;
    if (mockup != null) {
      final translate = screenTranslate(device);
      return Matrix4.translationValues(
        translate.dx,
        translate.dy,
        0,
      );
    }

    return Matrix4.identity();
  }

  static Offset screenTranslate(Device device, [bool inverted = false]) {
    final mockup = device.mockup;
    if (mockup != null) {
      return Offset(
        mockup.screenOffset.dx * (inverted ? -1 : 1),
        mockup.screenOffset.dy * (inverted ? -1 : 1),
      );
    }
    return Offset.zero;
  }

  static Matrix4 screenScaleTransform(Device device) {
    final mockup = device.mockup;
    if (mockup != null) {
      final scale = screenScale(device);
      return Matrix4.identity()..scale(scale, scale, scale);
    }

    return Matrix4.identity();
  }

  static double screenScale(Device device) {
    final mockup = device.mockup;
    if (mockup != null) {
      return mockup.screenShape.getBounds().width / device.physicalSize!.width;
    }

    return 1;
  }
}

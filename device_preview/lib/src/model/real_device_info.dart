import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'json_utils.dart';

/// Read-only snapshot of the real host device's characteristics.
///
/// Never simulated: the values always describe the physical device (or
/// window) the app is actually running on. The controller keeps this live by
/// refreshing it whenever the host reports a change.
@immutable
class RealDeviceInfo {
  /// Creates a snapshot of the real device.
  const RealDeviceInfo({
    required this.logicalSize,
    required this.physicalSize,
    required this.devicePixelRatio,
    required this.padding,
    required this.locales,
    required this.platformBrightness,
    required this.textScaleFactor,
    required this.targetPlatform,
  });

  /// The real logical screen size (physical size / device pixel ratio).
  final ui.Size logicalSize;

  /// The real physical screen size, in device pixels.
  final ui.Size physicalSize;

  /// The real device pixel ratio.
  final double devicePixelRatio;

  /// The real safe-area padding, in logical pixels.
  final EdgeInsets padding;

  /// The real locale list.
  final List<ui.Locale> locales;

  /// The real platform brightness.
  final ui.Brightness platformBrightness;

  /// The real text scale factor.
  final double textScaleFactor;

  /// The real target platform.
  final TargetPlatform targetPlatform;

  /// Encodes this snapshot as the `realDevice` object of the service
  /// extension state shape.
  Map<String, Object?> toJson() => <String, Object?>{
    'logicalSize': encodeSize(logicalSize),
    'devicePixelRatio': devicePixelRatio,
    'padding': encodeEdgeInsets(padding),
    'locales': locales.map(encodeLocale).toList(),
    'platformBrightness': platformBrightness.name,
    'textScaleFactor': textScaleFactor,
    'targetPlatform': targetPlatform.name,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is RealDeviceInfo &&
        other.logicalSize == logicalSize &&
        other.physicalSize == physicalSize &&
        other.devicePixelRatio == devicePixelRatio &&
        other.padding == padding &&
        listEquals(other.locales, locales) &&
        other.platformBrightness == platformBrightness &&
        other.textScaleFactor == textScaleFactor &&
        other.targetPlatform == targetPlatform;
  }

  @override
  int get hashCode => Object.hash(
    logicalSize,
    physicalSize,
    devicePixelRatio,
    padding,
    Object.hashAll(locales),
    platformBrightness,
    textScaleFactor,
    targetPlatform,
  );

  @override
  String toString() =>
      'RealDeviceInfo(logicalSize: $logicalSize, '
      'physicalSize: $physicalSize, devicePixelRatio: $devicePixelRatio, '
      'padding: $padding, locales: $locales, '
      'platformBrightness: ${platformBrightness.name}, '
      'textScaleFactor: $textScaleFactor, '
      'targetPlatform: ${targetPlatform.name})';
}

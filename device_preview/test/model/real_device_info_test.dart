import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

RealDeviceInfo buildInfo() {
  return const RealDeviceInfo(
    logicalSize: ui.Size(402, 874),
    physicalSize: ui.Size(1206, 2622),
    devicePixelRatio: 3.0,
    padding: EdgeInsets.only(top: 59, bottom: 34),
    locales: [ui.Locale('en', 'US')],
    platformBrightness: ui.Brightness.dark,
    textScaleFactor: 1.0,
    targetPlatform: TargetPlatform.iOS,
  );
}

void main() {
  group('RealDeviceInfo', () {
    test('toJson matches the state-shape realDevice object', () {
      expect(buildInfo().toJson(), <String, Object?>{
        'logicalSize': {'width': 402.0, 'height': 874.0},
        'devicePixelRatio': 3.0,
        'padding': {'left': 0.0, 'top': 59.0, 'right': 0.0, 'bottom': 34.0},
        'locales': ['en-US'],
        'platformBrightness': 'dark',
        'textScaleFactor': 1.0,
        'targetPlatform': 'iOS',
      });
    });

    test('equality and hashCode', () {
      expect(buildInfo(), buildInfo());
      expect(buildInfo().hashCode, buildInfo().hashCode);
      const other = RealDeviceInfo(
        logicalSize: ui.Size(1, 1),
        physicalSize: ui.Size(2, 2),
        devicePixelRatio: 2.0,
        padding: EdgeInsets.zero,
        locales: [ui.Locale('en')],
        platformBrightness: ui.Brightness.light,
        textScaleFactor: 1.0,
        targetPlatform: TargetPlatform.android,
      );
      expect(buildInfo(), isNot(other));
    });

    test('locale list uses deep equality', () {
      final a = buildInfo();
      const b = RealDeviceInfo(
        logicalSize: ui.Size(402, 874),
        physicalSize: ui.Size(1206, 2622),
        devicePixelRatio: 3.0,
        padding: EdgeInsets.only(top: 59, bottom: 34),
        locales: [ui.Locale('en', 'US')],
        platformBrightness: ui.Brightness.dark,
        textScaleFactor: 1.0,
        targetPlatform: TargetPlatform.iOS,
      );
      expect(a, b);
    });

    test('toString mentions the platform', () {
      expect(buildInfo().toString(), contains('iOS'));
    });
  });
}

import 'package:device_frame/src/info/identifier.dart';
import 'package:device_frame/src/info/info.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'frame.g.dart';

final info = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.iOS,
    DeviceType.phone,
    'iphone-12-mini',
  ),
  name: 'iPhone 12 Mini',
  year: 2019,
  pixelRatio: 2.0,
  frameSize: const Size(871.0, 1768.0),
  screenSize: const Size(375.0, 812.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 44.0,
    right: 0.0,
    bottom: 34.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 44.0,
    top: 0.0,
    right: 44.0,
    bottom: 21.0,
  ),
  framePainter: const _FramePainter(),
  screenPath: parseSvgPathData(
    'M203.851 63.8789C203.851 88.9158 224.074 109.212 249.151 109.212H621.848C646.925 109.212 667.148 88.9158 667.148 63.8789V51.5152C667.148 44.687 672.664 39.1516 679.503 39.1516H683.436C725.805 39.1516 746.989 39.1516 763.84 45.6754C789.255 55.5151 809.348 75.622 819.18 101.056C825.699 117.919 825.699 139.119 825.699 181.519V1586.48C825.699 1628.88 825.699 1650.08 819.18 1666.94C809.348 1692.38 789.255 1712.49 763.84 1722.32C747.437 1728.68 726.927 1728.84 686.766 1728.85C685.671 1728.85 684.561 1728.85 683.436 1728.85H187.563C186.438 1728.85 185.328 1728.85 184.233 1728.85C144.072 1728.84 123.562 1728.68 107.159 1722.32C81.7436 1712.49 61.6514 1692.38 51.8189 1666.94C45.2998 1650.08 45.2998 1628.88 45.2998 1586.48V181.519C45.2998 139.119 45.2998 117.919 51.8189 101.056C61.6514 75.622 81.7436 55.5151 107.159 45.6754C124.01 39.1516 145.194 39.1516 187.563 39.1516H191.496C198.335 39.1516 203.851 44.687 203.851 51.5152V63.8789Z',
  )..fillType = PathFillType.evenOdd,
);

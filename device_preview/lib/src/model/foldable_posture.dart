import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../../presets.dart';
import 'device_frame.dart';
import 'system_ui.dart';

/// Physical fold posture of a foldable device.
enum FoldablePosture {
  /// Inner display unfolded completely flat.
  open,

  /// Inner display partially folded (tabletop / book posture).
  halfOpen,

  /// Device folded shut, running on its outer cover display.
  folded,
}

/// Companion outer cover-screen presets for the built-in foldable devices.
abstract final class FoldableCoverSpecs {
  static const String _coverSuffix = '--cover';

  /// Whether [presetId] identifies a synthesized cover-screen preset.
  static bool isCoverId(String? presetId) =>
      presetId != null && presetId.endsWith(_coverSuffix);

  /// Base foldable preset id for a cover-screen [presetId], or [presetId]
  /// unchanged when it is not a cover id.
  static String? baseId(String? presetId) {
    if (presetId == null) {
      return null;
    }
    if (presetId.endsWith(_coverSuffix)) {
      return presetId.substring(0, presetId.length - _coverSuffix.length);
    }
    return presetId;
  }

  /// Returns the folded outer cover-screen [DevicePreset] for [foldable], or
  /// null if [foldable] is not a foldable device.
  static DevicePreset? coverFor(DevicePreset foldable) {
    if (foldable.kind != DeviceKind.foldable) {
      return null;
    }
    return switch (foldable.id) {
      'apple-iphone-duo' => _iPhoneDuoCover,
      'google-pixel-10-pro-fold' => _pixel10ProFoldCover,
      'samsung-galaxy-z-fold-8' => _galaxyZFold8Cover,
      'samsung-galaxy-z-fold-8-ultra' => _galaxyZFold8UltraCover,
      'samsung-galaxy-z-flip-8' => _galaxyZFlip8Cover,
      _ => _genericCoverFor(foldable),
    };
  }

  /// Apple iPhone Duo — 5.3" outer cover display (466 × 678 @ 3x) with
  /// titanium left hinge spine, asymmetric outer corners, and top-right camera
  /// pill cutout.
  static final DevicePreset _iPhoneDuoCover = DevicePreset(
    id: 'apple-iphone-duo$_coverSuffix',
    name: 'iPhone Duo (Cover)',
    brand: 'Apple',
    year: 2026,
    platform: TargetPlatform.iOS,
    kind: DeviceKind.foldable,
    portraitSize: const ui.Size(466, 678),
    devicePixelRatio: 3.0,
    portraitPadding: const EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: const EdgeInsets.only(left: 62, right: 62, bottom: 20),
    portraitKeyboardHeight: 290,
    landscapeKeyboardHeight: 198,
    frame: const DeviceFrame(
      size: ui.Size(514, 718),
      screenOffset: ui.Offset(28, 20),
      // Asymmetric screen outline: crisp 10pt corners along the left hinge
      // spine, 58pt Apple corners on the right edge, and top-right camera pill.
      screenPath:
          'M 10,0 H 408 A 58,58 0 0 1 466,58 V 620 A 58,58 0 0 1 408,678 '
          'H 10 A 10,10 0 0 1 0,668 V 10 A 10,10 0 0 1 10,0 Z '
          'M 418,19 A 19,19 0 1 0 418,57 A 19,19 0 1 0 418,19 Z',
      body:
          '<svg viewBox="0 0 514 718">\n'
          '  <g fill="#bdb6a8">\n'
          '    <rect x="230" y="0" width="32" height="4" rx="2"/>\n'
          '    <rect x="295" y="0" width="32" height="4" rx="2"/>\n'
          '    <rect x="510" y="195" width="4" height="88" rx="2"/>\n'
          '  </g>\n'
          '  <rect x="2" y="4" width="16" height="710" rx="6" fill="#9e978a"/>\n'
          '  <path d="M 14,2 H 434 A 78,78 0 0 1 512,80 V 638 A 78,78 0 0 1 434,716 H 14 A 10,10 0 0 1 4,706 V 12 A 10,10 0 0 1 14,2 Z" fill="#bdb6a8"/>\n'
          '  <path d="M 16,5 H 434 A 75,75 0 0 1 509,80 V 638 A 75,75 0 0 1 434,713 H 16 A 8,8 0 0 1 8,705 V 13 A 8,8 0 0 1 16,5 Z" fill="#2c2a27"/>\n'
          '  <path d="M 18,7 H 434 A 73,73 0 0 1 507,80 V 638 A 73,73 0 0 1 434,711 H 18 A 6,6 0 0 1 12,705 V 13 A 6,6 0 0 1 18,7 Z" fill="#0b0b0d"/>\n'
          '</svg>',
    ),
    systemUi: DevicePresets.iPhoneDuo.systemUi,
  );

  /// Google Pixel 10 Pro Fold — 6.3" Actua outer cover screen (411.43 × 923.43).
  static final DevicePreset _pixel10ProFoldCover = DevicePreset(
    id: 'google-pixel-10-pro-fold$_coverSuffix',
    name: 'Pixel 10 Pro Fold (Cover)',
    brand: 'Google',
    year: 2025,
    platform: TargetPlatform.android,
    kind: DeviceKind.foldable,
    portraitSize: DevicePresets.pixel10.portraitSize,
    devicePixelRatio: DevicePresets.pixel10.devicePixelRatio,
    portraitPadding: DevicePresets.pixel10.portraitPadding,
    landscapePadding: DevicePresets.pixel10.landscapePadding,
    portraitKeyboardHeight: DevicePresets.pixel10.portraitKeyboardHeight,
    landscapeKeyboardHeight: DevicePresets.pixel10.landscapeKeyboardHeight,
    frame: const DeviceFrame(
      size: ui.Size(459.05, 964.19),
      screenOffset: ui.Offset(28.48, 20.19),
      screenPath:
          'M 12,0 H 378.29 A 33.14,33.14 0 0 1 411.43,33.14 V 890.29 '
          'A 33.14,33.14 0 0 1 378.29,923.43 H 12 A 12,12 0 0 1 0,911.43 '
          'V 12 A 12,12 0 0 1 12,0 Z '
          'M 205.33,19.05 A 14.86,14.86 0 1 0 205.33,48.76 '
          'A 14.86,14.86 0 1 0 205.33,19.05 Z',
      body:
          '<svg viewBox="0 0 459.05 964.19">\n'
          '  <rect x="0" y="6" width="16" height="952.19" rx="6" fill="#5b6070"/>\n'
          '  <path d="M 10,0 H 404 A 55,55 0 0 1 459.05,55 V 909.19 A 55,55 0 0 1 404,964.19 H 10 A 8,8 0 0 1 2,956.19 V 8 A 8,8 0 0 1 10,0 Z" fill="#767b8c"/>\n'
          '  <path d="M 12,2 H 403 A 53,53 0 0 1 457.05,55 V 909.19 A 53,53 0 0 1 403,962.19 H 12 A 6,6 0 0 1 6,956.19 V 8 A 6,6 0 0 1 12,2 Z" fill="#060605"/>\n'
          '</svg>',
    ),
    systemUi: DevicePresets.pixel10ProFold.systemUi,
  );

  /// Samsung Galaxy Z Fold8 — 6.3" Dynamic AMOLED outer cover screen (384 × 915).
  static final DevicePreset _galaxyZFold8Cover = _buildSamsungBarCover(
    id: 'samsung-galaxy-z-fold-8$_coverSuffix',
    name: 'Galaxy Z Fold8 (Cover)',
    year: 2026,
    screenWidth: 384,
    screenHeight: 915,
    dpr: 2.625,
    systemUi: DevicePresets.galaxyZFold8.systemUi,
  );

  /// Samsung Galaxy Z Fold8 Ultra — 6.5" Dynamic AMOLED outer cover screen (412 × 915).
  static final DevicePreset _galaxyZFold8UltraCover = _buildSamsungBarCover(
    id: 'samsung-galaxy-z-fold-8-ultra$_coverSuffix',
    name: 'Galaxy Z Fold8 Ultra (Cover)',
    year: 2026,
    screenWidth: 412,
    screenHeight: 915,
    dpr: 2.625,
    systemUi: DevicePresets.galaxyZFold8Ultra.systemUi,
  );

  /// Samsung Galaxy Z Flip8 — 3.9" FlexWindow outer cover screen (360 × 382).
  static final DevicePreset _galaxyZFlip8Cover = DevicePreset(
    id: 'samsung-galaxy-z-flip-8$_coverSuffix',
    name: 'Galaxy Z Flip8 (Cover)',
    brand: 'Samsung',
    year: 2026,
    platform: TargetPlatform.android,
    kind: DeviceKind.foldable,
    portraitSize: const ui.Size(360, 382),
    devicePixelRatio: 3.0,
    portraitPadding: const EdgeInsets.only(top: 28, bottom: 16),
    landscapePadding: const EdgeInsets.only(top: 24, bottom: 16),
    portraitKeyboardHeight: 170,
    landscapeKeyboardHeight: 150,
    frame: const DeviceFrame(
      size: ui.Size(396, 444),
      screenOffset: ui.Offset(18, 18),
      // Folder-tab FlexWindow cutout around the dual camera lenses at bottom-right.
      screenPath:
          'M 22,0 H 338 A 22,22 0 0 1 360,22 V 316 '
          'A 18,18 0 0 1 342,334 H 236 A 18,18 0 0 0 218,352 V 364 '
          'A 18,18 0 0 1 200,382 H 22 A 22,22 0 0 1 0,360 V 22 '
          'A 22,22 0 0 1 22,0 Z',
      body:
          '<svg viewBox="0 0 396 444">\n'
          '  <rect x="10" y="434" width="376" height="10" rx="4" fill="#2e323a"/>\n'
          '  <rect x="4" y="0" width="388" height="438" rx="36" fill="#1f2126"/>\n'
          '  <rect x="6" y="2" width="384" height="434" rx="34" fill="#3d4149"/>\n'
          '  <rect x="8" y="4" width="380" height="430" rx="32" fill="#08090b"/>\n'
          '  <circle cx="282" cy="386" r="21" fill="#1f2126"/>\n'
          '  <circle cx="282" cy="386" r="16" fill="#0d111a"/>\n'
          '  <circle cx="336" cy="386" r="21" fill="#1f2126"/>\n'
          '  <circle cx="336" cy="386" r="16" fill="#0d111a"/>\n'
          '  <circle cx="370" cy="386" r="5" fill="#d8d4c8"/>\n'
          '</svg>',
    ),
    systemUi: DevicePresets.galaxyZFlip8.systemUi,
  );

  static DevicePreset _buildSamsungBarCover({
    required String id,
    required String name,
    required int year,
    required double screenWidth,
    required double screenHeight,
    required double dpr,
    required SystemUiSimulation? systemUi,
  }) {
    final double frameWidth = screenWidth + 40;
    final double frameHeight = screenHeight + 38;
    final double cx = screenWidth / 2;
    return DevicePreset(
      id: id,
      name: name,
      brand: 'Samsung',
      year: year,
      platform: TargetPlatform.android,
      kind: DeviceKind.foldable,
      portraitSize: ui.Size(screenWidth, screenHeight),
      devicePixelRatio: dpr,
      portraitPadding: const EdgeInsets.only(top: 38, bottom: 24),
      landscapePadding: const EdgeInsets.only(top: 32, bottom: 24),
      portraitKeyboardHeight: 336,
      landscapeKeyboardHeight: 252,
      frame: DeviceFrame(
        size: ui.Size(frameWidth, frameHeight),
        screenOffset: const ui.Offset(22, 19),
        screenPath:
            'M 10,0 H ${screenWidth - 18} A 18,18 0 0 1 $screenWidth,18 '
            'V ${screenHeight - 18} A 18,18 0 0 1 ${screenWidth - 18},$screenHeight '
            'H 10 A 10,10 0 0 1 0,${screenHeight - 10} V 10 A 10,10 0 0 1 10,0 Z '
            'M $cx,12 A 9,9 0 1 0 $cx,30 A 9,9 0 1 0 $cx,12 Z',
        body:
            '<svg viewBox="0 0 $frameWidth $frameHeight">\n'
            '  <rect x="0" y="6" width="14" height="${frameHeight - 12}" rx="4" fill="#2e323a"/>\n'
            '  <rect x="4" y="0" width="${frameWidth - 8}" height="$frameHeight" rx="28" fill="#1f2126"/>\n'
            '  <rect x="6" y="2" width="${frameWidth - 12}" height="${frameHeight - 4}" rx="26" fill="#3d4149"/>\n'
            '  <rect x="8" y="4" width="${frameWidth - 16}" height="${frameHeight - 8}" rx="24" fill="#08090b"/>\n'
            '</svg>',
      ),
      systemUi: systemUi,
    );
  }

  static DevicePreset _genericCoverFor(DevicePreset foldable) {
    final bool horizontalCrease =
        foldable.displayFeatures.isNotEmpty &&
        foldable.displayFeatures.first.bounds.width >
            foldable.displayFeatures.first.bounds.height;
    final ui.Size coverSize = horizontalCrease
        ? ui.Size(foldable.portraitSize.width, foldable.portraitSize.height / 2)
        : ui.Size(
            foldable.portraitSize.width / 2,
            foldable.portraitSize.height,
          );
    return DevicePreset(
      id: '${foldable.id}$_coverSuffix',
      name: '${foldable.name} (Cover)',
      brand: foldable.brand,
      year: foldable.year,
      platform: foldable.platform,
      kind: DeviceKind.foldable,
      portraitSize: coverSize,
      devicePixelRatio: foldable.devicePixelRatio,
      portraitPadding: foldable.portraitPadding,
      landscapePadding: foldable.landscapePadding,
      portraitKeyboardHeight: foldable.portraitKeyboardHeight,
      landscapeKeyboardHeight: foldable.landscapeKeyboardHeight,
      systemUi: foldable.systemUi,
    );
  }
}

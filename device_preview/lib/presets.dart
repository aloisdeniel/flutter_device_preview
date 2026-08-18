/// Built-in device presets for `package:device_preview`.
///
/// A separate library so that unreferenced presets tree-shake away from apps
/// that never import it.
library;

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'src/model/device_frame.dart';
import 'src/model/device_kind.dart';
import 'src/model/json_utils.dart';
import 'src/model/simulation.dart';
import 'src/model/system_ui.dart';

export 'src/model/device_kind.dart';
export 'src/model/simulation.dart' show SimulatedDisplayFeature;

/// Description of a device: its metrics, and optionally the [frame] it is
/// drawn in.
///
/// Metric fields are expressed for the portrait orientation; landscape
/// values are either provided explicitly or derived by the documented
/// rotation rule (see [rotateToLandscape]).
///
/// The built-in [DevicePresets] are metrics-only — no artwork ships in the
/// package. Frames come from the device spec catalog of the DevTools
/// extension (`device_specs/` at the root of the repository), which pushes
/// them over the simulation protocol; [fromJson] decodes exactly that
/// catalog format, so a spec file can also be loaded directly by an app that
/// wants a framed golden test.
@immutable
class DevicePreset {
  /// Creates a device preset.
  const DevicePreset({
    required this.id,
    required this.name,
    required this.platform,
    required this.portraitSize,
    required this.devicePixelRatio,
    this.brand,
    this.year,
    this.frame,
    this.systemUi,
    this.portraitPadding = EdgeInsets.zero,
    this.portraitViewPadding,
    this.landscapePadding,
    this.landscapeViewPadding,
    this.systemGestureInsets = EdgeInsets.zero,
    this.displayFeatures = const <SimulatedDisplayFeature>[],
    this.kind = DeviceKind.phone,
  });

  /// Decodes a preset from the JSON produced by [toJson].
  ///
  /// Unknown keys are ignored; missing required keys or malformed values
  /// throw a [FormatException].
  factory DevicePreset.fromJson(Map<String, Object?> json) {
    return DevicePreset(
      id: decodeString(json['id'], 'id'),
      name: decodeString(json['name'], 'name'),
      brand: json['brand'] == null
          ? null
          : decodeString(json['brand'], 'brand'),
      year: json['year'] == null ? null : decodeInt(json['year'], 'year'),
      platform: decodeEnum(json['platform'], TargetPlatform.values, 'platform'),
      frame: json['frame'] == null
          ? null
          : DeviceFrame.fromJson(decodeMap(json['frame'], 'frame')),
      systemUi: json['systemUi'] == null
          ? null
          : SystemUiSimulation.fromJson(decodeMap(json['systemUi'], 'systemUi')),
      portraitSize: decodeSize(json['portraitSize'], 'portraitSize'),
      devicePixelRatio: decodeDouble(
        json['devicePixelRatio'],
        'devicePixelRatio',
      ),
      portraitPadding: json['portraitPadding'] == null
          ? EdgeInsets.zero
          : decodeEdgeInsets(json['portraitPadding'], 'portraitPadding'),
      portraitViewPadding: json['portraitViewPadding'] == null
          ? null
          : decodeEdgeInsets(
              json['portraitViewPadding'],
              'portraitViewPadding',
            ),
      landscapePadding: json['landscapePadding'] == null
          ? null
          : decodeEdgeInsets(json['landscapePadding'], 'landscapePadding'),
      landscapeViewPadding: json['landscapeViewPadding'] == null
          ? null
          : decodeEdgeInsets(
              json['landscapeViewPadding'],
              'landscapeViewPadding',
            ),
      systemGestureInsets: json['systemGestureInsets'] == null
          ? EdgeInsets.zero
          : decodeEdgeInsets(
              json['systemGestureInsets'],
              'systemGestureInsets',
            ),
      displayFeatures: json['displayFeatures'] == null
          ? const <SimulatedDisplayFeature>[]
          : List<SimulatedDisplayFeature>.unmodifiable(
              decodeList(json['displayFeatures'], 'displayFeatures').map(
                (Object? e) => SimulatedDisplayFeature.fromJson(
                  decodeMap(e, 'displayFeatures[]'),
                ),
              ),
            ),
      kind: json['kind'] == null
          ? DeviceKind.phone
          : decodeEnum(json['kind'], DeviceKind.values, 'kind'),
    );
  }

  /// Stable identifier, e.g. `'apple-iphone-16-pro'`.
  final String id;

  /// Human-readable name, e.g. `'iPhone 16 Pro'`.
  final String name;

  /// The manufacturer, e.g. `'Apple'`. Null when unspecified.
  final String? brand;

  /// The year the device was released, e.g. `2025`. Null when unspecified.
  ///
  /// Purely informational — nothing in the simulation depends on it. The
  /// DevTools picker shows it so that a catalog spanning several generations
  /// can be read at a glance.
  final int? year;

  /// The platform of the device.
  final TargetPlatform platform;

  /// The device's screen outline and body artwork, or null for a plain
  /// rectangular screen with no artwork.
  final DeviceFrame? frame;

  /// The device's decorative system UI (status bar, gesture pill), or null
  /// to leave the screen bare.
  final SystemUiSimulation? systemUi;

  /// The logical screen size in portrait orientation.
  ///
  /// Desktop presets use their natural window dimensions here (typically
  /// wider than tall).
  final ui.Size portraitSize;

  /// The device pixel ratio.
  final double devicePixelRatio;

  /// The portrait safe-area padding, in logical pixels.
  final EdgeInsets portraitPadding;

  /// The portrait view padding; defaults to [portraitPadding] when null.
  final EdgeInsets? portraitViewPadding;

  /// The landscape safe-area padding; when null, derived from
  /// [portraitPadding] by the rotation rule ([rotateToLandscape]).
  final EdgeInsets? landscapePadding;

  /// The landscape view padding; when null, follows [landscapePadding], or
  /// the rotation rule applied to the effective portrait view padding.
  final EdgeInsets? landscapeViewPadding;

  /// The system gesture insets, in logical pixels.
  final EdgeInsets systemGestureInsets;

  /// Display features (folds, hinges, cutouts), in portrait logical pixels.
  final List<SimulatedDisplayFeature> displayFeatures;

  /// The broad category of the device.
  final DeviceKind kind;

  /// The documented rotation rule for deriving landscape safe areas from
  /// portrait ones:
  ///
  /// ```
  /// landscape = EdgeInsets.only(
  ///   left: portrait.top, right: portrait.top, bottom: portrait.bottom)
  /// ```
  ///
  /// The notch/status area is mirrored to both sides and the home indicator
  /// is kept at the bottom.
  static EdgeInsets rotateToLandscape(EdgeInsets portrait) => EdgeInsets.only(
    left: portrait.top,
    right: portrait.top,
    bottom: portrait.bottom,
  );

  /// Resolves this preset into a metrics-only [DeviceSimulation] with
  /// [DeviceSimulation.presetId] set.
  ///
  /// For [Orientation.landscape], the screen dimensions are swapped and the
  /// preset's explicit landscape safe areas are used when available;
  /// otherwise they are derived by [rotateToLandscape]. Display features
  /// (expressed in portrait coordinates) are mapped through the 90° rotation
  /// ([SimulatedDisplayFeature.rotatedToLandscape]) so hinge/fold geometry
  /// stays physically correct. [systemGestureInsets] intentionally pass
  /// through unrotated: their edge semantics (back-gesture side edges, home
  /// area at the bottom) are orientation-invariant on real devices.
  DeviceSimulation resolve({Orientation orientation = Orientation.portrait}) {
    final EdgeInsets effectivePortraitViewPadding =
        portraitViewPadding ?? portraitPadding;
    if (orientation == Orientation.portrait) {
      return DeviceSimulation(
        presetId: id,
        deviceKind: kind,
        screenSize: portraitSize,
        frame: frame,
        systemUi: systemUi,
        devicePixelRatio: devicePixelRatio,
        padding: portraitPadding,
        viewPadding: effectivePortraitViewPadding,
        systemGestureInsets: systemGestureInsets,
        displayFeatures: displayFeatures.isEmpty ? null : displayFeatures,
      );
    }
    final EdgeInsets resolvedLandscapePadding =
        landscapePadding ?? rotateToLandscape(portraitPadding);
    final EdgeInsets resolvedLandscapeViewPadding =
        landscapeViewPadding ??
        landscapePadding ??
        rotateToLandscape(effectivePortraitViewPadding);
    return DeviceSimulation(
      presetId: id,
      deviceKind: kind,
      orientation: Orientation.landscape,
      screenSize: ui.Size(portraitSize.height, portraitSize.width),
      // Frames are described in portrait and rotated at paint time.
      frame: frame,
      // System bars follow the safe areas, which resolve() already rotated.
      systemUi: systemUi,
      devicePixelRatio: devicePixelRatio,
      padding: resolvedLandscapePadding,
      viewPadding: resolvedLandscapeViewPadding,
      systemGestureInsets: systemGestureInsets,
      displayFeatures: displayFeatures.isEmpty
          ? null
          : List<SimulatedDisplayFeature>.unmodifiable(
              displayFeatures.map(
                (SimulatedDisplayFeature feature) =>
                    feature.rotatedToLandscape(portraitSize.width),
              ),
            ),
    );
  }

  /// Encodes this preset as JSON. Null fields are absent.
  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'name': name,
    if (brand != null) 'brand': brand,
    if (year != null) 'year': year,
    'platform': platform.name,
    'kind': kind.name,
    'portraitSize': encodeSize(portraitSize),
    if (frame != null) 'frame': frame!.toJson(),
    if (systemUi != null) 'systemUi': systemUi!.toJson(),
    'devicePixelRatio': devicePixelRatio,
    'portraitPadding': encodeEdgeInsets(portraitPadding),
    if (portraitViewPadding != null)
      'portraitViewPadding': encodeEdgeInsets(portraitViewPadding!),
    if (landscapePadding != null)
      'landscapePadding': encodeEdgeInsets(landscapePadding!),
    if (landscapeViewPadding != null)
      'landscapeViewPadding': encodeEdgeInsets(landscapeViewPadding!),
    'systemGestureInsets': encodeEdgeInsets(systemGestureInsets),
    if (displayFeatures.isNotEmpty)
      'displayFeatures': displayFeatures
          .map((SimulatedDisplayFeature f) => f.toJson())
          .toList(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DevicePreset &&
        other.id == id &&
        other.name == name &&
        other.brand == brand &&
        other.year == year &&
        other.platform == platform &&
        other.frame == frame &&
        other.systemUi == systemUi &&
        other.portraitSize == portraitSize &&
        other.devicePixelRatio == devicePixelRatio &&
        other.portraitPadding == portraitPadding &&
        other.portraitViewPadding == portraitViewPadding &&
        other.landscapePadding == landscapePadding &&
        other.landscapeViewPadding == landscapeViewPadding &&
        other.systemGestureInsets == systemGestureInsets &&
        listEquals(other.displayFeatures, displayFeatures) &&
        other.kind == kind;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    brand,
    year,
    platform,
    frame,
    systemUi,
    portraitSize,
    devicePixelRatio,
    portraitPadding,
    portraitViewPadding,
    landscapePadding,
    landscapeViewPadding,
    systemGestureInsets,
    Object.hashAll(displayFeatures),
    kind,
  );

  @override
  String toString() => 'DevicePreset($id, $name)';
}

/// The built-in device preset catalog.
///
/// Static const entries: unreferenced presets tree-shake away. Metrics are
/// logical pixels; iOS landscape insets follow real UIKit behavior
/// (notch/island mirrored to the sides, 21px home indicator).
abstract final class DevicePresets {
  /// iPhone 16 — Dynamic Island.
  static const DevicePreset iPhone16 = DevicePreset(
    id: 'apple-iphone-16',
    name: 'iPhone 16',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(393, 852),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 59, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 59, right: 59, bottom: 20),
  );

  /// iPhone 16 Pro — Dynamic Island.
  static const DevicePreset iPhone16Pro = DevicePreset(
    id: 'apple-iphone-16-pro',
    name: 'iPhone 16 Pro',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(402, 874),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 20),
  );

  /// iPhone 16 Pro Max — Dynamic Island.
  static const DevicePreset iPhone16ProMax = DevicePreset(
    id: 'apple-iphone-16-pro-max',
    name: 'iPhone 16 Pro Max',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(440, 956),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 20),
  );

  /// iPhone 16 Plus — Dynamic Island, 6.7" display.
  static const DevicePreset iPhone16Plus = DevicePreset(
    id: 'apple-iphone-16-plus',
    name: 'iPhone 16 Plus',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(430, 932),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 59, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 59, right: 59, bottom: 20),
  );

  /// iPhone 16e — notch, the 6.1" entry model.
  static const DevicePreset iPhone16e = DevicePreset(
    id: 'apple-iphone-16e',
    name: 'iPhone 16e',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(390, 844),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 47, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 47, right: 47, bottom: 20),
  );

  /// iPhone 17e — notch, the 6.1" entry model.
  static const DevicePreset iPhone17e = DevicePreset(
    id: 'apple-iphone-17e',
    name: 'iPhone 17e',
    brand: 'Apple',
    year: 2026,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(390, 844),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 47, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 47, right: 47, bottom: 20),
  );

  /// iPhone 17 — Dynamic Island, 6.3" display.
  static const DevicePreset iPhone17 = DevicePreset(
    id: 'apple-iphone-17',
    name: 'iPhone 17',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(402, 874),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 20),
  );

  /// iPhone 17 Pro — Dynamic Island, 6.3" display.
  static const DevicePreset iPhone17Pro = DevicePreset(
    id: 'apple-iphone-17-pro',
    name: 'iPhone 17 Pro',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(402, 874),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 20),
  );

  /// iPhone Air — Dynamic Island, 6.5" display.
  static const DevicePreset iPhoneAir = DevicePreset(
    id: 'apple-iphone-air',
    name: 'iPhone Air',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(420, 912),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 68, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 68, right: 68, bottom: 20),
  );

  /// iPad Pro 13" (M4).
  static const DevicePreset iPadPro13 = DevicePreset(
    id: 'apple-ipad-pro-13',
    name: 'iPad Pro 13"',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(1032, 1376),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 32, bottom: 25),
    landscapePadding: EdgeInsets.only(top: 32, bottom: 25),
    kind: DeviceKind.tablet,
  );

  /// iPad Pro 11" (M4).
  static const DevicePreset iPadPro11 = DevicePreset(
    id: 'apple-ipad-pro-11',
    name: 'iPad Pro 11"',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(834, 1210),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 32, bottom: 25),
    landscapePadding: EdgeInsets.only(top: 32, bottom: 25),
    kind: DeviceKind.tablet,
  );

  /// iPad Air 13" (M3).
  static const DevicePreset iPadAir13 = DevicePreset(
    id: 'apple-ipad-air-13',
    name: 'iPad Air 13"',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(1024, 1366),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 32, bottom: 25),
    landscapePadding: EdgeInsets.only(top: 32, bottom: 25),
    kind: DeviceKind.tablet,
  );

  /// iPad Air 11" (M3).
  static const DevicePreset iPadAir11 = DevicePreset(
    id: 'apple-ipad-air-11',
    name: 'iPad Air 11"',
    brand: 'Apple',
    year: 2025,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(820, 1180),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 32, bottom: 25),
    landscapePadding: EdgeInsets.only(top: 32, bottom: 25),
    kind: DeviceKind.tablet,
  );

  /// iPad mini (6th/7th generation).
  static const DevicePreset iPadMini = DevicePreset(
    id: 'apple-ipad-mini',
    name: 'iPad mini',
    brand: 'Apple',
    year: 2024,
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(744, 1133),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 32, bottom: 25),
    landscapePadding: EdgeInsets.only(top: 32, bottom: 25),
    kind: DeviceKind.tablet,
  );

  /// Google Pixel 9 — gesture navigation.
  static const DevicePreset pixel9 = DevicePreset(
    id: 'google-pixel-9',
    name: 'Pixel 9',
    brand: 'Google',
    year: 2024,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(411.43, 923.43),
    devicePixelRatio: 2.625,
    portraitPadding: EdgeInsets.only(top: 54, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 52, bottom: 24),
  );

  /// Google Pixel 10 — gesture navigation.
  static const DevicePreset pixel10 = DevicePreset(
    id: 'google-pixel-10',
    name: 'Pixel 10',
    brand: 'Google',
    year: 2025,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(411.43, 923.43),
    devicePixelRatio: 2.625,
    portraitPadding: EdgeInsets.only(top: 54, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 52, bottom: 24),
  );

  /// Google Pixel 10 Pro Fold — 8" inner display, book-style fold with a
  /// vertical crease at mid-width.
  static const DevicePreset pixel10ProFold = DevicePreset(
    id: 'google-pixel-10-pro-fold',
    name: 'Pixel 10 Pro Fold',
    brand: 'Google',
    year: 2025,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(851.69, 882.87),
    devicePixelRatio: 2.4375,
    portraitPadding: EdgeInsets.only(top: 36, bottom: 32),
    landscapePadding: EdgeInsets.only(top: 56, bottom: 32),
    displayFeatures: <SimulatedDisplayFeature>[
      SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(425.845, 0, 425.845, 882.87),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ],
    kind: DeviceKind.foldable,
  );

  /// Samsung Galaxy S24 — punch-hole, gesture navigation.
  static const DevicePreset galaxyS24 = DevicePreset(
    id: 'samsung-galaxy-s24',
    name: 'Galaxy S24',
    brand: 'Samsung',
    year: 2024,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(360, 780),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
  );

  /// Samsung Galaxy S25 — punch-hole, gesture navigation.
  static const DevicePreset galaxyS25 = DevicePreset(
    id: 'samsung-galaxy-s25',
    name: 'Galaxy S25',
    brand: 'Samsung',
    year: 2025,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(360, 780),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
  );

  /// Samsung Galaxy Z Flip8 — clamshell fold, horizontal crease at
  /// mid-height.
  static const DevicePreset galaxyZFlip8 = DevicePreset(
    id: 'samsung-galaxy-z-flip-8',
    name: 'Galaxy Z Flip8',
    brand: 'Samsung',
    year: 2026,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(360, 840),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    displayFeatures: <SimulatedDisplayFeature>[
      SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(0, 420, 360, 420),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ],
    kind: DeviceKind.foldable,
  );

  /// Samsung Galaxy Z Fold8 — 7.6" inner display; the wide-format fold
  /// opens vertically, so the crease is horizontal at mid-height.
  static const DevicePreset galaxyZFold8 = DevicePreset(
    id: 'samsung-galaxy-z-fold-8',
    name: 'Galaxy Z Fold8',
    brand: 'Samsung',
    year: 2026,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(731, 979),
    devicePixelRatio: 2.5,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    displayFeatures: <SimulatedDisplayFeature>[
      SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(0, 489.5, 731, 489.5),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ],
    kind: DeviceKind.foldable,
  );

  /// Samsung Galaxy Z Fold8 Ultra — 8" inner display, book-style fold with
  /// a vertical crease at mid-width.
  static const DevicePreset galaxyZFold8Ultra = DevicePreset(
    id: 'samsung-galaxy-z-fold-8-ultra',
    name: 'Galaxy Z Fold8 Ultra',
    brand: 'Samsung',
    year: 2026,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(860, 954),
    devicePixelRatio: 2.625,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    displayFeatures: <SimulatedDisplayFeature>[
      SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(430, 0, 430, 954),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ],
    kind: DeviceKind.foldable,
  );

  /// Samsung Galaxy Tab S10+.
  static const DevicePreset galaxyTabS10Plus = DevicePreset(
    id: 'samsung-galaxy-tab-s10-plus',
    name: 'Galaxy Tab S10+',
    brand: 'Samsung',
    year: 2024,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(876, 1400),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    kind: DeviceKind.tablet,
  );

  /// Samsung Galaxy Tab S11.
  static const DevicePreset galaxyTabS11 = DevicePreset(
    id: 'samsung-galaxy-tab-s11',
    name: 'Galaxy Tab S11',
    brand: 'Samsung',
    year: 2025,
    platform: TargetPlatform.android,
    portraitSize: ui.Size(800, 1280),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    kind: DeviceKind.tablet,
  );

  /// A small desktop window: 1024×640 at 1x.
  static const DevicePreset smallDesktopWindow = DevicePreset(
    id: 'desktop-small',
    name: 'Small Desktop Window',
    brand: 'Generic',
    platform: TargetPlatform.windows,
    portraitSize: ui.Size(1024, 640),
    devicePixelRatio: 1.0,
    kind: DeviceKind.desktop,
  );

  /// A large desktop window: 1920×1080 at 2x.
  static const DevicePreset largeDesktopWindow = DevicePreset(
    id: 'desktop-large',
    name: 'Large Desktop Window',
    brand: 'Generic',
    platform: TargetPlatform.macOS,
    portraitSize: ui.Size(1920, 1080),
    devicePixelRatio: 2.0,
    kind: DeviceKind.desktop,
  );

  /// All built-in presets.
  static const List<DevicePreset> all = <DevicePreset>[
    iPhone16,
    iPhone16Plus,
    iPhone16Pro,
    iPhone16ProMax,
    iPhone16e,
    iPhone17e,
    iPhone17,
    iPhone17Pro,
    iPhoneAir,
    iPadPro13,
    iPadPro11,
    iPadAir13,
    iPadAir11,
    iPadMini,
    pixel9,
    pixel10,
    pixel10ProFold,
    galaxyS24,
    galaxyS25,
    galaxyZFlip8,
    galaxyZFold8,
    galaxyZFold8Ultra,
    galaxyTabS10Plus,
    galaxyTabS11,
    smallDesktopWindow,
    largeDesktopWindow,
  ];

  /// Returns the built-in preset with the given [id], or null.
  static DevicePreset? byId(String id) {
    for (final DevicePreset preset in all) {
      if (preset.id == id) {
        return preset;
      }
    }
    return null;
  }
}

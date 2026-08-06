/// Built-in device presets for `package:device_preview`.
///
/// A separate library so that unreferenced presets tree-shake away from apps
/// that never import it.
library;

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'src/model/json_utils.dart';
import 'src/model/simulation.dart';

/// The broad category of a device preset.
enum DeviceKind {
  /// A phone-sized device.
  phone,

  /// A tablet-sized device.
  tablet,

  /// A foldable device.
  foldable,

  /// A desktop window.
  desktop,
}

/// Metrics-only description of a device. No frame artwork, no images.
///
/// Metric fields are expressed for the portrait orientation; landscape
/// values are either provided explicitly or derived by the documented
/// rotation rule (see [rotateToLandscape]).
@immutable
class DevicePreset {
  /// Creates a device preset.
  const DevicePreset({
    required this.id,
    required this.name,
    required this.platform,
    required this.portraitSize,
    required this.devicePixelRatio,
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
      platform: decodeEnum(json['platform'], TargetPlatform.values, 'platform'),
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

  /// The platform of the device.
  final TargetPlatform platform;

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
        screenSize: portraitSize,
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
      orientation: Orientation.landscape,
      screenSize: ui.Size(portraitSize.height, portraitSize.width),
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
    'platform': platform.name,
    'kind': kind.name,
    'portraitSize': encodeSize(portraitSize),
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
        other.platform == platform &&
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
    platform,
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
  /// iPhone SE (3rd generation) — home button, status bar hidden in
  /// landscape.
  static const DevicePreset iPhoneSe3 = DevicePreset(
    id: 'apple-iphone-se-3',
    name: 'iPhone SE (3rd gen)',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(375, 667),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 20),
    landscapePadding: EdgeInsets.zero,
    landscapeViewPadding: EdgeInsets.zero,
  );

  /// iPhone 16 — Dynamic Island.
  static const DevicePreset iPhone16 = DevicePreset(
    id: 'apple-iphone-16',
    name: 'iPhone 16',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(393, 852),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 59, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 59, right: 59, bottom: 21),
  );

  /// iPhone 16 Pro — Dynamic Island.
  static const DevicePreset iPhone16Pro = DevicePreset(
    id: 'apple-iphone-16-pro',
    name: 'iPhone 16 Pro',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(402, 874),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 21),
  );

  /// iPhone 16 Pro Max — Dynamic Island.
  static const DevicePreset iPhone16ProMax = DevicePreset(
    id: 'apple-iphone-16-pro-max',
    name: 'iPhone 16 Pro Max',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(440, 956),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 62, bottom: 34),
    landscapePadding: EdgeInsets.only(left: 62, right: 62, bottom: 21),
  );

  /// iPad Pro 13" (M4).
  static const DevicePreset iPadPro13 = DevicePreset(
    id: 'apple-ipad-pro-13',
    name: 'iPad Pro 13"',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(1032, 1376),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 20),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 20),
    kind: DeviceKind.tablet,
  );

  /// iPad mini (6th/7th generation).
  static const DevicePreset iPadMini = DevicePreset(
    id: 'apple-ipad-mini',
    name: 'iPad mini',
    platform: TargetPlatform.iOS,
    portraitSize: ui.Size(744, 1133),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 20),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 20),
    kind: DeviceKind.tablet,
  );

  /// Google Pixel 8 — gesture navigation.
  static const DevicePreset pixel8 = DevicePreset(
    id: 'google-pixel-8',
    name: 'Pixel 8',
    platform: TargetPlatform.android,
    portraitSize: ui.Size(412, 915),
    devicePixelRatio: 2.625,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
  );

  /// Google Pixel 9 — gesture navigation.
  static const DevicePreset pixel9 = DevicePreset(
    id: 'google-pixel-9',
    name: 'Pixel 9',
    platform: TargetPlatform.android,
    portraitSize: ui.Size(412, 923),
    devicePixelRatio: 2.625,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
  );

  /// Google Pixel Tablet.
  static const DevicePreset pixelTablet = DevicePreset(
    id: 'google-pixel-tablet',
    name: 'Pixel Tablet',
    platform: TargetPlatform.android,
    portraitSize: ui.Size(800, 1280),
    devicePixelRatio: 2.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
    kind: DeviceKind.tablet,
  );

  /// Samsung Galaxy S24 — punch-hole, gesture navigation.
  static const DevicePreset galaxyS24 = DevicePreset(
    id: 'samsung-galaxy-s24',
    name: 'Galaxy S24',
    platform: TargetPlatform.android,
    portraitSize: ui.Size(360, 780),
    devicePixelRatio: 3.0,
    portraitPadding: EdgeInsets.only(top: 24, bottom: 24),
    landscapePadding: EdgeInsets.only(top: 24, bottom: 24),
  );

  /// A small desktop window: 1024×640 at 1x.
  static const DevicePreset smallDesktopWindow = DevicePreset(
    id: 'desktop-small',
    name: 'Small Desktop Window',
    platform: TargetPlatform.windows,
    portraitSize: ui.Size(1024, 640),
    devicePixelRatio: 1.0,
    kind: DeviceKind.desktop,
  );

  /// A large desktop window: 1920×1080 at 2x.
  static const DevicePreset largeDesktopWindow = DevicePreset(
    id: 'desktop-large',
    name: 'Large Desktop Window',
    platform: TargetPlatform.macOS,
    portraitSize: ui.Size(1920, 1080),
    devicePixelRatio: 2.0,
    kind: DeviceKind.desktop,
  );

  /// All built-in presets.
  static const List<DevicePreset> all = <DevicePreset>[
    iPhoneSe3,
    iPhone16,
    iPhone16Pro,
    iPhone16ProMax,
    iPadPro13,
    iPadMini,
    pixel8,
    pixel9,
    pixelTablet,
    galaxyS24,
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

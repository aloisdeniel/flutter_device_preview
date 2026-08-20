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

part 'src/presets.g.dart';

/// Description of a device: its metrics, and optionally the [frame] it is
/// drawn in.
///
/// Metric fields are expressed for the portrait orientation; landscape
/// values are either provided explicitly or derived by the documented
/// rotation rule (see [rotateToLandscape]).
///
/// The built-in [DevicePresets] carry the complete spec — [frame] artwork
/// and [systemUi] included. They are generated from the device spec catalog
/// shared with the DevTools extension (`device_specs/` at the root of the
/// repository); [fromJson] decodes exactly that catalog format, so a spec
/// file can also be loaded directly by an app that wants a framed golden
/// test.
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
    final TargetPlatform platform = decodeEnum(
      json['platform'],
      TargetPlatform.values,
      'platform',
    );
    // Bars that do not name their platform get the device's: paint-time
    // behavior (Android tints bar backgrounds, iOS never does) must follow
    // the simulated device, not the app's host. Specs in `device_specs/`
    // rely on this — they never repeat the platform inside `systemUi`.
    SystemUiSimulation? systemUi = json['systemUi'] == null
        ? null
        : SystemUiSimulation.fromJson(decodeMap(json['systemUi'], 'systemUi'));
    if (systemUi != null && systemUi.platform == null) {
      systemUi = SystemUiSimulation(
        statusBar: systemUi.statusBar,
        navigationBar: systemUi.navigationBar,
        platform: platform,
      );
    }
    return DevicePreset(
      id: decodeString(json['id'], 'id'),
      name: decodeString(json['name'], 'name'),
      brand: json['brand'] == null
          ? null
          : decodeString(json['brand'], 'brand'),
      year: json['year'] == null ? null : decodeInt(json['year'], 'year'),
      platform: platform,
      frame: json['frame'] == null
          ? null
          : DeviceFrame.fromJson(decodeMap(json['frame'], 'frame')),
      systemUi: systemUi,
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
    // The bars belong to the simulated device's operating system: stamp the
    // preset's platform so paint-time behavior (Android tints the bar
    // backgrounds from the app's `SystemUiOverlayStyle`, iOS never does)
    // follows the device rather than the host the app runs on.
    final SystemUiSimulation? resolvedSystemUi = systemUi == null
        ? null
        : (systemUi!.platform != null
              ? systemUi
              : SystemUiSimulation(
                  statusBar: systemUi!.statusBar,
                  navigationBar: systemUi!.navigationBar,
                  platform: platform,
                ));
    if (orientation == Orientation.portrait) {
      return DeviceSimulation(
        presetId: id,
        deviceKind: kind,
        screenSize: portraitSize,
        frame: frame,
        systemUi: resolvedSystemUi,
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
      systemUi: resolvedSystemUi,
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

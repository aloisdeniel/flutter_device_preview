import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presets.dart';
import '../model/foldable_posture.dart';
import '../model/simulation.dart';

const String _kPanelPrefsKey = 'device_preview.in_app_panel.v1';

/// Persisted snapshot of the in-app Device Preview panel settings across
/// debug sessions.
class InAppPanelPreferences {
  const InAppPanelPreferences({
    required this.isExpanded,
    required this.isLightBackground,
    required this.lastPresetId,
    required this.simulatesMetrics,
    this.activePresetId,
    this.foldPosture = FoldablePosture.open,
    this.orientation = Orientation.portrait,
    this.showSystemUi = true,
    this.keyboardVisible = false,
    this.touchInput,
    this.platformBrightness,
    this.textScaleFactor,
    this.targetPlatform,
    this.accessibility,
  });

  factory InAppPanelPreferences.fromJson(Map<String, Object?> json) {
    T? enumOrNull<T extends Enum>(Object? raw, List<T> values) {
      if (raw is! String) {
        return null;
      }
      for (final T v in values) {
        if (v.name == raw) {
          return v;
        }
      }
      return null;
    }

    final Object? rawA11y = json['accessibility'];
    SimulatedAccessibilityFeatures? a11y;
    if (rawA11y is Map) {
      try {
        a11y = SimulatedAccessibilityFeatures.fromJson(
          Map<String, Object?>.from(rawA11y),
        );
      } on FormatException {
        a11y = null;
      }
    }

    return InAppPanelPreferences(
      isExpanded: json['isExpanded'] as bool? ?? true,
      isLightBackground: json['isLightBackground'] as bool? ?? false,
      lastPresetId:
          json['lastPresetId'] as String? ?? DevicePresets.iPhone17Pro.id,
      simulatesMetrics: json['simulatesMetrics'] as bool? ?? true,
      activePresetId: json['activePresetId'] as String?,
      foldPosture:
          enumOrNull(json['foldPosture'], FoldablePosture.values) ??
          FoldablePosture.open,
      orientation:
          enumOrNull(json['orientation'], Orientation.values) ??
          Orientation.portrait,
      showSystemUi: json['showSystemUi'] as bool? ?? true,
      keyboardVisible: json['keyboardVisible'] as bool? ?? false,
      touchInput: json['touchInput'] as bool?,
      platformBrightness: enumOrNull(
        json['platformBrightness'],
        ui.Brightness.values,
      ),
      textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble(),
      targetPlatform: enumOrNull(json['targetPlatform'], TargetPlatform.values),
      accessibility: a11y,
    );
  }

  final bool isExpanded;
  final bool isLightBackground;
  final String lastPresetId;
  final bool simulatesMetrics;
  final String? activePresetId;
  final FoldablePosture foldPosture;
  final Orientation orientation;
  final bool showSystemUi;
  final bool keyboardVisible;
  final bool? touchInput;
  final ui.Brightness? platformBrightness;
  final double? textScaleFactor;
  final TargetPlatform? targetPlatform;
  final SimulatedAccessibilityFeatures? accessibility;

  Map<String, Object?> toJson() => <String, Object?>{
    'isExpanded': isExpanded,
    'isLightBackground': isLightBackground,
    'lastPresetId': lastPresetId,
    'simulatesMetrics': simulatesMetrics,
    if (activePresetId != null) 'activePresetId': activePresetId,
    'foldPosture': foldPosture.name,
    'orientation': orientation.name,
    'showSystemUi': showSystemUi,
    'keyboardVisible': keyboardVisible,
    if (touchInput != null) 'touchInput': touchInput,
    if (platformBrightness != null)
      'platformBrightness': platformBrightness!.name,
    if (textScaleFactor != null) 'textScaleFactor': textScaleFactor,
    if (targetPlatform != null) 'targetPlatform': targetPlatform!.name,
    if (accessibility != null) 'accessibility': accessibility!.toJson(),
  };

  /// Rebuilds the [DeviceSimulation] matching these saved settings against
  /// [presets].
  DeviceSimulation buildSimulation(List<DevicePreset> presets) {
    DevicePreset? findBase(String? id) {
      final String? baseId = FoldableCoverSpecs.baseId(id);
      if (baseId == null) {
        return null;
      }
      for (final DevicePreset p in presets) {
        if (p.id == baseId) {
          return p;
        }
      }
      return null;
    }

    if (!simulatesMetrics) {
      return DeviceSimulation(
        orientation: orientation,
        showSystemUi: showSystemUi,
        touchInput: touchInput,
        platformBrightness: platformBrightness,
        textScaleFactor: textScaleFactor,
        targetPlatform: targetPlatform,
        accessibility: accessibility,
      );
    }

    final DevicePreset basePreset =
        findBase(activePresetId) ??
        findBase(lastPresetId) ??
        DevicePresets.iPhone17Pro;

    DevicePreset targetPreset = basePreset;
    if (basePreset.kind == DeviceKind.foldable &&
        foldPosture == FoldablePosture.folded) {
      targetPreset = FoldableCoverSpecs.coverFor(basePreset) ?? basePreset;
    }

    DeviceSimulation sim = targetPreset.resolve(orientation: orientation);
    if (basePreset.kind == DeviceKind.foldable &&
        foldPosture == FoldablePosture.halfOpen &&
        sim.displayFeatures != null) {
      sim = sim.copyWith(
        displayFeatures: List<SimulatedDisplayFeature>.unmodifiable(
          sim.displayFeatures!.map(
            (SimulatedDisplayFeature f) =>
                f.type == ui.DisplayFeatureType.fold ||
                    f.type == ui.DisplayFeatureType.hinge
                ? SimulatedDisplayFeature(
                    bounds: f.bounds,
                    type: f.type,
                    state: ui.DisplayFeatureState.postureHalfOpened,
                  )
                : f,
          ),
        ),
      );
    }

    final double? kbHeight = keyboardVisible
        ? targetPreset.keyboardHeight(orientation)
        : null;

    return sim.copyWith(
      showSystemUi: showSystemUi,
      keyboardInset: kbHeight,
      touchInput: touchInput,
      platformBrightness: platformBrightness,
      textScaleFactor: textScaleFactor,
      targetPlatform: targetPlatform,
      accessibility: accessibility,
    );
  }

  /// Loads saved preferences, or returns null when none exist yet (or when the
  /// platform plugin is unavailable, such as in unit tests).
  static Future<InAppPanelPreferences?> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? raw = prefs.getString(_kPanelPrefsKey);
      if (raw == null || raw.isEmpty) {
        return null;
      }
      final Object? decoded = jsonDecode(raw);
      if (decoded is Map) {
        return InAppPanelPreferences.fromJson(
          Map<String, Object?>.from(decoded),
        );
      }
    } on Object {
      // Ignore corrupt or unavailable storage in debug preview.
    }
    return null;
  }

  /// Saves preferences asynchronously; errors are swallowed so preview storage
  /// can never disrupt the app.
  static Future<void> save(InAppPanelPreferences value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPanelPrefsKey, jsonEncode(value.toJson()));
    } on Object {
      // Ignore unavailable storage in tests.
    }
  }
}

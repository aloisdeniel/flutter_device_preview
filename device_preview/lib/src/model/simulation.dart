import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'device_frame.dart';
import 'json_utils.dart';
import 'system_ui.dart';

/// Sentinel used by the `copyWith` implementations to distinguish "parameter
/// not passed" from "parameter explicitly set to null" (which clears the
/// override).
class _Unset {
  const _Unset();
}

const Object _unset = _Unset();

/// Immutable set of simulated device characteristics.
///
/// Every field is optional; `null` means "use the real device value". Null
/// fields are merged live: real-device changes keep propagating for them.
@immutable
class DeviceSimulation {
  /// Creates a simulation description.
  ///
  /// All parameters are optional; an empty simulation ([isEmpty]) passes every
  /// characteristic of the real device through.
  const DeviceSimulation({
    this.presetId,
    this.orientation = Orientation.portrait,
    this.screenSize,
    this.frame,
    this.systemUi,
    this.devicePixelRatio,
    this.padding,
    this.viewPadding,
    this.systemGestureInsets,
    this.displayFeatures,
    this.locales,
    this.platformBrightness,
    this.textScaleFactor,
    this.accessibility,
    this.alwaysUse24HourFormat,
    this.targetPlatform,
  });

  /// Decodes a simulation from the JSON produced by [toJson].
  ///
  /// Unknown keys are ignored (forward compatibility). Malformed values throw
  /// a [FormatException].
  factory DeviceSimulation.fromJson(Map<String, Object?> json) {
    return DeviceSimulation(
      presetId: json['presetId'] == null
          ? null
          : decodeString(json['presetId'], 'presetId'),
      orientation: json['orientation'] == null
          ? Orientation.portrait
          : decodeEnum(json['orientation'], Orientation.values, 'orientation'),
      screenSize: json['screenSize'] == null
          ? null
          : decodeSize(json['screenSize'], 'screenSize'),
      frame: json['frame'] == null
          ? null
          : DeviceFrame.fromJson(decodeMap(json['frame'], 'frame')),
      systemUi: json['systemUi'] == null
          ? null
          : SystemUiSimulation.fromJson(decodeMap(json['systemUi'], 'systemUi')),
      devicePixelRatio: json['devicePixelRatio'] == null
          ? null
          : decodeDouble(json['devicePixelRatio'], 'devicePixelRatio'),
      padding: json['padding'] == null
          ? null
          : decodeEdgeInsets(json['padding'], 'padding'),
      viewPadding: json['viewPadding'] == null
          ? null
          : decodeEdgeInsets(json['viewPadding'], 'viewPadding'),
      systemGestureInsets: json['systemGestureInsets'] == null
          ? null
          : decodeEdgeInsets(
              json['systemGestureInsets'],
              'systemGestureInsets',
            ),
      displayFeatures: json['displayFeatures'] == null
          ? null
          : List<SimulatedDisplayFeature>.unmodifiable(
              decodeList(json['displayFeatures'], 'displayFeatures').map(
                (Object? e) => SimulatedDisplayFeature.fromJson(
                  decodeMap(e, 'displayFeatures[]'),
                ),
              ),
            ),
      locales: json['locales'] == null
          ? null
          : List<ui.Locale>.unmodifiable(
              decodeList(
                json['locales'],
                'locales',
              ).map((Object? e) => decodeLocale(e, 'locales[]')),
            ),
      platformBrightness: json['platformBrightness'] == null
          ? null
          : decodeEnum(
              json['platformBrightness'],
              ui.Brightness.values,
              'platformBrightness',
            ),
      textScaleFactor: json['textScaleFactor'] == null
          ? null
          : decodeDouble(json['textScaleFactor'], 'textScaleFactor'),
      accessibility: json['accessibility'] == null
          ? null
          : SimulatedAccessibilityFeatures.fromJson(
              decodeMap(json['accessibility'], 'accessibility'),
            ),
      alwaysUse24HourFormat: json['alwaysUse24HourFormat'] == null
          ? null
          : decodeBool(json['alwaysUse24HourFormat'], 'alwaysUse24HourFormat'),
      targetPlatform: json['platform'] == null
          ? null
          : decodeEnum(json['platform'], TargetPlatform.values, 'platform'),
    );
  }

  /// The identifier of the preset this simulation was built from, if any.
  ///
  /// Purely informational; round-tripped to DevTools so the panel can show
  /// which preset is active.
  final String? presetId;

  /// The orientation the metric fields ([screenSize], [padding], …) are
  /// expressed in.
  ///
  /// Metric fields are stored orientation-resolved: rotating a simulation
  /// swaps [screenSize] dimensions and rotates the paddings; this label only
  /// records which orientation they currently describe.
  final Orientation orientation;

  /// The simulated logical screen size, already orientation-resolved.
  ///
  /// When null, no metric simulation is active ([simulatesMetrics] is false).
  final ui.Size? screenSize;

  /// The physical appearance of the device: screen outline and body artwork.
  ///
  /// Null (the default) renders the app as a plain, unclipped rectangle. The
  /// frame is always described in portrait and rotated with [orientation], so
  /// rotating a simulation leaves this field untouched.
  final DeviceFrame? frame;

  /// Decorative system UI — status bar, gesture pill — drawn over the app.
  ///
  /// Each bar fills the safe area on its side of the screen, so it follows
  /// [padding] and disappears where the safe area is zero. Its colors follow
  /// the app's `SystemUiOverlayStyle`, never this description.
  final SystemUiSimulation? systemUi;

  /// The simulated device pixel ratio.
  final double? devicePixelRatio;

  /// The simulated safe-area padding (`MediaQuery.padding`), in logical
  /// pixels.
  final EdgeInsets? padding;

  /// The simulated view padding (`MediaQuery.viewPadding`), in logical pixels.
  ///
  /// Defaults to [padding] when null and [screenSize] is non-null (applied by
  /// the view wrapper, not stored here).
  final EdgeInsets? viewPadding;

  /// The simulated system gesture insets, in logical pixels.
  ///
  /// Zero while simulating metrics if null.
  final EdgeInsets? systemGestureInsets;

  /// Simulated display features (folds, hinges, cutouts), in logical pixels.
  final List<SimulatedDisplayFeature>? displayFeatures;

  /// The simulated locale list; the first entry becomes
  /// `PlatformDispatcher.locale`.
  final List<ui.Locale>? locales;

  /// The simulated platform brightness.
  final ui.Brightness? platformBrightness;

  /// The simulated linear text scale factor.
  ///
  /// Drives both `textScaleFactor` and `scaleFontSize` atomically.
  final double? textScaleFactor;

  /// Tri-state accessibility flag overrides; null = all real.
  final SimulatedAccessibilityFeatures? accessibility;

  /// The simulated 24-hour time format preference.
  final bool? alwaysUse24HourFormat;

  /// The simulated target platform.
  ///
  /// Debug-only: applying it triggers a reassemble, and it is
  /// capability-flagged as unsupported in profile builds.
  final TargetPlatform? targetPlatform;

  /// Whether every overridable field is null (pure pass-through).
  bool get isEmpty =>
      presetId == null &&
      screenSize == null &&
      frame == null &&
      systemUi == null &&
      devicePixelRatio == null &&
      padding == null &&
      viewPadding == null &&
      systemGestureInsets == null &&
      displayFeatures == null &&
      locales == null &&
      platformBrightness == null &&
      textScaleFactor == null &&
      accessibility == null &&
      alwaysUse24HourFormat == null &&
      targetPlatform == null;

  /// Whether screen metrics are simulated ([screenSize] is non-null).
  bool get simulatesMetrics => screenSize != null;

  /// The rectangle the simulation paints into, in simulated logical pixels.
  ///
  /// The screen rectangle, grown to include the device body when a [frame] is
  /// simulated — the body starts at negative coordinates, so this rectangle
  /// usually does too. The binding fits *this* rectangle inside the real
  /// window, which is what keeps a device body fully visible.
  ///
  /// [ui.Rect.zero] when no metric simulation is active.
  ui.Rect get contentBounds {
    final ui.Size? size = screenSize;
    if (size == null) {
      return ui.Rect.zero;
    }
    final ui.Rect screen = ui.Offset.zero & size;
    final DeviceFrame? deviceFrame = frame;
    if (deviceFrame == null || deviceFrame.size.isEmpty) {
      return screen;
    }
    return screen.expandToInclude(deviceFrame.bodyBounds(size, orientation));
  }

  /// Creates a copy with the given fields replaced.
  ///
  /// Sentinel-based: passing `null` explicitly CLEARS the corresponding
  /// override (e.g. `copyWith(textScaleFactor: null)` reverts to the real
  /// device value), while omitting the parameter keeps the current value.
  /// [orientation] is non-nullable and cannot be cleared.
  DeviceSimulation copyWith({
    Object? presetId = _unset,
    Orientation? orientation,
    Object? screenSize = _unset,
    Object? frame = _unset,
    Object? systemUi = _unset,
    Object? devicePixelRatio = _unset,
    Object? padding = _unset,
    Object? viewPadding = _unset,
    Object? systemGestureInsets = _unset,
    Object? displayFeatures = _unset,
    Object? locales = _unset,
    Object? platformBrightness = _unset,
    Object? textScaleFactor = _unset,
    Object? accessibility = _unset,
    Object? alwaysUse24HourFormat = _unset,
    Object? targetPlatform = _unset,
  }) {
    return DeviceSimulation(
      presetId: identical(presetId, _unset)
          ? this.presetId
          : presetId as String?,
      orientation: orientation ?? this.orientation,
      screenSize: identical(screenSize, _unset)
          ? this.screenSize
          : screenSize as ui.Size?,
      frame: identical(frame, _unset) ? this.frame : frame as DeviceFrame?,
      systemUi: identical(systemUi, _unset)
          ? this.systemUi
          : systemUi as SystemUiSimulation?,
      devicePixelRatio: identical(devicePixelRatio, _unset)
          ? this.devicePixelRatio
          : devicePixelRatio as double?,
      padding: identical(padding, _unset)
          ? this.padding
          : padding as EdgeInsets?,
      viewPadding: identical(viewPadding, _unset)
          ? this.viewPadding
          : viewPadding as EdgeInsets?,
      systemGestureInsets: identical(systemGestureInsets, _unset)
          ? this.systemGestureInsets
          : systemGestureInsets as EdgeInsets?,
      displayFeatures: identical(displayFeatures, _unset)
          ? this.displayFeatures
          : displayFeatures as List<SimulatedDisplayFeature>?,
      locales: identical(locales, _unset)
          ? this.locales
          : locales as List<ui.Locale>?,
      platformBrightness: identical(platformBrightness, _unset)
          ? this.platformBrightness
          : platformBrightness as ui.Brightness?,
      textScaleFactor: identical(textScaleFactor, _unset)
          ? this.textScaleFactor
          : textScaleFactor as double?,
      accessibility: identical(accessibility, _unset)
          ? this.accessibility
          : accessibility as SimulatedAccessibilityFeatures?,
      alwaysUse24HourFormat: identical(alwaysUse24HourFormat, _unset)
          ? this.alwaysUse24HourFormat
          : alwaysUse24HourFormat as bool?,
      targetPlatform: identical(targetPlatform, _unset)
          ? this.targetPlatform
          : targetPlatform as TargetPlatform?,
    );
  }

  /// Encodes this simulation as JSON. Null fields are absent.
  ///
  /// Note: [targetPlatform] serializes under the key `"platform"`.
  Map<String, Object?> toJson() {
    return <String, Object?>{
      if (presetId != null) 'presetId': presetId,
      'orientation': orientation.name,
      if (screenSize != null) 'screenSize': encodeSize(screenSize!),
      if (frame != null) 'frame': frame!.toJson(),
      if (systemUi != null) 'systemUi': systemUi!.toJson(),
      if (devicePixelRatio != null) 'devicePixelRatio': devicePixelRatio,
      if (padding != null) 'padding': encodeEdgeInsets(padding!),
      if (viewPadding != null) 'viewPadding': encodeEdgeInsets(viewPadding!),
      if (systemGestureInsets != null)
        'systemGestureInsets': encodeEdgeInsets(systemGestureInsets!),
      if (displayFeatures != null)
        'displayFeatures': displayFeatures!
            .map((SimulatedDisplayFeature f) => f.toJson())
            .toList(),
      if (locales != null) 'locales': locales!.map(encodeLocale).toList(),
      if (platformBrightness != null)
        'platformBrightness': platformBrightness!.name,
      if (textScaleFactor != null) 'textScaleFactor': textScaleFactor,
      if (accessibility != null) 'accessibility': accessibility!.toJson(),
      if (alwaysUse24HourFormat != null)
        'alwaysUse24HourFormat': alwaysUse24HourFormat,
      if (targetPlatform != null) 'platform': targetPlatform!.name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DeviceSimulation &&
        other.presetId == presetId &&
        other.orientation == orientation &&
        other.screenSize == screenSize &&
        other.frame == frame &&
        other.systemUi == systemUi &&
        other.devicePixelRatio == devicePixelRatio &&
        other.padding == padding &&
        other.viewPadding == viewPadding &&
        other.systemGestureInsets == systemGestureInsets &&
        listEquals(other.displayFeatures, displayFeatures) &&
        listEquals(other.locales, locales) &&
        other.platformBrightness == platformBrightness &&
        other.textScaleFactor == textScaleFactor &&
        other.accessibility == accessibility &&
        other.alwaysUse24HourFormat == alwaysUse24HourFormat &&
        other.targetPlatform == targetPlatform;
  }

  @override
  int get hashCode => Object.hash(
    presetId,
    orientation,
    screenSize,
    frame,
    systemUi,
    devicePixelRatio,
    padding,
    viewPadding,
    systemGestureInsets,
    displayFeatures == null ? null : Object.hashAll(displayFeatures!),
    locales == null ? null : Object.hashAll(locales!),
    platformBrightness,
    textScaleFactor,
    accessibility,
    alwaysUse24HourFormat,
    targetPlatform,
  );

  @override
  String toString() {
    final List<String> fields = <String>[
      if (presetId != null) 'presetId: $presetId',
      'orientation: ${orientation.name}',
      if (screenSize != null) 'screenSize: $screenSize',
      if (frame != null) 'frame: $frame',
      if (systemUi != null) 'systemUi: $systemUi',
      if (devicePixelRatio != null) 'devicePixelRatio: $devicePixelRatio',
      if (padding != null) 'padding: $padding',
      if (viewPadding != null) 'viewPadding: $viewPadding',
      if (systemGestureInsets != null)
        'systemGestureInsets: $systemGestureInsets',
      if (displayFeatures != null) 'displayFeatures: $displayFeatures',
      if (locales != null) 'locales: $locales',
      if (platformBrightness != null)
        'platformBrightness: ${platformBrightness!.name}',
      if (textScaleFactor != null) 'textScaleFactor: $textScaleFactor',
      if (accessibility != null) 'accessibility: $accessibility',
      if (alwaysUse24HourFormat != null)
        'alwaysUse24HourFormat: $alwaysUse24HourFormat',
      if (targetPlatform != null) 'targetPlatform: ${targetPlatform!.name}',
    ];
    return 'DeviceSimulation(${fields.join(', ')})';
  }
}

/// Tri-state accessibility flag overrides.
///
/// For each flag, `null` means "use the real device value"; `true`/`false`
/// force the flag on/off.
@immutable
class SimulatedAccessibilityFeatures {
  /// Creates a set of tri-state accessibility overrides.
  const SimulatedAccessibilityFeatures({
    this.accessibleNavigation,
    this.invertColors,
    this.disableAnimations,
    this.boldText,
    this.reduceMotion,
    this.highContrast,
    this.onOffSwitchLabels,
  });

  /// Decodes flags from the JSON produced by [toJson].
  ///
  /// Unknown keys are ignored; malformed values throw a [FormatException].
  factory SimulatedAccessibilityFeatures.fromJson(Map<String, Object?> json) {
    bool? read(String key) =>
        json[key] == null ? null : decodeBool(json[key], key);
    return SimulatedAccessibilityFeatures(
      accessibleNavigation: read('accessibleNavigation'),
      invertColors: read('invertColors'),
      disableAnimations: read('disableAnimations'),
      boldText: read('boldText'),
      reduceMotion: read('reduceMotion'),
      highContrast: read('highContrast'),
      onOffSwitchLabels: read('onOffSwitchLabels'),
    );
  }

  /// Override for [ui.AccessibilityFeatures.accessibleNavigation].
  final bool? accessibleNavigation;

  /// Override for [ui.AccessibilityFeatures.invertColors].
  final bool? invertColors;

  /// Override for [ui.AccessibilityFeatures.disableAnimations].
  final bool? disableAnimations;

  /// Override for [ui.AccessibilityFeatures.boldText].
  final bool? boldText;

  /// Override for [ui.AccessibilityFeatures.reduceMotion].
  final bool? reduceMotion;

  /// Override for [ui.AccessibilityFeatures.highContrast].
  final bool? highContrast;

  /// Override for [ui.AccessibilityFeatures.onOffSwitchLabels].
  final bool? onOffSwitchLabels;

  /// Creates a copy with the given flags replaced.
  ///
  /// Sentinel-based: passing `null` explicitly clears the flag override
  /// (reverting to the real device value); omitting a parameter keeps the
  /// current value.
  SimulatedAccessibilityFeatures copyWith({
    Object? accessibleNavigation = _unset,
    Object? invertColors = _unset,
    Object? disableAnimations = _unset,
    Object? boldText = _unset,
    Object? reduceMotion = _unset,
    Object? highContrast = _unset,
    Object? onOffSwitchLabels = _unset,
  }) {
    return SimulatedAccessibilityFeatures(
      accessibleNavigation: identical(accessibleNavigation, _unset)
          ? this.accessibleNavigation
          : accessibleNavigation as bool?,
      invertColors: identical(invertColors, _unset)
          ? this.invertColors
          : invertColors as bool?,
      disableAnimations: identical(disableAnimations, _unset)
          ? this.disableAnimations
          : disableAnimations as bool?,
      boldText: identical(boldText, _unset) ? this.boldText : boldText as bool?,
      reduceMotion: identical(reduceMotion, _unset)
          ? this.reduceMotion
          : reduceMotion as bool?,
      highContrast: identical(highContrast, _unset)
          ? this.highContrast
          : highContrast as bool?,
      onOffSwitchLabels: identical(onOffSwitchLabels, _unset)
          ? this.onOffSwitchLabels
          : onOffSwitchLabels as bool?,
    );
  }

  /// Encodes the flags as JSON. Null flags are absent.
  Map<String, Object?> toJson() {
    return <String, Object?>{
      if (accessibleNavigation != null)
        'accessibleNavigation': accessibleNavigation,
      if (invertColors != null) 'invertColors': invertColors,
      if (disableAnimations != null) 'disableAnimations': disableAnimations,
      if (boldText != null) 'boldText': boldText,
      if (reduceMotion != null) 'reduceMotion': reduceMotion,
      if (highContrast != null) 'highContrast': highContrast,
      if (onOffSwitchLabels != null) 'onOffSwitchLabels': onOffSwitchLabels,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SimulatedAccessibilityFeatures &&
        other.accessibleNavigation == accessibleNavigation &&
        other.invertColors == invertColors &&
        other.disableAnimations == disableAnimations &&
        other.boldText == boldText &&
        other.reduceMotion == reduceMotion &&
        other.highContrast == highContrast &&
        other.onOffSwitchLabels == onOffSwitchLabels;
  }

  @override
  int get hashCode => Object.hash(
    accessibleNavigation,
    invertColors,
    disableAnimations,
    boldText,
    reduceMotion,
    highContrast,
    onOffSwitchLabels,
  );

  @override
  String toString() {
    final List<String> fields = <String>[
      if (accessibleNavigation != null)
        'accessibleNavigation: $accessibleNavigation',
      if (invertColors != null) 'invertColors: $invertColors',
      if (disableAnimations != null) 'disableAnimations: $disableAnimations',
      if (boldText != null) 'boldText: $boldText',
      if (reduceMotion != null) 'reduceMotion: $reduceMotion',
      if (highContrast != null) 'highContrast: $highContrast',
      if (onOffSwitchLabels != null) 'onOffSwitchLabels: $onOffSwitchLabels',
    ];
    return 'SimulatedAccessibilityFeatures(${fields.join(', ')})';
  }
}

/// A `dart:ui`-free, JSON-serializable mirror of [ui.DisplayFeature], in
/// logical pixels.
@immutable
class SimulatedDisplayFeature {
  /// Creates a display feature description.
  const SimulatedDisplayFeature({
    required this.bounds,
    required this.type,
    required this.state,
  });

  /// Decodes a display feature from the JSON produced by [toJson].
  ///
  /// Unknown keys are ignored; malformed values throw a [FormatException].
  factory SimulatedDisplayFeature.fromJson(Map<String, Object?> json) {
    return SimulatedDisplayFeature(
      bounds: decodeRect(json['bounds'], 'bounds'),
      type: decodeEnum(json['type'], ui.DisplayFeatureType.values, 'type'),
      state: decodeEnum(json['state'], ui.DisplayFeatureState.values, 'state'),
    );
  }

  /// The bounds of the feature, in logical pixels.
  final ui.Rect bounds;

  /// The type of the feature (fold, hinge, cutout).
  final ui.DisplayFeatureType type;

  /// The posture state of the feature.
  final ui.DisplayFeatureState state;

  /// Returns this feature mapped through the 90° portrait → landscape
  /// rotation, for a portrait screen [portraitWidth] logical pixels wide.
  ///
  /// A point `(x, y)` in portrait coordinates maps to `(y, portraitWidth - x)`
  /// in landscape coordinates, so a vertical hinge becomes a horizontal one
  /// (and vice versa). Exact inverse of [rotatedToPortrait].
  SimulatedDisplayFeature rotatedToLandscape(double portraitWidth) {
    return SimulatedDisplayFeature(
      bounds: ui.Rect.fromLTRB(
        bounds.top,
        portraitWidth - bounds.right,
        bounds.bottom,
        portraitWidth - bounds.left,
      ),
      type: type,
      state: state,
    );
  }

  /// Returns this feature mapped through the 90° landscape → portrait
  /// rotation, for a landscape screen [landscapeHeight] logical pixels tall.
  ///
  /// Exact inverse of [rotatedToLandscape].
  SimulatedDisplayFeature rotatedToPortrait(double landscapeHeight) {
    return SimulatedDisplayFeature(
      bounds: ui.Rect.fromLTRB(
        landscapeHeight - bounds.bottom,
        bounds.left,
        landscapeHeight - bounds.top,
        bounds.right,
      ),
      type: type,
      state: state,
    );
  }

  /// Encodes this feature as JSON.
  Map<String, Object?> toJson() => <String, Object?>{
    'bounds': encodeRect(bounds),
    'type': type.name,
    'state': state.name,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SimulatedDisplayFeature &&
        other.bounds == bounds &&
        other.type == type &&
        other.state == state;
  }

  @override
  int get hashCode => Object.hash(bounds, type, state);

  @override
  String toString() =>
      'SimulatedDisplayFeature(bounds: $bounds, type: ${type.name}, '
      'state: ${state.name})';
}

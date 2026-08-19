import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'json_utils.dart';

/// Artwork for the platform's own on-screen furniture — the status bar at the
/// top, the gesture pill or navigation bar at the bottom — drawn **on top of**
/// the app, inside the simulated screen.
///
/// Everything here is decoration: the clock is a static drawing that never
/// ticks (it shows whatever time the artwork was extracted with), the battery
/// never drains, nothing updates. It exists so a preview looks like the
/// device it simulates, and so status bar styling can be seen while it is
/// written.
///
/// The bars are not positioned by this description: each one fills the
/// simulated safe area on its side (`DeviceSimulation.padding`), which is
/// already resolved per orientation. A bar whose safe area is zero — an iPhone
/// status bar in landscape, the gesture pill on a home-button device — is not
/// drawn at all.
///
/// Colors come from the app's `SystemUiOverlayStyle`, not from the artwork:
/// shapes that declare `fill="currentColor"` (or no fill) are tinted at paint
/// time. See `SystemUiColors`.
@immutable
class SystemUiSimulation {
  /// Creates a system UI description.
  const SystemUiSimulation({this.statusBar, this.navigationBar});

  /// Decodes a description from the JSON produced by [toJson].
  factory SystemUiSimulation.fromJson(Map<String, Object?> json) {
    return SystemUiSimulation(
      statusBar: json['statusBar'] == null
          ? null
          : SystemUiBar.fromJson(decodeMap(json['statusBar'], 'statusBar')),
      navigationBar: json['navigationBar'] == null
          ? null
          : SystemUiBar.fromJson(
              decodeMap(json['navigationBar'], 'navigationBar'),
            ),
    );
  }

  /// The status bar, drawn in the top safe area.
  final SystemUiBar? statusBar;

  /// The navigation bar or gesture pill, drawn in the bottom safe area.
  final SystemUiBar? navigationBar;

  /// Whether nothing would be drawn.
  bool get isEmpty =>
      (statusBar?.isEmpty ?? true) && (navigationBar?.isEmpty ?? true);

  /// Encodes this description as JSON. Empty bars are absent.
  Map<String, Object?> toJson() => <String, Object?>{
    if (statusBar != null && !statusBar!.isEmpty)
      'statusBar': statusBar!.toJson(),
    if (navigationBar != null && !navigationBar!.isEmpty)
      'navigationBar': navigationBar!.toJson(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SystemUiSimulation &&
        other.statusBar == statusBar &&
        other.navigationBar == navigationBar;
  }

  @override
  int get hashCode => Object.hash(statusBar, navigationBar);

  @override
  String toString() =>
      'SystemUiSimulation(statusBar: $statusBar, '
      'navigationBar: $navigationBar)';
}

/// One system bar: up to three pieces of artwork laid out inside the safe area
/// on its side of the screen.
///
/// Each piece is drawn at its natural size — the size of its SVG view box —
/// never stretched, so the same description works at any screen width:
///
/// ```
///  ┌────────────────────────────────────────────┐
///  │ ⟨inset⟩ leading      center     trailing ⟨inset⟩ │  ← the safe area
///  ├────────────────────────────────────────────┤
///  │                   app                      │
/// ```
///
/// Vertically, artwork is centered in the safe area unless [bottomInset] is
/// given, which instead pins its bottom edge that far from the bar's outer
/// edge (how a home indicator sits).
@immutable
class SystemUiBar {
  /// Creates a bar description.
  const SystemUiBar({
    this.leading = '',
    this.center = '',
    this.trailing = '',
    this.inset = 16,
    this.bottomInset,
  });

  /// Decodes a bar from the JSON produced by [toJson].
  ///
  /// Artwork may be written as an array of lines, joined with newlines, so
  /// that device spec files stay readable.
  factory SystemUiBar.fromJson(Map<String, Object?> json) {
    String artwork(String key) =>
        json[key] == null ? '' : decodeStringOrLines(json[key], key);
    return SystemUiBar(
      leading: artwork('leading'),
      center: artwork('center'),
      trailing: artwork('trailing'),
      inset: json['inset'] == null
          ? 16
          : decodeDouble(json['inset'], 'inset'),
      bottomInset: json['bottomInset'] == null
          ? null
          : decodeDouble(json['bottomInset'], 'bottomInset'),
    );
  }

  /// Artwork anchored to the leading edge — the clock, typically.
  final String leading;

  /// Artwork centered horizontally — the gesture pill, typically.
  final String center;

  /// Artwork anchored to the trailing edge — the status icons, typically.
  final String trailing;

  /// The distance from the screen edge to [leading] / [trailing].
  final double inset;

  /// When set, the distance from the bar's outer edge to the bottom of the
  /// artwork; otherwise the artwork is centered in the safe area.
  final double? bottomInset;

  /// Whether this bar has no artwork.
  bool get isEmpty => leading.isEmpty && center.isEmpty && trailing.isEmpty;

  /// Encodes this bar as JSON. Empty artwork is absent.
  Map<String, Object?> toJson() => <String, Object?>{
    if (leading.isNotEmpty) 'leading': leading,
    if (center.isNotEmpty) 'center': center,
    if (trailing.isNotEmpty) 'trailing': trailing,
    'inset': inset,
    if (bottomInset != null) 'bottomInset': bottomInset,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SystemUiBar &&
        other.leading == leading &&
        other.center == center &&
        other.trailing == trailing &&
        other.inset == inset &&
        other.bottomInset == bottomInset;
  }

  @override
  int get hashCode =>
      Object.hash(leading, center, trailing, inset, bottomInset);

  @override
  String toString() =>
      'SystemUiBar(leading: ${leading.length} chars, '
      'center: ${center.length} chars, trailing: ${trailing.length} chars, '
      'inset: $inset, bottomInset: $bottomInset)';
}

/// The colors a system bar is painted with, resolved from the app's
/// [SystemUiOverlayStyle].
///
/// Icon brightness follows the framework's own conventions:
///
/// * `statusBarIconBrightness` wins when set (Android semantics:
///   [Brightness.light] means *light icons*).
/// * else `statusBarBrightness` — the iOS field, which describes the
///   *background* — is inverted to get the icon color.
/// * else the icons contrast with the simulated platform brightness.
///
/// Background and divider colors are honored only on Android, the only
/// platform whose bars can actually be tinted; elsewhere they stay
/// transparent however the app sets them.
@immutable
class SystemUiColors {
  /// Creates a resolved color set.
  const SystemUiColors({
    required this.statusBarIcons,
    required this.navigationBarIcons,
    this.statusBarBackground = const ui.Color(0x00000000),
    this.navigationBarBackground = const ui.Color(0x00000000),
    this.navigationBarDivider = const ui.Color(0x00000000),
  });

  /// Resolves the colors for [style] under a simulated platform.
  factory SystemUiColors.resolve({
    required SystemUiOverlayStyle? style,
    required Brightness platformBrightness,
    required TargetPlatform platform,
  }) {
    Brightness? iconBrightness = style?.statusBarIconBrightness;
    if (iconBrightness == null && style?.statusBarBrightness != null) {
      iconBrightness = _invert(style!.statusBarBrightness!);
    }
    iconBrightness ??= _invert(platformBrightness);
    final Brightness navIconBrightness =
        style?.systemNavigationBarIconBrightness ?? iconBrightness;
    final bool tintable =
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return SystemUiColors(
      statusBarIcons: _iconColor(iconBrightness),
      navigationBarIcons: _iconColor(navIconBrightness),
      statusBarBackground: tintable
          ? (style?.statusBarColor ?? _transparent)
          : _transparent,
      navigationBarBackground: tintable
          ? (style?.systemNavigationBarColor ?? _transparent)
          : _transparent,
      navigationBarDivider: tintable
          ? (style?.systemNavigationBarDividerColor ?? _transparent)
          : _transparent,
    );
  }

  static const ui.Color _transparent = ui.Color(0x00000000);

  static Brightness _invert(Brightness brightness) =>
      brightness == Brightness.dark ? Brightness.light : Brightness.dark;

  /// White for light icons, near-black for dark ones — matching what the
  /// platforms actually draw.
  static ui.Color _iconColor(Brightness brightness) => brightness ==
          Brightness.light
      ? const ui.Color(0xFFFFFFFF)
      : const ui.Color(0xFF16181C);

  /// The tint of the status bar artwork.
  final ui.Color statusBarIcons;

  /// The tint of the navigation bar artwork.
  final ui.Color navigationBarIcons;

  /// The status bar background fill (transparent unless set on Android).
  final ui.Color statusBarBackground;

  /// The navigation bar background fill (transparent unless set on Android).
  final ui.Color navigationBarBackground;

  /// The one-pixel divider above the navigation bar.
  final ui.Color navigationBarDivider;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SystemUiColors &&
        other.statusBarIcons == statusBarIcons &&
        other.navigationBarIcons == navigationBarIcons &&
        other.statusBarBackground == statusBarBackground &&
        other.navigationBarBackground == navigationBarBackground &&
        other.navigationBarDivider == navigationBarDivider;
  }

  @override
  int get hashCode => Object.hash(
    statusBarIcons,
    navigationBarIcons,
    statusBarBackground,
    navigationBarBackground,
    navigationBarDivider,
  );

  @override
  String toString() =>
      'SystemUiColors(statusBarIcons: $statusBarIcons, '
      'navigationBarIcons: $navigationBarIcons)';
}

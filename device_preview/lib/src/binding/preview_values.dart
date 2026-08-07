import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../model/simulation.dart';

/// A fabricated [ui.ViewPadding].
///
/// The upstream class has a private constructor, so simulated values are
/// produced through an `implements` wrapper (the same pattern flutter_test
/// uses for its `FakeViewPadding`). Values are in physical pixels.
@immutable
class PreviewViewPadding implements ui.ViewPadding {
  /// Creates a view padding from raw physical-pixel values.
  const PreviewViewPadding({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  /// Creates a view padding from logical-pixel [insets], converted to
  /// physical pixels using [devicePixelRatio].
  PreviewViewPadding.fromEdgeInsets(EdgeInsets insets, double devicePixelRatio)
    : left = insets.left * devicePixelRatio,
      top = insets.top * devicePixelRatio,
      right = insets.right * devicePixelRatio,
      bottom = insets.bottom * devicePixelRatio;

  /// A view padding with zeros for every edge.
  static const PreviewViewPadding zero = PreviewViewPadding(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
  );

  @override
  final double left;

  @override
  final double top;

  @override
  final double right;

  @override
  final double bottom;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PreviewViewPadding &&
        other.left == left &&
        other.top == top &&
        other.right == right &&
        other.bottom == bottom;
  }

  @override
  int get hashCode => Object.hash(left, top, right, bottom);

  @override
  String toString() =>
      'PreviewViewPadding(left: $left, top: $top, right: $right, '
      'bottom: $bottom)';
}

/// A fabricated [ui.AccessibilityFeatures] merging tri-state simulated flags
/// over the real host flags.
///
/// For each of the seven overridable flags, a non-null value in [simulated]
/// wins; a null value falls through to [host] live (real device changes for
/// that flag keep propagating). The engine-only flags ([supportsAnnounce],
/// [autoPlayAnimatedImages], [autoPlayVideos], [deterministicCursor]) always
/// delegate to the host.
@immutable
class PreviewAccessibilityFeatures implements ui.AccessibilityFeatures {
  /// Creates a merged accessibility feature set.
  const PreviewAccessibilityFeatures({required this.host, this.simulated});

  /// The real device's accessibility features.
  final ui.AccessibilityFeatures host;

  /// The tri-state overrides, or null for full pass-through.
  final SimulatedAccessibilityFeatures? simulated;

  @override
  bool get accessibleNavigation =>
      simulated?.accessibleNavigation ?? host.accessibleNavigation;

  @override
  bool get invertColors => simulated?.invertColors ?? host.invertColors;

  @override
  bool get disableAnimations =>
      simulated?.disableAnimations ?? host.disableAnimations;

  @override
  bool get boldText => simulated?.boldText ?? host.boldText;

  @override
  bool get reduceMotion => simulated?.reduceMotion ?? host.reduceMotion;

  @override
  bool get highContrast => simulated?.highContrast ?? host.highContrast;

  @override
  bool get onOffSwitchLabels =>
      simulated?.onOffSwitchLabels ?? host.onOffSwitchLabels;

  @override
  bool get supportsAnnounce => host.supportsAnnounce;

  @override
  bool get autoPlayAnimatedImages => host.autoPlayAnimatedImages;

  @override
  bool get autoPlayVideos => host.autoPlayVideos;

  @override
  bool get deterministicCursor => host.deterministicCursor;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PreviewAccessibilityFeatures &&
        other.host == host &&
        other.simulated == simulated;
  }

  @override
  int get hashCode => Object.hash(host, simulated);

  @override
  String toString() {
    final List<String> features = <String>[
      if (accessibleNavigation) 'accessibleNavigation',
      if (invertColors) 'invertColors',
      if (disableAnimations) 'disableAnimations',
      if (boldText) 'boldText',
      if (reduceMotion) 'reduceMotion',
      if (highContrast) 'highContrast',
      if (onOffSwitchLabels) 'onOffSwitchLabels',
      if (supportsAnnounce) 'supportsAnnounce',
    ];
    return 'PreviewAccessibilityFeatures([${features.join(', ')}])';
  }
}

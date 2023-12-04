import 'package:flutter/rendering.dart';

class PreviewAccessibilityFeatures implements AccessibilityFeatures {
  PreviewAccessibilityFeatures({
    required this.accessibleNavigation,
    required this.boldText,
    required this.disableAnimations,
    required this.highContrast,
    required this.invertColors,
    required this.reduceMotion,
    required this.onOffSwitchLabels,
  });

  factory PreviewAccessibilityFeatures.merge(
    AccessibilityFeatures other, {
    bool? accessibleNavigation,
    bool? boldText,
    bool? disableAnimations,
    bool? highContrast,
    bool? invertColors,
    bool? reduceMotion,
    bool? onOffSwitchLabels,
  }) =>
      PreviewAccessibilityFeatures(
        accessibleNavigation:
            accessibleNavigation ?? other.accessibleNavigation,
        boldText: boldText ?? other.boldText,
        disableAnimations: disableAnimations ?? other.disableAnimations,
        highContrast: highContrast ?? other.highContrast,
        invertColors: invertColors ?? other.invertColors,
        reduceMotion: reduceMotion ?? other.reduceMotion,
        onOffSwitchLabels: onOffSwitchLabels ?? other.onOffSwitchLabels,
      );

  @override
  final bool accessibleNavigation;

  @override
  final bool boldText;

  @override
  final bool disableAnimations;

  @override
  final bool highContrast;

  @override
  final bool invertColors;

  @override
  final bool reduceMotion;

  @override
  final bool onOffSwitchLabels;
}

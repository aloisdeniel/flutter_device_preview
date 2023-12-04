// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:device_frame/device_frame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'preference.dart';

class PreviewConfiguration {
  const PreviewConfiguration({
    this.isEnabled = true,
    this.accessibility = const PreviewAccessibilityConfiguration(),
    this.internationalization =
        const PreviewInternationalizationConfiguration(),
    this.device = const PreviewDeviceConfiguration(),
  });

  final bool isEnabled;
  final PreviewAccessibilityConfiguration accessibility;
  final PreviewInternationalizationConfiguration internationalization;
  final PreviewDeviceConfiguration device;

  PreviewConfiguration copyWith({
    bool? isEnabled,
    PreviewAccessibilityConfiguration? accessibility,
    PreviewInternationalizationConfiguration? internationalization,
    PreviewDeviceConfiguration? device,
  }) {
    return PreviewConfiguration(
      isEnabled: isEnabled ?? this.isEnabled,
      accessibility: accessibility ?? this.accessibility,
      internationalization: internationalization ?? this.internationalization,
      device: device ?? this.device,
    );
  }
}

class PreviewAccessibilityConfiguration {
  const PreviewAccessibilityConfiguration({
    this.textScaleFactor = const PreviewPreference<double>.system(),
    this.accessibleNavigation = const PreviewPreference<bool>.system(),
    this.invertColors = const PreviewPreference<bool>.system(),
    this.disableAnimations = const PreviewPreference<bool>.system(),
    this.boldText = const PreviewPreference<bool>.system(),
    this.reduceMotion = const PreviewPreference<bool>.system(),
    this.highContrast = const PreviewPreference<bool>.system(),
    this.onOffSwitchLabels = const PreviewPreference<bool>.system(),
  });
  final PreviewPreference<bool> accessibleNavigation;
  final PreviewPreference<bool> invertColors;
  final PreviewPreference<bool> disableAnimations;
  final PreviewPreference<bool> boldText;
  final PreviewPreference<bool> reduceMotion;
  final PreviewPreference<bool> highContrast;
  final PreviewPreference<bool> onOffSwitchLabels;
  final PreviewPreference<double> textScaleFactor;

  PreviewAccessibilityConfiguration copyWith({
    PreviewPreference<bool>? accessibleNavigation,
    PreviewPreference<bool>? invertColors,
    PreviewPreference<bool>? disableAnimations,
    PreviewPreference<bool>? boldText,
    PreviewPreference<bool>? reduceMotion,
    PreviewPreference<bool>? highContrast,
    PreviewPreference<bool>? onOffSwitchLabels,
    PreviewPreference<double>? textScaleFactor,
  }) {
    return PreviewAccessibilityConfiguration(
      accessibleNavigation: accessibleNavigation ?? this.accessibleNavigation,
      invertColors: invertColors ?? this.invertColors,
      disableAnimations: disableAnimations ?? this.disableAnimations,
      boldText: boldText ?? this.boldText,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      highContrast: highContrast ?? this.highContrast,
      onOffSwitchLabels: onOffSwitchLabels ?? this.onOffSwitchLabels,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    );
  }
}

class PreviewInternationalizationConfiguration {
  const PreviewInternationalizationConfiguration({
    this.locale = const PreviewPreference<Locale>.system(),
  });
  final PreviewPreference<Locale> locale;
}

class PreviewDeviceConfiguration {
  const PreviewDeviceConfiguration({
    this.brightness = const PreviewPreference<Brightness>.system(),
    this.device = const PreviewPreference<DeviceInfo>.system(),
    this.orientation = const PreviewPreference<Orientation>.system(),
  });
  final PreviewPreference<DeviceInfo> device;
  final PreviewPreference<Orientation> orientation;
  final PreviewPreference<Brightness> brightness;

  PreviewDeviceConfiguration copyWith({
    PreviewPreference<DeviceInfo>? device,
    PreviewPreference<Orientation>? orientation,
    PreviewPreference<Brightness>? brightness,
  }) {
    return PreviewDeviceConfiguration(
      device: device ?? this.device,
      orientation: orientation ?? this.orientation,
      brightness: brightness ?? this.brightness,
    );
  }
}

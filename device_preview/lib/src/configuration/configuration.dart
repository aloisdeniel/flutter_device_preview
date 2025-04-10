// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessibleNavigation': accessibleNavigation.asNullable(),
      'invertColors': invertColors.asNullable(),
      'disableAnimations': disableAnimations.asNullable(),
      'boldText': boldText.asNullable(),
      'reduceMotion': reduceMotion.asNullable(),
      'highContrast': highContrast.asNullable(),
      'onOffSwitchLabels': onOffSwitchLabels.asNullable(),
      'textScaleFactor': textScaleFactor.asNullable(),
    };
  }

  factory PreviewAccessibilityConfiguration.fromMap(Map<String, dynamic> map) {
    return PreviewAccessibilityConfiguration(
      accessibleNavigation: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'accessibleNavigation': bool value} => value,
          _ => null,
        },
      ),
      invertColors: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'invertColors': bool value} => value,
          _ => null,
        },
      ),
      disableAnimations: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'disableAnimations': bool value} => value,
          _ => null,
        },
      ),
      boldText: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'boldText': bool value} => value,
          _ => null,
        },
      ),
      reduceMotion: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'reduceMotion': bool value} => value,
          _ => null,
        },
      ),
      highContrast: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'highContrast': bool value} => value,
          _ => null,
        },
      ),
      onOffSwitchLabels: PreviewPreference<bool>.fromNullable(
        switch (map) {
          {'onOffSwitchLabels': bool value} => value,
          _ => null,
        },
      ),
      textScaleFactor: PreviewPreference<double>.fromNullable(
        switch (map) {
          {'textScaleFactor': num value} => value.toDouble(),
          _ => null,
        },
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviewAccessibilityConfiguration.fromJson(String? source) {
    if (source == null) return const PreviewAccessibilityConfiguration();
    return PreviewAccessibilityConfiguration.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
}

class PreviewInternationalizationConfiguration {
  const PreviewInternationalizationConfiguration({
    this.locale = const PreviewPreference<Locale>.system(),
  });
  final PreviewPreference<Locale> locale;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locale': locale.toString(),
    };
  }

  factory PreviewInternationalizationConfiguration.fromMap(
      Map<String, dynamic> map) {
    return PreviewInternationalizationConfiguration(
      locale: PreviewPreference<Locale>.fromNullable(
        switch (map) {
          {'locale': String value} => () {
              final splits = value.split(value);
              if (splits.length > 1) {
                return Locale(splits[0], splits[1]);
              }
              return Locale(value);
            }(),
          _ => null,
        },
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviewInternationalizationConfiguration.fromJson(String? source) {
    if (source == null) return const PreviewInternationalizationConfiguration();
    return PreviewInternationalizationConfiguration.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'device': device.asNullable()?.identifier.toString(),
      'orientation': orientation.asNullable()?.index,
      'brightness': brightness.asNullable()?.index,
    };
  }

  factory PreviewDeviceConfiguration.fromMap(Map<String, dynamic> map) {
    return PreviewDeviceConfiguration(
      device: PreviewPreference<DeviceInfo>.fromNullable(
        switch (map) {
          {'device': String id} =>
            Devices.all.where((x) => x.identifier.toString() == id).firstOrNull,
          _ => null,
        },
      ),
      orientation: PreviewPreference<Orientation>.fromNullable(
        switch (map) {
          {'orientation': num value} => Orientation.values[value.toInt()],
          _ => null,
        },
      ),
      brightness: PreviewPreference<Brightness>.fromNullable(
        switch (map) {
          {'brightness': num value} => Brightness.values[value.toInt()],
          _ => null,
        },
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviewDeviceConfiguration.fromJson(String? source) {
    if (source == null) return const PreviewDeviceConfiguration();
    return PreviewDeviceConfiguration.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
}

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class PreviewWindow implements ui.SingletonFlutterWindow {
  PreviewWindow(this.parent);
  final ui.SingletonFlutterWindow parent;

  @override
  VoidCallback? get onAccessibilityFeaturesChanged =>
      parent.onAccessibilityFeaturesChanged;

  @override
  set onAccessibilityFeaturesChanged(VoidCallback? value) =>
      parent.onAccessibilityFeaturesChanged = value;

  @override
  ui.FrameCallback? get onBeginFrame => parent.onBeginFrame;

  @override
  set onBeginFrame(ui.FrameCallback? value) => parent.onBeginFrame = value;

  @override
  VoidCallback? get onDrawFrame => parent.onDrawFrame;

  @override
  set onDrawFrame(VoidCallback? value) => parent.onDrawFrame = value;

  @override
  VoidCallback? get onLocaleChanged => parent.onLocaleChanged;

  @override
  set onLocaleChanged(VoidCallback? value) => parent.onLocaleChanged = value;

  @override
  VoidCallback? get onMetricsChanged => parent.onMetricsChanged;

  @override
  set onMetricsChanged(VoidCallback? value) => parent.onMetricsChanged = value;

  @override
  VoidCallback? get onPlatformBrightnessChanged =>
      parent.onPlatformBrightnessChanged;

  @override
  set onPlatformBrightnessChanged(VoidCallback? value) =>
      parent.onPlatformBrightnessChanged = value;

  @override
  ui.PlatformMessageCallback? get onPlatformMessage => parent.onPlatformMessage;

  @override
  set onPlatformMessage(ui.PlatformMessageCallback? value) =>
      parent.onPlatformMessage = value;

  @override
  ui.PointerDataPacketCallback? get onPointerDataPacket =>
      parent.onPointerDataPacket;

  @override
  set onPointerDataPacket(ui.PointerDataPacketCallback? value) =>
      parent.onPointerDataPacket = value;

  @override
  ui.TimingsCallback? get onReportTimings => parent.onReportTimings;

  @override
  set onReportTimings(ui.TimingsCallback? value) =>
      parent.onReportTimings = value;

  @override
  ui.VoidCallback? get onSemanticsEnabledChanged =>
      parent.onSemanticsEnabledChanged;

  @override
  set onSemanticsEnabledChanged(ui.VoidCallback? value) =>
      parent.onSemanticsEnabledChanged = value;

  @override
  ui.SemanticsActionCallback? get onSemanticsAction => parent.onSemanticsAction;

  @override
  set onSemanticsAction(ui.SemanticsActionCallback? value) =>
      parent.onSemanticsAction = value;

  @override
  ui.VoidCallback? get onTextScaleFactorChanged =>
      parent.onTextScaleFactorChanged;

  @override
  set onTextScaleFactorChanged(ui.VoidCallback? value) =>
      parent.onTextScaleFactorChanged = value;

  ui.AccessibilityFeatures? _previewAccessibilityFeatures;

  @override
  ui.AccessibilityFeatures get accessibilityFeatures =>
      _previewAccessibilityFeatures ?? parent.accessibilityFeatures;

  set accessibilityFeatures(ui.AccessibilityFeatures value) {
    _previewAccessibilityFeatures = value;
    if (onAccessibilityFeaturesChanged != null) {
      onAccessibilityFeaturesChanged!();
    }
  }

  double? _previewDevicePixelRatio;

  @override
  double get devicePixelRatio =>
      _previewDevicePixelRatio ?? parent.devicePixelRatio;

  set devicePixelRatio(double? value) {
    _previewDevicePixelRatio = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  bool? _previewAlwaysUse24HourFormat;

  @override
  bool get alwaysUse24HourFormat =>
      _previewAlwaysUse24HourFormat ?? parent.alwaysUse24HourFormat;

  set alwaysUse24HourFormat(bool? value) {
    _previewAlwaysUse24HourFormat = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  @override
  ui.Locale? computePlatformResolvedLocale(List<ui.Locale> supportedLocales) {
    return parent.computePlatformResolvedLocale(supportedLocales);
  }

  @override
  String get defaultRouteName => parent.defaultRouteName;

  @override
  String get initialLifecycleState => parent.initialLifecycleState;

  ui.Locale? _previewLocale;

  @override
  ui.Locale get locale => _previewLocale ?? parent.locale;

  set locale(ui.Locale? value) {
    _previewLocale = value;
    if (onLocaleChanged != null) {
      onLocaleChanged!();
    }
  }

  List<ui.Locale>? _previewLocales;

  @override
  List<ui.Locale> get locales => _previewLocales ?? parent.locales;

  set locales(List<ui.Locale> value) {
    _previewLocales = value;
    if (onLocaleChanged != null) {
      onLocaleChanged!();
    }
  }

  ui.WindowPadding? _previewPadding;

  @override
  ui.WindowPadding get padding => _previewPadding ?? parent.padding;

  set padding(ui.WindowPadding? value) {
    _previewPadding = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  ui.Rect? _previewPhysicalGeometry;

  @override
  ui.Rect get physicalGeometry =>
      _previewPhysicalGeometry ?? parent.physicalGeometry;

  set physicalGeometry(ui.Rect? value) {
    _previewPhysicalGeometry = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  ui.Size? _previewPhysicalSize;

  @override
  ui.Size get physicalSize => _previewPhysicalSize ?? parent.physicalSize;

  set physicalSize(ui.Size? value) {
    _previewPhysicalSize = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  ui.Brightness? _previewBirghtness;

  @override
  ui.Brightness get platformBrightness =>
      _previewBirghtness ?? parent.platformBrightness;

  set platformBrightness(ui.Brightness? value) {
    _previewBirghtness = value;
    if (onPlatformBrightnessChanged != null) {
      onPlatformBrightnessChanged!();
    }
  }

  @override
  ui.PlatformDispatcher get platformDispatcher => parent.platformDispatcher;

  @override
  void render(ui.Scene scene) {
    parent.render(scene);
  }

  @override
  void scheduleFrame() {
    parent.scheduleFrame();
  }

  @override
  bool get semanticsEnabled => parent.semanticsEnabled;

  @override
  void sendPlatformMessage(String name, ByteData? data, callback) {
    parent.sendPlatformMessage(name, data, callback);
  }

  @override
  void setIsolateDebugName(String name) {
    parent.setIsolateDebugName(name);
  }

  @override
  ui.WindowPadding get systemGestureInsets => parent.systemGestureInsets;

  double? _previewTextScaleFactor;

  @override
  double get textScaleFactor =>
      _previewTextScaleFactor ?? parent.textScaleFactor;

  set textScaleFactor(double? value) {
    _previewTextScaleFactor = value;
    if (onMetricsChanged != null) {
      onMetricsChanged!();
    }
  }

  @override
  void updateSemantics(ui.SemanticsUpdate update) =>
      parent.updateSemantics(update);

  @override
  ui.ViewConfiguration get viewConfiguration => parent.viewConfiguration;

  @override
  ui.WindowPadding get viewInsets => parent.viewInsets;

  @override
  ui.WindowPadding get viewPadding => parent.viewPadding;
}

class PreviewWindowPadding implements ui.WindowPadding {
  const PreviewWindowPadding(
      {required this.left,
      required this.top,
      required this.right,
      required this.bottom});

  const PreviewWindowPadding.all(double value)
      : left = value,
        right = value,
        top = value,
        bottom = value;

  /// The distance from the left edge to the first unpadded pixel, in physical pixels.
  @override
  final double left;

  /// The distance from the top edge to the first unpadded pixel, in physical pixels.
  @override
  final double top;

  /// The distance from the right edge to the first unpadded pixel, in physical pixels.
  @override
  final double right;

  /// The distance from the bottom edge to the first unpadded pixel, in physical pixels.
  @override
  final double bottom;

  @override
  String toString() {
    return 'WindowPadding(left: $left, top: $top, right: $right, bottom: $bottom)';
  }
}

class PreviewAccessibilityFeatures implements AccessibilityFeatures {
  PreviewAccessibilityFeatures({
    required this.accessibleNavigation,
    required this.boldText,
    required this.disableAnimations,
    required this.highContrast,
    required this.invertColors,
    required this.reduceMotion,
  });

  factory PreviewAccessibilityFeatures.merge(
    AccessibilityFeatures other, {
    bool? accessibleNavigation,
    bool? boldText,
    bool? disableAnimations,
    bool? highContrast,
    bool? invertColors,
    bool? reduceMotion,
  }) =>
      PreviewAccessibilityFeatures(
        accessibleNavigation:
            accessibleNavigation ?? other.accessibleNavigation,
        boldText: boldText ?? other.boldText,
        disableAnimations: disableAnimations ?? other.disableAnimations,
        highContrast: highContrast ?? other.highContrast,
        invertColors: invertColors ?? other.invertColors,
        reduceMotion: reduceMotion ?? other.reduceMotion,
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
}

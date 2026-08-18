// The wrapper must implement the complete PlatformDispatcher interface,
// including members the SDK has deprecated but not yet removed.
// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show basicLocaleListResolution;

import '../model/fit_transform.dart';
import '../model/pointer_rewrite.dart';
import '../model/simulation.dart';
import 'preview_flutter_view.dart';
import 'preview_state.dart';
import 'preview_values.dart';

/// A wrapper [ui.PlatformDispatcher] that reports simulated device
/// characteristics.
///
/// One instance is created per process and cached forever. Every interface
/// member is implemented explicitly (no `noSuchMethod`): SDK interface drift
/// is a compile error by design.
///
/// Member policy:
///
/// * **Simulatable getters** ([locale], [locales], [platformBrightness],
///   [textScaleFactor], [accessibilityFeatures], [alwaysUse24HourFormat],
///   [scaleFontSize], [computePlatformResolvedLocale]) return
///   `simulated ?? host`.
/// * **View accessors** swap the host's implicit view for the cached
///   [PreviewFlutterView]; secondary views pass through untouched.
/// * **Simulatable callback setters** ([onMetricsChanged],
///   [onTextScaleFactorChanged], [onPlatformBrightnessChanged],
///   [onLocaleChanged], [onAccessibilityFeaturesChanged],
///   [onPointerDataPacket]) store the framework's callback and register a
///   trampoline on the host. When the dimension is currently simulated the
///   host notification is swallowed (the simulated value did not change);
///   otherwise it is forwarded. Accessibility always forwards because its
///   tri-state merge keeps depending on live host flags. The metrics
///   trampoline additionally always invokes [PreviewState.onHostMetricsChanged]
///   so the fit transform tracks host resizes.
/// * **Everything with engine side effects** is pure delegation to [host].
class PreviewPlatformDispatcher implements ui.PlatformDispatcher {
  /// Creates a wrapper over [host].
  PreviewPlatformDispatcher({required this.host, required this.state}) {
    final ui.FlutterView? hostImplicitView = host.implicitView;
    _implicitView = hostImplicitView == null
        ? null
        : PreviewFlutterView(
            hostView: hostImplicitView,
            platformDispatcher: this,
            state: state,
          );
  }

  /// The real engine dispatcher.
  final ui.PlatformDispatcher host;

  /// The shared simulation state.
  final PreviewState state;

  late final PreviewFlutterView? _implicitView;

  DeviceSimulation? get _simulation => state.simulation;

  /// The cached wrapper view, if the host had an implicit view.
  PreviewFlutterView? get previewImplicitView => _implicitView;

  // ---------------------------------------------------------------------------
  // Views.
  // ---------------------------------------------------------------------------

  @override
  Iterable<ui.Display> get displays => host.displays;

  @override
  ui.FlutterView? get implicitView => _implicitView ?? host.implicitView;

  /// Returns the wrapper when [id] is the implicit view's id, else delegates.
  ///
  /// Mandatory: `PointerEventConverter` drops events whose view id does not
  /// resolve, and divides positions by the returned view's device pixel
  /// ratio.
  @override
  ui.FlutterView? view({required int id}) {
    final PreviewFlutterView? wrapper = _implicitView;
    if (wrapper != null && wrapper.viewId == id) {
      return wrapper;
    }
    return host.view(id: id);
  }

  @override
  Iterable<ui.FlutterView> get views {
    final PreviewFlutterView? wrapper = _implicitView;
    if (wrapper == null) {
      return host.views;
    }
    return <ui.FlutterView>[
      for (final ui.FlutterView view in host.views)
        if (view.viewId == wrapper.viewId) wrapper else view,
    ];
  }

  @override
  int? get engineId => host.engineId;

  // ---------------------------------------------------------------------------
  // Simulatable getters.
  // ---------------------------------------------------------------------------

  @override
  ui.Locale get locale {
    final List<ui.Locale>? simulated = _simulation?.locales;
    if (simulated != null && simulated.isNotEmpty) {
      return simulated.first;
    }
    return host.locale;
  }

  @override
  List<ui.Locale> get locales => _simulation?.locales ?? host.locales;

  @override
  ui.Brightness get platformBrightness =>
      _simulation?.platformBrightness ?? host.platformBrightness;

  @override
  double get textScaleFactor =>
      _simulation?.textScaleFactor ?? host.textScaleFactor;

  /// Coherent with [textScaleFactor]: `SystemTextScaler` binds this
  /// dispatcher at construction and calls [scaleFontSize] per measurement,
  /// keying equality on [textScaleFactor]. Simulated scaling is linear.
  @override
  double scaleFontSize(double unscaledFontSize) {
    final double? simulated = _simulation?.textScaleFactor;
    if (simulated != null) {
      return unscaledFontSize * simulated;
    }
    return host.scaleFontSize(unscaledFontSize);
  }

  @override
  ui.AccessibilityFeatures get accessibilityFeatures {
    final SimulatedAccessibilityFeatures? simulated =
        _simulation?.accessibility;
    if (simulated == null) {
      return host.accessibilityFeatures;
    }
    return PreviewAccessibilityFeatures(
      host: host.accessibilityFeatures,
      simulated: simulated,
    );
  }

  @override
  bool get alwaysUse24HourFormat =>
      _simulation?.alwaysUse24HourFormat ?? host.alwaysUse24HourFormat;

  /// Runs the framework's basic best-match algorithm against the simulated
  /// locale list when locales are simulated; delegates otherwise.
  @override
  ui.Locale? computePlatformResolvedLocale(List<ui.Locale> supportedLocales) {
    final List<ui.Locale>? simulated = _simulation?.locales;
    if (simulated == null) {
      return host.computePlatformResolvedLocale(supportedLocales);
    }
    if (supportedLocales.isEmpty) {
      return null;
    }
    return basicLocaleListResolution(simulated, supportedLocales);
  }

  // ---------------------------------------------------------------------------
  // Store-and-forward callbacks (simulatable dimensions).
  // ---------------------------------------------------------------------------

  ui.VoidCallback? _onMetricsChanged;

  @override
  ui.VoidCallback? get onMetricsChanged => _onMetricsChanged;

  @override
  set onMetricsChanged(ui.VoidCallback? callback) {
    _onMetricsChanged = callback;
    host.onMetricsChanged = _handleHostMetricsChanged;
  }

  void _handleHostMetricsChanged() {
    // Always let the controller refresh the fit transform (a window resize
    // or host rotation changes the fit) and re-trigger handleMetricsChanged
    // when metric simulation is active.
    state.onHostMetricsChanged?.call();
    if (!state.simulatesMetrics) {
      _onMetricsChanged?.call();
    }
  }

  ui.VoidCallback? _onTextScaleFactorChanged;

  @override
  ui.VoidCallback? get onTextScaleFactorChanged => _onTextScaleFactorChanged;

  @override
  set onTextScaleFactorChanged(ui.VoidCallback? callback) {
    _onTextScaleFactorChanged = callback;
    host.onTextScaleFactorChanged = _handleHostTextScaleFactorChanged;
  }

  void _handleHostTextScaleFactorChanged() {
    if (_simulation?.textScaleFactor == null) {
      _onTextScaleFactorChanged?.call();
    }
  }

  ui.VoidCallback? _onPlatformBrightnessChanged;

  @override
  ui.VoidCallback? get onPlatformBrightnessChanged =>
      _onPlatformBrightnessChanged;

  @override
  set onPlatformBrightnessChanged(ui.VoidCallback? callback) {
    _onPlatformBrightnessChanged = callback;
    host.onPlatformBrightnessChanged = _handleHostPlatformBrightnessChanged;
  }

  void _handleHostPlatformBrightnessChanged() {
    if (_simulation?.platformBrightness == null) {
      _onPlatformBrightnessChanged?.call();
    }
  }

  ui.VoidCallback? _onLocaleChanged;

  @override
  ui.VoidCallback? get onLocaleChanged => _onLocaleChanged;

  @override
  set onLocaleChanged(ui.VoidCallback? callback) {
    _onLocaleChanged = callback;
    host.onLocaleChanged = _handleHostLocaleChanged;
  }

  void _handleHostLocaleChanged() {
    if (_simulation?.locales == null) {
      _onLocaleChanged?.call();
    }
  }

  ui.VoidCallback? _onAccessibilityFeaturesChanged;

  @override
  ui.VoidCallback? get onAccessibilityFeaturesChanged =>
      _onAccessibilityFeaturesChanged;

  @override
  set onAccessibilityFeaturesChanged(ui.VoidCallback? callback) {
    _onAccessibilityFeaturesChanged = callback;
    host.onAccessibilityFeaturesChanged =
        _handleHostAccessibilityFeaturesChanged;
  }

  void _handleHostAccessibilityFeaturesChanged() {
    // Always forwarded: the tri-state merge reads live host flags for every
    // null override, so a host change can change the merged value even while
    // accessibility is simulated.
    _onAccessibilityFeaturesChanged?.call();
  }

  ui.PointerDataPacketCallback? _onPointerDataPacket;

  @override
  ui.PointerDataPacketCallback? get onPointerDataPacket => _onPointerDataPacket;

  @override
  set onPointerDataPacket(ui.PointerDataPacketCallback? callback) {
    _onPointerDataPacket = callback;
    host.onPointerDataPacket = _handleHostPointerDataPacket;
  }

  void _handleHostPointerDataPacket(ui.PointerDataPacket packet) {
    state.observeHostPointers(packet);
    _onPointerDataPacket?.call(rewritePointerDataPacket(packet));
  }

  /// Rewrites [packet] into simulated physical coordinates when metric
  /// simulation is active, and relabels the pointer kind when the simulation
  /// asks for one.
  ///
  /// When neither applies the same packet object is forwarded untouched —
  /// zero-allocation fast path. Data targeting other views passes through
  /// untouched (multi-view simulation is unsupported).
  @visibleForTesting
  ui.PointerDataPacket rewritePointerDataPacket(ui.PointerDataPacket packet) {
    final PreviewFlutterView? wrapper = _implicitView;
    if (wrapper == null) {
      return packet;
    }
    final ui.PointerDeviceKind? kind =
        state.simulation?.effectivePointerKind;
    final double realRatio = wrapper.hostView.devicePixelRatio;
    final double simulatedRatio = wrapper.devicePixelRatio;
    final FitTransform fit = state.fit;
    final bool rewritesGeometry =
        state.simulatesMetrics &&
        !(fit == FitTransform.identity && realRatio == simulatedRatio);
    if (!rewritesGeometry && kind == null) {
      return packet;
    }
    final List<ui.PointerData> data = <ui.PointerData>[];
    for (final ui.PointerData datum in packet.data) {
      if (datum.viewId != wrapper.viewId) {
        data.add(datum);
        continue;
      }
      ui.PointerData? rewritten = rewritesGeometry
          ? rewritePointerData(datum, fit, realRatio, simulatedRatio)
          : datum;
      if (kind != null) {
        // Null drops the event: the simulated kind could not have produced it.
        rewritten = retargetPointerKind(rewritten, kind);
      }
      if (rewritten != null) {
        data.add(rewritten);
      }
    }
    return ui.PointerDataPacket(data: data);
  }

  /// Feeds [packet] through the host-side pointer trampoline, exactly as if
  /// the engine had delivered it to the real dispatcher.
  ///
  /// Used by the binding's `debugInjectPointerData` test seam.
  void debugReceiveHostPointerDataPacket(ui.PointerDataPacket packet) =>
      _handleHostPointerDataPacket(packet);

  // ---------------------------------------------------------------------------
  // Pass-through callbacks (no simulation semantics) — direct delegation, so
  // zone capture matches the host's own behavior exactly.
  // ---------------------------------------------------------------------------

  @override
  ui.VoidCallback? get onPlatformConfigurationChanged =>
      host.onPlatformConfigurationChanged;

  @override
  set onPlatformConfigurationChanged(ui.VoidCallback? callback) =>
      host.onPlatformConfigurationChanged = callback;

  @override
  ui.ViewFocusChangeCallback? get onViewFocusChange => host.onViewFocusChange;

  @override
  set onViewFocusChange(ui.ViewFocusChangeCallback? callback) =>
      host.onViewFocusChange = callback;

  @override
  ui.FrameCallback? get onBeginFrame => host.onBeginFrame;

  @override
  set onBeginFrame(ui.FrameCallback? callback) => host.onBeginFrame = callback;

  @override
  ui.VoidCallback? get onDrawFrame => host.onDrawFrame;

  @override
  set onDrawFrame(ui.VoidCallback? callback) => host.onDrawFrame = callback;

  @override
  ui.HitTestCallback? get onHitTest => host.onHitTest;

  @override
  set onHitTest(ui.HitTestCallback? callback) => host.onHitTest = callback;

  @override
  ui.KeyDataCallback? get onKeyData => host.onKeyData;

  @override
  set onKeyData(ui.KeyDataCallback? callback) => host.onKeyData = callback;

  @override
  ui.TimingsCallback? get onReportTimings => host.onReportTimings;

  @override
  set onReportTimings(ui.TimingsCallback? callback) =>
      host.onReportTimings = callback;

  @override
  ui.PlatformMessageCallback? get onPlatformMessage => host.onPlatformMessage;

  @override
  set onPlatformMessage(ui.PlatformMessageCallback? callback) =>
      host.onPlatformMessage = callback;

  @override
  ui.VoidCallback? get onSystemFontFamilyChanged =>
      host.onSystemFontFamilyChanged;

  @override
  set onSystemFontFamilyChanged(ui.VoidCallback? callback) =>
      host.onSystemFontFamilyChanged = callback;

  @override
  ui.VoidCallback? get onSemanticsEnabledChanged =>
      host.onSemanticsEnabledChanged;

  @override
  set onSemanticsEnabledChanged(ui.VoidCallback? callback) =>
      host.onSemanticsEnabledChanged = callback;

  @override
  ui.SemanticsActionEventCallback? get onSemanticsActionEvent =>
      host.onSemanticsActionEvent;

  @override
  set onSemanticsActionEvent(ui.SemanticsActionEventCallback? callback) =>
      host.onSemanticsActionEvent = callback;

  @override
  ui.VoidCallback? get onFrameDataChanged => host.onFrameDataChanged;

  @override
  set onFrameDataChanged(ui.VoidCallback? callback) =>
      host.onFrameDataChanged = callback;

  @override
  ui.ErrorCallback? get onError => host.onError;

  @override
  set onError(ui.ErrorCallback? callback) => host.onError = callback;

  // ---------------------------------------------------------------------------
  // Pure delegation — engine side effects and non-simulated state.
  // ---------------------------------------------------------------------------

  @override
  void requestViewFocusChange({
    required int viewId,
    required ui.ViewFocusState state,
    required ui.ViewFocusDirection direction,
  }) => host.requestViewFocusChange(
    viewId: viewId,
    state: state,
    direction: direction,
  );

  @override
  void sendPlatformMessage(
    String name,
    ByteData? data,
    ui.PlatformMessageResponseCallback? callback,
  ) => host.sendPlatformMessage(name, data, callback);

  // The [port] parameter is declared as [Object] because the dart:ui
  // interface differs per platform: native declares `SendPort port` while the
  // web SDK declares `Object port` (dart:isolate is unavailable there). An
  // [Object] parameter is a valid contravariant override of both; the
  // `as dynamic` cast lets the delegation compile against native's narrower
  // `SendPort` parameter without importing dart:isolate.
  @override
  void sendPortPlatformMessage(
    String name,
    ByteData? data,
    int identifier,
    Object port,
  ) => host.sendPortPlatformMessage(name, data, identifier, port as dynamic);

  @override
  void registerBackgroundIsolate(ui.RootIsolateToken token) =>
      host.registerBackgroundIsolate(token);

  @override
  void setSemanticsTreeEnabled(bool enabled) =>
      host.setSemanticsTreeEnabled(enabled);

  @override
  void setIsolateDebugName(String name) => host.setIsolateDebugName(name);

  @override
  void requestDartPerformanceMode(ui.DartPerformanceMode mode) =>
      host.requestDartPerformanceMode(mode);

  @override
  ByteData? getPersistentIsolateData() => host.getPersistentIsolateData();

  @override
  void scheduleFrame() => host.scheduleFrame();

  @override
  void scheduleWarmUpFrame({
    required ui.VoidCallback beginFrame,
    required ui.VoidCallback drawFrame,
  }) => host.scheduleWarmUpFrame(beginFrame: beginFrame, drawFrame: drawFrame);

  @override
  void updateSemantics(ui.SemanticsUpdate update) =>
      host.updateSemantics(update);

  @override
  void setApplicationLocale(ui.Locale locale) =>
      host.setApplicationLocale(locale);

  @override
  String get initialLifecycleState => host.initialLifecycleState;

  @override
  double? get lineHeightScaleFactorOverride =>
      host.lineHeightScaleFactorOverride;

  @override
  double? get letterSpacingOverride => host.letterSpacingOverride;

  @override
  double? get wordSpacingOverride => host.wordSpacingOverride;

  @override
  double? get paragraphSpacingOverride => host.paragraphSpacingOverride;

  @override
  bool get nativeSpellCheckServiceDefined =>
      host.nativeSpellCheckServiceDefined;

  @override
  bool get supportsShowingSystemContextMenu =>
      host.supportsShowingSystemContextMenu;

  @override
  bool get brieflyShowPassword => host.brieflyShowPassword;

  @override
  String? get systemFontFamily => host.systemFontFamily;

  @override
  bool get semanticsEnabled => host.semanticsEnabled;

  @override
  ui.FrameData get frameData => host.frameData;

  @override
  String get defaultRouteName => host.defaultRouteName;

  @override
  String toString() => 'PreviewPlatformDispatcher(host: $host)';
}

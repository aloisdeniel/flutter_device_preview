import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../model/simulation.dart';
import 'preview_state.dart';
import 'preview_values.dart';

/// A wrapper [ui.FlutterView] that reports simulated screen metrics.
///
/// One instance is created per process and cached forever — view identity is
/// load-bearing (`PlatformDispatcher.implicitView` asserts stability and the
/// framework's `_DeprecatedRawViewKey` compares views with `identical`).
///
/// Every interface member is implemented explicitly (no `noSuchMethod`):
/// SDK interface drift is a compile error by design.
///
/// When no metric simulation is active, every member is a one-line delegation
/// to [hostView].
class PreviewFlutterView implements ui.FlutterView {
  /// Creates a wrapper over [hostView].
  ///
  /// [platformDispatcher] must be the wrapper dispatcher that owns this view,
  /// so that `MediaQueryData.fromView` reads simulated dispatcher values
  /// through `view.platformDispatcher`.
  PreviewFlutterView({
    required this.hostView,
    required ui.PlatformDispatcher platformDispatcher,
    required this.state,
  }) : _platformDispatcher = platformDispatcher;

  /// The real engine view every engine-side effect delegates to.
  final ui.FlutterView hostView;

  /// The shared simulation state.
  final PreviewState state;

  final ui.PlatformDispatcher _platformDispatcher;

  /// The active simulation when it simulates screen metrics, else null.
  ///
  /// Metric members (size, ratio, paddings, insets, features) simulate only
  /// when [DeviceSimulation.screenSize] is set; a lone
  /// [DeviceSimulation.devicePixelRatio] without a screen size has no effect.
  DeviceSimulation? get _metricSimulation {
    final DeviceSimulation? simulation = state.simulation;
    if (simulation == null || !simulation.simulatesMetrics) {
      return null;
    }
    return simulation;
  }

  // ---------------------------------------------------------------------------
  // Identity — always the real values.
  // ---------------------------------------------------------------------------

  /// The real implicit view id.
  ///
  /// Load-bearing: pointer `PointerData.viewId`, the framework's
  /// `_viewIdToRenderView` keying, and the render/semantics natives all rely
  /// on the wrapper reporting the real id.
  @override
  int get viewId => hostView.viewId;

  @override
  ui.PlatformDispatcher get platformDispatcher => _platformDispatcher;

  @override
  ui.Display get display => hostView.display;

  // ---------------------------------------------------------------------------
  // Simulated metrics.
  // ---------------------------------------------------------------------------

  @override
  double get devicePixelRatio =>
      _metricSimulation?.devicePixelRatio ?? hostView.devicePixelRatio;

  @override
  ui.Size get physicalSize {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.physicalSize;
    }
    final ui.Size logical = simulation.screenSize!;
    final double ratio = devicePixelRatio;
    return ui.Size(logical.width * ratio, logical.height * ratio);
  }

  @override
  ui.ViewConstraints get physicalConstraints => _metricSimulation == null
      ? hostView.physicalConstraints
      : ui.ViewConstraints.tight(physicalSize);

  @override
  ui.ViewPadding get padding {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.padding;
    }
    return PreviewViewPadding.fromEdgeInsets(
      simulation.padding ?? EdgeInsets.zero,
      devicePixelRatio,
    );
  }

  @override
  ui.ViewPadding get viewPadding {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.viewPadding;
    }
    return PreviewViewPadding.fromEdgeInsets(
      simulation.viewPadding ?? simulation.padding ?? EdgeInsets.zero,
      devicePixelRatio,
    );
  }

  @override
  ui.ViewPadding get systemGestureInsets {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.systemGestureInsets;
    }
    return PreviewViewPadding.fromEdgeInsets(
      simulation.systemGestureInsets ?? EdgeInsets.zero,
      devicePixelRatio,
    );
  }

  /// The real keyboard inset mapped into simulated space.
  ///
  /// `simInsetLogical = hostInsetPhysical / realDPR / fit.scale`, returned at
  /// the simulated device pixel ratio. Text fields keep avoiding the real
  /// keyboard; geometry is host-faithful, not device-faithful.
  @override
  ui.ViewPadding get viewInsets {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.viewInsets;
    }
    final ui.ViewPadding hostInsets = hostView.viewInsets;
    final double k =
        devicePixelRatio / (hostView.devicePixelRatio * state.fit.scale);
    return PreviewViewPadding(
      left: hostInsets.left * k,
      top: hostInsets.top * k,
      right: hostInsets.right * k,
      bottom: hostInsets.bottom * k,
    );
  }

  /// Gesture slop rescaled so a drag requires the same physical finger
  /// travel on the real screen as without simulation.
  ///
  /// `DeviceGestureSettings.fromView` divides `physicalTouchSlop` by this
  /// view's (simulated) device pixel ratio, hence:
  /// `slop' = hostSlop / realDPR / fit.scale × simDPR`.
  @override
  ui.GestureSettings get gestureSettings {
    final DeviceSimulation? simulation = _metricSimulation;
    final ui.GestureSettings host = hostView.gestureSettings;
    if (simulation == null) {
      return host;
    }
    final double k =
        devicePixelRatio / (hostView.devicePixelRatio * state.fit.scale);
    double? rescale(double? slop) => slop == null ? null : slop * k;
    return ui.GestureSettings(
      physicalTouchSlop: rescale(host.physicalTouchSlop),
      physicalDoubleTapSlop: rescale(host.physicalDoubleTapSlop),
    );
  }

  /// Simulated display features, or `const []` while simulating metrics
  /// without any.
  ///
  /// [ui.DisplayFeature.bounds] is documented in logical pixels, so the
  /// simulated bounds are passed through unscaled.
  @override
  List<ui.DisplayFeature> get displayFeatures {
    final DeviceSimulation? simulation = _metricSimulation;
    if (simulation == null) {
      return hostView.displayFeatures;
    }
    final List<SimulatedDisplayFeature>? features = simulation.displayFeatures;
    if (features == null || features.isEmpty) {
      return const <ui.DisplayFeature>[];
    }
    return <ui.DisplayFeature>[
      for (final SimulatedDisplayFeature feature in features)
        ui.DisplayFeature(
          bounds: feature.bounds,
          type: feature.type,
          state: feature.state,
        ),
    ];
  }

  /// Null while simulating metrics (a simulated device has no known corner
  /// radii); the host value otherwise.
  @override
  ui.DisplayCornerRadii? get displayCornerRadii =>
      _metricSimulation == null ? hostView.displayCornerRadii : null;

  // ---------------------------------------------------------------------------
  // Engine side effects — always delegated to the real view.
  // ---------------------------------------------------------------------------

  /// Delegates to the real view, forcing [size] to the real physical size
  /// while simulating metrics (belt-and-braces with
  /// `PreviewViewConfiguration.toPhysicalSize`): rendering with a simulated
  /// physical size is undefined behavior on the real surface.
  @override
  void render(ui.Scene scene, {ui.Size? size}) {
    hostView.render(
      scene,
      size: _metricSimulation == null ? size : hostView.physicalSize,
    );
  }

  @override
  void updateSemantics(ui.SemanticsUpdate update) =>
      hostView.updateSemantics(update);

  @override
  String toString() => 'PreviewFlutterView(id: $viewId, host: $hostView)';
}

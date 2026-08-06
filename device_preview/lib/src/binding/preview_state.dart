import 'dart:ui' as ui;

import '../model/fit_transform.dart';
import '../model/simulation.dart';

/// Shared mutable simulation state, owned by the binding mixin and read live
/// by the wrapper dispatcher and view.
///
/// This object is internal: it is never exported from the package. All
/// simulation math stays in the pure model classes; this is only the mailbox
/// through which the controller publishes the active simulation to the
/// wrappers.
class PreviewState {
  /// The active simulation, or null when passing through.
  DeviceSimulation? simulation;

  /// The current scale-to-fit mapping ([FitTransform.identity] when no
  /// metric simulation is active).
  FitTransform fit = FitTransform.identity;

  /// Invoked by the wrapper dispatcher's real `onMetricsChanged` trampoline
  /// before applying the swallow-vs-forward policy.
  ///
  /// The controller uses it to recompute [fit] (window resizes and host
  /// rotations change the fit) and to trigger `handleMetricsChanged()` when
  /// metric simulation is active.
  ui.VoidCallback? onHostMetricsChanged;

  /// Whether the active simulation simulates screen metrics.
  bool get simulatesMetrics => simulation?.simulatesMetrics ?? false;
}

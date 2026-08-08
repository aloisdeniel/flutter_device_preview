import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

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

  /// Listenable form of [fit], for painters that must repaint when the
  /// letterbox moves (the background decoration render object). Notifies only
  /// on value changes — [FitTransform] compares by value.
  final ValueNotifier<FitTransform> fitNotifier = ValueNotifier<FitTransform>(
    FitTransform.identity,
  );

  /// The current scale-to-fit mapping ([FitTransform.identity] when no
  /// metric simulation is active).
  FitTransform get fit => fitNotifier.value;
  set fit(FitTransform value) => fitNotifier.value = value;

  /// Invoked by the wrapper dispatcher's real `onMetricsChanged` trampoline
  /// before applying the swallow-vs-forward policy.
  ///
  /// The controller uses it to recompute [fit] (window resizes and host
  /// rotations change the fit) and to trigger `handleMetricsChanged()` when
  /// metric simulation is active.
  ui.VoidCallback? onHostMetricsChanged;

  /// Invoked by the controller when [DeviceSimulation.simulatesTouch]
  /// changes.
  ///
  /// The binding uses it to send the host's mouse out of the window:
  /// relabelled pointers stop producing hover events, so without this whatever
  /// was hovered when the switch flipped would stay hovered forever.
  ui.VoidCallback? onPointerKindChanged;

  /// Host mouse devices seen in the window, and the last timestamp any pointer
  /// carried — everything needed to synthesize a departure for them later.
  ///
  /// Fed from wherever host pointer data enters (the wrapper dispatcher's
  /// trampoline in production, the binding's inject seam in tests), so the
  /// two compositions share one view of which mice exist.
  final Set<int> hostMouseDevices = <int>{};

  /// The timestamp of the last host pointer datum seen.
  Duration lastPointerTimeStamp = Duration.zero;

  /// Records the mouse devices of [packet].
  void observeHostPointers(ui.PointerDataPacket packet) {
    for (final ui.PointerData datum in packet.data) {
      lastPointerTimeStamp = datum.timeStamp;
      if (datum.kind != ui.PointerDeviceKind.mouse) {
        continue;
      }
      if (datum.change == ui.PointerChange.remove) {
        hostMouseDevices.remove(datum.device);
      } else {
        hostMouseDevices.add(datum.device);
      }
    }
  }

  /// Whether the active simulation simulates screen metrics.
  bool get simulatesMetrics => simulation?.simulatesMetrics ?? false;
}

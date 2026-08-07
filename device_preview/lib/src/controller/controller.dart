import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../presets.dart';
import '../binding/preview_state.dart';
import '../model/fit_transform.dart';
import '../model/real_device_info.dart';
import '../model/simulation.dart';

/// Programmatic control surface for device simulation.
///
/// All mutation methods are safe any time after binding initialization;
/// concurrent calls are serialized in call order. Returned futures complete
/// when the change has fully propagated (only
/// [DeviceSimulation.targetPlatform] changes do heavy work — a debug-only
/// reassemble).
abstract class DevicePreviewController implements Listenable {
  /// The active simulation, or null when passing through (real device).
  DeviceSimulation? get simulation;

  /// Listenable view of [simulation].
  ValueListenable<DeviceSimulation?> get simulationListenable;

  /// Metrics of the real host device (never simulated, always live).
  RealDeviceInfo get realDevice;

  /// The current scale-to-fit mapping. [FitTransform.identity] when no
  /// metric simulation is active.
  FitTransform get fitTransform;

  /// Replaces the active simulation wholesale. `null` fields = real device.
  Future<void> apply(DeviceSimulation simulation);

  /// Partial update on top of the current simulation (empty simulation if
  /// none active):
  ///
  /// ```dart
  /// await c.update((s) => s.copyWith(platformBrightness: Brightness.dark));
  /// ```
  Future<void> update(
    DeviceSimulation Function(DeviceSimulation current) mutate,
  );

  /// Builds a simulation from [preset] and applies it, preserving active
  /// non-metric overrides (locale, brightness, text scale, accessibility,
  /// platform) unless [resetOverrides] is true.
  Future<void> applyPreset(
    DevicePreset preset, {
    Orientation orientation = Orientation.portrait,
    bool resetOverrides = false,
  });

  /// Swaps screen dimensions and rotates safe areas (uses the preset's
  /// per-orientation safe areas when [DeviceSimulation.presetId] resolves,
  /// else the documented rotation rule).
  Future<void> setOrientation(Orientation orientation);

  /// Clears the simulation entirely (pass-through).
  Future<void> reset();

  /// Presets reported to DevTools. Seeded with [DevicePresets.all].
  List<DevicePreset> get presets;

  /// Appends a custom preset and posts `device_preview.presetsChanged`.
  void registerPreset(DevicePreset preset);
}

/// Concrete [DevicePreviewController].
///
/// Constructor-injected with the binding's `@protected` change handlers so
/// the class stays binding-free and unit-testable. The change propagation
/// table:
///
/// | Changed fields | Trigger |
/// |---|---|
/// | screenSize / frame / devicePixelRatio / padding / viewPadding / systemGestureInsets / displayFeatures / orientation / alwaysUse24HourFormat | recompute fit, then `handleMetricsChanged()` |
/// | textScaleFactor | `handleTextScaleFactorChanged()` |
/// | platformBrightness | `handlePlatformBrightnessChanged()` |
/// | locales | `handleLocaleChanged()` |
/// | accessibility | `handleAccessibilityFeaturesChanged()` |
/// | targetPlatform | debug-only override + `reassembleApplication()` |
class DevicePreviewControllerImpl implements DevicePreviewController {
  /// Creates a controller over the shared [state].
  DevicePreviewControllerImpl({
    required this.state,
    required this.hostView,
    required this.hostDispatcher,
    required VoidCallback handleMetricsChanged,
    required VoidCallback handleTextScaleFactorChanged,
    required VoidCallback handlePlatformBrightnessChanged,
    required VoidCallback handleLocaleChanged,
    required VoidCallback handleAccessibilityFeaturesChanged,
    required Future<void> Function(TargetPlatform? platform)
    applyTargetPlatformOverride,
    List<DevicePreset>? initialPresets,
  }) : _handleMetricsChanged = handleMetricsChanged,
       _handleTextScaleFactorChanged = handleTextScaleFactorChanged,
       _handlePlatformBrightnessChanged = handlePlatformBrightnessChanged,
       _handleLocaleChanged = handleLocaleChanged,
       _handleAccessibilityFeaturesChanged = handleAccessibilityFeaturesChanged,
       _applyTargetPlatformOverride = applyTargetPlatformOverride,
       _realTargetPlatform = defaultTargetPlatform,
       _presets = List<DevicePreset>.of(initialPresets ?? DevicePresets.all) {
    state.onHostMetricsChanged = handleHostMetricsChanged;
  }

  /// The shared simulation state read live by the wrappers.
  final PreviewState state;

  /// The real (host) implicit view.
  final ui.FlutterView hostView;

  /// The real (host) platform dispatcher.
  final ui.PlatformDispatcher hostDispatcher;

  final VoidCallback _handleMetricsChanged;
  final VoidCallback _handleTextScaleFactorChanged;
  final VoidCallback _handlePlatformBrightnessChanged;
  final VoidCallback _handleLocaleChanged;
  final VoidCallback _handleAccessibilityFeaturesChanged;
  final Future<void> Function(TargetPlatform? platform)
  _applyTargetPlatformOverride;

  /// The real target platform, captured before any override is applied.
  final TargetPlatform _realTargetPlatform;

  final List<DevicePreset> _presets;

  final ValueNotifier<DeviceSimulation?> _simulation =
      ValueNotifier<DeviceSimulation?>(null);

  /// Invoked after every successful apply/reset with the
  /// `device_preview.stateChanged` event payload. Wired to
  /// `developer.postEvent` by the service extension glue.
  void Function(Map<String, Object?> eventData)? onStateChanged;

  /// Invoked on [registerPreset] with the new preset count. Wired to
  /// `developer.postEvent` by the service extension glue.
  void Function(int count)? onPresetsChanged;

  bool _warnedAboutBrightnessOverride = false;

  @override
  void addListener(VoidCallback listener) => _simulation.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _simulation.removeListener(listener);

  @override
  DeviceSimulation? get simulation => _simulation.value;

  @override
  ValueListenable<DeviceSimulation?> get simulationListenable => _simulation;

  @override
  RealDeviceInfo get realDevice {
    final double ratio = hostView.devicePixelRatio;
    return RealDeviceInfo(
      logicalSize: hostView.physicalSize / ratio,
      physicalSize: hostView.physicalSize,
      devicePixelRatio: ratio,
      padding: EdgeInsets.fromViewPadding(hostView.padding, ratio),
      locales: hostDispatcher.locales,
      platformBrightness: hostDispatcher.platformBrightness,
      textScaleFactor: hostDispatcher.textScaleFactor,
      targetPlatform: _realTargetPlatform,
    );
  }

  @override
  FitTransform get fitTransform => state.fit;

  /// Recomputes [fitTransform] from the current host metrics and the active
  /// simulation.
  void recomputeFit() {
    final DeviceSimulation? active = state.simulation;
    if (active == null || !active.simulatesMetrics) {
      state.fit = FitTransform.identity;
      return;
    }
    state.fit = FitTransform.compute(
      realLogicalSize: hostView.physicalSize / hostView.devicePixelRatio,
      simulatedLogicalSize: active.screenSize!,
      // Reserve room for the device body, which surrounds the screen.
      contentBounds: active.contentBounds,
    );
  }

  /// Reacts to a real (host) metrics change reported by the wrapper
  /// dispatcher's trampoline: refreshes the fit and re-propagates metrics
  /// when metric simulation is active (the trampoline swallowed the host
  /// notification in that case).
  void handleHostMetricsChanged() {
    recomputeFit();
    if (state.simulatesMetrics) {
      _handleMetricsChanged();
    }
  }

  @override
  Future<void> apply(DeviceSimulation simulation) => applyTagged(simulation);

  @override
  Future<void> update(
    DeviceSimulation Function(DeviceSimulation current) mutate,
  ) {
    // The mutation base is read inside the serialized queue (and from
    // [state], the committed truth), so an update issued while another apply
    // is still propagating builds on top of it instead of a stale snapshot.
    return _enqueue(
      () => _applyNow(
        mutate(state.simulation ?? const DeviceSimulation()),
        source: 'programmatic',
      ),
    );
  }

  @override
  Future<void> reset() => applyTagged(null);

  @override
  Future<void> applyPreset(
    DevicePreset preset, {
    Orientation orientation = Orientation.portrait,
    bool resetOverrides = false,
  }) {
    return _enqueue(
      () => _applyNow(
        _resolvePresetSimulation(
          preset,
          orientation: orientation,
          resetOverrides: resetOverrides,
        ),
        source: 'programmatic',
      ),
    );
  }

  DeviceSimulation _resolvePresetSimulation(
    DevicePreset preset, {
    required Orientation orientation,
    required bool resetOverrides,
  }) {
    DeviceSimulation next = preset.resolve(orientation: orientation);
    final DeviceSimulation? current = state.simulation;
    if (!resetOverrides && current != null) {
      next = next.copyWith(
        locales: current.locales,
        platformBrightness: current.platformBrightness,
        textScaleFactor: current.textScaleFactor,
        accessibility: current.accessibility,
        alwaysUse24HourFormat: current.alwaysUse24HourFormat,
        targetPlatform: current.targetPlatform,
      );
    }
    return next;
  }

  @override
  Future<void> setOrientation(Orientation orientation) {
    return _enqueue(() {
      final DeviceSimulation? current = state.simulation;
      if (current == null || !current.simulatesMetrics) {
        return Future<void>.value();
      }
      if (current.orientation == orientation) {
        return Future<void>.value();
      }
      final String? presetId = current.presetId;
      if (presetId != null) {
        final DevicePreset? preset = _presetById(presetId);
        if (preset != null) {
          return _applyNow(
            _resolvePresetSimulation(
              preset,
              orientation: orientation,
              resetOverrides: false,
            ),
            source: 'programmatic',
          );
        }
      }
      // Documented rotation rule (and its inverse for landscape → portrait).
      EdgeInsets? rotate(EdgeInsets? insets) {
        if (insets == null) {
          return null;
        }
        return orientation == Orientation.landscape
            ? DevicePreset.rotateToLandscape(insets)
            : EdgeInsets.only(top: insets.left, bottom: insets.bottom);
      }

      final ui.Size size = current.screenSize!;
      // Display features are geometry: map them through the 90° rotation so
      // hinge/fold bounds keep describing the same physical location.
      // systemGestureInsets intentionally pass through unchanged — their edge
      // semantics (back-gesture side edges, home area at the bottom) are
      // orientation-invariant on real devices.
      final List<SimulatedDisplayFeature>? features = current.displayFeatures;
      return _applyNow(
        current.copyWith(
          orientation: orientation,
          screenSize: ui.Size(size.height, size.width),
          padding: rotate(current.padding),
          viewPadding: rotate(current.viewPadding),
          displayFeatures: features == null
              ? null
              : List<SimulatedDisplayFeature>.unmodifiable(
                  orientation == Orientation.landscape
                      ? features.map(
                          (SimulatedDisplayFeature f) =>
                              f.rotatedToLandscape(size.width),
                        )
                      : features.map(
                          (SimulatedDisplayFeature f) =>
                              f.rotatedToPortrait(size.height),
                        ),
                ),
        ),
        source: 'programmatic',
      );
    });
  }

  DevicePreset? _presetById(String id) {
    for (final DevicePreset preset in _presets) {
      if (preset.id == id) {
        return preset;
      }
    }
    return null;
  }

  /// Tail of the serialized apply queue, or null when no apply is in flight.
  ///
  /// A targetPlatform change awaits a full `reassembleApplication()` (tens to
  /// hundreds of ms in debug); the queue guarantees a second apply issued
  /// during that window runs strictly after it instead of interleaving —
  /// interleaving could otherwise leave the rendered and the reported
  /// simulation permanently divergent.
  Future<void>? _applyQueue;

  /// Runs [task] after every previously enqueued apply has completed.
  ///
  /// When the queue is idle, [task] starts synchronously — this keeps the
  /// non-overlapping case free of extra microtask hops (fake-async test
  /// environments only pump microtasks scheduled in their own zone, so a hop
  /// through a queue future created in another zone would deadlock them).
  /// The queue survives a throwing task (the error still surfaces through the
  /// future returned to that task's caller).
  Future<void> _enqueue(Future<void> Function() task) {
    final Future<void>? previous = _applyQueue;
    final Future<void> result = previous == null
        ? task()
        : previous.then((_) => task());
    final Future<void> tail = result.catchError((Object _) {});
    _applyQueue = tail;
    tail.whenComplete(() {
      if (identical(_applyQueue, tail)) {
        _applyQueue = null;
      }
    });
    return result;
  }

  /// Applies (or, with null, clears) the simulation, tagging the resulting
  /// `device_preview.stateChanged` event with [source] and echoing
  /// [requestId] when provided.
  ///
  /// Applies are serialized: concurrent calls run strictly in call order, so
  /// none can observe (or clobber) another one's in-flight propagation.
  Future<void> applyTagged(
    DeviceSimulation? next, {
    String source = 'programmatic',
    String? requestId,
  }) => _enqueue(() => _applyNow(next, source: source, requestId: requestId));

  Future<void> _applyNow(
    DeviceSimulation? next, {
    required String source,
    String? requestId,
  }) async {
    final DeviceSimulation? previous = state.simulation;

    _maybeWarnAboutBrightnessOverride(next);

    final bool metricsChanged =
        previous?.screenSize != next?.screenSize ||
        previous?.frame != next?.frame ||
        previous?.devicePixelRatio != next?.devicePixelRatio ||
        previous?.padding != next?.padding ||
        previous?.viewPadding != next?.viewPadding ||
        previous?.systemGestureInsets != next?.systemGestureInsets ||
        !listEquals(previous?.displayFeatures, next?.displayFeatures) ||
        (previous?.orientation ?? Orientation.portrait) !=
            (next?.orientation ?? Orientation.portrait) ||
        previous?.alwaysUse24HourFormat != next?.alwaysUse24HourFormat;
    final bool textScaleChanged =
        previous?.textScaleFactor != next?.textScaleFactor;
    final bool brightnessChanged =
        previous?.platformBrightness != next?.platformBrightness;
    final bool localesChanged = !listEquals(previous?.locales, next?.locales);
    final bool accessibilityChanged =
        previous?.accessibility != next?.accessibility;
    final bool platformChanged =
        previous?.targetPlatform != next?.targetPlatform;

    // Commit the rendered state (read live by the wrappers) and the reported
    // state ([simulation] / listeners) together, before any asynchronous
    // propagation work, so the two can never diverge.
    state.simulation = next;
    recomputeFit();
    _simulation.value = next;

    try {
      if (metricsChanged) {
        _handleMetricsChanged();
      }
      if (textScaleChanged) {
        _handleTextScaleFactorChanged();
      }
      if (brightnessChanged) {
        _handlePlatformBrightnessChanged();
      }
      if (localesChanged) {
        _handleLocaleChanged();
      }
      if (accessibilityChanged) {
        _handleAccessibilityFeaturesChanged();
      }
      if (platformChanged) {
        await _applyTargetPlatformOverride(next?.targetPlatform);
      }
    } finally {
      // Posted even when propagation throws (e.g. a failing reassemble): the
      // state HAS changed above, and observers such as the DevTools panel
      // must not be left holding a stale view of it.
      onStateChanged?.call(<String, Object?>{
        'simulation': next?.toJson(),
        'fit': state.fit.toJson(),
        'source': source,
        'requestId': ?requestId,
      });
    }
  }

  void _maybeWarnAboutBrightnessOverride(DeviceSimulation? next) {
    if (!kDebugMode || _warnedAboutBrightnessOverride) {
      return;
    }
    if (next?.platformBrightness != null && debugBrightnessOverride != null) {
      _warnedAboutBrightnessOverride = true;
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: FlutterError(
            'A device_preview brightness simulation was applied while '
            'debugBrightnessOverride is set.\n'
            'The two silently compete: MediaQuery prefers '
            'debugBrightnessOverride when there is no ancestor MediaQuery. '
            'Consider clearing debugBrightnessOverride while simulating '
            'brightness with device_preview.',
          ),
          library: 'device_preview',
          context: ErrorDescription('while applying a device simulation'),
        ),
      );
    }
  }

  @override
  List<DevicePreset> get presets => List<DevicePreset>.unmodifiable(_presets);

  @override
  void registerPreset(DevicePreset preset) {
    _presets.add(preset);
    onPresetsChanged?.call(_presets.length);
  }

  /// Releases resources. Called by nothing in production (the controller
  /// lives for the process lifetime); exposed for tests.
  @visibleForTesting
  void dispose() => _simulation.dispose();
}

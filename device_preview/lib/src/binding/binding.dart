import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../controller/controller.dart';
import '../model/pointer_rewrite.dart';
import '../model/simulation.dart';
import '../service/extensions.dart';
import '../service/protocol.dart';
import '../service/screenshot.dart';
import 'preview_flutter_view.dart';
import 'preview_platform_dispatcher.dart';
import 'preview_state.dart';
import 'preview_view_configuration.dart';

/// The simulation machinery as a mixin, so it can be layered onto other
/// binding stacks (test / integration-test bindings). Apply it LAST.
///
/// The mixin owns the shared simulation state, the wrapper dispatcher/view
/// pair, the controller, the `createViewConfigurationFor` seam, and the
/// `ext.device_preview.*` service extensions.
///
/// ## The `platformDispatcher` seam
///
/// Concrete bindings route the framework through the wrapper dispatcher by
/// overriding [BindingBase.platformDispatcher]:
///
/// ```dart
/// @override
/// ui.PlatformDispatcher get platformDispatcher => previewPlatformDispatcher;
/// ```
///
/// [DevicePreview] does exactly that. The override intentionally
/// lives in the concrete class rather than in this mixin: flutter_test's
/// `TestWidgetsFlutterBinding` narrows the getter's type to
/// `TestPlatformDispatcher`, so a mixin-level `ui.PlatformDispatcher`
/// override would be an invalid override in `... with
/// DevicePreviewBindingMixin` applications over test bindings. When layered
/// over a test binding (which cannot re-route the getter), simulation flows
/// through the wrapper view instead: wrap the app in
/// `View(view: previewImplicitView!, child: ...)` (typically from a
/// `wrapWithDefaultView` override) and MediaQuery, root layout, and the fit
/// matrix all follow.
mixin DevicePreviewBindingMixin
    on
        BindingBase,
        GestureBinding,
        SchedulerBinding,
        ServicesBinding,
        PaintingBinding,
        SemanticsBinding,
        RendererBinding,
        WidgetsBinding {
  static bool _latchedEnabled = kDebugMode;
  static DeviceSimulation? _latchedInitialSimulation;

  /// Latches the configuration consumed by the next binding constructed
  /// with this mixin. Must be called before the binding is constructed;
  /// [DevicePreview.enable] does this automatically.
  static void latchConfiguration({
    bool enabled = kDebugMode,
    DeviceSimulation? initialSimulation,
  }) {
    _latchedEnabled = enabled;
    _latchedInitialSimulation = initialSimulation;
  }

  /// Whether simulation machinery is installed. Latched before init and
  /// fixed for the binding's lifetime.
  late final bool simulationEnabled = _latchedEnabled;

  final PreviewState _state = PreviewState();
  PreviewPlatformDispatcher? _previewDispatcher;
  DevicePreviewControllerImpl? _controller;

  /// The controller, or null when [simulationEnabled] is false (or no
  /// implicit view exists to simulate).
  DevicePreviewController? get devicePreview => _controller;

  ui.PlatformDispatcher get _hostPlatformDispatcher => super.platformDispatcher;

  /// The wrapper dispatcher when simulation is enabled, or the host
  /// dispatcher (zero interposition) when disabled.
  ///
  /// Created lazily with `??=` so init-order concerns vanish: the wrapper
  /// pair exists from the first touch, and both instances are cached for the
  /// process lifetime (identity is load-bearing).
  @protected
  ui.PlatformDispatcher get previewPlatformDispatcher {
    if (!simulationEnabled) {
      return super.platformDispatcher;
    }
    return _previewDispatcher ??= PreviewPlatformDispatcher(
      host: super.platformDispatcher,
      state: _state,
    );
  }

  /// The wrapper view over the host's implicit view, or null when simulation
  /// is disabled or the host has no implicit view.
  ///
  /// Compositions that cannot re-route [BindingBase.platformDispatcher]
  /// (test bindings) wrap their root widget in a `View` using this instance.
  ui.FlutterView? get previewImplicitView {
    if (!simulationEnabled) {
      return null;
    }
    return (previewPlatformDispatcher as PreviewPlatformDispatcher)
        .previewImplicitView;
  }

  @override
  void initInstances() {
    super.initInstances();
    if (!simulationEnabled) {
      return;
    }
    final PreviewPlatformDispatcher dispatcher =
        previewPlatformDispatcher as PreviewPlatformDispatcher;
    final ui.FlutterView? hostView = dispatcher.host.implicitView;
    if (hostView == null) {
      // Nothing to simulate without an implicit view (multi-view-only
      // embeddings are unsupported for simulation).
      return;
    }
    _controller = DevicePreviewControllerImpl(
      state: _state,
      hostView: hostView,
      hostDispatcher: dispatcher.host,
      handleMetricsChanged: handleMetricsChanged,
      handleTextScaleFactorChanged: handleTextScaleFactorChanged,
      handlePlatformBrightnessChanged: handlePlatformBrightnessChanged,
      handleLocaleChanged: handleLocaleChanged,
      handleAccessibilityFeaturesChanged: handleAccessibilityFeaturesChanged,
      applyTargetPlatformOverride: _applyTargetPlatformOverride,
    );
    final DeviceSimulation? initial = _latchedInitialSimulation;
    _latchedInitialSimulation = null;
    if (initial != null) {
      // Applied before the first frame; only targetPlatform work is async.
      unawaited(_controller!.applyTagged(initial));
    }
  }

  @override
  void initServiceExtensions() {
    super.initServiceExtensions();
    if (!kReleaseMode) {
      final DevicePreviewControllerImpl? controller = _controller;
      DevicePreviewScreenshot? screenshot;
      if (controller != null) {
        controller.onStateChanged = postStateChangedEvent;
        controller.onPresetsChanged = postPresetsChangedEvent;
        screenshot = DevicePreviewScreenshot(
          findRenderView: _findPreviewRenderView,
          findHostView: () => _previewDispatcher?.host.implicitView,
          state: _state,
        );
      }
      registerDevicePreviewServiceExtensions(
        protocol: DevicePreviewProtocol(
          controller: controller,
          applyTagged: controller?.applyTagged,
          capabilities: () => <String, Object?>{
            'targetPlatform': simulationEnabled && kDebugMode,
            'screenshot': simulationEnabled && _controller != null,
          },
        ),
        screenshot: screenshot,
      );
    }
  }

  /// Returns a scale-to-fit configuration for the wrapper view's RenderView
  /// while metric simulation is active; defers to `super` otherwise.
  @override
  ViewConfiguration createViewConfigurationFor(RenderView renderView) {
    if (simulationEnabled) {
      final PreviewFlutterView? wrapper =
          _previewDispatcher?.previewImplicitView;
      final DeviceSimulation? simulation = _state.simulation;
      if (wrapper != null &&
          identical(renderView.flutterView, wrapper) &&
          simulation != null &&
          simulation.simulatesMetrics) {
        // Keep the fit fresh with respect to the current host metrics; this
        // runs on every handleMetricsChanged, covering host resizes in
        // compositions where the dispatcher trampolines are not installed.
        _controller?.recomputeFit();
        final ui.FlutterView host = wrapper.hostView;
        return PreviewViewConfiguration(
          simulatedLogicalSize: simulation.screenSize!,
          simulatedDevicePixelRatio:
              simulation.devicePixelRatio ?? host.devicePixelRatio,
          realDevicePixelRatio: host.devicePixelRatio,
          realPhysicalSize: host.physicalSize,
          fit: _state.fit,
        );
      }
    }
    return super.createViewConfigurationFor(renderView);
  }

  RenderView? _findPreviewRenderView() {
    final int? viewId = _previewDispatcher?.previewImplicitView?.viewId;
    if (viewId == null) {
      return null;
    }
    for (final RenderView renderView in renderViews) {
      if (renderView.flutterView.viewId == viewId) {
        return renderView;
      }
    }
    return null;
  }

  Future<void> _applyTargetPlatformOverride(TargetPlatform? platform) async {
    if (kDebugMode) {
      debugDefaultTargetPlatformOverride = platform;
      await reassembleApplication();
    } else {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: FlutterError(
            'DeviceSimulation.targetPlatform is only supported in debug '
            'builds.\n'
            'defaultTargetPlatform is const-folded by the compiler in '
            'profile and release builds, so there is no mechanism to '
            'override it. The field is reported as unsupported in the '
            'protocol capabilities.',
          ),
          library: 'device_preview',
          context: ErrorDescription('while applying a device simulation'),
        ),
      );
    }
  }

  /// Test seam: feeds [packet] (real physical coordinates, real view ids)
  /// through the same rewrite path an engine-delivered packet would take.
  ///
  /// In the production composition this invokes the wrapper dispatcher's
  /// host-side trampoline directly. In compositions where the dispatcher
  /// seam is not interposed (test bindings), the packet is rewritten for the
  /// device pixel ratio the pointer converter will actually use and handed
  /// to the handler the framework registered on the ambient dispatcher.
  @visibleForTesting
  void debugInjectPointerData(ui.PointerDataPacket packet) {
    final PreviewPlatformDispatcher? previewDispatcher = _previewDispatcher;
    if (previewDispatcher != null &&
        identical(platformDispatcher, previewDispatcher)) {
      previewDispatcher.debugReceiveHostPointerDataPacket(packet);
      return;
    }
    final ui.FlutterView? hostView = _hostPlatformDispatcher.implicitView;
    final DeviceSimulation? simulation = _state.simulation;
    ui.PointerDataPacket effective = packet;
    if (simulationEnabled &&
        hostView != null &&
        simulation != null &&
        simulation.simulatesMetrics) {
      final double realRatio = hostView.devicePixelRatio;
      effective = ui.PointerDataPacket(
        data: <ui.PointerData>[
          for (final ui.PointerData datum in packet.data)
            if (datum.viewId == hostView.viewId)
              rewritePointerData(
                datum,
                _state.fit,
                realRatio,
                platformDispatcher.view(id: datum.viewId)?.devicePixelRatio ??
                    realRatio,
              )
            else
              datum,
        ],
      );
    }
    platformDispatcher.onPointerDataPacket?.call(effective);
  }
}

/// Entry point of `package:device_preview`, and a drop-in replacement for
/// [WidgetsFlutterBinding] that can simulate the characteristics of another
/// device.
///
/// ```dart
/// void main() {
///   DevicePreview.enable();
///   runApp(const MyApp()); // runs as usual — now simulatable
/// }
/// ```
///
/// Use [enable] to install it, then [controller] (or [maybeController]) to
/// drive the simulation from Dart. When simulation is off — the default in
/// release builds — no wrapper objects are installed and the binding is
/// behaviorally identical to [WidgetsFlutterBinding].
class DevicePreview extends BindingBase
    with
        GestureBinding,
        SchedulerBinding,
        ServicesBinding,
        PaintingBinding,
        SemanticsBinding,
        RendererBinding,
        WidgetsBinding,
        DevicePreviewBindingMixin {
  static DevicePreview? _instance;

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  /// Seam 1: every framework read of the dispatcher routes through the
  /// wrapper (or, when disabled, straight through to the host — zero
  /// interposition).
  @override
  ui.PlatformDispatcher get platformDispatcher => previewPlatformDispatcher;

  /// Enables device simulation, then initializes (once) and returns the
  /// ambient binding.
  ///
  /// Call this before `runApp`. It is safe to call unconditionally: [when]
  /// defaults to [kDebugMode], so release builds get a plain
  /// [WidgetsFlutterBinding] with no simulation machinery at all. Pass
  /// `when: !kReleaseMode` to also allow simulation in profile builds
  /// (target-platform simulation stays debug-only regardless).
  ///
  /// The value of [when] is latched forever at the first call.
  ///
  /// [initialSimulation] is applied before the first frame — useful for
  /// golden/CI scenarios without DevTools.
  static WidgetsBinding enable({
    bool when = kDebugMode,
    DeviceSimulation? initialSimulation,
  }) {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: when,
        initialSimulation: initialSimulation,
      );
      DevicePreview();
    }
    return _instance!;
  }

  /// The active controller, or null when the ambient binding is not a
  /// device-preview binding or simulation is disabled.
  static DevicePreviewController? get maybeController =>
      _instance?.devicePreview;

  /// The active controller. Throws a [StateError] when unavailable.
  static DevicePreviewController get controller {
    final DevicePreviewController? active = maybeController;
    if (active == null) {
      throw StateError(
        'DevicePreview.controller is unavailable: either '
        'DevicePreview.enable() was never called, another '
        'binding is installed, or simulation is disabled.',
      );
    }
    return active;
  }
}

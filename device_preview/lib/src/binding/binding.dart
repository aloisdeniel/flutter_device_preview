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
import '../widgets/device_preview_frame.dart';
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
  static bool _latchedEnabled = !kReleaseMode;
  static DeviceSimulation? _latchedInitialSimulation;

  /// Latches the configuration consumed by the next binding constructed
  /// with this mixin. Must be called before the binding is constructed;
  /// [DevicePreview.enable] does this automatically.
  ///
  /// [initialSimulation] is applied before the first frame, which is how
  /// golden and CI scenarios start under a given device without DevTools.
  static void latchConfiguration({
    bool enabled = !kReleaseMode,
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

  /// The app's last known system overlay style, republished after every frame.
  ///
  /// `SystemChrome.latestStyle` is where both `setSystemUIOverlayStyle` calls
  /// and `AnnotatedRegion<SystemUiOverlayStyle>` values (which
  /// `RenderView.compositeFrame` resolves against the *simulated* safe areas)
  /// end up, so this is one notifier for every way an app styles its bars.
  /// It only ever changes value — [SystemUiOverlayStyle] compares by value —
  /// so a repaint is never scheduled for an unchanged style.
  final ValueNotifier<SystemUiOverlayStyle?> _systemOverlayStyle =
      ValueNotifier<SystemUiOverlayStyle?>(null);

  /// The app's live system overlay style, driving the simulated system UI.
  ValueListenable<SystemUiOverlayStyle?> get systemOverlayStyle =>
      _systemOverlayStyle;

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
    _state.onPointerKindChanged = _dismissHostHover;
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
            // Screen clipping and body artwork are rendered by the root
            // wrapper this binding installs; a composition that builds its
            // own View without DevicePreviewFrame simply ignores the field.
            'frame': simulationEnabled && _controller != null,
          },
        ),
        screenshot: screenshot,
      );
    }
  }

  /// Wraps the root widget with [DevicePreviewFrame] so the simulated device
  /// body paints behind the app and the app is clipped to the simulated
  /// screen outline.
  ///
  /// A pass-through when simulation is disabled, and — since the frame is
  /// driven by the live simulation — a no-op renderer until a simulation
  /// carrying a [DeviceSimulation.frame] is applied.
  @override
  Widget wrapWithDefaultView(Widget rootWidget) {
    final DevicePreviewControllerImpl? controller = _controller;
    if (!simulationEnabled || controller == null) {
      return super.wrapWithDefaultView(rootWidget);
    }
    return super.wrapWithDefaultView(
      DevicePreviewFrame(
        simulation: controller.simulationListenable,
        overlayStyle: _systemOverlayStyle,
        child: rootWidget,
      ),
    );
  }

  /// Picks up the style the frame just resolved.
  ///
  /// `RenderView.compositeFrame` reads the app's overlay style annotations at
  /// the end of the frame, so this is the earliest the value can be observed;
  /// a change repaints the frame on the next one.
  @override
  void drawFrame() {
    super.drawFrame();
    if (simulationEnabled) {
      // `SystemChrome.setSystemUIOverlayStyle` commits to `latestStyle` from a
      // microtask, so reading it synchronously here would always see the
      // previous frame's value. Ours is queued after the framework's — FIFO —
      // so by the time it runs the style is the one this frame resolved.
      scheduleMicrotask(_captureSystemOverlayStyle);
    }
  }

  void _captureSystemOverlayStyle() {
    if (!simulationEnabled) {
      return;
    }
    // `latestStyle` is annotated @visibleForTesting, and is where every
    // *direct* `SystemChrome.setSystemUIOverlayStyle` call lands — the pattern
    // an app uses outside a widget. Reading it is inert (a getter over a
    // static field); if it ever disappears upstream this fails to compile,
    // which is a loud, cheap failure to fix.
    // ignore: invalid_use_of_visible_for_testing_member
    final SystemUiOverlayStyle? direct = SystemChrome.latestStyle;
    _systemOverlayStyle.value = _annotatedOverlayStyle() ?? direct;
  }

  /// The `AnnotatedRegion<SystemUiOverlayStyle>` an `AppBar` (or any other
  /// widget) placed under the simulated status and navigation bars.
  ///
  /// This repeats what `RenderView.compositeFrame` does, with one fix: the
  /// framework probes `paintBounds` — physical coordinates that assume the
  /// root transform is a plain `devicePixelRatio` scale. Under the scale-to-fit
  /// configuration it is not, so its probes land off the simulated screen and
  /// find nothing. Mapping the probe points through the very matrix the frame
  /// was composited with puts them back where the app actually painted.
  SystemUiOverlayStyle? _annotatedOverlayStyle() {
    final RenderView? renderView = _findPreviewRenderView();
    if (renderView == null || !renderView.hasConfiguration) {
      return null;
    }
    // Reading the root layer from outside the render tree, as the screenshot
    // module does: the risk stays isolated to this debug-only read.
    // ignore: invalid_use_of_protected_member
    final Layer? layer = renderView.layer;
    if (layer is! ContainerLayer) {
      return null;
    }
    final ViewConfiguration configuration = renderView.configuration;
    final ui.Size size = renderView.size;
    final double ratio = configuration.devicePixelRatio;
    if (size.isEmpty || ratio <= 0) {
      return null;
    }
    final Matrix4 matrix = configuration.toMatrix();
    final ui.ViewPadding padding = renderView.flutterView.padding;
    SystemUiOverlayStyle? find(double y) => layer.find<SystemUiOverlayStyle>(
      MatrixUtils.transformPoint(matrix, Offset(size.width / 2, y)),
    );

    // The vertical center of each bar, in simulated logical pixels.
    final SystemUiOverlayStyle? upper = find(padding.top / ratio / 2);
    final SystemUiOverlayStyle? lower = find(
      size.height - 1 - padding.bottom / ratio / 2,
    );
    if (upper == null || lower == null) {
      return upper ?? lower;
    }
    // Both present: the upper region styles the status bar, the lower one the
    // navigation bar — the same split the framework applies.
    return SystemUiOverlayStyle(
      statusBarBrightness: upper.statusBarBrightness,
      statusBarIconBrightness: upper.statusBarIconBrightness,
      statusBarColor: upper.statusBarColor,
      systemStatusBarContrastEnforced: upper.systemStatusBarContrastEnforced,
      systemNavigationBarColor: lower.systemNavigationBarColor,
      systemNavigationBarDividerColor: lower.systemNavigationBarDividerColor,
      systemNavigationBarIconBrightness: lower.systemNavigationBarIconBrightness,
      systemNavigationBarContrastEnforced:
          lower.systemNavigationBarContrastEnforced,
    );
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

  /// Moves every known host mouse far outside the view, so whatever it was
  /// hovering exits.
  ///
  /// Called when [DeviceSimulation.pointerKind] changes: from then on the
  /// mouse's hover events are dropped (a finger cannot hover), and the hover
  /// state it left behind — a highlighted button, an open tooltip — would
  /// otherwise never be cleared. A hover far away rather than a removal, so
  /// the framework's view of which devices exist stays exactly the engine's.
  ///
  /// The packet is handed straight to the framework's handler: it is already
  /// expressed in simulated coordinates and must not be rewritten again.
  void _dismissHostHover() {
    final ui.PointerDataPacketCallback? handler =
        platformDispatcher.onPointerDataPacket;
    if (handler == null || _state.hostMouseDevices.isEmpty) {
      return;
    }
    final int? viewId =
        _previewDispatcher?.previewImplicitView?.viewId ??
        _hostPlatformDispatcher.implicitView?.viewId;
    if (viewId == null) {
      return;
    }
    handler(
      ui.PointerDataPacket(
        data: <ui.PointerData>[
          for (final int device in _state.hostMouseDevices)
            ui.PointerData(
              viewId: viewId,
              timeStamp: _state.lastPointerTimeStamp,
              change: ui.PointerChange.hover,
              kind: ui.PointerDeviceKind.mouse,
              device: device,
              physicalX: -100000,
              physicalY: -100000,
              synthesized: true,
            ),
        ],
      ),
    );
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
    _state.observeHostPointers(packet);
    ui.PointerDataPacket effective = packet;
    if (simulationEnabled && hostView != null && simulation != null) {
      final double realRatio = hostView.devicePixelRatio;
      final ui.PointerDeviceKind? kind = simulation.pointerKind;
      final List<ui.PointerData> data = <ui.PointerData>[];
      for (final ui.PointerData datum in packet.data) {
        if (datum.viewId != hostView.viewId) {
          data.add(datum);
          continue;
        }
        ui.PointerData? rewritten = simulation.simulatesMetrics
            ? rewritePointerData(
                datum,
                _state.fit,
                realRatio,
                platformDispatcher.view(id: datum.viewId)?.devicePixelRatio ??
                    realRatio,
              )
            : datum;
        if (kind != null) {
          rewritten = retargetPointerKind(rewritten, kind);
        }
        if (rewritten != null) {
          data.add(rewritten);
        }
      }
      effective = ui.PointerDataPacket(data: data);
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
  /// Call this before `runApp`. It is safe to call unconditionally: when
  /// [enabled] is null — the default — simulation is active in debug and
  /// profile builds and completely off in release builds, where the binding
  /// behaves exactly like [WidgetsFlutterBinding]. Pass an explicit value to
  /// decide yourself:
  ///
  /// ```dart
  /// DevicePreview.enable();               // debug + profile
  /// DevicePreview.enable(kDebugMode);     // debug only
  /// DevicePreview.enable(false);          // never
  /// ```
  ///
  /// Target-platform simulation stays debug-only regardless, because
  /// `defaultTargetPlatform` is const-folded in other build modes.
  ///
  /// The resolved value is latched forever at the first call; later calls
  /// return the existing binding unchanged.
  ///
  /// To start from a given simulation before the first frame (golden or CI
  /// scenarios without DevTools), apply it through the controller right
  /// after enabling, or latch one with
  /// [DevicePreviewBindingMixin.latchConfiguration].
  static WidgetsBinding enable([bool? enabled]) {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: enabled ?? !kReleaseMode,
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

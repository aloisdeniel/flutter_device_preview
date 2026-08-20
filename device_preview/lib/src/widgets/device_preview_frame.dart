import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../model/device_frame.dart';
import '../model/simulation.dart';
import '../model/system_ui.dart';
import 'device_frame_painter.dart';
import 'system_ui_painter.dart';

/// Draws the simulated device around the app: the body artwork behind the
/// screen, the screen's own outline as a clip on everything the app paints,
/// and the platform's decorative system UI over it.
///
/// The binding inserts this automatically between the root [View] and the
/// widget passed to `runApp`, so applications never need it. Compositions
/// that build their own [View] — test bindings wrapping the app in
/// `View(view: previewImplicitView!, …)` — can wrap their root with it to get
/// the same rendering:
///
/// ```dart
/// View(
///   view: binding.previewImplicitView!,
///   child: DevicePreviewFrame(
///     simulation: DevicePreview.controller.simulationListenable,
///     child: myApp,
///   ),
/// )
/// ```
///
/// [overlayStyle] carries the app's live `SystemUiOverlayStyle`, which tints
/// the simulated status bar and gesture pill; the binding feeds it from
/// `SystemChrome.latestStyle` after every frame.
///
/// The body deliberately paints **outside** this widget's bounds — the widget
/// is laid out at exactly the simulated screen size, and the frame surrounds
/// it. The letterbox computed by the binding
/// (`DeviceSimulation.contentBounds`) already reserves the room for it.
///
/// Without a [DeviceSimulation.frame] this is a pass-through: no clip layer,
/// no extra painting.
class DevicePreviewFrame extends SingleChildRenderObjectWidget {
  /// Wraps [child] with the device frame described by [simulation].
  const DevicePreviewFrame({
    super.key,
    required this.simulation,
    this.overlayStyle,
    required Widget super.child,
  });

  /// The live simulation; the frame repaints whenever it changes.
  final ValueListenable<DeviceSimulation?> simulation;

  /// The app's live system overlay style, tinting the simulated system UI.
  ///
  /// Null falls back to a style derived from the simulated platform
  /// brightness.
  final ValueListenable<SystemUiOverlayStyle?>? overlayStyle;

  @override
  RenderDevicePreviewFrame createRenderObject(BuildContext context) =>
      RenderDevicePreviewFrame(
        simulation: simulation,
        overlayStyle: overlayStyle,
        textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderDevicePreviewFrame renderObject,
  ) {
    renderObject
      ..simulation = simulation
      ..overlayStyle = overlayStyle
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

/// The render object behind [DevicePreviewFrame].
class RenderDevicePreviewFrame extends RenderProxyBox {
  /// Creates a render object painting the frame of [simulation].
  RenderDevicePreviewFrame({
    required ValueListenable<DeviceSimulation?> simulation,
    ValueListenable<SystemUiOverlayStyle?>? overlayStyle,
    TextDirection textDirection = TextDirection.ltr,
    RenderBox? child,
  }) : _simulation = simulation,
       _overlayStyle = overlayStyle,
       _textDirection = textDirection,
       super(child);

  ValueListenable<DeviceSimulation?> _simulation;

  /// The live simulation.
  ValueListenable<DeviceSimulation?> get simulation => _simulation;
  set simulation(ValueListenable<DeviceSimulation?> value) {
    if (identical(value, _simulation)) {
      return;
    }
    if (attached) {
      _simulation.removeListener(_handleSimulationChanged);
      value.addListener(_handleSimulationChanged);
    }
    _simulation = value;
    _handleSimulationChanged();
  }

  ValueListenable<SystemUiOverlayStyle?>? _overlayStyle;

  /// The app's live system overlay style.
  ValueListenable<SystemUiOverlayStyle?>? get overlayStyle => _overlayStyle;
  set overlayStyle(ValueListenable<SystemUiOverlayStyle?>? value) {
    if (identical(value, _overlayStyle)) {
      return;
    }
    if (attached) {
      _overlayStyle?.removeListener(_handleSimulationChanged);
      value?.addListener(_handleSimulationChanged);
    }
    _overlayStyle = value;
    _handleSimulationChanged();
  }

  TextDirection _textDirection;

  /// The ambient text direction, deciding which edge is leading.
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) {
      return;
    }
    _textDirection = value;
    markNeedsPaint();
  }

  DeviceFramePainter? _painter;
  SystemUiPainter? _systemUiPainter;
  final LayerHandle<ClipPathLayer> _clipLayer =
      LayerHandle<ClipPathLayer>();

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _simulation.addListener(_handleSimulationChanged);
    _overlayStyle?.addListener(_handleSimulationChanged);
  }

  @override
  void detach() {
    _simulation.removeListener(_handleSimulationChanged);
    _overlayStyle?.removeListener(_handleSimulationChanged);
    super.detach();
  }

  @override
  void dispose() {
    _clipLayer.layer = null;
    super.dispose();
  }

  void _handleSimulationChanged() => markNeedsPaint();

  /// The painter for the active frame, or null when no frame is simulated.
  ///
  /// Rebuilt (and its parsed artwork thrown away) only when the simulated
  /// frame actually changes.
  DeviceFramePainter? get _activePainter {
    final DeviceFrame? frame = _simulation.value?.frame;
    if (frame == null) {
      _painter = null;
      return null;
    }
    if (_painter?.frame != frame) {
      _painter = DeviceFramePainter(frame);
    }
    return _painter;
  }

  /// The painter for the simulated system UI, or null when there is none —
  /// or when the simulation asks for it to be hidden.
  SystemUiPainter? get _activeSystemUiPainter {
    final DeviceSimulation? simulation = _simulation.value;
    final SystemUiSimulation? systemUi = simulation?.systemUi;
    if (systemUi == null || systemUi.isEmpty || !simulation!.showSystemUi) {
      _systemUiPainter = null;
      return null;
    }
    if (_systemUiPainter?.systemUi != systemUi) {
      _systemUiPainter = SystemUiPainter(systemUi);
    }
    return _systemUiPainter;
  }

  /// Paints the simulated system UI over [offset], inside the screen.
  void _paintSystemUi(PaintingContext context, Offset offset) {
    final SystemUiPainter? painter = _activeSystemUiPainter;
    final DeviceSimulation? simulation = _simulation.value;
    if (painter == null || simulation == null) {
      return;
    }
    final Canvas canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    painter.paint(
      canvas,
      screenSize: size,
      padding: simulation.padding ?? simulation.viewPadding ?? EdgeInsets.zero,
      colors: SystemUiColors.resolve(
        style: _overlayStyle?.value,
        platformBrightness:
            simulation.platformBrightness ??
            PlatformDispatcher.instance.platformBrightness,
        // The bars are the *simulated device's* furniture: their
        // platform-specific paint behavior follows the device that carried
        // them, falling back to the app's platform for bar artwork that
        // does not say (hand-built simulations).
        platform:
            simulation.systemUi?.platform ??
            simulation.targetPlatform ??
            defaultTargetPlatform,
      ),
      textDirection: _textDirection,
    );
    canvas.restore();
  }

  /// Paints the app and, over it, the simulated system UI.
  void _paintContents(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    _paintSystemUi(context, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final DeviceFramePainter? painter = _activePainter;
    if (painter == null) {
      _clipLayer.layer = null;
      _paintContents(context, offset);
      return;
    }
    final Orientation orientation =
        _simulation.value?.orientation ?? Orientation.portrait;
    final ui.Size screenSize = size;

    if (painter.body != null) {
      final Canvas canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      painter.paintBody(canvas, screenSize, orientation);
      canvas.restore();
    }

    final ui.Path? clip = painter.screenClip(screenSize, orientation);
    if (clip == null) {
      _clipLayer.layer = null;
      _paintContents(context, offset);
      return;
    }
    // The system UI belongs to the screen, so it is clipped with the app.
    _clipLayer.layer = context.pushClipPath(
      needsCompositing,
      offset,
      Offset.zero & screenSize,
      clip,
      _paintContents,
      oldLayer: _clipLayer.layer,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<DeviceFrame>(
        'frame',
        _simulation.value?.frame,
        defaultValue: null,
      ),
    );
  }
}

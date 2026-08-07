import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../model/device_frame.dart';
import '../model/simulation.dart';
import 'device_frame_painter.dart';

/// Draws the simulated device around the app: the body artwork behind the
/// screen, and the screen's own outline as a clip on everything the app
/// paints.
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
    required Widget super.child,
  });

  /// The live simulation; the frame repaints whenever it changes.
  final ValueListenable<DeviceSimulation?> simulation;

  @override
  RenderDevicePreviewFrame createRenderObject(BuildContext context) =>
      RenderDevicePreviewFrame(simulation: simulation);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderDevicePreviewFrame renderObject,
  ) {
    renderObject.simulation = simulation;
  }
}

/// The render object behind [DevicePreviewFrame].
class RenderDevicePreviewFrame extends RenderProxyBox {
  /// Creates a render object painting the frame of [simulation].
  RenderDevicePreviewFrame({
    required ValueListenable<DeviceSimulation?> simulation,
    RenderBox? child,
  }) : _simulation = simulation,
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

  DeviceFramePainter? _painter;
  final LayerHandle<ClipPathLayer> _clipLayer =
      LayerHandle<ClipPathLayer>();

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _simulation.addListener(_handleSimulationChanged);
  }

  @override
  void detach() {
    _simulation.removeListener(_handleSimulationChanged);
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

  @override
  void paint(PaintingContext context, Offset offset) {
    final DeviceFramePainter? painter = _activePainter;
    if (painter == null) {
      _clipLayer.layer = null;
      super.paint(context, offset);
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
      super.paint(context, offset);
      return;
    }
    _clipLayer.layer = context.pushClipPath(
      needsCompositing,
      offset,
      Offset.zero & screenSize,
      clip,
      super.paint,
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

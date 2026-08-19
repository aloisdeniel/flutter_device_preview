import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../model/fit_transform.dart';
import '../model/simulation.dart';

/// Paints the configured background decoration across the real window,
/// behind the simulated device.
///
/// Internal: the binding wraps it around the `DevicePreviewFrame` wrapper
/// when `DevicePreview.enable` has a non-null `backgroundDecoration`; it is
/// never exported.
///
/// This render object lives in *simulated* logical coordinates — the root
/// view configuration scales everything it paints by the fit transform. The
/// decoration is nevertheless painted in *real* logical pixels, by undoing
/// the fit on the canvas first: a gradient, an image or a dot grid then
/// keeps the same size on screen whatever the simulated device or the fit
/// scale. The fit changes whenever the letterbox moves (host resize, device
/// switch), hence the listenable [fit].
///
/// Nothing is painted while no metric simulation is active: the app then
/// fills the window and the decoration could never be seen.
class PreviewBackground extends SingleChildRenderObjectWidget {
  /// Wraps [child] with the window-filling [decoration].
  const PreviewBackground({
    super.key,
    required this.decoration,
    required this.simulation,
    required this.fit,
    required this.hostView,
    required Widget super.child,
  });

  /// The decoration filling the window around the simulated device.
  final Decoration decoration;

  /// The live simulation; decides whether anything is painted at all.
  final ValueListenable<DeviceSimulation?> simulation;

  /// The live scale-to-fit mapping; repaints when the letterbox moves.
  final ValueListenable<FitTransform> fit;

  /// The real (host) view, read live for the window's logical size.
  final ui.FlutterView hostView;

  @override
  RenderPreviewBackground createRenderObject(BuildContext context) =>
      RenderPreviewBackground(
        decoration: decoration,
        simulation: simulation,
        fit: fit,
        hostView: hostView,
        textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderPreviewBackground renderObject,
  ) {
    renderObject
      ..decoration = decoration
      ..simulation = simulation
      ..fit = fit
      ..hostView = hostView
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

/// The render object behind [PreviewBackground].
class RenderPreviewBackground extends RenderProxyBox {
  /// Creates a render object painting [decoration] behind its child.
  RenderPreviewBackground({
    required Decoration decoration,
    required ValueListenable<DeviceSimulation?> simulation,
    required ValueListenable<FitTransform> fit,
    required ui.FlutterView hostView,
    TextDirection textDirection = TextDirection.ltr,
    RenderBox? child,
  }) : _decoration = decoration,
       _simulation = simulation,
       _fit = fit,
       _hostView = hostView,
       _textDirection = textDirection,
       super(child);

  Decoration _decoration;

  /// The decoration filling the window around the simulated device.
  Decoration get decoration => _decoration;
  set decoration(Decoration value) {
    if (value == _decoration) {
      return;
    }
    _decoration = value;
    _painter?.dispose();
    _painter = null;
    markNeedsPaint();
  }

  ValueListenable<DeviceSimulation?> _simulation;

  /// The live simulation.
  ValueListenable<DeviceSimulation?> get simulation => _simulation;
  set simulation(ValueListenable<DeviceSimulation?> value) {
    if (identical(value, _simulation)) {
      return;
    }
    if (attached) {
      _simulation.removeListener(markNeedsPaint);
      value.addListener(markNeedsPaint);
    }
    _simulation = value;
    markNeedsPaint();
  }

  ValueListenable<FitTransform> _fit;

  /// The live scale-to-fit mapping.
  ValueListenable<FitTransform> get fit => _fit;
  set fit(ValueListenable<FitTransform> value) {
    if (identical(value, _fit)) {
      return;
    }
    if (attached) {
      _fit.removeListener(markNeedsPaint);
      value.addListener(markNeedsPaint);
    }
    _fit = value;
    markNeedsPaint();
  }

  ui.FlutterView _hostView;

  /// The real (host) view.
  ui.FlutterView get hostView => _hostView;
  set hostView(ui.FlutterView value) {
    if (identical(value, _hostView)) {
      return;
    }
    _hostView = value;
    markNeedsPaint();
  }

  TextDirection _textDirection;

  /// The ambient text direction, resolving direction-aware decorations.
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) {
      return;
    }
    _textDirection = value;
    markNeedsPaint();
  }

  BoxPainter? _painter;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _simulation.addListener(markNeedsPaint);
    _fit.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _simulation.removeListener(markNeedsPaint);
    _fit.removeListener(markNeedsPaint);
    _painter?.dispose();
    _painter = null;
    super.detach();
  }

  @override
  void dispose() {
    _painter?.dispose();
    _painter = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final DeviceSimulation? simulation = _simulation.value;
    final FitTransform fit = _fit.value;
    if (simulation != null && simulation.simulatesMetrics && fit.scale > 0) {
      final ui.Size real = _hostView.physicalSize / _hostView.devicePixelRatio;
      final BoxPainter painter = _painter ??= _decoration.createBoxPainter(
        markNeedsPaint,
      );
      final ui.Canvas canvas = context.canvas;
      // Undo the fit: after this, one canvas unit is one real logical pixel
      // and the origin is the real window's top-left corner.
      final Offset origin = fit.toSimulatedLogical(Offset.zero) + offset;
      canvas
        ..save()
        ..translate(origin.dx, origin.dy)
        ..scale(1 / fit.scale, 1 / fit.scale);
      painter.paint(
        canvas,
        Offset.zero,
        ImageConfiguration(size: real, textDirection: _textDirection),
      );
      canvas.restore();
    }
    super.paint(context, offset);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Decoration>('decoration', _decoration));
  }
}

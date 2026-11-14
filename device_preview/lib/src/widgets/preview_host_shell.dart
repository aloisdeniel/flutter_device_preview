import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../binding/preview_state.dart';
import '../model/fit_transform.dart';

/// Slots hosted by [PreviewHostShell].
enum PreviewShellSlot {
  /// The simulated application subtree (laid out at simulated logical size).
  app,

  /// The in-app developer toolbar (laid out at the real host window size).
  overlay,
}

/// Hosts the simulated [app] alongside an unscaled [overlay] rendered in real
/// host window coordinates.
class PreviewHostShell
    extends SlottedMultiChildRenderObjectWidget<PreviewShellSlot, RenderBox> {
  /// Creates the host shell.
  const PreviewHostShell({
    super.key,
    required this.fit,
    required this.hostMetricsRevision,
    required this.hostView,
    required this.state,
    required this.computeHitRect,
    required this.app,
    required this.overlay,
  });

  /// Live scale-to-fit transform applied to the simulated app.
  final ValueListenable<FitTransform> fit;

  /// Notifier incremented when the real host window metrics change.
  final ValueListenable<int> hostMetricsRevision;

  /// The real host view providing unscaled window dimensions.
  final ui.FlutterView hostView;

  /// Shared preview state updated with the active overlay hit rect.
  final PreviewState state;

  /// Computes the interactive bounds of [overlay] in real logical coordinates.
  final ui.Rect Function(ui.Size realLogicalSize) computeHitRect;

  /// The application widget tree.
  final Widget app;

  /// The developer toolbar widget tree.
  final Widget overlay;

  @override
  Iterable<PreviewShellSlot> get slots => PreviewShellSlot.values;

  @override
  Widget? childForSlot(PreviewShellSlot slot) => switch (slot) {
    PreviewShellSlot.app => app,
    PreviewShellSlot.overlay => overlay,
  };

  @override
  RenderPreviewHostShell createRenderObject(BuildContext context) =>
      RenderPreviewHostShell(
        fit: fit,
        hostMetricsRevision: hostMetricsRevision,
        hostView: hostView,
        state: state,
        computeHitRect: computeHitRect,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderPreviewHostShell renderObject,
  ) {
    renderObject
      ..fit = fit
      ..hostMetricsRevision = hostMetricsRevision
      ..hostView = hostView
      ..state = state
      ..computeHitRect = computeHitRect;
  }
}

/// Render object backing [PreviewHostShell].
class RenderPreviewHostShell extends RenderBox
    with SlottedContainerRenderObjectMixin<PreviewShellSlot, RenderBox> {
  /// Creates the host shell render box.
  RenderPreviewHostShell({
    required ValueListenable<FitTransform> fit,
    required ValueListenable<int> hostMetricsRevision,
    required ui.FlutterView hostView,
    required PreviewState state,
    required ui.Rect Function(ui.Size realLogicalSize) computeHitRect,
  }) : _fit = fit,
       _hostMetricsRevision = hostMetricsRevision,
       _hostView = hostView,
       _state = state,
       _computeHitRect = computeHitRect;

  ValueListenable<FitTransform> _fit;
  ValueListenable<FitTransform> get fit => _fit;
  set fit(ValueListenable<FitTransform> value) {
    if (identical(value, _fit)) {
      return;
    }
    if (attached) {
      _fit.removeListener(_handleHostOrFitChanged);
      value.addListener(_handleHostOrFitChanged);
    }
    _fit = value;
    markNeedsLayout();
  }

  ValueListenable<int> _hostMetricsRevision;
  ValueListenable<int> get hostMetricsRevision => _hostMetricsRevision;
  set hostMetricsRevision(ValueListenable<int> value) {
    if (identical(value, _hostMetricsRevision)) {
      return;
    }
    if (attached) {
      _hostMetricsRevision.removeListener(_handleHostOrFitChanged);
      value.addListener(_handleHostOrFitChanged);
    }
    _hostMetricsRevision = value;
    markNeedsLayout();
  }

  ui.FlutterView _hostView;
  ui.FlutterView get hostView => _hostView;
  set hostView(ui.FlutterView value) {
    if (identical(value, _hostView)) {
      return;
    }
    _hostView = value;
    markNeedsLayout();
  }

  PreviewState _state;
  PreviewState get state => _state;
  set state(PreviewState value) {
    _state = value;
  }

  ui.Rect Function(ui.Size realLogicalSize) _computeHitRect;
  ui.Rect Function(ui.Size realLogicalSize) get computeHitRect =>
      _computeHitRect;
  set computeHitRect(ui.Rect Function(ui.Size realLogicalSize) value) {
    _computeHitRect = value;
    markNeedsLayout();
  }

  final LayerHandle<TransformLayer> _overlayTransformLayer =
      LayerHandle<TransformLayer>();

  RenderBox? get _appChild => childForSlot(PreviewShellSlot.app);
  RenderBox? get _overlayChild => childForSlot(PreviewShellSlot.overlay);

  void _handleHostOrFitChanged() {
    markNeedsLayout();
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _fit.addListener(_handleHostOrFitChanged);
    _hostMetricsRevision.addListener(_handleHostOrFitChanged);
  }

  @override
  void detach() {
    _fit.removeListener(_handleHostOrFitChanged);
    _hostMetricsRevision.removeListener(_handleHostOrFitChanged);
    _overlayTransformLayer.layer = null;
    _state.overlayHitRect = null;
    super.detach();
  }

  @override
  void dispose() {
    _overlayTransformLayer.layer = null;
    super.dispose();
  }

  ui.Size get _realLogicalSize {
    final double dpr = _hostView.devicePixelRatio;
    if (dpr <= 0) {
      return constraints.biggest;
    }
    final ui.Size real = _hostView.physicalSize / dpr;
    if (real.isEmpty || !real.width.isFinite || !real.height.isFinite) {
      return constraints.biggest;
    }
    return real;
  }

  Matrix4 _overlayToSimulatedMatrix() {
    final FitTransform currentFit = _fit.value;
    if (currentFit == FitTransform.identity || currentFit.scale <= 0) {
      return Matrix4.identity();
    }
    final ui.Offset origin = currentFit.toSimulatedLogical(ui.Offset.zero);
    final double invScale = 1.0 / currentFit.scale;
    return Matrix4.diagonal3Values(invScale, invScale, 1)
      ..setTranslationRaw(origin.dx, origin.dy, 0);
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    _appChild?.layout(BoxConstraints.tight(size));

    final ui.Size realSize = _realLogicalSize;
    _state.overlayHitRect = _computeHitRect(realSize);
    _overlayChild?.layout(BoxConstraints.tight(realSize));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? appChild = _appChild;
    if (appChild != null) {
      context.paintChild(appChild, offset);
    }

    final RenderBox? overlayChild = _overlayChild;
    if (overlayChild == null) {
      _overlayTransformLayer.layer = null;
      return;
    }

    final FitTransform currentFit = _fit.value;
    if (currentFit == FitTransform.identity || currentFit.scale <= 0) {
      _overlayTransformLayer.layer = null;
      context.paintChild(overlayChild, offset);
      return;
    }

    _overlayTransformLayer.layer = context.pushTransform(
      needsCompositing,
      offset,
      _overlayToSimulatedMatrix(),
      (PaintingContext innerContext, Offset innerOffset) {
        innerContext.paintChild(overlayChild, innerOffset);
      },
      oldLayer: _overlayTransformLayer.layer,
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    if (identical(child, _overlayChild)) {
      transform.multiply(_overlayToSimulatedMatrix());
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? overlayChild = _overlayChild;
    if (overlayChild != null) {
      final bool hitOverlay = result.addWithPaintTransform(
        transform: _overlayToSimulatedMatrix(),
        position: position,
        hitTest: (BoxHitTestResult innerResult, Offset realPosition) {
          if (!_state.hitsOverlay(realPosition)) {
            return false;
          }
          return overlayChild.hitTest(innerResult, position: realPosition);
        },
      );
      if (hitOverlay) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }

    if (size.contains(position)) {
      final RenderBox? appChild = _appChild;
      if (appChild != null && appChild.hitTest(result, position: position)) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }
    return false;
  }
}

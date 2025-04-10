import 'dart:math';
import 'dart:ui';

import 'package:device_preview/src/helpers/transforms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flutter_view.dart';

class PreviewRenderView extends RenderView {
  PreviewRenderView({
    required RenderView parent,
    RenderBox? child,
    required PreviewFlutterView view,
  })  : _view = view,
        _parent = parent,
        super(
          child: child,
          view: view,
        );

  final RenderView _parent;

  final PreviewFlutterView _view;
  PreviewFlutterView get previewView => _view;

  @override
  ViewConfiguration get configuration => _parent.configuration;

  @override
  set configuration(ViewConfiguration value) {
    _parent.configuration = value;
  }

  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      _backgroundColor = value;
      markNeedsPaint();
    }
  }

  Orientation _orientation = Orientation.portrait;
  Orientation get orientation => _orientation;
  set orientation(Orientation value) {
    if (_orientation != value) {
      _orientation = value;
      markNeedsLayout();
      markNeedsPaint();
    }
  }

  PointerEvent transformPointerEvent(PointerEvent event) {
    if (_view.previewConfiguration?.device.device.asNullable()
        case final device?) {
      final screenArea =
          PreviewTransforms.screenDestinationRect(device, orientation);
      if (screenArea.contains(event.position)) {
        final relativePosition = Offset(
          (event.position.dx - screenArea.left) / screenArea.width,
          (event.position.dy - screenArea.top) / screenArea.height,
        );

        final relativeDelta = Offset(
          event.delta.dx / screenArea.width,
          event.delta.dy / screenArea.height,
        );

        final screenSize = orientation == Orientation.portrait
            ? device.screenSize
            : device.screenSize.flipped;

        return event.copyWith(
          position: Offset(
            relativePosition.dx * screenSize.width,
            relativePosition.dy * screenSize.height,
          ),
          delta: Offset(
            relativeDelta.dx * screenSize.width,
            relativeDelta.dy * screenSize.height,
          ),
        );
      }
    }

    return event;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print('PAINT');
    if (_view.previewConfiguration case final previewConfiguration?) {
      context.canvas.drawColor(
        _backgroundColor,
        BlendMode.color,
      );

      if (previewConfiguration.device.device.asNullable() case final device?) {
        final screenBounds = device.screenPath.getBounds();

        context.pushTransform(
          needsCompositing,
          offset,
          PreviewTransforms.globalTransform(device, orientation),
          (context, offset) {
            var screenPath = device.screenPath.shift(-screenBounds.topLeft);
            if (orientation == Orientation.landscape) {
              final screenTransform = (Matrix4.rotationZ(pi * 0.5)
                ..translate(0.0, -screenBounds.height));
              screenPath = screenPath.transform(screenTransform.storage);
              final frameTransform = (Matrix4.rotationZ(pi * 0.5)
                ..translate(0.0, -device.frameSize.height));
              context.pushTransform(
                needsCompositing,
                offset,
                frameTransform,
                (context, offset) {
                  device.framePainter.paint(
                    context.canvas,
                    device.frameSize,
                  );
                },
              );
            } else {
              device.framePainter.paint(
                context.canvas,
                device.frameSize,
              );
            }

            context.pushClipPath(
              needsCompositing,
              screenBounds.topLeft,
              screenBounds.shift(-screenBounds.topLeft),
              screenPath,
              (context, offset) {
                context.pushTransform(
                  needsCompositing,
                  offset,
                  PreviewTransforms.screenScaleTransform(device),
                  super.paint,
                );
              },
            );
          },
        );
      }
    } else {
      super.paint(context, offset);
    }
  }

  @override
  bool get automaticSystemUiAdjustment => _parent.automaticSystemUiAdjustment;

  @override
  set automaticSystemUiAdjustment(bool v) {
    _parent.automaticSystemUiAdjustment = v;
  }

  @override
  RenderBox? get child => _parent.child;

  @override
  set child(RenderBox? v) {
    _parent.child = v;
  }

  @override
  Object? get debugCreator => _parent.debugCreator;

  @override
  set debugCreator(Object? v) {
    _parent.debugCreator = v;
  }

  @override
  ContainerLayer? get layer => _parent.layer;

  @override
  set layer(ContainerLayer? v) {
    _parent.layer = v;
  }

  @override
  ParentData? get parentData => _parent.parentData;

  @override
  set parentData(ParentData? v) {
    _parent.parentData = v;
  }

  @override
  void adoptChild(RenderObject child) {
    _parent.adoptChild(child);
  }

  @override
  bool get alwaysNeedsCompositing => _parent.alwaysNeedsCompositing;

  @override
  void applyPaintTransform(covariant RenderBox child, Matrix4 transform) {
    _parent.applyPaintTransform(child, transform);
  }

  @override
  void assembleSemanticsNode(SemanticsNode node, SemanticsConfiguration config,
      Iterable<SemanticsNode> children) {
    _parent.assembleSemanticsNode(node, config, children);
  }

  @override
  void attach(PipelineOwner owner) {
    _parent.attach(owner);
  }

  @override
  bool get attached => _parent.attached;

  @override
  void clearSemantics() {
    _parent.clearSemantics();
  }

  @override
  void compositeFrame() {
    _parent.compositeFrame();
  }

  @override
  Constraints get constraints => _parent.constraints;

  @override
  void debugAssertDoesMeetConstraints() {
    _parent.debugAssertDoesMeetConstraints();
  }

  @override
  bool get debugCanParentUseSize => _parent.debugCanParentUseSize;

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return _parent.debugDescribeChildren();
  }

  @override
  bool? get debugDisposed => _parent.debugDisposed;

  @override
  bool get debugDoingThisLayout => _parent.debugDoingThisLayout;

  @override
  bool get debugDoingThisLayoutWithCallback =>
      _parent.debugDoingThisLayoutWithCallback;

  @override
  bool get debugDoingThisPaint => _parent.debugDoingThisPaint;

  @override
  bool get debugDoingThisResize => _parent.debugDoingThisResize;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    _parent.debugFillProperties(properties);
  }

  @override
  ContainerLayer? get debugLayer => _parent.debugLayer;

  @override
  RenderObject? get debugLayoutParent => _parent.debugLayoutParent;

  @override
  bool get debugNeedsCompositedLayerUpdate =>
      _parent.debugNeedsCompositedLayerUpdate;

  @override
  bool get debugNeedsLayout => _parent.debugNeedsLayout;

  @override
  bool get debugNeedsPaint => _parent.debugNeedsPaint;

  @override
  void debugPaint(PaintingContext context, Offset offset) {
    _parent.debugPaint(context, offset);
  }

  @override
  void debugRegisterRepaintBoundaryPaint(
      {bool includedParent = true, bool includedChild = false}) {
    _parent.debugRegisterRepaintBoundaryPaint(
      includedParent: includedParent,
      includedChild: includedChild,
    );
  }

  @override
  void debugResetSize() {
    _parent.debugResetSize();
  }

  @override
  SemanticsNode? get debugSemantics => _parent.debugSemantics;

  @override
  bool debugValidateChild(RenderObject child) {
    return _parent.debugValidateChild(child);
  }

  @override
  int get depth => _parent.depth;

  @override
  Rect? describeApproximatePaintClip(covariant RenderObject child) {
    return _parent.describeApproximatePaintClip(child);
  }

  @override
  DiagnosticsNode describeForError(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.shallow}) {
    return _parent.describeForError(name, style: style);
  }

  @override
  Rect? describeSemanticsClip(covariant RenderObject? child) {
    return _parent.describeSemanticsClip(child);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    _parent.describeSemanticsConfiguration(config);
  }

  @override
  void detach() {
    _parent.detach();
  }

  @override
  void dispose() {
    _parent.dispose();
  }

  @override
  void dropChild(RenderObject child) {
    _parent.dropChild(child);
  }

  @override
  FlutterView get flutterView => _parent.flutterView;

  @override
  Matrix4 getTransformTo(RenderObject? ancestor) {
    return _parent.getTransformTo(ancestor);
  }

  @override
  void handleEvent(
      PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    return _parent.handleEvent(event, entry);
  }

  @override
  bool get hasConfiguration => _parent.hasConfiguration;

  @override
  bool hitTest(HitTestResult result, {required Offset position}) {
    return _parent.hitTest(result, position: position);
  }

  @override
  void invokeLayoutCallback<T extends Constraints>(LayoutCallback<T> callback) {
    _parent.invokeLayoutCallback(callback);
  }

  @override
  bool get isRepaintBoundary => _parent.isRepaintBoundary;

  @override
  void layout(Constraints constraints, {bool parentUsesSize = false}) {
    _parent.layout(constraints, parentUsesSize: parentUsesSize);
  }

  @override
  void markNeedsCompositedLayerUpdate() {
    _parent.markNeedsCompositedLayerUpdate();
  }

  @override
  void markNeedsCompositingBitsUpdate() {
    _parent.markNeedsCompositingBitsUpdate();
  }

  @override
  void markNeedsLayout() {
    _parent.markNeedsLayout();
  }

  @override
  void markNeedsLayoutForSizedByParentChange() {
    _parent.markNeedsLayoutForSizedByParentChange();
  }

  @override
  void markNeedsPaint() {
    _parent.markNeedsPaint();
  }

  @override
  void markNeedsSemanticsUpdate() {
    _parent.markNeedsSemanticsUpdate();
  }

  @override
  void markParentNeedsLayout() {
    _parent.markParentNeedsLayout();
  }

  @override
  bool get needsCompositing => _parent.needsCompositing;

  @override
  PipelineOwner? get owner => _parent.owner;

  @override
  Rect get paintBounds => _parent.paintBounds;

  @override
  bool paintsChild(covariant RenderObject child) {
    return _parent.paintsChild(child);
  }

  @override
  RenderObject? get parent => _parent.parent;

  @override
  void performLayout() {
    _parent.performLayout();
  }

  @override
  void performResize() {
    _parent.performResize();
  }

  @override
  void prepareInitialFrame() {
    _parent.prepareInitialFrame();
  }

  @override
  void reassemble() {
    _parent.reassemble();
  }

  @override
  void redepthChild(RenderObject child) {
    _parent.redepthChild(child);
  }

  @override
  void redepthChildren() {
    _parent.redepthChildren();
  }

  @override
  void replaceRootLayer(OffsetLayer rootLayer) {
    _parent.replaceRootLayer(rootLayer);
  }

  @override
  void scheduleInitialLayout() {
    _parent.scheduleInitialLayout();
  }

  @override
  void scheduleInitialPaint(ContainerLayer rootLayer) {
    _parent.scheduleInitialPaint(rootLayer);
  }

  @override
  void scheduleInitialSemantics() {
    _parent.scheduleInitialSemantics();
  }

  @override
  Rect get semanticBounds => _parent.semanticBounds;

  @override
  void sendSemanticsEvent(SemanticsEvent semanticsEvent) {
    _parent.sendSemanticsEvent(semanticsEvent);
  }

  @override
  void setupParentData(covariant RenderObject child) {
    _parent.setupParentData(child);
  }

  @override
  void showOnScreen(
      {RenderObject? descendant,
      Rect? rect,
      Duration duration = Duration.zero,
      Curve curve = Curves.ease}) {
    _parent.showOnScreen(
      descendant: descendant,
      rect: rect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Size get size => _parent.size;

  @override
  bool get sizedByParent => _parent.sizedByParent;

  @override
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    return toDiagnosticsNode(
      name: name,
      style: style,
    );
  }

  @override
  String toStringDeep(
      {String prefixLineOne = '',
      String? prefixOtherLines = '',
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return _parent.toStringDeep(
      prefixLineOne: prefixLineOne,
      prefixOtherLines: prefixOtherLines,
      minLevel: minLevel,
    );
  }

  @override
  String toStringShallow(
      {String joiner = ', ',
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return _parent.toStringShallow(
      joiner: joiner,
      minLevel: minLevel,
    );
  }

  @override
  String toStringShort() {
    return _parent.toStringShort();
  }

  @override
  OffsetLayer updateCompositedLayer({covariant OffsetLayer? oldLayer}) {
    return _parent.updateCompositedLayer(oldLayer: oldLayer);
  }

  @override
  void updateSemantics(SemanticsUpdate update) {
    _parent.updateSemantics(update);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    _parent.visitChildren(visitor);
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    _parent.visitChildrenForSemantics(visitor);
  }
}

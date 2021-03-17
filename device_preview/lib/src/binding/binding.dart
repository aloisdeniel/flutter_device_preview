import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:device_preview/src/helpers/transforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

import 'render_view.dart';
import 'window.dart';

/// A concrete binding for applications based on the Widgets framework.
///
/// This is the glue that binds the framework to the Flutter engine.
class PreviewWidgetsFlutterBinding extends BindingBase
    with
        GestureBinding,
        SchedulerBinding,
        ServicesBinding,
        PaintingBinding,
        SemanticsBinding,
        RendererBinding,
        WidgetsBinding {
  static PreviewWindow get previewWindow {
    return previewBinding.window as PreviewWindow;
  }

  static PreviewWidgetsFlutterBinding get previewBinding {
    return WidgetsBinding.instance as PreviewWidgetsFlutterBinding;
  }

  static PreviewRenderView get previewRenderView {
    return previewBinding.renderView as PreviewRenderView;
  }

  /// Returns an instance of the [WidgetsBinding], creating and
  /// initializing it if necessary. If one is created, it will be a
  /// [WidgetsFlutterBinding]. If one was previously initialized, then
  /// it will at least implement [WidgetsBinding].
  ///
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  ///
  /// In the `flutter_test` framework, [testWidgets] initializes the
  /// binding instance to a [TestWidgetsFlutterBinding], not a
  /// [WidgetsFlutterBinding].
  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) PreviewWidgetsFlutterBinding();
    return WidgetsBinding.instance!;
  }

  ui.SingletonFlutterWindow? _previewWindow;

  @override
  ui.SingletonFlutterWindow get window =>
      _previewWindow ??= PreviewWindow(super.window);

  @override
  void initRenderView() {
    super.initRenderView();
    renderView = PreviewRenderView(
      configuration: createViewConfiguration(),
      window: window,
    );
    renderView.prepareInitialFrame();
  }

  @override
  void handlePointerEvent(PointerEvent event) {
    final device = PreviewWidgetsFlutterBinding.previewRenderView.device;
    if (device != null) {
      final globalScale = PreviewTransforms.globalScale(device);
      final screenScale = PreviewTransforms.screenScale(device);
      final screenTranslate = PreviewTransforms.screenTranslate(device);
      Offset transformPoint(Offset offset) {
        offset /= globalScale;
        offset -= screenTranslate;
        offset /= screenScale;

        return offset;
      }

      event = event.copyWith(
        position: transformPoint(event.position),
        delta: Offset(
          event.delta.dx * globalScale,
          event.delta.dy * globalScale,
        ),
      );
    }

    super.handlePointerEvent(event);
  }

  @override
  void handleLocaleChanged() {
    super.handleLocaleChanged();
    reassembleApplication();
  }

  Size _previewWindowSize = ui.window.physicalSize;
  bool _isUpdatingWindowSize = false;

  @override
  void handleMetricsChanged() {
    if (_previewWindowSize != ui.window.physicalSize) {
      updatePreviewWindowSize();
    }
    super.handleMetricsChanged();
  }

  void updatePreviewWindowSize() async {
    _previewWindowSize = ui.window.physicalSize;
    final device = previewRenderView.device;
    if (device != null) {
      final mockup = device.mockup;
      if (mockup != null && !_isUpdatingWindowSize) {
        _isUpdatingWindowSize = true;
        await Future.delayed(const Duration(milliseconds: 20));
        final windowRatio = mockup.frameSize.height / mockup.frameSize.width;
        final info = await getWindowInfo();
        final windowSize =
            Size(info.frame.width, info.frame.width * windowRatio);

        final windowBarHeight = info.frame.height -
            (ui.window.physicalSize.height / ui.window.devicePixelRatio);

        final newWindowSize = Size(
            windowSize.width, windowSize.height + math.max(0, windowBarHeight));
        if (!newWindowSize.isEmpty) {
          setWindowFrame(info.frame.topLeft & newWindowSize);
        }

        _isUpdatingWindowSize = false;
      }
    }
  }
}

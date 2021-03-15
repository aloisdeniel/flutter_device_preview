import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'render_view.dart';
import 'window.dart';

/// A concrete binding for applications based on the Widgets framework.
///
/// This is the glue that binds the framework to the Flutter engine.
class PreviewWidgetsFlutterBinding extends PreviewBindingBase
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

  @override
  void initRenderView() {
    /* assert(!_debugIsRenderViewInitialized);
    assert(() {
      _debugIsRenderViewInitialized = true;
      return true;
    }());*/
    renderView = PreviewRenderView(
        configuration: createViewConfiguration(), window: window);
    renderView.prepareInitialFrame();
  }

  @override
  void handlePointerEvent(PointerEvent event) {
    /// Transform coordinates for preview
    final transform = Matrix4.translationValues(-100, -100, 0);
    final newPosition = MatrixUtils.transformPoint(transform, event.position);
    event = event.copyWith(
      position: newPosition,
    );

    super.handlePointerEvent(event);
  }
}

class PreviewBindingBase extends BindingBase {
  ui.SingletonFlutterWindow? _window;

  @override
  ui.SingletonFlutterWindow get window =>
      _window ??= PreviewWindow(super.window);
}

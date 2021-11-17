import 'dart:ui' as ui;

import 'package:device_frame/device_frame.dart';
import 'package:devtools_device_preview/src/helpers/transforms.dart';
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

  Orientation _orientation = Orientation.portrait;
  Orientation get orientation => _orientation;
  set orientation(Orientation value) {
    if (_orientation != value) {
      _orientation = value;
      _updateSizeAndPadding();
      previewRenderView.orientation = value;
    }
  }

  DeviceInfo? _device;
  DeviceInfo? get device => _device;
  set device(DeviceInfo? value) {
    if (_device?.identifier != value?.identifier) {
      _device = value;
      _updateSizeAndPadding();
      previewRenderView.device = value;
    }
  }

  void _updateSizeAndPadding() {
    final device = this.device;
    if (device != null) {
      // Physical size
      final size = device.screenSize;
      final width =
          _orientation == Orientation.portrait ? size.width : size.height;
      final height =
          _orientation == Orientation.portrait ? size.height : size.width;

      PreviewWidgetsFlutterBinding.previewWindow.physicalSize = Size(
        width * device.pixelRatio,
        height * device.pixelRatio,
      );

      // Padding
      final padding = ((_orientation == Orientation.portrait
                  ? device.safeAreas
                  : device.rotatedSafeAreas) ??
              device.safeAreas) *
          device.pixelRatio;
      final windowPadding = PreviewWindowPadding.fromEdgeInsets(padding);
      PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio =
          device.pixelRatio;
      PreviewWidgetsFlutterBinding.previewWindow.padding = windowPadding;
      PreviewWidgetsFlutterBinding.previewWindow.viewPadding = windowPadding;
    } else {
      PreviewWidgetsFlutterBinding.previewWindow.physicalSize = null;
      PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio = null;
      PreviewWidgetsFlutterBinding.previewWindow.padding = null;
      PreviewWidgetsFlutterBinding.previewWindow.viewPadding = null;
    }
    reassembleApplication();
  }

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
    final device = this.device;
    if (device != null) {
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

        event = event.copyWith(
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

    super.handlePointerEvent(event);
  }

  @override
  void handleMetricsChanged() {
    super.handleMetricsChanged();
    reassembleApplication();
  }

  @override
  void handleLocaleChanged() {
    super.handleLocaleChanged();
    reassembleApplication();
  }
}

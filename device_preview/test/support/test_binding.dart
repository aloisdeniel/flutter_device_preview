/// Widget-test binding used by this package's own test suite.
///
/// This lives under `test/` (not `lib/`) on purpose: shipping it from `lib/`
/// would force `flutter_test` into the regular dependencies of every consumer
/// of `device_preview`. Users who want the same capability compose it
/// themselves from the public [DevicePreviewBindingMixin] — the full recipe
/// (this file, essentially) is reproduced in the package README.
library;

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:device_preview/device_preview.dart';

/// A widget-test binding with the device-preview machinery layered on top.
///
/// `flutter_test`'s `TestWidgetsFlutterBinding` pins the type of its
/// `platformDispatcher` getter to `TestPlatformDispatcher`, so the wrapper
/// dispatcher can never be returned from `binding.platformDispatcher` here
/// (that would be an invalid override — the reason
/// [DevicePreviewBindingMixin] leaves the `platformDispatcher` override to
/// concrete bindings such as `DevicePreview`).
///
/// Instead, this binding routes simulation through the wrapper **view**: the
/// root widget is wrapped in a `View` using
/// [DevicePreviewBindingMixin.previewImplicitView], so `MediaQuery` reads the
/// wrapper pair (`view.*` and `view.platformDispatcher.*`) and the mixin's
/// `createViewConfigurationFor` seam supplies the scale-to-fit
/// `PreviewViewConfiguration` for the wrapper's `RenderView`. What this
/// composition does *not* cover is framework reads that go through
/// `binding.platformDispatcher` directly (for example `WidgetsApp`'s locale
/// list); those are only interposed by the real `DevicePreview`.
class TestDevicePreviewBinding extends AutomatedTestWidgetsFlutterBinding
    with DevicePreviewBindingMixin {
  static TestDevicePreviewBinding? _instance;

  /// Initializes (once) and returns the binding, with simulation enabled.
  static TestDevicePreviewBinding ensureInitialized({
    DeviceSimulation? initialSimulation,
  }) {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: true,
        initialSimulation: initialSimulation,
      );
      TestDevicePreviewBinding();
    }
    return _instance!;
  }

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  /// Mirrors what [DevicePreview] does, minus the dispatcher seam: the root
  /// widget goes under the wrapper view, wrapped in [DevicePreviewFrame] so
  /// the simulated screen outline and device body render here too.
  @override
  Widget wrapWithDefaultView(Widget rootWidget) {
    final ui.FlutterView? wrapperView = previewImplicitView;
    final DevicePreviewController? controller = devicePreview;
    if (wrapperView != null) {
      return View(
        view: wrapperView,
        child: controller == null
            ? rootWidget
            : DevicePreviewFrame(
                simulation: controller.simulationListenable,
                overlayStyle: systemOverlayStyle,
                child: rootWidget,
              ),
      );
    }
    return super.wrapWithDefaultView(rootWidget);
  }
}

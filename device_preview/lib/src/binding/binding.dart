import 'dart:ui' as ui;

import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/helpers/transforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'flutter_view.dart';
import 'padding.dart';
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
  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  @override
  void initServiceExtensions() {
    super.initServiceExtensions();

    if (!kReleaseMode) {
      registerBoolServiceExtension(
        name: 'isDevicePreviewEnabled',
        getter: () async => device != null,
        setter: (bool value) async {
          if (value && device == null) {
            device = Devices.all.first;
          } else if (!value && device != null) {
            device = null;
          }
        },
      );
    }
  }

  /// The current [TestWidgetsFlutterBinding], if one has been created.
  ///
  /// Provides access to the features exposed by this binding. The binding must
  /// be initialized before using this getter; this is typically done by calling
  /// [testWidgets] or [TestWidgetsFlutterBinding.ensureInitialized].
  static PreviewWidgetsFlutterBinding get instance =>
      BindingBase.checkInstance(_instance);
  static PreviewWidgetsFlutterBinding? _instance;

  /// Creates and initializes the binding. This function is
  /// idempotent; calling it a second time will just return the
  /// previously-created instance.
  static PreviewWidgetsFlutterBinding ensureInitialized() {
    if (PreviewWidgetsFlutterBinding._instance == null) {
      PreviewWidgetsFlutterBinding();
    }
    return PreviewWidgetsFlutterBinding.instance;
  }

  @override
  void addRenderView(RenderView view) {
    super.addRenderView(
      PreviewRenderView(
        view: PreviewFlutterView(
          parent: view.flutterView,
        ),
      ),
    );
  }

  @override
  void handlePointerEvent(PointerEvent event) {
    final view = renderViews
        .where((element) => event.viewId == element.flutterView.viewId)
        .map((e) => e.flutterView)
        .whereType<PreviewRenderView>()
        .firstOrNull;

    if (view case final view?) {
      event = view.transformPointerEvent(event);
    }
    super.handlePointerEvent(event);
  }
}

import 'dart:ui';

import '../configuration/configuration.dart';
import 'padding.dart';

class PreviewFlutterView implements FlutterView {
  PreviewFlutterView({
    required this.parent,
  });

  final FlutterView parent;

  PreviewConfiguration? _previewConfiguration;
  PreviewConfiguration? get previewConfiguration => _previewConfiguration;

  set previewConfiguration(PreviewConfiguration? value) {
    if (_previewConfiguration != value) {
      _previewConfiguration = value;
    }
  }

  @override
  double get devicePixelRatio =>
      _previewConfiguration?.device.device.asNullable()?.pixelRatio ??
      parent.devicePixelRatio;

  @override
  Display get display => parent.display;

  @override
  List<DisplayFeature> get displayFeatures => parent.displayFeatures;

  @override
  GestureSettings get gestureSettings => throw UnimplementedError();

  @override
  ViewPadding get padding {
    if (_previewConfiguration?.device.device.asNullable()?.safeAreas
        case final safeAreas?) {
      return PreviewWindowPadding.fromEdgeInsets(safeAreas);
    }

    return parent.padding;
  }

  @override
  Rect get physicalGeometry =>
      _previewConfiguration?.device.device
          .asNullable()
          ?.screenPath
          .getBounds() ??
      parent.physicalGeometry;

  @override
  Size get physicalSize =>
      _previewConfiguration?.device.device.asNullable()?.screenSize ??
      parent.physicalSize;

  @override
  PlatformDispatcher get platformDispatcher => parent.platformDispatcher;

  @override
  void render(Scene scene) {
    // TODO: implement render
  }

  @override
  ViewPadding get systemGestureInsets {
    if (_previewConfiguration?.device.device.asNullable() != null) {
      // Might cause issues though
      return ViewPadding.zero;
    }

    return parent.systemGestureInsets;
  }

  @override
  void updateSemantics(SemanticsUpdate update) {
    parent.updateSemantics(update);
  }

  @override
  int get viewId => parent.viewId;

  @override
  ViewPadding get viewInsets => parent.viewInsets;

  @override
  ViewPadding get viewPadding => padding;
}

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../model/device_frame.dart';
import '../svg/svg_drawing.dart';
import '../svg/svg_path_data.dart';

/// Parses a [DeviceFrame] once and paints it.
///
/// Path data and SVG artwork are parsed lazily on first use and cached for the
/// painter's lifetime; the render object replaces the painter whenever the
/// simulated frame changes.
///
/// Malformed artwork never breaks the app being previewed: the failure is
/// reported once through [FlutterError.reportError] and that part of the frame
/// is simply not drawn.
class DeviceFramePainter {
  /// Creates a painter for [frame].
  DeviceFramePainter(this.frame);

  /// The frame this painter draws.
  final DeviceFrame frame;

  SvgDrawing? _body;
  bool _bodyParsed = false;
  ui.Path? _screenPath;
  bool _screenPathParsed = false;

  /// The parsed body artwork, or null when absent or malformed.
  SvgDrawing? get body {
    if (!_bodyParsed) {
      _bodyParsed = true;
      if (frame.body.isNotEmpty) {
        _body = _guard(() => SvgDrawing.parse(frame.body), 'body artwork');
      }
    }
    return _body;
  }

  /// The parsed screen outline in portrait screen coordinates, or null when
  /// absent or malformed (a rectangular screen).
  ui.Path? get screenPath {
    if (!_screenPathParsed) {
      _screenPathParsed = true;
      if (frame.screenPath.isNotEmpty) {
        _screenPath = _guard(
          () => parseSvgPathData(frame.screenPath),
          'screen outline',
        );
      }
    }
    return _screenPath;
  }

  /// The screen clip outline for a screen of [screenSize] in [orientation],
  /// in the app's own coordinate space, or null for a rectangular screen.
  ui.Path? screenClip(ui.Size screenSize, Orientation orientation) {
    final ui.Path? path = screenPath;
    if (path == null) {
      return null;
    }
    if (orientation == Orientation.portrait) {
      return path;
    }
    return path.transform(_landscapeTransform(screenSize).storage);
  }

  /// Paints the body artwork behind a screen of [screenSize] in [orientation].
  ///
  /// The canvas origin must be the screen's top-left corner.
  void paintBody(
    ui.Canvas canvas,
    ui.Size screenSize,
    Orientation orientation,
  ) {
    final SvgDrawing? drawing = body;
    if (drawing == null || drawing.isEmpty) {
      return;
    }
    canvas.save();
    if (orientation == Orientation.landscape) {
      // A quarter turn: portrait (x, y) → landscape (y, portraitWidth − x).
      canvas
        ..translate(0, screenSize.height)
        ..rotate(-math.pi / 2);
    }
    drawing.paintInto(
      canvas,
      ui.Rect.fromLTWH(
        -frame.screenOffset.dx,
        -frame.screenOffset.dy,
        frame.size.width,
        frame.size.height,
      ),
    );
    canvas.restore();
  }

  Matrix4 _landscapeTransform(ui.Size screenSize) => Matrix4.identity()
    ..translateByDouble(0, screenSize.height, 0, 1)
    ..rotateZ(-math.pi / 2);

  T? _guard<T>(T Function() parse, String what) {
    try {
      return parse();
    } catch (error, stack) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'device_preview',
          context: ErrorDescription('while parsing the device frame $what'),
        ),
      );
      return null;
    }
  }
}

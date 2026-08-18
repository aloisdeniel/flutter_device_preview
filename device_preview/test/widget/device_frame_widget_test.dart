import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

const String kBody =
    '<svg viewBox="0 0 220 420">'
    '<rect width="220" height="420" fill="#112233"/>'
    '</svg>';

/// A 200×400 screen inside a 220×420 body: a 10 pixel border all around.
const DeviceFrame kFrame = DeviceFrame(
  size: ui.Size(220, 420),
  screenOffset: ui.Offset(10, 10),
  // A screen outline with cut corners: the top-left corner is outside it.
  screenPath: 'M20,0 H200 V400 H0 V20 Z',
  body: kBody,
);

const DeviceSimulation kFramedSimulation = DeviceSimulation(
  screenSize: ui.Size(200, 400),
  devicePixelRatio: 2,
  frame: kFrame,
);

void main() {
  final TestDevicePreviewBinding binding =
      TestDevicePreviewBinding.ensureInitialized();

  tearDown(() async {
    await binding.devicePreview?.reset();
  });

  RenderDevicePreviewFrame frameRenderObject() =>
      _findRenderObject<RenderDevicePreviewFrame>();

  group('rendering', () {
    testWidgets('paints the body behind the app and clips it to the screen', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(kFramedSimulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      expect(
        frameRenderObject(),
        paints
          // The body, mapped onto the body rectangle around the screen.
          ..path(color: const Color(0xFF112233))
          // …then the app, clipped to the screen outline.
          ..clipPath(),
      );
    });

    testWidgets('the body is drawn outside the widget bounds', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(kFramedSimulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      final RenderDevicePreviewFrame render = frameRenderObject();
      expect(render.size, const Size(200, 400));

      final List<ui.Path> paths = _recordPaths(render);
      // First op: the body, covering (-10, -10) to (210, 410).
      expect(paths.first.getBounds(), const Rect.fromLTRB(-10, -10, 210, 410));
    });

    testWidgets('without a frame nothing extra is painted', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(screenSize: ui.Size(200, 400)),
      );
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      final RenderDevicePreviewFrame render = frameRenderObject();
      expect(render, isNot(paints..clipPath()));
      expect(_recordPaths(render), isEmpty);
    });

    testWidgets('a frame without artwork clips nothing', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(
          screenSize: ui.Size(200, 400),
          frame: DeviceFrame(size: ui.Size(220, 420)),
        ),
      );
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));
      expect(frameRenderObject(), isNot(paints..clipPath()));
    });

    testWidgets('landscape rotates the body a quarter turn', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(kFramedSimulation);
      await binding.devicePreview!.setOrientation(Orientation.landscape);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      final RenderDevicePreviewFrame render = frameRenderObject();
      expect(render.size, const Size(400, 200));
      // The portrait body (-10, -10, 210, 410) rotated for a 200-wide screen.
      expect(
        _recordPaths(render).first.getBounds(),
        const Rect.fromLTRB(-10, -10, 410, 210),
      );
    });

    testWidgets('applying a frame repaints without a rebuild', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(screenSize: ui.Size(200, 400)),
      );
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));
      final RenderDevicePreviewFrame render = frameRenderObject();
      expect(_recordPaths(render), isEmpty);

      // No pumpWidget: the render object listens to the simulation directly.
      await binding.devicePreview!.apply(kFramedSimulation);
      await tester.pump();
      expect(identical(frameRenderObject(), render), isTrue);
      expect(_recordPaths(render), isNotEmpty);
    });
  });

  group('catalog end to end', () {
    // The DevTools panel pushes a catalog entry's `frame` object verbatim
    // inside the simulation JSON (asserted on the panel side by
    // `selectPreset pushes the frame artwork`). This is the other half: the
    // app decodes that exact JSON and renders it.
    testWidgets('a device_specs entry decodes and paints', (
      WidgetTester tester,
    ) async {
      final File spec = File('../device_specs/apple-iphone-16-pro.json');
      expect(spec.existsSync(), isTrue, reason: 'run from the package root');
      final Map<String, Object?> json = Map<String, Object?>.from(
        jsonDecode(spec.readAsStringSync()) as Map,
      );

      // Exactly the wire shape the panel sends.
      final Map<String, Object?> pushed = <String, Object?>{
        'presetId': json['id'],
        'orientation': 'portrait',
        'screenSize': json['portraitSize'],
        'frame': json['frame'],
        'devicePixelRatio': json['devicePixelRatio'],
        'padding': json['portraitPadding'],
      };
      final DeviceSimulation simulation = DeviceSimulation.fromJson(
        Map<String, Object?>.from(jsonDecode(jsonEncode(pushed)) as Map),
      );
      await binding.devicePreview!.apply(simulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      final RenderDevicePreviewFrame render = frameRenderObject();
      expect(render.size, const Size(402, 874));
      // The body paints around the screen, and the app is clipped to the
      // rounded screen outline.
      expect(_recordPaths(render), isNotEmpty);
      expect(render, paints..clipPath());
      // The letterbox reserves the body: 436x908 around a 402x874 screen.
      expect(simulation.contentBounds, const Rect.fromLTRB(-17, -17, 419, 891));
      expect(tester.takeException(), isNull);
    });
  });

  group('fit', () {
    testWidgets('the letterbox reserves room for the body', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(2200, 4200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pump();

      await binding.devicePreview!.apply(kFramedSimulation);
      final FitTransform fit = binding.devicePreview!.fitTransform;
      // Fitting the 220x420 body — not the 200x400 screen — into 2200x4200
      // means scale 1 (never upscaled) with the body centered.
      expect(fit.scale, 1.0);
      expect(fit.toRealLogical(const Offset(-10, -10)), const Offset(990, 1890));

      // A window exactly the size of the body: the body just fits.
      tester.view.physicalSize = const Size(220, 420);
      await tester.pump();
      final FitTransform tight = binding.devicePreview!.fitTransform;
      expect(tight.scale, 1.0);
      expect(tight.offset, const Offset(10, 10));
    });

    testWidgets('a screenshot of a framed device covers the body', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pump();
      await binding.devicePreview!.apply(kFramedSimulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));

      final DeviceSimulation simulation = binding.devicePreview!.simulation!;
      final FitTransform fit = binding.devicePreview!.fitTransform;
      final Rect content = simulation.contentBounds;
      final Rect capture =
          (fit.toRealLogical(content.topLeft)) &
          Size(content.width * fit.scale, content.height * fit.scale);
      expect(capture.size, const Size(220, 420));
      expect(capture.center, const Offset(500, 500));
    });
  });
}

/// Finds the single render object of type [T] in the current tree.
T _findRenderObject<T extends RenderObject>() {
  final List<T> found = <T>[];
  void visit(RenderObject node) {
    if (node is T) {
      found.add(node);
    }
    node.visitChildren(visit);
  }

  for (final RenderView view in RendererBinding.instance.renderViews) {
    visit(view);
  }
  return found.single;
}

/// Replays [render]'s own painting and returns every path it drew directly,
/// mapped into the render object's own coordinate space (the body artwork;
/// the app itself paints through a clip layer).
List<ui.Path> _recordPaths(RenderDevicePreviewFrame render) {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final _PathCapturingContext context = _PathCapturingContext(
    ContainerLayer(),
    render.paintBounds,
    Canvas(recorder),
  );
  render.paint(context, Offset.zero);
  recorder.endRecording().dispose();
  return context.paths;
}

/// A painting context whose canvas records the paths drawn on it, already
/// transformed by whatever canvas transform was in effect.
class _PathCapturingContext extends PaintingContext {
  _PathCapturingContext(super.containerLayer, super.estimatedBounds, Canvas canvas)
      : _canvas = _PathCapturingCanvas(canvas);

  final _PathCapturingCanvas _canvas;

  List<ui.Path> get paths => _canvas.paths;

  @override
  Canvas get canvas => _canvas;

  @override
  void paintChild(RenderObject child, Offset offset) {
    // The app's own painting is irrelevant here.
  }
}

class _PathCapturingCanvas implements Canvas {
  _PathCapturingCanvas(this._delegate);

  final Canvas _delegate;
  final List<ui.Path> paths = <ui.Path>[];

  @override
  void drawPath(ui.Path path, Paint paint) {
    paths.add(path.transform(_delegate.getTransform()));
    _delegate.drawPath(path, paint);
  }

  @override
  void save() => _delegate.save();

  @override
  void restore() => _delegate.restore();

  @override
  void translate(double dx, double dy) => _delegate.translate(dx, dy);

  @override
  void scale(double sx, [double? sy]) => _delegate.scale(sx, sy);

  @override
  void rotate(double radians) => _delegate.rotate(radians);

  @override
  void clipPath(ui.Path path, {bool doAntiAlias = true}) =>
      _delegate.clipPath(path, doAntiAlias: doAntiAlias);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('unexpected canvas call ${invocation.memberName}');
}

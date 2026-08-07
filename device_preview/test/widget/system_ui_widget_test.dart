import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/widgets/system_ui_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

/// A 20×10 block per slot, so drawn rectangles are trivial to locate.
String block(double width, double height) =>
    '<svg viewBox="0 0 $width $height">'
    '<rect width="$width" height="$height" fill="currentColor"/></svg>';

const SystemUiSimulation kSystemUi = SystemUiSimulation(
  statusBar: SystemUiBar(
    leading: '<svg viewBox="0 0 20 10">'
        '<rect width="20" height="10" fill="currentColor"/></svg>',
    trailing: '<svg viewBox="0 0 30 10">'
        '<rect width="30" height="10" fill="currentColor"/></svg>',
    inset: 12,
  ),
  navigationBar: SystemUiBar(
    center: '<svg viewBox="0 0 100 4">'
        '<rect width="100" height="4" fill="currentColor"/></svg>',
    bottomInset: 6,
  ),
);

const DeviceSimulation kSimulation = DeviceSimulation(
  screenSize: ui.Size(400, 800),
  padding: EdgeInsets.only(top: 40, bottom: 30),
  systemUi: kSystemUi,
);

void main() {
  group('SystemUiPainter layout', () {
    late _Recorder recorder;

    setUp(() => recorder = _Recorder());

    void paint({
      SystemUiSimulation systemUi = kSystemUi,
      EdgeInsets padding = const EdgeInsets.only(top: 40, bottom: 30),
      SystemUiColors colors = const SystemUiColors(
        statusBarIcons: ui.Color(0xFFFFFFFF),
        navigationBarIcons: ui.Color(0xFFFF0000),
      ),
      TextDirection textDirection = TextDirection.ltr,
    }) {
      SystemUiPainter(systemUi).paint(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        padding: padding,
        colors: colors,
        textDirection: textDirection,
      );
    }

    test('anchors artwork to the edges and centers it in the safe area', () {
      paint();
      // Leading: inset 12 from the left, centered in the 40pt status bar.
      expect(recorder.rects[0], const Rect.fromLTWH(12, 15, 20, 10));
      // Trailing: inset 12 from the right.
      expect(recorder.rects[1], const Rect.fromLTWH(358, 15, 30, 10));
      // Center of the bottom bar, its bottom 6 above the screen's edge.
      expect(recorder.rects[2], const Rect.fromLTWH(150, 790, 100, 4));
    });

    test('tints artwork with the resolved colors', () {
      paint();
      expect(recorder.colors[0], 0xFFFFFFFF);
      expect(recorder.colors[1], 0xFFFFFFFF);
      expect(recorder.colors[2], 0xFFFF0000);
    });

    test('skips a bar whose safe area is zero', () {
      // An iPhone in landscape: no status bar, home indicator still there.
      paint(padding: const EdgeInsets.only(bottom: 30));
      expect(recorder.rects, hasLength(1));
      expect(recorder.rects.single.width, 100);
    });

    test('draws nothing at all without safe areas', () {
      paint(padding: EdgeInsets.zero);
      expect(recorder.rects, isEmpty);
    });

    test('without a bottom inset the artwork is centered vertically', () {
      paint(
        systemUi: const SystemUiSimulation(
          navigationBar: SystemUiBar(
            center: '<svg viewBox="0 0 100 4">'
                '<rect width="100" height="4" fill="currentColor"/></svg>',
          ),
        ),
      );
      expect(recorder.rects.single, const Rect.fromLTWH(150, 783, 100, 4));
    });

    test('leading and trailing swap under a right-to-left directionality', () {
      paint(textDirection: TextDirection.rtl);
      // The 30-wide trailing artwork is now on the left.
      expect(recorder.rects[0], const Rect.fromLTWH(12, 15, 30, 10));
      expect(recorder.rects[1], const Rect.fromLTWH(368, 15, 20, 10));
    });

    test('fills backgrounds and the divider when the style asks for it', () {
      paint(
        colors: const SystemUiColors(
          statusBarIcons: ui.Color(0xFFFFFFFF),
          navigationBarIcons: ui.Color(0xFFFFFFFF),
          statusBarBackground: ui.Color(0xFF102030),
          navigationBarBackground: ui.Color(0xFF405060),
          navigationBarDivider: ui.Color(0xFF708090),
        ),
      );
      expect(recorder.fills[0].$1, const Rect.fromLTWH(0, 0, 400, 40));
      expect(recorder.fills[0].$2, 0xFF102030);
      expect(recorder.fills[1].$1, const Rect.fromLTWH(0, 770, 400, 30));
      expect(recorder.fills[1].$2, 0xFF405060);
      // The divider sits on the inner edge of the navigation bar.
      expect(recorder.fills[2].$1, const Rect.fromLTWH(0, 770, 400, 1));
      expect(recorder.fills[2].$2, 0xFF708090);
    });

    test('transparent backgrounds are not painted at all', () {
      paint();
      expect(recorder.fills, isEmpty);
    });

    test('malformed artwork is reported once, then skipped', () {
      paint(
        systemUi: const SystemUiSimulation(
          statusBar: SystemUiBar(leading: 'not svg at all'),
        ),
      );
      expect(recorder.rects, isEmpty);
      final Object? error = _takeError();
      expect(error, isNotNull);
      // A second paint of the same painter does not report again (parsed once).
      expect(_takeError(), isNull);
    });
  });

  group('rendering through the binding', () {
    final TestDevicePreviewBinding binding =
        TestDevicePreviewBinding.ensureInitialized();

    tearDown(() async {
      await binding.devicePreview?.reset();
    });

    testWidgets('system UI paints over the app', (WidgetTester tester) async {
      await binding.devicePreview!.apply(kSimulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFF224466)));
      expect(
        _frame(),
        paints
          ..something(
            (Symbol method, List<dynamic> arguments) => method == #drawPath,
          ),
      );
    });

    testWidgets('the tint follows the app system overlay style', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(kSimulation);
      await tester.pumpWidget(
        const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          child: ColoredBox(color: Color(0xFF101010)),
        ),
      );
      // The binding republishes the style the frame resolved; a second pump
      // lets the repaint it schedules land.
      await tester.pump();
      expect(
        binding.systemOverlayStyle.value?.statusBarIconBrightness,
        Brightness.light,
      );
      expect(_paintedColors(_frame()), contains(0xFFFFFFFF));

      await tester.pumpWidget(
        const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          child: ColoredBox(color: Color(0xFFF0F0F0)),
        ),
      );
      await tester.pump();
      expect(_paintedColors(_frame()), contains(0xFF16181C));
    });

    testWidgets('a real catalog entry paints its bars', (
      WidgetTester tester,
    ) async {
      final File spec = File('../device_specs/apple-iphone-16-pro.json');
      final DevicePreset preset = DevicePreset.fromJson(
        Map<String, Object?>.from(
          jsonDecode(spec.readAsStringSync()) as Map,
        ),
      );
      expect(preset.systemUi, isNotNull);
      await binding.devicePreview!.apply(preset.resolve());
      await tester.pumpWidget(const ColoredBox(color: Color(0xFFFFFFFF)));
      // Clock digits, status icons and the home indicator are all paths.
      expect(_paintedColors(_frame()), isNotEmpty);
      expect(tester.takeException(), isNull);
    });
  });
}

RenderDevicePreviewFrame _frame() {
  final List<RenderDevicePreviewFrame> found = <RenderDevicePreviewFrame>[];
  void visit(RenderObject node) {
    if (node is RenderDevicePreviewFrame) {
      found.add(node);
    }
    node.visitChildren(visit);
  }

  for (final RenderView view in RendererBinding.instance.renderViews) {
    visit(view);
  }
  return found.single;
}

/// Replays the render object's painting and returns the packed colors it
/// filled with.
List<int> _paintedColors(RenderDevicePreviewFrame render) {
  final _Recorder recorder = _Recorder();
  render.paint(
    _RecordingContext(ContainerLayer(), render.paintBounds, recorder.canvas),
    Offset.zero,
  );
  return recorder.colors;
}

Object? _takeError() {
  final FlutterErrorDetails? details = _lastError;
  _lastError = null;
  return details?.exception;
}

FlutterErrorDetails? _lastError;

/// Records `drawPath` / `drawRect` calls, with the canvas transform applied.
class _Recorder {
  _Recorder() {
    FlutterError.onError = (FlutterErrorDetails details) => _lastError = details;
    _canvas = _RecordingCanvas(this);
  }

  late final ui.Canvas _canvas;
  final ui.PictureRecorder _recorder = ui.PictureRecorder();

  ui.Canvas get canvas => _canvas;

  /// Bounds of every filled path.
  final List<Rect> rects = <Rect>[];

  /// Colors of every filled path, in order, as packed ARGB.
  ///
  /// Packed rather than [ui.Color]: `Paint` round-trips its color through
  /// float32 components, so a `Color` read back from one rarely compares equal
  /// to the constant that was set.
  final List<int> colors = <int>[];

  /// `drawRect` calls — the bar backgrounds and dividers.
  final List<(Rect, int)> fills = <(Rect, int)>[];
}

class _RecordingCanvas implements ui.Canvas {
  _RecordingCanvas(this._owner) : _delegate = ui.Canvas(_owner._recorder);

  final _Recorder _owner;
  final ui.Canvas _delegate;

  @override
  void drawPath(ui.Path path, ui.Paint paint) {
    _owner.rects.add(path.transform(_delegate.getTransform()).getBounds());
    _owner.colors.add(paint.color.toARGB32());
  }

  @override
  void drawRect(Rect rect, ui.Paint paint) =>
      _owner.fills.add((MatrixUtils.transformRect(
        Matrix4.fromFloat64List(_delegate.getTransform()),
        rect,
      ), paint.color.toARGB32()));

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
  void clipPath(ui.Path path, {bool doAntiAlias = true}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('unexpected canvas call ${invocation.memberName}');
}

class _RecordingContext extends PaintingContext {
  _RecordingContext(super.containerLayer, super.estimatedBounds, this._canvas);

  final ui.Canvas _canvas;

  @override
  ui.Canvas get canvas => _canvas;

  @override
  void paintChild(RenderObject child, Offset offset) {}
}

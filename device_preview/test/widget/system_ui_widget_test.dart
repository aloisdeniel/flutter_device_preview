import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/widgets/system_ui_painter.dart';
import 'package:flutter/foundation.dart'
    show FlutterExceptionHandler, defaultTargetPlatform;
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
    tearDown(() => recorder.dispose());

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

  group('paintSimulatedKeyboard', () {
    late _Recorder recorder;

    setUp(() => recorder = _Recorder());
    tearDown(() => recorder.dispose());

    test('fills the bottom band and its hairline', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        inset: 300,
      );
      final (Rect bounds, int color, double radius) = recorder.rrects.first;
      expect(bounds, const Rect.fromLTWH(0, 500, 400, 300));
      // Translucent, so the covered content stays readable.
      expect(color, 0xCC17171A);
      // Rounded where it meets the app, square against the screen edge.
      expect(radius, kKeyboardBandRadius);
      // The hairline sits on the band's top edge.
      expect(recorder.fills, hasLength(1));
      expect(recorder.fills.single.$1, const Rect.fromLTWH(0, 500, 400, 1));
    });

    test('a keyboard taller than the screen is clamped to it', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 200),
        inset: 900,
      );
      expect(recorder.rrects.first.$1, const Rect.fromLTWH(0, 0, 400, 200));
      expect(recorder.rrects.first.$2, 0xCC17171A);
    });

    test('the mark is centered in the band and scales with it', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        inset: 300,
      );
      // The mark is min(300 × .30, 400 × .20, 56) = 56 across, drawn on the
      // 16-unit grid: the outline spans 13.5 units, the eight key dots and
      // the space bar sit inside it.
      expect(recorder.rrects, hasLength(2), reason: 'the band and the mark');
      final Rect outline = recorder.rrects
          .firstWhere((r) => r.$2 == 0x40FFFFFF)
          .$1;
      expect(outline.width, closeTo(56 * 13.5 / 16, 0.01));
      expect(outline.center.dx, closeTo(200, 0.01));
      expect(recorder.circles, hasLength(8));
      final List<Rect> markLines = <Rect>[
        for (final (Rect bounds, int color) in recorder.lines)
          if (color == 0x40FFFFFF) bounds,
      ];
      expect(markLines, hasLength(1), reason: 'the space bar');
      for (final Rect key in <Rect>[...recorder.circles, ...markLines]) {
        expect(outline.contains(key.topLeft), isTrue);
        expect(outline.contains(key.bottomRight), isTrue);
      }
    });

    test('a band too short for a legible mark carries none', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        inset: 40,
      );
      expect(recorder.rrects, hasLength(1), reason: 'the band, no mark');
      expect(recorder.circles, isEmpty);
      // Hatching still runs; only the mark is dropped.
      expect(recorder.lines.every((l) => l.$2 == 0x14FFFFFF), isTrue);
    });

    test('the hatch stripes run at 45° across the whole band', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        inset: 300,
      );
      final List<Rect> stripes = <Rect>[
        for (final (Rect bounds, int color) in recorder.lines)
          if (color == 0x14FFFFFF) bounds,
      ];
      // From a band-height left of the band to its right edge, every 12px.
      expect(stripes, hasLength((300 + 400) ~/ 12 + 1));
      for (final Rect stripe in stripes) {
        // 45°: as wide as it is tall, and spanning the band's full height.
        expect(stripe.width, closeTo(stripe.height, 0.01));
        expect(stripe.height, closeTo(300, 0.01));
      }
      // Evenly pitched.
      expect(stripes[1].left - stripes[0].left, closeTo(12, 0.01));
    });

    test('nothing is painted without a positive inset', () {
      paintSimulatedKeyboard(
        recorder.canvas,
        screenSize: const ui.Size(400, 800),
        inset: 0,
      );
      expect(recorder.fills, isEmpty);
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

    testWidgets('bar backgrounds follow the simulated device platform, '
        'not the host', (WidgetTester tester) async {
      // Under `flutter_test` the app's own platform is Android — the case
      // where the framework tints bar backgrounds from the app's declared
      // `SystemUiOverlayStyle`.
      expect(defaultTargetPlatform, TargetPlatform.android);

      DeviceSimulation simFor(TargetPlatform? platform) => DeviceSimulation(
        screenSize: const ui.Size(400, 800),
        padding: const EdgeInsets.only(top: 40, bottom: 30),
        systemUi: SystemUiSimulation(
          statusBar: kSystemUi.statusBar,
          navigationBar: kSystemUi.navigationBar,
          platform: platform,
        ),
      );

      Future<void> pumpUnder(TargetPlatform? platform) async {
        await binding.devicePreview!.apply(simFor(platform));
        await tester.pumpWidget(
          const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              systemNavigationBarColor: Color(0xFF123456),
            ),
            child: ColoredBox(color: Color(0xFF101010)),
          ),
        );
        // Let the binding republish the style and the repaint land.
        await tester.pump();
      }

      // An iPhone's bars: iOS never paints bar backgrounds, whatever the
      // host platform says.
      await pumpUnder(TargetPlatform.iOS);
      expect(_paintedFills(_frame()), isNot(contains(0xFF123456)));

      // An Android device's bars: the declared background is painted.
      await pumpUnder(TargetPlatform.android);
      expect(_paintedFills(_frame()), contains(0xFF123456));

      // Artwork that does not say falls back to the app's own platform.
      await pumpUnder(null);
      expect(_paintedFills(_frame()), contains(0xFF123456));
    });

    testWidgets('showSystemUi: false hides the bars, keeping the safe areas', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(kSimulation);
      await tester.pumpWidget(const ColoredBox(color: Color(0xFF224466)));
      final int painted = _paintedColors(_frame()).length;
      expect(painted, greaterThan(0));

      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(showSystemUi: false),
      );
      await tester.pump();
      expect(_paintedColors(_frame()), isEmpty);
      // Hiding is purely visual: the app still lays out under the safe areas.
      expect(
        binding.devicePreview!.simulation!.padding,
        const EdgeInsets.only(top: 40, bottom: 30),
      );

      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(showSystemUi: true),
      );
      await tester.pump();
      expect(_paintedColors(_frame()), hasLength(painted));
    });

    testWidgets('a simulated keyboard paints a band the app lays out '
        'around', (WidgetTester tester) async {
      await binding.devicePreview!.apply(
        kSimulation.copyWith(keyboardInset: 300),
      );
      await tester.pumpWidget(const ColoredBox(color: Color(0xFF224466)));
      // The band is a translucent near-black panel over the app.
      expect(_paintedRRects(_frame()), contains(0xCC17171A));
      // And the app knows about it: the inset reaches MediaQuery, and the
      // bottom safe area collapses under it exactly as the engines do.
      final ui.FlutterView view =
          binding.previewImplicitView ?? tester.view;
      expect(view.viewInsets.bottom, 300 * view.devicePixelRatio);
      expect(view.padding.bottom, 0);

      // The band does not follow the app's brightness: it stands for a
      // surface that covers the app, not for one of the app's own.
      await binding.devicePreview!.update(
        (DeviceSimulation s) =>
            s.copyWith(platformBrightness: ui.Brightness.dark),
      );
      await tester.pump();
      expect(_paintedRRects(_frame()), contains(0xCC17171A));

      // Hiding the system UI hides the band without moving the app: the
      // inset it stands for is still reported.
      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(showSystemUi: false),
      );
      await tester.pump();
      expect(_paintedRRects(_frame()), isNot(contains(0xCC17171A)));
      expect(view.viewInsets.bottom, 300 * view.devicePixelRatio);
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

/// Replays the render object's painting and returns the packed colors of its
/// `drawRect` fills — the bar backgrounds and dividers.
List<int> _paintedFills(RenderDevicePreviewFrame render) {
  final _Recorder recorder = _Recorder();
  try {
    render.paint(
      _RecordingContext(ContainerLayer(), render.paintBounds, recorder.canvas),
      Offset.zero,
    );
    return recorder.fills.map(((Rect, int) fill) => fill.$2).toList();
  } finally {
    recorder.dispose();
  }
}

/// Replays the render object's painting and returns the packed colors of its
/// `drawRRect` calls — the simulated keyboard band and its mark.
List<int> _paintedRRects(RenderDevicePreviewFrame render) {
  final _Recorder recorder = _Recorder();
  try {
    render.paint(
      _RecordingContext(ContainerLayer(), render.paintBounds, recorder.canvas),
      Offset.zero,
    );
    return recorder.rrects
        .map(((Rect, int, double) rrect) => rrect.$2)
        .toList();
  } finally {
    recorder.dispose();
  }
}

/// Replays the render object's painting and returns the packed colors it
/// filled with.
List<int> _paintedColors(RenderDevicePreviewFrame render) {
  final _Recorder recorder = _Recorder();
  try {
    render.paint(
      _RecordingContext(ContainerLayer(), render.paintBounds, recorder.canvas),
      Offset.zero,
    );
    return recorder.colors;
  } finally {
    recorder.dispose();
  }
}

Object? _takeError() {
  final FlutterErrorDetails? details = _lastError;
  _lastError = null;
  return details?.exception;
}

FlutterErrorDetails? _lastError;

/// Records `drawPath` / `drawRect` calls, with the canvas transform applied.
///
/// Also intercepts [FlutterError.onError] (read back through `_takeError`);
/// [dispose] restores the previous handler so errors reported after the
/// recorder's scope are not silently swallowed for the rest of the run.
class _Recorder {
  _Recorder() {
    _previousOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) => _lastError = details;
    _canvas = _RecordingCanvas(this);
  }

  late final ui.Canvas _canvas;
  final ui.PictureRecorder _recorder = ui.PictureRecorder();
  FlutterExceptionHandler? _previousOnError;

  void dispose() {
    FlutterError.onError = _previousOnError;
  }

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

  /// Bounds, color and top-left radius of every `drawRRect` — the keyboard
  /// band and the keyboard mark's outline.
  final List<(Rect, int, double)> rrects = <(Rect, int, double)>[];

  /// Bounds of every `drawCircle` — the keyboard mark's key dots.
  final List<Rect> circles = <Rect>[];

  /// Bounds and color of every `drawLine` — the band's hatching and the
  /// keyboard mark's space bar.
  final List<(Rect, int)> lines = <(Rect, int)>[];
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
      _owner.fills.add((_transform(rect), paint.color.toARGB32()));

  @override
  void drawRRect(ui.RRect rrect, ui.Paint paint) => _owner.rrects.add((
    _transform(rrect.outerRect),
    paint.color.toARGB32(),
    rrect.tlRadiusX,
  ));

  @override
  void drawCircle(Offset center, double radius, ui.Paint paint) => _owner
      .circles
      .add(_transform(Rect.fromCircle(center: center, radius: radius)));

  @override
  void drawLine(Offset from, Offset to, ui.Paint paint) => _owner.lines.add((
    _transform(Rect.fromPoints(from, to)),
    paint.color.toARGB32(),
  ));

  Rect _transform(Rect rect) => MatrixUtils.transformRect(
    Matrix4.fromFloat64List(_delegate.getTransform()),
    rect,
  );

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
  void clipRect(
    Rect rect, {
    ui.ClipOp clipOp = ui.ClipOp.intersect,
    bool doAntiAlias = true,
  }) {}

  @override
  void clipRRect(ui.RRect rrect, {bool doAntiAlias = true}) {}

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

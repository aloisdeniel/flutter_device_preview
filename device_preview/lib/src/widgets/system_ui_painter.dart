import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../model/system_ui.dart';
import '../svg/svg_drawing.dart';

/// Parses a [SystemUiSimulation] once and paints it over the app.
///
/// Each bar fills the safe area on its side of the screen; artwork is drawn at
/// its natural (view box) size, anchored to the leading edge, the center, or
/// the trailing edge. Nothing is stretched, so one description covers every
/// screen width and both orientations.
///
/// Malformed artwork is failure-isolated exactly like device bodies: reported
/// once through [FlutterError.reportError], then skipped.
class SystemUiPainter {
  /// Creates a painter for [systemUi].
  SystemUiPainter(this.systemUi);

  /// The description this painter draws.
  final SystemUiSimulation systemUi;

  final Map<String, SvgDrawing?> _parsed = <String, SvgDrawing?>{};

  /// Paints the bars of a screen of [screenSize] whose safe area is [padding].
  ///
  /// The canvas origin must be the screen's top-left corner. Bars whose safe
  /// area is zero are skipped.
  void paint(
    ui.Canvas canvas, {
    required ui.Size screenSize,
    required EdgeInsets padding,
    required SystemUiColors colors,
    required TextDirection textDirection,
  }) {
    final SystemUiBar? statusBar = systemUi.statusBar;
    if (statusBar != null && padding.top > 0) {
      _paintBar(
        canvas,
        bar: statusBar,
        region: ui.Rect.fromLTWH(0, 0, screenSize.width, padding.top),
        background: colors.statusBarBackground,
        divider: const ui.Color(0x00000000),
        dividerAtTop: false,
        tint: colors.statusBarIcons,
        textDirection: textDirection,
      );
    }
    final SystemUiBar? navigationBar = systemUi.navigationBar;
    if (navigationBar != null && padding.bottom > 0) {
      _paintBar(
        canvas,
        bar: navigationBar,
        region: ui.Rect.fromLTWH(
          0,
          screenSize.height - padding.bottom,
          screenSize.width,
          padding.bottom,
        ),
        background: colors.navigationBarBackground,
        divider: colors.navigationBarDivider,
        dividerAtTop: true,
        tint: colors.navigationBarIcons,
        textDirection: textDirection,
      );
    }
  }

  void _paintBar(
    ui.Canvas canvas, {
    required SystemUiBar bar,
    required ui.Rect region,
    required ui.Color background,
    required ui.Color divider,
    required bool dividerAtTop,
    required ui.Color tint,
    required TextDirection textDirection,
  }) {
    if (background.a > 0) {
      canvas.drawRect(region, ui.Paint()..color = background);
    }
    if (divider.a > 0) {
      canvas.drawRect(
        ui.Rect.fromLTWH(
          region.left,
          dividerAtTop ? region.top : region.bottom - 1,
          region.width,
          1,
        ),
        ui.Paint()..color = divider,
      );
    }
    final bool rtl = textDirection == TextDirection.rtl;
    _paintArtwork(
      canvas,
      source: rtl ? bar.trailing : bar.leading,
      region: region,
      bar: bar,
      alignment: -1,
      tint: tint,
    );
    _paintArtwork(
      canvas,
      source: bar.center,
      region: region,
      bar: bar,
      alignment: 0,
      tint: tint,
    );
    _paintArtwork(
      canvas,
      source: rtl ? bar.leading : bar.trailing,
      region: region,
      bar: bar,
      alignment: 1,
      tint: tint,
    );
  }

  /// [alignment] is -1 (leading edge), 0 (centered) or 1 (trailing edge).
  void _paintArtwork(
    ui.Canvas canvas, {
    required String source,
    required ui.Rect region,
    required SystemUiBar bar,
    required int alignment,
    required ui.Color tint,
  }) {
    if (source.isEmpty) {
      return;
    }
    final SvgDrawing? drawing = _drawing(source);
    if (drawing == null || drawing.isEmpty || drawing.size.isEmpty) {
      return;
    }
    final ui.Size size = drawing.size;
    final double left = switch (alignment) {
      < 0 => region.left + bar.inset,
      0 => region.center.dx - size.width / 2,
      _ => region.right - bar.inset - size.width,
    };
    final double? bottomInset = bar.bottomInset;
    final double top = bottomInset == null
        ? region.center.dy - size.height / 2
        : region.bottom - bottomInset - size.height;
    // Never let artwork spill outside its own bar.
    final double clampedTop = math.max(region.top, math.min(top, region.bottom - size.height));
    drawing.paintInto(
      canvas,
      ui.Rect.fromLTWH(left, clampedTop, size.width, size.height),
      currentColor: tint,
    );
  }

  SvgDrawing? _drawing(String source) {
    return _parsed.putIfAbsent(source, () {
      try {
        return SvgDrawing.parse(source);
      } catch (error, stack) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'device_preview',
            context: ErrorDescription('while parsing simulated system UI'),
          ),
        );
        return null;
      }
    });
  }
}

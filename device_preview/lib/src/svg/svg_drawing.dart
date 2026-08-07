import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'svg_path_data.dart';
import 'svg_xml.dart';

/// A single flattened, ready-to-paint shape of an [SvgDrawing].
///
/// The path is already expressed in the drawing's own (view box) coordinate
/// space: every ancestor `transform` has been baked in at parse time, so
/// painting is a flat loop with no state to unwind.
@immutable
class SvgShape {
  /// Creates a flattened shape.
  const SvgShape({required this.path, required this.color, this.clips = const <ui.Path>[]});

  /// The outline to fill, in view box coordinates.
  final ui.Path path;

  /// The resolved fill color, including `fill-opacity` and inherited
  /// `opacity`.
  final ui.Color color;

  /// Clip outlines to intersect before filling, in view box coordinates.
  ///
  /// One entry per `clip-path` reference on the shape or on any of its
  /// ancestors, outermost first.
  final List<ui.Path> clips;
}

/// A parsed, dependency-free rendering of a small SVG subset.
///
/// ## Supported subset
///
/// * Structure: `<svg>` (`viewBox`, `width`/`height`), `<g>`, `<defs>`,
///   `<clipPath>`, `<use>`-free.
/// * Shapes: `<path>`, `<rect>` (including `rx`/`ry`), `<circle>`,
///   `<ellipse>`, `<polygon>`.
/// * Paint: `fill` (`#rgb`, `#rgba`, `#rrggbb`, `#rrggbbaa`, `rgb()`,
///   `rgba()`, a handful of named colors, `none`), `fill-opacity`,
///   `fill-rule`, `opacity`, and the same properties written inside a
///   `style="…"` attribute.
/// * Geometry: `transform` (`matrix`, `translate`, `scale`, `rotate`,
///   `skewX`, `skewY`) and `clip-path="url(#id)"`.
///
/// Everything else — strokes, gradients, filters, text, images, masks,
/// `objectBoundingBox` clip units — is ignored by design. Group `opacity` is
/// multiplied into descendant fills rather than composited through a layer,
/// which is exact for non-overlapping flat artwork.
///
/// This exists so `package:device_preview` can draw device bodies with zero
/// dependencies; it is not a general purpose SVG renderer.
@immutable
class SvgDrawing {
  /// Creates a drawing from already-flattened [shapes].
  const SvgDrawing({required this.viewBox, required this.shapes});

  /// An empty drawing that paints nothing.
  static const SvgDrawing empty = SvgDrawing(
    viewBox: ui.Rect.zero,
    shapes: <SvgShape>[],
  );

  /// Parses an SVG document.
  ///
  /// Throws a [FormatException] when the document is not well-formed XML, is
  /// not rooted at `<svg>`, or carries neither a `viewBox` nor
  /// `width`/`height`.
  factory SvgDrawing.parse(String source) {
    final XmlElement root = parseXmlDocument(source);
    if (root.name != 'svg') {
      throw FormatException('Expected a root <svg> element, got <${root.name}>');
    }
    final ui.Rect viewBox = _parseViewBox(root);
    final Map<String, List<XmlElement>> clipPaths = <String, List<XmlElement>>{};
    _collectClipPaths(root, clipPaths);
    final List<SvgShape> shapes = <SvgShape>[];
    _Flattener(clipPaths, shapes).visitChildren(
      root,
      _InheritedStyle(
        transform: Matrix4.identity(),
        // The SVG initial value of `fill`.
        color: const ui.Color(0xFF000000),
        opacity: 1,
        clips: const <ui.Path>[],
      ),
    );
    return SvgDrawing(viewBox: viewBox, shapes: shapes);
  }

  /// The document's coordinate space.
  final ui.Rect viewBox;

  /// The flattened shapes, in paint order.
  final List<SvgShape> shapes;

  /// The size of [viewBox].
  ui.Size get size => viewBox.size;

  /// Whether this drawing paints nothing.
  bool get isEmpty => shapes.isEmpty;

  /// Paints the drawing in its own view box coordinates.
  void paint(ui.Canvas canvas) {
    final ui.Paint paint = ui.Paint()..isAntiAlias = true;
    for (final SvgShape shape in shapes) {
      if (shape.clips.isEmpty) {
        canvas.drawPath(shape.path, paint..color = shape.color);
        continue;
      }
      canvas.save();
      for (final ui.Path clip in shape.clips) {
        canvas.clipPath(clip);
      }
      canvas.drawPath(shape.path, paint..color = shape.color);
      canvas.restore();
    }
  }

  /// Paints the drawing stretched onto [destination].
  ///
  /// The view box is mapped onto the destination rectangle without preserving
  /// the aspect ratio — device bodies declare a view box that already matches
  /// their target rectangle, and an exact mapping keeps the screen cut-out
  /// aligned with the simulated screen.
  void paintInto(ui.Canvas canvas, ui.Rect destination) {
    if (shapes.isEmpty || viewBox.isEmpty || destination.isEmpty) {
      return;
    }
    canvas.save();
    canvas.translate(destination.left, destination.top);
    canvas.scale(
      destination.width / viewBox.width,
      destination.height / viewBox.height,
    );
    canvas.translate(-viewBox.left, -viewBox.top);
    paint(canvas);
    canvas.restore();
  }

  static ui.Rect _parseViewBox(XmlElement root) {
    final String? raw = root.attribute('viewBox');
    if (raw != null) {
      final List<double> values = _parseNumberList(raw);
      if (values.length != 4) {
        throw FormatException('Expected four numbers in viewBox, got: $raw');
      }
      return ui.Rect.fromLTWH(values[0], values[1], values[2], values[3]);
    }
    final double? width = _parseLength(root.attribute('width'));
    final double? height = _parseLength(root.attribute('height'));
    if (width == null || height == null) {
      throw const FormatException(
        'The root <svg> element needs a viewBox or width/height attributes',
      );
    }
    return ui.Rect.fromLTWH(0, 0, width, height);
  }

  static void _collectClipPaths(
    XmlElement element,
    Map<String, List<XmlElement>> into,
  ) {
    for (final XmlElement child in element.children) {
      if (child.name == 'clipPath') {
        final String? id = child.attribute('id');
        if (id != null) {
          into[id] = child.children;
        }
      }
      _collectClipPaths(child, into);
    }
  }
}

/// Style inherited down the element tree while flattening.
@immutable
class _InheritedStyle {
  const _InheritedStyle({
    required this.transform,
    required this.color,
    required this.opacity,
    required this.clips,
  });

  final Matrix4 transform;

  /// The inherited `fill`, or null for `fill="none"`.
  final ui.Color? color;
  final double opacity;
  final List<ui.Path> clips;
}

/// Walks the element tree once, resolving styles and baking transforms into
/// absolute paths.
class _Flattener {
  _Flattener(this.clipPaths, this.shapes);

  final Map<String, List<XmlElement>> clipPaths;
  final List<SvgShape> shapes;

  /// Elements that only group children.
  static const Set<String> _containers = <String>{'g', 'a', 'svg', 'switch'};

  /// Elements skipped entirely (definitions and metadata).
  static const Set<String> _skipped = <String>{
    'defs',
    'clipPath',
    'mask',
    'title',
    'desc',
    'metadata',
    'style',
    'symbol',
    'linearGradient',
    'radialGradient',
    'filter',
  };

  void visitChildren(XmlElement element, _InheritedStyle style) {
    for (final XmlElement child in element.children) {
      _visit(child, style);
    }
  }

  void _visit(XmlElement element, _InheritedStyle parent) {
    if (_skipped.contains(element.name)) {
      return;
    }
    final Map<String, String> attributes = _resolveAttributes(element);
    final Matrix4 transform = parent.transform.clone();
    final String? rawTransform = _valueOf(attributes, 'transform');
    if (rawTransform != null) {
      transform.multiply(_parseTransform(rawTransform));
    }
    final double opacity =
        parent.opacity * (_parseNumber(_valueOf(attributes, 'opacity')) ?? 1);
    final String? rawFill = _valueOf(attributes, 'fill');
    // `none` is inheritable, so it is carried as a null color rather than
    // handled at the leaf.
    final ui.Color? color;
    if (rawFill == null || rawFill == 'currentColor') {
      color = parent.color;
    } else if (rawFill == 'none' || rawFill == 'transparent') {
      color = null;
    } else {
      color = _parseColor(rawFill) ?? parent.color;
    }
    final List<ui.Path> clips = _resolveClips(attributes, transform, parent);
    final _InheritedStyle style = _InheritedStyle(
      transform: transform,
      color: color,
      opacity: opacity,
      clips: clips,
    );

    if (_containers.contains(element.name)) {
      visitChildren(element, style);
      return;
    }

    if (color == null) {
      return;
    }
    final ui.Path? path = _buildShape(element, attributes);
    if (path == null) {
      return;
    }
    final double fillOpacity =
        _parseNumber(_valueOf(attributes, 'fill-opacity')) ?? 1;
    final double alpha = (opacity * fillOpacity).clamp(0.0, 1.0);
    shapes.add(
      SvgShape(
        path: path.transform(transform.storage),
        color: color.withValues(alpha: color.a * alpha),
        clips: clips,
      ),
    );
  }

  List<ui.Path> _resolveClips(
    Map<String, String> attributes,
    Matrix4 transform,
    _InheritedStyle parent,
  ) {
    final String? reference = _valueOf(attributes, 'clip-path');
    if (reference == null) {
      return parent.clips;
    }
    final String? id = _parseUrlReference(reference);
    final List<XmlElement>? definition = id == null ? null : clipPaths[id];
    if (definition == null || definition.isEmpty) {
      return parent.clips;
    }
    // `clipPathUnits` defaults to `userSpaceOnUse`: the clip geometry lives in
    // the user space of the referencing element, i.e. under `transform`.
    final ui.Path clip = ui.Path();
    for (final XmlElement child in definition) {
      final Map<String, String> childAttributes = _resolveAttributes(child);
      final ui.Path? shape = _buildShape(child, childAttributes);
      if (shape == null) {
        continue;
      }
      final String? childTransform = _valueOf(childAttributes, 'transform');
      clip.addPath(
        childTransform == null
            ? shape
            : shape.transform(_parseTransform(childTransform).storage),
        ui.Offset.zero,
      );
    }
    return <ui.Path>[...parent.clips, clip.transform(transform.storage)];
  }

  ui.Path? _buildShape(XmlElement element, Map<String, String> attributes) {
    final ui.PathFillType fillType =
        _valueOf(attributes, 'fill-rule') == 'evenodd'
        ? ui.PathFillType.evenOdd
        : ui.PathFillType.nonZero;
    switch (element.name) {
      case 'path':
        final String? data = _valueOf(attributes, 'd');
        if (data == null) {
          return null;
        }
        return parseSvgPathData(data, fillType: fillType);
      case 'rect':
        final double width = _parseNumber(_valueOf(attributes, 'width')) ?? 0;
        final double height = _parseNumber(_valueOf(attributes, 'height')) ?? 0;
        if (width <= 0 || height <= 0) {
          return null;
        }
        final double x = _parseNumber(_valueOf(attributes, 'x')) ?? 0;
        final double y = _parseNumber(_valueOf(attributes, 'y')) ?? 0;
        final double? rx = _parseNumber(_valueOf(attributes, 'rx'));
        final double? ry = _parseNumber(_valueOf(attributes, 'ry'));
        final ui.Rect rect = ui.Rect.fromLTWH(x, y, width, height);
        final ui.Path path = ui.Path()..fillType = fillType;
        if ((rx ?? ry) == null) {
          path.addRect(rect);
        } else {
          path.addRRect(
            ui.RRect.fromRectXY(rect, rx ?? ry!, ry ?? rx!),
          );
        }
        return path;
      case 'circle':
        final double radius = _parseNumber(_valueOf(attributes, 'r')) ?? 0;
        if (radius <= 0) {
          return null;
        }
        return ui.Path()
          ..fillType = fillType
          ..addOval(
            ui.Rect.fromCircle(
              center: ui.Offset(
                _parseNumber(_valueOf(attributes, 'cx')) ?? 0,
                _parseNumber(_valueOf(attributes, 'cy')) ?? 0,
              ),
              radius: radius,
            ),
          );
      case 'ellipse':
        final double rx = _parseNumber(_valueOf(attributes, 'rx')) ?? 0;
        final double ry = _parseNumber(_valueOf(attributes, 'ry')) ?? 0;
        if (rx <= 0 || ry <= 0) {
          return null;
        }
        return ui.Path()
          ..fillType = fillType
          ..addOval(
            ui.Rect.fromCenter(
              center: ui.Offset(
                _parseNumber(_valueOf(attributes, 'cx')) ?? 0,
                _parseNumber(_valueOf(attributes, 'cy')) ?? 0,
              ),
              width: rx * 2,
              height: ry * 2,
            ),
          );
      case 'polygon':
        final List<double> points = _parseNumberList(
          _valueOf(attributes, 'points') ?? '',
        );
        if (points.length < 6) {
          return null;
        }
        final ui.Path path = ui.Path()..fillType = fillType;
        path.moveTo(points[0], points[1]);
        for (int i = 2; i + 1 < points.length; i += 2) {
          path.lineTo(points[i], points[i + 1]);
        }
        path.close();
        return path;
      default:
        return null;
    }
  }

  /// Merges presentation attributes with the `style="…"` declarations, which
  /// win over their attribute form.
  static Map<String, String> _resolveAttributes(XmlElement element) {
    final String? style = element.attribute('style');
    if (style == null) {
      return element.attributes;
    }
    final Map<String, String> merged = Map<String, String>.of(
      element.attributes,
    );
    for (final String declaration in style.split(';')) {
      final int separator = declaration.indexOf(':');
      if (separator <= 0) {
        continue;
      }
      merged[declaration.substring(0, separator).trim()] = declaration
          .substring(separator + 1)
          .trim();
    }
    return merged;
  }

  static String? _valueOf(Map<String, String> attributes, String name) {
    final String? value = attributes[name];
    return (value == null || value.isEmpty) ? null : value.trim();
  }
}

/// Parses a whitespace/comma separated list of numbers.
List<double> _parseNumberList(String raw) {
  final List<double> values = <double>[];
  for (final Match match in _numberPattern.allMatches(raw)) {
    final double? value = double.tryParse(match.group(0)!);
    if (value != null) {
      values.add(value);
    }
  }
  return values;
}

final RegExp _numberPattern = RegExp(r'[-+]?(\d*\.\d+|\d+\.?)([eE][-+]?\d+)?');

double? _parseNumber(String? raw) => raw == null ? null : double.tryParse(raw);

/// Parses a length, dropping a `px` suffix (other units are unsupported).
double? _parseLength(String? raw) {
  if (raw == null) {
    return null;
  }
  final String trimmed = raw.endsWith('px')
      ? raw.substring(0, raw.length - 2)
      : raw;
  return double.tryParse(trimmed.trim());
}

String? _parseUrlReference(String raw) {
  final Match? match = _urlPattern.firstMatch(raw);
  return match?.group(1);
}

final RegExp _urlPattern = RegExp(r'url\(\s*#([^)\s]+)\s*\)');

/// Parses the color syntaxes of the supported subset; returns null for
/// anything else (including `none`, handled by the caller).
ui.Color? _parseColor(String raw) {
  final String value = raw.trim();
  if (value.isEmpty || value == 'none' || value == 'transparent') {
    return null;
  }
  if (value.startsWith('#')) {
    final String hex = value.substring(1);
    switch (hex.length) {
      case 3:
      case 4:
        final StringBuffer expanded = StringBuffer();
        for (int i = 0; i < hex.length; i++) {
          expanded
            ..write(hex[i])
            ..write(hex[i]);
        }
        return _parseHex(expanded.toString());
      case 6:
      case 8:
        return _parseHex(hex);
      default:
        return null;
    }
  }
  final Match? rgb = _rgbPattern.firstMatch(value);
  if (rgb != null) {
    final List<double> components = _parseNumberList(rgb.group(1)!);
    if (components.length < 3) {
      return null;
    }
    final double alpha = components.length > 3 ? components[3] : 1;
    return ui.Color.fromARGB(
      (alpha.clamp(0.0, 1.0) * 255).round(),
      components[0].round().clamp(0, 255),
      components[1].round().clamp(0, 255),
      components[2].round().clamp(0, 255),
    );
  }
  return _namedColors[value.toLowerCase()];
}

ui.Color? _parseHex(String hex) {
  final int? value = int.tryParse(hex, radix: 16);
  if (value == null) {
    return null;
  }
  if (hex.length == 6) {
    return ui.Color(0xFF000000 | value);
  }
  // #rrggbbaa → 0xAARRGGBB
  return ui.Color(((value & 0xFF) << 24) | (value >> 8));
}

final RegExp _rgbPattern = RegExp(r'rgba?\(([^)]*)\)');

const Map<String, ui.Color> _namedColors = <String, ui.Color>{
  'black': ui.Color(0xFF000000),
  'white': ui.Color(0xFFFFFFFF),
  'gray': ui.Color(0xFF808080),
  'grey': ui.Color(0xFF808080),
  'silver': ui.Color(0xFFC0C0C0),
  'red': ui.Color(0xFFFF0000),
  'green': ui.Color(0xFF008000),
  'blue': ui.Color(0xFF0000FF),
  'yellow': ui.Color(0xFFFFFF00),
  'orange': ui.Color(0xFFFFA500),
  'navy': ui.Color(0xFF000080),
};

/// Parses an SVG `transform` attribute into a matrix.
Matrix4 _parseTransform(String raw) {
  final Matrix4 result = Matrix4.identity();
  for (final Match match in _transformPattern.allMatches(raw)) {
    final String name = match.group(1)!;
    final List<double> values = _parseNumberList(match.group(2)!);
    switch (name) {
      case 'matrix':
        if (values.length == 6) {
          result.multiply(
            Matrix4(
              values[0], values[1], 0, 0, //
              values[2], values[3], 0, 0, //
              0, 0, 1, 0, //
              values[4], values[5], 0, 1,
            ),
          );
        }
      case 'translate':
        if (values.isNotEmpty) {
          result.translateByDouble(
            values[0],
            values.length > 1 ? values[1] : 0,
            0,
            1,
          );
        }
      case 'scale':
        if (values.isNotEmpty) {
          result.scaleByDouble(
            values[0],
            values.length > 1 ? values[1] : values[0],
            1,
            1,
          );
        }
      case 'rotate':
        if (values.isNotEmpty) {
          final double radians = values[0] * math.pi / 180;
          if (values.length >= 3) {
            result
              ..translateByDouble(values[1], values[2], 0, 1)
              ..rotateZ(radians)
              ..translateByDouble(-values[1], -values[2], 0, 1);
          } else {
            result.rotateZ(radians);
          }
        }
      case 'skewX':
        if (values.isNotEmpty) {
          result.multiply(Matrix4.skewX(values[0] * math.pi / 180));
        }
      case 'skewY':
        if (values.isNotEmpty) {
          result.multiply(Matrix4.skewY(values[0] * math.pi / 180));
        }
    }
  }
  return result;
}

final RegExp _transformPattern = RegExp(r'(\w+)\s*\(([^)]*)\)');

import 'dart:ui' as ui;

import 'package:device_preview/svg.dart';
import 'package:flutter_test/flutter_test.dart';

String document(String body, {String viewBox = '0 0 100 100'}) =>
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="$viewBox">$body</svg>';

void main() {
  group('xml', () {
    test('elements, attributes, nesting and self-closing tags', () {
      final XmlElement root = parseXmlDocument(
        '<svg width="10"><g id="a"><path d="M0,0"/></g></svg>',
      );
      expect(root.name, 'svg');
      expect(root.attribute('width'), '10');
      expect(root.children.single.name, 'g');
      expect(root.children.single.attribute('id'), 'a');
      expect(root.children.single.children.single.name, 'path');
    });

    test('prologue, comments, doctype and CDATA are skipped', () {
      final XmlElement root = parseXmlDocument(
        '<?xml version="1.0"?>\n'
        '<!-- a comment -->\n'
        '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "svg11.dtd">\n'
        '<svg><!-- inner --><g/><![CDATA[ raw ]]></svg>',
      );
      expect(root.name, 'svg');
      expect(root.children.map((XmlElement e) => e.name), <String>['g']);
    });

    test('namespace prefixes are stripped from element names', () {
      final XmlElement root = parseXmlDocument('<svg:svg><svg:g/></svg:svg>');
      expect(root.name, 'svg');
      expect(root.children.single.name, 'g');
    });

    test('entities are decoded in attribute values', () {
      final XmlElement root = parseXmlDocument(
        "<svg title='a &amp; b &lt;c&gt; &#65;'/>",
      );
      expect(root.attribute('title'), 'a & b <c> A');
    });

    test('text content is ignored', () {
      final XmlElement root = parseXmlDocument('<svg>hello<g/>world</svg>');
      expect(root.children, hasLength(1));
    });

    test('malformed input throws', () {
      expect(() => parseXmlDocument(''), throwsFormatException);
      expect(() => parseXmlDocument('<svg>'), throwsFormatException);
      expect(() => parseXmlDocument('<svg></g>'), throwsFormatException);
      expect(() => parseXmlDocument('<svg a=b/>'), throwsFormatException);
    });
  });

  group('document', () {
    test('view box is read from viewBox', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document('<path d="M0,0"/>', viewBox: '-5 -10 40 60'),
      );
      expect(drawing.viewBox, const ui.Rect.fromLTWH(-5, -10, 40, 60));
      expect(drawing.size, const ui.Size(40, 60));
    });

    test('view box falls back to width and height', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        '<svg width="30px" height="40"><rect width="10" height="10"/></svg>',
      );
      expect(drawing.viewBox, const ui.Rect.fromLTWH(0, 0, 30, 40));
    });

    test('a document without geometry information is rejected', () {
      expect(() => SvgDrawing.parse('<svg><g/></svg>'), throwsFormatException);
    });

    test('a non-svg root is rejected', () {
      expect(
        () => SvgDrawing.parse('<html viewBox="0 0 1 1"/>'),
        throwsFormatException,
      );
    });

    test('the empty drawing paints nothing', () {
      expect(SvgDrawing.empty.isEmpty, isTrue);
      expect(SvgDrawing.empty.shapes, isEmpty);
    });
  });

  group('shapes', () {
    test('path, rect, circle, ellipse and polygon are all supported', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<path d="M0,0 H10 V10 Z"/>'
          '<rect x="20" y="0" width="10" height="20"/>'
          '<circle cx="50" cy="50" r="5"/>'
          '<ellipse cx="70" cy="50" rx="10" ry="5"/>'
          '<polygon points="0,80 20,80 10,100"/>',
        ),
      );
      expect(drawing.shapes, hasLength(5));
      expect(
        drawing.shapes[1].path.getBounds(),
        const ui.Rect.fromLTRB(20, 0, 30, 20),
      );
      expect(
        drawing.shapes[2].path.getBounds(),
        const ui.Rect.fromLTRB(45, 45, 55, 55),
      );
      expect(
        drawing.shapes[3].path.getBounds(),
        const ui.Rect.fromLTRB(60, 45, 80, 55),
      );
      expect(
        drawing.shapes[4].path.getBounds(),
        const ui.Rect.fromLTRB(0, 80, 20, 100),
      );
    });

    test('rounded rectangles honor rx / ry', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document('<rect width="100" height="100" rx="20"/>'),
      );
      expect(drawing.shapes.single.path.contains(const ui.Offset(1, 1)), isFalse);
      expect(
        drawing.shapes.single.path.contains(const ui.Offset(50, 50)),
        isTrue,
      );
    });

    test('unsupported elements are skipped, not fatal', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<text x="0" y="0">hi</text>'
          '<image href="a.png"/>'
          '<line x1="0" y1="0" x2="10" y2="10"/>'
          '<rect width="10" height="10"/>',
        ),
      );
      expect(drawing.shapes, hasLength(1));
    });

    test('definitions and metadata never paint', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<title>Device</title><desc>Body</desc>'
          '<defs><rect width="10" height="10"/></defs>'
          '<rect width="20" height="20"/>',
        ),
      );
      expect(drawing.shapes, hasLength(1));
      expect(
        drawing.shapes.single.path.getBounds(),
        const ui.Rect.fromLTRB(0, 0, 20, 20),
      );
    });
  });

  group('paint', () {
    test('fill colors: hex, short hex, rgb, rgba and names', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<rect width="1" height="1" fill="#ff0000"/>'
          '<rect width="1" height="1" fill="#0f0"/>'
          '<rect width="1" height="1" fill="rgb(0, 0, 255)"/>'
          '<rect width="1" height="1" fill="rgba(0, 0, 0, 0.5)"/>'
          '<rect width="1" height="1" fill="white"/>'
          '<rect width="1" height="1" fill="#11223344"/>',
        ),
      );
      expect(
        drawing.shapes.map((SvgShape s) => s.color),
        <ui.Color>[
          const ui.Color(0xFFFF0000),
          const ui.Color(0xFF00FF00),
          const ui.Color(0xFF0000FF),
          const ui.Color(0x80000000),
          const ui.Color(0xFFFFFFFF),
          const ui.Color(0x44112233),
        ],
      );
    });

    test('the default fill is black and unknown colors fall back', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document('<rect width="1" height="1"/><rect width="1" height="1" '
            'fill="not-a-color"/>'),
      );
      expect(drawing.shapes.first.color, const ui.Color(0xFF000000));
      expect(drawing.shapes.last.color, const ui.Color(0xFF000000));
    });

    test('fill is inherited from groups, including "none"', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<g fill="#ff0000"><rect width="1" height="1"/></g>'
          '<g fill="none"><rect width="1" height="1"/></g>',
        ),
      );
      expect(drawing.shapes, hasLength(1));
      expect(drawing.shapes.single.color, const ui.Color(0xFFFF0000));
    });

    test('currentColor follows the paint-time tint regardless of the '
        'inherited fill', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          // CSS: currentColor resolves to the `color` property (the tint),
          // not to the fill an element would inherit.
          '<rect width="1" height="1" fill="currentColor"/>'
          '<g fill="#ff0000"><rect width="1" height="1" '
          'fill="currentColor"/></g>'
          '<g fill="none"><rect width="1" height="1" '
          'fill="currentColor"/></g>',
        ),
      );
      expect(drawing.shapes, hasLength(3));
      expect(
        drawing.shapes.map((SvgShape s) => s.followsCurrentColor),
        everyElement(isTrue),
      );
      // Under fill="none" the spec default for `color` (black) applies when
      // no tint is supplied; under an explicit group fill the untinted
      // fallback keeps the inherited color.
      expect(drawing.shapes[1].color, const ui.Color(0xFFFF0000));
      expect(drawing.shapes[2].color, const ui.Color(0xFF000000));
    });

    test('opacity and fill-opacity multiply into the alpha channel', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<g opacity="0.5">'
          '<rect width="1" height="1" fill="#000000" fill-opacity="0.5"/>'
          '</g>',
        ),
      );
      expect(drawing.shapes.single.color.a, closeTo(0.25, 0.01));
    });

    test('style declarations win over presentation attributes', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<rect width="1" height="1" fill="#000000" '
          'style="fill:#ff0000;fill-opacity:1"/>',
        ),
      );
      expect(drawing.shapes.single.color, const ui.Color(0xFFFF0000));
    });

    test('fill-rule selects the even-odd fill type', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<path fill-rule="evenodd" '
          'd="M0,0 H100 V100 H0 Z M25,25 H75 V75 H25 Z"/>',
        ),
      );
      expect(
        drawing.shapes.single.path.contains(const ui.Offset(50, 50)),
        isFalse,
      );
    });
  });

  group('transforms', () {
    test('translate, scale and their nesting', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<g transform="translate(10, 20)">'
          '<rect width="10" height="10"/>'
          '<g transform="scale(2)"><rect width="10" height="10"/></g>'
          '</g>',
        ),
      );
      expect(
        drawing.shapes.first.path.getBounds(),
        const ui.Rect.fromLTRB(10, 20, 20, 30),
      );
      expect(
        drawing.shapes.last.path.getBounds(),
        const ui.Rect.fromLTRB(10, 20, 30, 40),
      );
    });

    test('matrix and rotate about a point', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<rect width="10" height="10" transform="matrix(1 0 0 1 5 5)"/>'
          '<rect width="10" height="10" transform="rotate(90, 0, 0)"/>',
        ),
      );
      expect(
        drawing.shapes.first.path.getBounds(),
        const ui.Rect.fromLTRB(5, 5, 15, 15),
      );
      final ui.Rect rotated = drawing.shapes.last.path.getBounds();
      expect(rotated.left, closeTo(-10, 0.001));
      expect(rotated.top, closeTo(0, 0.001));
      expect(rotated.right, closeTo(0, 0.001));
      expect(rotated.bottom, closeTo(10, 0.001));
    });
  });

  group('clip paths', () {
    test('a clip-path reference attaches the clip outline to the shape', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<defs><clipPath id="c">'
          '<rect x="0" y="0" width="50" height="50"/>'
          '</clipPath></defs>'
          '<g clip-path="url(#c)">'
          '<rect width="100" height="100" fill="#ff0000"/>'
          '</g>',
        ),
      );
      final SvgShape shape = drawing.shapes.single;
      expect(shape.clips, hasLength(1));
      expect(shape.clips.single.getBounds(), const ui.Rect.fromLTRB(0, 0, 50, 50));
      // The shape itself is not clipped at parse time — the clip is applied
      // on the canvas at paint time.
      expect(shape.path.getBounds(), const ui.Rect.fromLTRB(0, 0, 100, 100));
    });

    test('definitions may follow their use', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<rect width="100" height="100" clip-path="url(#late)"/>'
          '<defs><clipPath id="late">'
          '<rect width="10" height="10"/>'
          '</clipPath></defs>',
        ),
      );
      expect(drawing.shapes.single.clips, hasLength(1));
    });

    test('the clip lives in the referencing element user space', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<defs><clipPath id="c">'
          '<rect width="50" height="50"/>'
          '</clipPath></defs>'
          '<g transform="translate(20, 30)" clip-path="url(#c)">'
          '<rect width="100" height="100"/>'
          '</g>',
        ),
      );
      expect(
        drawing.shapes.single.clips.single.getBounds(),
        const ui.Rect.fromLTRB(20, 30, 70, 80),
      );
    });

    test('nested clips accumulate, an unknown reference is ignored', () {
      final SvgDrawing drawing = SvgDrawing.parse(
        document(
          '<defs><clipPath id="c"><rect width="50" height="50"/></clipPath>'
          '</defs>'
          '<g clip-path="url(#c)">'
          '<g clip-path="url(#c)"><rect width="10" height="10"/></g>'
          '<rect width="10" height="10" clip-path="url(#missing)"/>'
          '</g>',
        ),
      );
      expect(drawing.shapes.first.clips, hasLength(2));
      expect(drawing.shapes.last.clips, hasLength(1));
    });
  });

  test('painting issues one fill per shape, clipped and mapped', () {
    final SvgDrawing drawing = SvgDrawing.parse(
      document(
        '<defs><clipPath id="c"><rect width="50" height="50"/></clipPath>'
        '</defs>'
        '<rect width="100" height="100" fill="#112233"/>'
        '<rect width="100" height="100" fill="#445566" clip-path="url(#c)"/>',
      ),
    );

    final _RecordingCanvas canvas = _RecordingCanvas();
    drawing.paintInto(canvas, const ui.Rect.fromLTWH(10, 20, 200, 200));

    expect(canvas.log, <String>[
      'save',
      'translate(10.0, 20.0)',
      'scale(2.0, 2.0)',
      'translate(-0.0, -0.0)',
      // Unclipped shape.
      'drawPath(#ff112233)',
      // Clipped shape: the clip is scoped by a save/restore pair.
      'save',
      'clipPath',
      'drawPath(#ff445566)',
      'restore',
      'restore',
    ]);
  });
}

/// Records the canvas operations the drawing issues. Everything else is
/// swallowed by [noSuchMethod] — the subset never calls it.
class _RecordingCanvas implements ui.Canvas {
  final List<String> log = <String>[];

  @override
  void save() => log.add('save');

  @override
  void restore() => log.add('restore');

  @override
  void translate(double dx, double dy) => log.add('translate($dx, $dy)');

  @override
  void scale(double sx, [double? sy]) => log.add('scale($sx, ${sy ?? sx})');

  @override
  void clipPath(ui.Path path, {bool doAntiAlias = true}) =>
      log.add('clipPath');

  @override
  void drawPath(ui.Path path, ui.Paint paint) => log.add(
        'drawPath(#${paint.color.toARGB32().toRadixString(16).padLeft(8, '0')})',
      );

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('unexpected ${invocation.memberName}');
}

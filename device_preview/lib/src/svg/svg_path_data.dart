import 'dart:ui' as ui;

/// Parses the SVG path data grammar (the `d` attribute of `<path>`) into a
/// [ui.Path].
///
/// The full command set is supported — `M m Z z L l H h V v C c S s Q q T t
/// A a` — including implicit command repetition (`M 0 0 10 10` continues as
/// `L`), implicit sign separation (`10-5`), exponent notation, and compact
/// arc flags (`a5 5 0 0150 5`).
///
/// Elliptical arcs map onto [ui.Path.arcToPoint], which implements the same
/// endpoint parameterization; a zero radius degenerates to a line, as the SVG
/// specification requires.
///
/// Throws a [FormatException] on malformed input, with the offending offset.
ui.Path parseSvgPathData(
  String data, {
  ui.PathFillType fillType = ui.PathFillType.nonZero,
}) {
  final ui.Path path = ui.Path()..fillType = fillType;
  _SvgPathDataParser(data, path).run();
  return path;
}

/// Single-pass, allocation-light parser over the path data grammar.
class _SvgPathDataParser {
  _SvgPathDataParser(this._source, this._path);

  final String _source;
  final ui.Path _path;

  int _index = 0;

  /// Current point.
  double _x = 0;
  double _y = 0;

  /// Start of the current subpath (the point `Z` returns to).
  double _startX = 0;
  double _startY = 0;

  /// Second control point of the previous cubic, for the `S`/`s` reflection.
  double? _cubicControlX;
  double? _cubicControlY;

  /// Control point of the previous quadratic, for the `T`/`t` reflection.
  double? _quadControlX;
  double? _quadControlY;

  void run() {
    String? command;
    while (true) {
      _skipSeparators();
      if (_index >= _source.length) {
        return;
      }
      if (_isCommand(_source.codeUnitAt(_index))) {
        command = _source[_index];
        _index++;
      } else if (command == null) {
        throw FormatException(
          'Expected an SVG path command',
          _source,
          _index,
        );
      } else if (command == 'Z' || command == 'z') {
        throw FormatException(
          'Unexpected argument after a "close" command',
          _source,
          _index,
        );
      }
      _execute(command);
      // A moveto's trailing coordinate pairs are implicit linetos.
      if (command == 'M') {
        command = 'L';
      } else if (command == 'm') {
        command = 'l';
      }
    }
  }

  void _execute(String command) {
    final bool relative = command.toUpperCase() != command;
    switch (command.toUpperCase()) {
      case 'M':
        final double x = _number() + (relative ? _x : 0);
        final double y = _number() + (relative ? _y : 0);
        _path.moveTo(x, y);
        _x = _startX = x;
        _y = _startY = y;
        _clearReflections();
      case 'L':
        final double x = _number() + (relative ? _x : 0);
        final double y = _number() + (relative ? _y : 0);
        _lineTo(x, y);
      case 'H':
        _lineTo(_number() + (relative ? _x : 0), _y);
      case 'V':
        _lineTo(_x, _number() + (relative ? _y : 0));
      case 'C':
        final double dx = relative ? _x : 0;
        final double dy = relative ? _y : 0;
        final double x1 = _number() + dx;
        final double y1 = _number() + dy;
        final double x2 = _number() + dx;
        final double y2 = _number() + dy;
        final double x = _number() + dx;
        final double y = _number() + dy;
        _cubicTo(x1, y1, x2, y2, x, y);
      case 'S':
        final double dx = relative ? _x : 0;
        final double dy = relative ? _y : 0;
        final double x2 = _number() + dx;
        final double y2 = _number() + dy;
        final double x = _number() + dx;
        final double y = _number() + dy;
        // Reflection of the previous cubic's second control point; the
        // current point itself when the previous command was not a cubic.
        final double x1 = _cubicControlX == null ? _x : 2 * _x - _cubicControlX!;
        final double y1 = _cubicControlY == null ? _y : 2 * _y - _cubicControlY!;
        _cubicTo(x1, y1, x2, y2, x, y);
      case 'Q':
        final double dx = relative ? _x : 0;
        final double dy = relative ? _y : 0;
        final double x1 = _number() + dx;
        final double y1 = _number() + dy;
        final double x = _number() + dx;
        final double y = _number() + dy;
        _quadraticTo(x1, y1, x, y);
      case 'T':
        final double dx = relative ? _x : 0;
        final double dy = relative ? _y : 0;
        final double x = _number() + dx;
        final double y = _number() + dy;
        final double x1 = _quadControlX == null ? _x : 2 * _x - _quadControlX!;
        final double y1 = _quadControlY == null ? _y : 2 * _y - _quadControlY!;
        _quadraticTo(x1, y1, x, y);
      case 'A':
        final double rx = _number().abs();
        final double ry = _number().abs();
        final double rotation = _number();
        final bool largeArc = _flag();
        final bool sweep = _flag();
        final double x = _number() + (relative ? _x : 0);
        final double y = _number() + (relative ? _y : 0);
        if (rx == 0 || ry == 0) {
          // Degenerate radii: the specification mandates a straight line.
          _lineTo(x, y);
        } else {
          _path.arcToPoint(
            ui.Offset(x, y),
            radius: ui.Radius.elliptical(rx, ry),
            rotation: rotation,
            largeArc: largeArc,
            clockwise: sweep,
          );
          _x = x;
          _y = y;
          _clearReflections();
        }
      case 'Z':
        _path.close();
        _x = _startX;
        _y = _startY;
        _clearReflections();
      default:
        throw FormatException(
          'Unsupported SVG path command "$command"',
          _source,
          _index,
        );
    }
  }

  void _lineTo(double x, double y) {
    _path.lineTo(x, y);
    _x = x;
    _y = y;
    _clearReflections();
  }

  void _cubicTo(
    double x1,
    double y1,
    double x2,
    double y2,
    double x,
    double y,
  ) {
    _path.cubicTo(x1, y1, x2, y2, x, y);
    _x = x;
    _y = y;
    _quadControlX = null;
    _quadControlY = null;
    _cubicControlX = x2;
    _cubicControlY = y2;
  }

  void _quadraticTo(double x1, double y1, double x, double y) {
    _path.quadraticBezierTo(x1, y1, x, y);
    _x = x;
    _y = y;
    _cubicControlX = null;
    _cubicControlY = null;
    _quadControlX = x1;
    _quadControlY = y1;
  }

  void _clearReflections() {
    _cubicControlX = null;
    _cubicControlY = null;
    _quadControlX = null;
    _quadControlY = null;
  }

  static bool _isCommand(int code) {
    // A–Z / a–z, restricted to the path command letters.
    const String commands = 'MmZzLlHhVvCcSsQqTtAa';
    return commands.contains(String.fromCharCode(code));
  }

  static bool _isDigit(int code) => code >= 0x30 && code <= 0x39;

  void _skipSeparators() {
    while (_index < _source.length) {
      final int code = _source.codeUnitAt(_index);
      // Whitespace or comma.
      if (code == 0x20 ||
          code == 0x09 ||
          code == 0x0A ||
          code == 0x0D ||
          code == 0x0C ||
          code == 0x2C) {
        _index++;
      } else {
        return;
      }
    }
  }

  /// Reads one number, skipping any leading separators.
  double _number() {
    _skipSeparators();
    final int start = _index;
    if (_index < _source.length) {
      final int code = _source.codeUnitAt(_index);
      if (code == 0x2B || code == 0x2D) {
        _index++;
      }
    }
    while (_index < _source.length && _isDigit(_source.codeUnitAt(_index))) {
      _index++;
    }
    if (_index < _source.length && _source.codeUnitAt(_index) == 0x2E) {
      _index++;
      while (_index < _source.length && _isDigit(_source.codeUnitAt(_index))) {
        _index++;
      }
    }
    if (_index < _source.length) {
      final int code = _source.codeUnitAt(_index);
      if (code == 0x65 || code == 0x45) {
        // A trailing "e" only belongs to the number when an exponent follows.
        final int exponentStart = _index;
        _index++;
        if (_index < _source.length) {
          final int sign = _source.codeUnitAt(_index);
          if (sign == 0x2B || sign == 0x2D) {
            _index++;
          }
        }
        if (_index < _source.length && _isDigit(_source.codeUnitAt(_index))) {
          while (_index < _source.length &&
              _isDigit(_source.codeUnitAt(_index))) {
            _index++;
          }
        } else {
          _index = exponentStart;
        }
      }
    }
    final String text = _source.substring(start, _index);
    final double? value = double.tryParse(text);
    if (value == null) {
      throw FormatException('Expected a number', _source, start);
    }
    return value;
  }

  /// Reads a single-character arc flag (`0` or `1`).
  bool _flag() {
    _skipSeparators();
    if (_index >= _source.length) {
      throw FormatException('Expected an arc flag', _source, _index);
    }
    final int code = _source.codeUnitAt(_index);
    if (code != 0x30 && code != 0x31) {
      throw FormatException(
        'Expected an arc flag ("0" or "1")',
        _source,
        _index,
      );
    }
    _index++;
    return code == 0x31;
  }
}

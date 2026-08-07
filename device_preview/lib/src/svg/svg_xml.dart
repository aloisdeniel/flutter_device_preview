import 'package:flutter/foundation.dart';

/// A parsed XML element: a name, its attributes, and its element children.
///
/// Text content, comments, processing instructions and doctypes are dropped —
/// the SVG subset this package renders is entirely attribute-driven.
@immutable
class XmlElement {
  /// Creates an element node.
  const XmlElement({
    required this.name,
    required this.attributes,
    required this.children,
  });

  /// The local element name, with any namespace prefix stripped
  /// (`svg:path` → `path`).
  final String name;

  /// The element's attributes, keyed by their raw (prefixed) name.
  final Map<String, String> attributes;

  /// The element children, in document order.
  final List<XmlElement> children;

  /// Returns the value of [name], or null when absent or empty.
  String? attribute(String name) {
    final String? value = attributes[name];
    return (value == null || value.isEmpty) ? null : value;
  }

  @override
  String toString() => '<$name ${attributes.keys.join(' ')}>';
}

/// Parses [source] into its root [XmlElement].
///
/// A deliberately small, dependency-free reader: elements, attributes,
/// self-closing tags, entity references in attribute values, and the usual
/// prologue noise (`<?xml …?>`, comments, `<!DOCTYPE …>`, CDATA). Namespaces
/// are not resolved — prefixes are stripped from element names.
///
/// Throws a [FormatException] on malformed input.
XmlElement parseXmlDocument(String source) => _XmlParser(source).parseDocument();

class _XmlParser {
  _XmlParser(this._source);

  final String _source;
  int _index = 0;

  XmlElement parseDocument() {
    while (true) {
      _skipWhitespace();
      if (_index >= _source.length) {
        throw FormatException('No XML element found', _source, _index);
      }
      if (!_startsWith('<')) {
        throw FormatException('Expected an element', _source, _index);
      }
      if (_startsWith('<?')) {
        _skipUntil('?>');
      } else if (_startsWith('<!--')) {
        _skipUntil('-->');
      } else if (_startsWith('<!')) {
        _skipDeclaration();
      } else {
        return _parseElement();
      }
    }
  }

  XmlElement _parseElement() {
    _expect('<');
    final String name = _readName();
    final Map<String, String> attributes = <String, String>{};
    while (true) {
      _skipWhitespace();
      if (_startsWith('/>')) {
        _index += 2;
        return XmlElement(
          name: _localName(name),
          attributes: attributes,
          children: const <XmlElement>[],
        );
      }
      if (_startsWith('>')) {
        _index++;
        break;
      }
      final String attributeName = _readName();
      _skipWhitespace();
      _expect('=');
      _skipWhitespace();
      attributes[attributeName] = _readAttributeValue();
    }

    final List<XmlElement> children = <XmlElement>[];
    while (true) {
      final int textStart = _index;
      _skipUntilChar(0x3C /* < */);
      if (_index >= _source.length) {
        throw FormatException(
          'Unterminated element "<$name>"',
          _source,
          textStart,
        );
      }
      if (_startsWith('</')) {
        _index += 2;
        final String closing = _readName();
        _skipWhitespace();
        _expect('>');
        if (closing != name) {
          throw FormatException(
            'Closing tag "</$closing>" does not match "<$name>"',
            _source,
            _index,
          );
        }
        return XmlElement(
          name: _localName(name),
          attributes: attributes,
          children: children,
        );
      }
      if (_startsWith('<!--')) {
        _skipUntil('-->');
      } else if (_startsWith('<![CDATA[')) {
        _skipUntil(']]>');
      } else if (_startsWith('<?')) {
        _skipUntil('?>');
      } else if (_startsWith('<!')) {
        _skipDeclaration();
      } else {
        children.add(_parseElement());
      }
    }
  }

  static String _localName(String name) {
    final int colon = name.indexOf(':');
    return colon == -1 ? name : name.substring(colon + 1);
  }

  bool _startsWith(String pattern) => _source.startsWith(pattern, _index);

  void _expect(String pattern) {
    if (!_startsWith(pattern)) {
      throw FormatException('Expected "$pattern"', _source, _index);
    }
    _index += pattern.length;
  }

  void _skipUntil(String pattern) {
    final int end = _source.indexOf(pattern, _index);
    if (end == -1) {
      throw FormatException('Expected "$pattern"', _source, _index);
    }
    _index = end + pattern.length;
  }

  void _skipUntilChar(int code) {
    while (_index < _source.length && _source.codeUnitAt(_index) != code) {
      _index++;
    }
  }

  /// Skips `<!DOCTYPE …>`, including a bracketed internal subset.
  void _skipDeclaration() {
    _index += 2;
    int depth = 1;
    while (_index < _source.length && depth > 0) {
      final int code = _source.codeUnitAt(_index);
      if (code == 0x5B /* [ */ ) {
        _skipUntil(']');
        continue;
      }
      if (code == 0x3E /* > */ ) {
        depth--;
      }
      _index++;
    }
    if (depth > 0) {
      throw FormatException('Unterminated declaration', _source, _index);
    }
  }

  void _skipWhitespace() {
    while (_index < _source.length) {
      final int code = _source.codeUnitAt(_index);
      if (code == 0x20 || code == 0x09 || code == 0x0A || code == 0x0D) {
        _index++;
      } else {
        return;
      }
    }
  }

  String _readName() {
    final int start = _index;
    while (_index < _source.length) {
      final int code = _source.codeUnitAt(_index);
      final bool isNameChar =
          (code >= 0x41 && code <= 0x5A) || // A-Z
          (code >= 0x61 && code <= 0x7A) || // a-z
          (code >= 0x30 && code <= 0x39) || // 0-9
          code == 0x2D || // -
          code == 0x5F || // _
          code == 0x2E || // .
          code == 0x3A; // :
      if (!isNameChar) {
        break;
      }
      _index++;
    }
    if (_index == start) {
      throw FormatException('Expected a name', _source, start);
    }
    return _source.substring(start, _index);
  }

  String _readAttributeValue() {
    if (_index >= _source.length) {
      throw FormatException('Expected an attribute value', _source, _index);
    }
    final int quote = _source.codeUnitAt(_index);
    if (quote != 0x22 && quote != 0x27) {
      throw FormatException(
        'Attribute values must be quoted',
        _source,
        _index,
      );
    }
    _index++;
    final int start = _index;
    while (_index < _source.length && _source.codeUnitAt(_index) != quote) {
      _index++;
    }
    if (_index >= _source.length) {
      throw FormatException('Unterminated attribute value', _source, start);
    }
    final String raw = _source.substring(start, _index);
    _index++;
    return _decodeEntities(raw);
  }

  static String _decodeEntities(String value) {
    if (!value.contains('&')) {
      return value;
    }
    return value.replaceAllMapped(_entityPattern, (Match match) {
      final String entity = match.group(1)!;
      switch (entity) {
        case 'amp':
          return '&';
        case 'lt':
          return '<';
        case 'gt':
          return '>';
        case 'quot':
          return '"';
        case 'apos':
          return "'";
      }
      if (entity.startsWith('#x') || entity.startsWith('#X')) {
        final int? code = int.tryParse(entity.substring(2), radix: 16);
        return code == null ? match.group(0)! : String.fromCharCode(code);
      }
      if (entity.startsWith('#')) {
        final int? code = int.tryParse(entity.substring(1));
        return code == null ? match.group(0)! : String.fromCharCode(code);
      }
      return match.group(0)!;
    });
  }

  static final RegExp _entityPattern = RegExp(r'&([a-zA-Z]+|#[xX]?[0-9a-fA-F]+);');
}

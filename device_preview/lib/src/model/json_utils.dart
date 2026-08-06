// Internal JSON codec helpers shared by the model layer and the preset
// catalog. Not exported from the package.

import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

/// Reads a required `double` from [value], accepting any JSON number.
///
/// Throws a [FormatException] when the value is missing or not a number.
double decodeDouble(Object? value, String context) {
  if (value is num) {
    return value.toDouble();
  }
  throw FormatException('Expected a number for "$context", got: $value');
}

/// Reads a `bool` from [value].
///
/// Throws a [FormatException] when the value is not a boolean.
bool decodeBool(Object? value, String context) {
  if (value is bool) {
    return value;
  }
  throw FormatException('Expected a boolean for "$context", got: $value');
}

/// Reads a `String` from [value].
///
/// Throws a [FormatException] when the value is not a string.
String decodeString(Object? value, String context) {
  if (value is String) {
    return value;
  }
  throw FormatException('Expected a string for "$context", got: $value');
}

/// Reads a JSON object from [value].
///
/// Throws a [FormatException] when the value is not a map.
Map<String, Object?> decodeMap(Object? value, String context) {
  if (value is Map<String, Object?>) {
    return value;
  }
  if (value is Map) {
    return value.map((Object? k, Object? v) => MapEntry('$k', v));
  }
  throw FormatException('Expected an object for "$context", got: $value');
}

/// Reads a JSON array from [value].
///
/// Throws a [FormatException] when the value is not a list.
List<Object?> decodeList(Object? value, String context) {
  if (value is List<Object?>) {
    return value;
  }
  throw FormatException('Expected an array for "$context", got: $value');
}

/// Encodes [size] as `{"width": …, "height": …}`.
Map<String, Object?> encodeSize(ui.Size size) => <String, Object?>{
  'width': size.width,
  'height': size.height,
};

/// Decodes a size encoded by [encodeSize].
ui.Size decodeSize(Object? value, String context) {
  final Map<String, Object?> map = decodeMap(value, context);
  return ui.Size(
    decodeDouble(map['width'], '$context.width'),
    decodeDouble(map['height'], '$context.height'),
  );
}

/// Encodes [insets] as `{"left": …, "top": …, "right": …, "bottom": …}`.
Map<String, Object?> encodeEdgeInsets(EdgeInsets insets) => <String, Object?>{
  'left': insets.left,
  'top': insets.top,
  'right': insets.right,
  'bottom': insets.bottom,
};

/// Decodes edge insets encoded by [encodeEdgeInsets].
EdgeInsets decodeEdgeInsets(Object? value, String context) {
  final Map<String, Object?> map = decodeMap(value, context);
  return EdgeInsets.fromLTRB(
    decodeDouble(map['left'], '$context.left'),
    decodeDouble(map['top'], '$context.top'),
    decodeDouble(map['right'], '$context.right'),
    decodeDouble(map['bottom'], '$context.bottom'),
  );
}

/// Encodes [rect] as `{"left": …, "top": …, "right": …, "bottom": …}`.
Map<String, Object?> encodeRect(ui.Rect rect) => <String, Object?>{
  'left': rect.left,
  'top': rect.top,
  'right': rect.right,
  'bottom': rect.bottom,
};

/// Decodes a rectangle encoded by [encodeRect].
ui.Rect decodeRect(Object? value, String context) {
  final Map<String, Object?> map = decodeMap(value, context);
  return ui.Rect.fromLTRB(
    decodeDouble(map['left'], '$context.left'),
    decodeDouble(map['top'], '$context.top'),
    decodeDouble(map['right'], '$context.right'),
    decodeDouble(map['bottom'], '$context.bottom'),
  );
}

/// Decodes an enum value serialized by [Enum.name].
///
/// Throws a [FormatException] when [value] is not a string or does not match
/// any member of [values].
T decodeEnum<T extends Enum>(Object? value, List<T> values, String context) {
  final String name = decodeString(value, context);
  for (final T candidate in values) {
    if (candidate.name == name) {
      return candidate;
    }
  }
  throw FormatException('Unknown value "$name" for "$context"');
}

/// Encodes [locale] as a BCP 47 language tag, e.g. `"en-US"`.
String encodeLocale(ui.Locale locale) => locale.toLanguageTag();

/// Decodes a locale from a language tag encoded by [encodeLocale].
///
/// Accepts `language`, `language-COUNTRY`, `language-Script`, and
/// `language-Script-COUNTRY` forms (also tolerating `_` separators).
/// Throws a [FormatException] for empty or structurally invalid tags.
ui.Locale decodeLocale(Object? value, String context) {
  final String tag = decodeString(value, context);
  final List<String> parts = tag.replaceAll('_', '-').split('-');
  if (parts.isEmpty || parts.any((String p) => p.isEmpty) || parts.length > 3) {
    throw FormatException('Invalid language tag for "$context": "$tag"');
  }
  final String language = parts[0];
  String? script;
  String? country;
  for (final String part in parts.skip(1)) {
    if (part.length == 4) {
      script = part;
    } else {
      country = part;
    }
  }
  return ui.Locale.fromSubtags(
    languageCode: language,
    scriptCode: script,
    countryCode: country,
  );
}

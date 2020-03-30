import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

class SizeJsonConverter implements JsonConverter<Size, Object> {
  const SizeJsonConverter();

  @override
  Size fromJson(Object json) {
    if (json == null) {
      return null;
    }

    if (json is Iterable) {
      final list = json.toList();

      if (list.length > 1) {
        final w = list[0];
        final h = list[1];
        if ((w is int || w is double) && (h is int || h is double)) {
          return Size(w.toDouble(), h.toDouble());
        }
      }
    }

    throw Exception('Failed to parse JSON as size');
  }

  @override
  Object toJson(Size object) {
    if (object == null) return null;
    return [object.width, object.height];
  }
}

import 'package:flutter/widgets.dart';

extension WidgetIterableExtensions on Iterable<Widget> {
  List<Widget> spaced({double horizontal, double vertical}) {
    if (isEmpty) return toList();
    return [
      first,
      ...skip(1).expand((x) => [
            SizedBox(
              width: horizontal,
              height: vertical,
            ),
            x,
          ]),
    ];
  }
}

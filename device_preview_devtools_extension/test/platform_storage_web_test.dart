@TestOn('browser')
library;

import 'package:device_preview_devtools_extension/src/platform/platform_io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final storage = createPlatformStorage();
  final key = 'device_preview.test.${DateTime.now().microsecondsSinceEpoch}';

  tearDown(() => storage.remove(key));

  test('persists values in browser storage', () {
    storage.write(key, 'persisted');
    expect(storage.read(key), 'persisted');

    storage.remove(key);
    expect(storage.read(key), isNull);
  });
}

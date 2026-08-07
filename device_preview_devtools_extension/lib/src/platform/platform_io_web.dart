import 'package:web/web.dart' as web;

import 'storage.dart';

/// Web implementation of the platform helpers, backed by `window.localStorage`.
KeyValueStorage createPlatformStorage() => _LocalStorage();

class _LocalStorage implements KeyValueStorage {
  @override
  String? read(String key) => web.window.localStorage.getItem(key);

  @override
  void write(String key, String value) =>
      web.window.localStorage.setItem(key, value);

  @override
  void remove(String key) => web.window.localStorage.removeItem(key);
}

/// Triggers a browser download of a PNG delivered as base64 [bytesBase64].
void savePngDownload(String bytesBase64, String filename) {
  final anchor = web.HTMLAnchorElement()
    ..href = 'data:image/png;base64,$bytesBase64'
    ..download = filename;
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}

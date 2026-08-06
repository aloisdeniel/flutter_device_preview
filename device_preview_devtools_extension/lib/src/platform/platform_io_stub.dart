import 'storage.dart';

/// Non-web implementation of the platform helpers.
///
/// Only reachable in VM unit tests — the extension itself is always built for
/// the web.
KeyValueStorage createPlatformStorage() => InMemoryStorage();

/// No-op on non-web platforms.
void savePngDownload(String bytesBase64, String filename) {}

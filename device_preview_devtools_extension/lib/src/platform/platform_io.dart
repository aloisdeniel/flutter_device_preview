/// Conditional export of the web-only helpers (localStorage persistence and
/// the screenshot download anchor) with a VM stub so that the package's unit
/// and widget tests can run on the Dart VM.
library;

export 'platform_io_stub.dart'
    if (dart.library.js_interop) 'platform_io_web.dart';
export 'storage.dart';

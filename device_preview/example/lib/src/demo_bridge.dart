/// Bridge between the device simulation and the HTML panel that embeds this
/// app on the landing page.
///
/// The web implementation is selected by conditional import; everywhere else
/// [connectDemoPanel] is a no-op, so `counter.dart` still runs as a plain
/// Flutter app on any platform.
library;

export 'demo_bridge_stub.dart'
    if (dart.library.js_interop) 'demo_bridge_web.dart';

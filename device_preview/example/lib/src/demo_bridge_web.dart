import 'dart:convert';
import 'dart:js_interop';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

/// The channel name carried by every message, so the page and the app ignore
/// the postMessage traffic of anything else on the origin.
const String _channel = 'device_preview_demo';

/// Wires [controller] to the HTML panel embedding this app in an iframe.
///
/// This plays the role Flutter DevTools plays for a real app: the page owns
/// the device catalog and the panel state, and pushes a whole simulation over
/// the wire; the app decodes it, applies it, and answers with its state. The
/// message shapes mirror `ext.device_preview.getState` and
/// `ext.device_preview.setSimulation` one for one — only the transport
/// differs (`window.postMessage` instead of the VM service).
///
/// Messages the page sends:
///
/// ```jsonc
/// { "channel": "device_preview_demo", "type": "getState", "requestId": "1" }
/// { "channel": "device_preview_demo", "type": "setSimulation",
///   "requestId": "2", "simulation": { /* DeviceSimulation JSON */ } }
/// ```
///
/// Messages the app sends back: `ready` (once, at startup) and `state`
/// (echoing `requestId`), both carrying the state shape.
void connectDemoPanel(DevicePreviewController? controller) {
  if (controller == null) {
    return;
  }
  _globalThis.addEventListener(
    'message',
    ((_MessageEvent event) => _handle(controller, event)).toJS,
  );
  _post(<String, Object?>{
    'type': 'ready',
    'state': _stateShape(controller),
  });
}

/// The state shape reported to the panel — the protocol's, minus the fields
/// that only make sense over the VM service.
Map<String, Object?> _stateShape(DevicePreviewController controller) {
  return <String, Object?>{
    'enabled': true,
    'simulation': controller.simulation?.toJson(),
    'realDevice': controller.realDevice.toJson(),
    'fit': controller.fitTransform.toJson(),
    'capabilities': <String, Object?>{
      // Same rule as the real protocol: `defaultTargetPlatform` is
      // const-folded outside debug builds, so a release demo cannot simulate
      // it. The panel disables the row and says why.
      'targetPlatform': kDebugMode,
    },
  };
}

void _handle(DevicePreviewController controller, _MessageEvent event) {
  final JSAny? data = event.data;
  if (data == null || !data.isA<JSString>()) {
    return;
  }
  final Object? decoded = jsonDecode((data as JSString).toDart);
  if (decoded is! Map || decoded['channel'] != _channel) {
    return;
  }
  final Object? requestId = decoded['requestId'];
  switch (decoded['type']) {
    case 'getState':
      _reply(controller, requestId);
    case 'setSimulation':
      _apply(controller, decoded['simulation'], requestId);
  }
}

Future<void> _apply(
  DevicePreviewController controller,
  Object? raw,
  Object? requestId,
) async {
  try {
    if (raw == null) {
      await controller.reset();
    } else if (raw is Map) {
      await controller.apply(
        DeviceSimulation.fromJson(
          raw.map((Object? key, Object? value) => MapEntry<String, Object?>(
            '$key',
            value,
          )),
        ),
      );
    } else {
      throw const FormatException('"simulation" must be an object or null.');
    }
  } catch (error) {
    _post(<String, Object?>{
      'type': 'state',
      'requestId': requestId,
      'state': _stateShape(controller),
      'error': '$error',
    });
    return;
  }
  _reply(controller, requestId);
}

void _reply(DevicePreviewController controller, Object? requestId) {
  _post(<String, Object?>{
    'type': 'state',
    'requestId': requestId,
    'state': _stateShape(controller),
  });
}

/// Posts [message] to the embedding page (or to nobody, when this app is
/// opened directly: `window.parent` is then the window itself).
void _post(Map<String, Object?> message) {
  final _Window? parent = _globalThis.parent;
  if (parent == null) {
    return;
  }
  parent.postMessage(
    jsonEncode(<String, Object?>{'channel': _channel, ...message}).toJS,
    '*',
  );
}

@JS('globalThis')
external _Window get _globalThis;

extension type _Window._(JSObject _) implements JSObject {
  external void addEventListener(String type, JSFunction callback);
  external _Window? get parent;
  external void postMessage(JSAny? message, String targetOrigin);
}

extension type _MessageEvent._(JSObject _) implements JSObject {
  external JSAny? get data;
}

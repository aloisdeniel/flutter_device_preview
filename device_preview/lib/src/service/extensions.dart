import 'dart:convert';
import 'dart:developer' as developer;

import 'protocol.dart';
import 'screenshot.dart';

/// Registers the `ext.device_preview.*` service extensions and posts the
/// `device_preview.ready` event.
///
/// This is the only file (besides the event helpers below) touching
/// `dart:developer`; all request logic lives in the pure
/// [DevicePreviewProtocol] handlers. Callers must guard the invocation with
/// `if (!kReleaseMode)` so release builds tree-shake the machinery.
void registerDevicePreviewServiceExtensions({
  required DevicePreviewProtocol protocol,
  DevicePreviewScreenshot? screenshot,
}) {
  developer.registerExtension(
    'ext.device_preview.getState',
    _wrap(protocol.getState),
  );
  developer.registerExtension(
    'ext.device_preview.setSimulation',
    _wrap(protocol.setSimulation),
  );
  developer.registerExtension(
    'ext.device_preview.reset',
    _wrap(protocol.reset),
  );
  developer.registerExtension(
    'ext.device_preview.listPresets',
    _wrap(protocol.listPresets),
  );
  if (screenshot != null) {
    developer.registerExtension(
      'ext.device_preview.screenshot',
      _wrap(screenshot.capture),
    );
  }
  developer.postEvent('device_preview.ready', <String, Object?>{
    'protocolVersion': DevicePreviewProtocol.protocolVersion,
  });
}

developer.ServiceExtensionHandler _wrap(ServiceProtocolHandler handler) {
  return (String method, Map<String, String> parameters) async {
    try {
      final Map<String, Object?> result = await handler(parameters);
      return developer.ServiceExtensionResponse.result(jsonEncode(result));
    } on FormatException catch (error) {
      return developer.ServiceExtensionResponse.error(
        developer.ServiceExtensionResponse.invalidParams,
        jsonEncode(<String, Object?>{
          'error': <String, Object?>{
            'code': 'invalidParams',
            'message': error.message,
          },
        }),
      );
    } catch (error) {
      // Handlers are specified never to throw; this is a safety net so a
      // bug can never take down the service extension.
      return developer.ServiceExtensionResponse.result(
        jsonEncode(<String, Object?>{
          'error': <String, Object?>{'code': 'internal', 'message': '$error'},
        }),
      );
    }
  };
}

/// Posts a `device_preview.stateChanged` event.
void postStateChangedEvent(Map<String, Object?> eventData) =>
    developer.postEvent('device_preview.stateChanged', eventData);

/// Posts a `device_preview.presetsChanged` event.
void postPresetsChangedEvent(int count) => developer.postEvent(
  'device_preview.presetsChanged',
  <String, Object?>{'count': count},
);

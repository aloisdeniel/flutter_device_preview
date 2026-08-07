// The ONLY file in this package that touches `serviceManager` /
// `extensionManager` (the devtools_extensions globals). Everything else talks
// to the abstract `DevicePreviewGateway` from `gateway_api.dart` so it can be
// tested against a fake on the Dart VM.

import 'dart:async';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:vm_service/vm_service.dart' as vm;

import 'gateway_api.dart';

export 'gateway_api.dart';

/// Production [DevicePreviewGateway] backed by the `devtools_extensions`
/// globals. Must only be instantiated below the `DevToolsExtension` widget.
class ServiceManagerGateway implements DevicePreviewGateway {
  /// Wires connection, availability and event forwarding to [serviceManager].
  ServiceManagerGateway() {
    serviceManager.connectedState.addListener(_onConnectedStateChanged);
    _onConnectedStateChanged();
  }

  final _connected = ValueNotifier<bool>(false);
  final _events = StreamController<DevicePreviewEvent>.broadcast();
  StreamSubscription<vm.Event>? _eventSubscription;

  @override
  ValueListenable<bool> get connected => _connected;

  @override
  ValueListenable<bool> get extensionAvailable =>
      serviceManager.serviceExtensionManager.hasServiceExtension(
        kGetStateExtension,
      );

  @override
  Stream<DevicePreviewEvent> get events => _events.stream;

  @override
  String? get serviceUri => serviceManager.serviceUri;

  void _onConnectedStateChanged() {
    final isConnected = serviceManager.connectedState.value.connected;
    _connected.value = isConnected;
    // The `onExtensionEvent` stream belongs to the per-connection VmService
    // object: re-subscribe on every transition to connected.
    unawaited(_eventSubscription?.cancel());
    _eventSubscription = null;
    final service = serviceManager.service;
    if (isConnected && service != null) {
      _eventSubscription = service.onExtensionEvent.listen((vm.Event event) {
        final kind = event.extensionKind;
        if (kind == null || !kind.startsWith(kEventPrefix)) return;
        final data = event.extensionData?.data ?? <String, Object?>{};
        _events.add(DevicePreviewEvent(kind, Map<String, Object?>.from(data)));
      });
    }
  }

  @override
  Future<Map<String, Object?>> call(
    String method, {
    Map<String, String>? args,
  }) async {
    try {
      final response = await serviceManager.callServiceExtensionOnMainIsolate(
        method,
        args: args,
      );
      final json = response.json;
      if (json == null) return <String, Object?>{};
      return Map<String, Object?>.from(json);
    } on vm.RPCError catch (error) {
      // Typically: isolate paused, extension no longer registered, or the
      // connection dropped mid-call. Surface as a status, never hang.
      throw GatewayException(
        method: method,
        message: error.message,
        isRpcError: true,
        code: error.code,
      );
    } catch (error) {
      throw GatewayException(method: method, message: '$error');
    }
  }

  @override
  void showNotification(String message) {
    extensionManager.showNotification(message);
  }

  @override
  void showBannerMessage({
    required String key,
    required String type,
    required String message,
  }) {
    extensionManager.showBannerMessage(
      key: key,
      type: type,
      message: message,
      extensionName: kExtensionName,
    );
  }

  @override
  void dispose() {
    serviceManager.connectedState.removeListener(_onConnectedStateChanged);
    unawaited(_eventSubscription?.cancel());
    unawaited(_events.close());
    _connected.dispose();
  }
}

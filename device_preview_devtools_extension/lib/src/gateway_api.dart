// Pure-Dart contract between the panel and the DevTools runtime.
//
// This file must stay importable on the Dart VM (no `package:web`, no
// devtools_extensions globals) so that the controller and panel can be unit-
// and widget-tested with a fake gateway. The production implementation lives
// in `gateway.dart` — the only file in this package touching
// `serviceManager` / `extensionManager`.

import 'package:flutter/foundation.dart';

/// The service extension whose registration signals that a
/// `DevicePreviewBinding` is installed in the inspected app.
const String kGetStateExtension = 'ext.device_preview.getState';

/// Prefix of all events posted by the device_preview package
/// (`developer.postEvent`).
const String kEventPrefix = 'device_preview.';

/// The extension name declared in `extension/devtools/config.yaml`; must match
/// exactly for [DevicePreviewGateway.showBannerMessage] to work.
const String kExtensionName = 'device_preview';

/// An event posted by the inspected app (`developer.postEvent`) on the
/// `Extension` stream, pre-filtered to the `device_preview.` prefix.
@immutable
class DevicePreviewEvent {
  /// Creates an event with its full [kind] (e.g. `device_preview.ready`).
  const DevicePreviewEvent(this.kind, this.data);

  /// Full event kind, including the `device_preview.` prefix.
  final String kind;

  /// The event payload (`extensionData.data`).
  final Map<String, Object?> data;

  @override
  String toString() => 'DevicePreviewEvent($kind, $data)';
}

/// Failure surfaced by [DevicePreviewGateway.call].
class GatewayException implements Exception {
  /// Creates an exception for a failed extension [method] call.
  const GatewayException({
    required this.method,
    required this.message,
    this.isRpcError = false,
    this.code,
  });

  /// The `ext.device_preview.*` method that failed.
  final String method;

  /// Human readable failure description.
  final String message;

  /// Whether the failure was a VM service `RPCError` — typically the isolate
  /// being paused (service extensions cannot run while paused).
  final bool isRpcError;

  /// The RPC error code, when [isRpcError] is true.
  final int? code;

  @override
  String toString() => 'GatewayException($method): $message';
}

/// Narrow interface between the panel and the DevTools runtime
/// (`serviceManager` / `extensionManager`).
abstract class DevicePreviewGateway {
  /// Whether a VM service connection to an app is currently established.
  ValueListenable<bool> get connected;

  /// Whether `ext.device_preview.getState` is registered on the main isolate.
  ///
  /// Flips false on hot restart and back to true once the new isolate has run
  /// `DevicePreviewBinding.ensureInitialized()` again.
  ValueListenable<bool> get extensionAvailable;

  /// Broadcast stream of `device_preview.*` events posted by the app.
  Stream<DevicePreviewEvent> get events;

  /// The VM service URI of the current connection, or null when disconnected.
  ///
  /// Used to key the persisted simulation stash per inspected app.
  String? get serviceUri;

  /// Calls the service extension [method] on the main isolate.
  ///
  /// All [args] values must already be strings (VM service contract). Returns
  /// the decoded JSON result map. Throws [GatewayException] on transport
  /// failure (never hangs on a paused isolate).
  Future<Map<String, Object?>> call(
    String method, {
    Map<String, String>? args,
  });

  /// Shows a DevTools toast notification.
  void showNotification(String message);

  /// Shows a DevTools banner message of [type] `'warning'` or `'error'`.
  void showBannerMessage({
    required String key,
    required String type,
    required String message,
  });

  /// Releases stream subscriptions and listeners.
  void dispose();
}

import 'dart:convert';

import '../controller/controller.dart';
import '../model/simulation.dart';
import '../../presets.dart';

/// Signature of a pure service-extension request handler.
///
/// Handlers receive the raw string parameters of the VM service call and
/// return the JSON-encodable response map. They never touch
/// `dart:developer` — the glue in `extensions.dart` does the encoding and
/// registration.
typedef ServiceProtocolHandler =
    Future<Map<String, Object?>> Function(Map<String, String> parameters);

/// Pure request handlers for the `ext.device_preview.*` service extensions.
///
/// Error convention:
///
/// * Handlers never throw for domain failures — those return an
///   `{"error": {"code", "message"}}` envelope inside a success response.
/// * Only malformed JSON input throws a [FormatException], which the
///   registration glue converts to a
///   `ServiceExtensionResponse.error(invalidParams, …)`.
class DevicePreviewProtocol {
  /// Creates the handler set.
  ///
  /// [controller] and [applyTagged] are null when simulation is disabled;
  /// handlers then return `enabled: false` state or a `disabled` error
  /// envelope.
  DevicePreviewProtocol({
    required this.controller,
    required this.applyTagged,
    required this.capabilities,
  });

  /// The current protocol version, pinned in every state shape and in the
  /// `device_preview.ready` event.
  ///
  /// * 1 — initial release.
  /// * 2 — `simulation.frame` (screen outline + device body artwork), plus
  ///   the `frame` capability flag.
  static const int protocolVersion = 2;

  /// The active controller, or null when simulation is disabled.
  final DevicePreviewController? controller;

  /// Applies (or clears, with null) a simulation with provenance tagging,
  /// or null when simulation is disabled.
  final Future<void> Function(
    DeviceSimulation? simulation, {
    String source,
    String? requestId,
  })?
  applyTagged;

  /// Supplies the capability flags advertised in the state shape.
  final Map<String, Object?> Function() capabilities;

  /// Builds the state shape returned by [getState], [setSimulation] and
  /// [reset].
  Map<String, Object?> stateShape() {
    final DevicePreviewController? active = controller;
    return <String, Object?>{
      'protocolVersion': protocolVersion,
      'enabled': active != null,
      'simulation': active?.simulation?.toJson(),
      'realDevice': active?.realDevice.toJson(),
      'fit': active?.fitTransform.toJson(),
      'capabilities': capabilities(),
    };
  }

  Map<String, Object?> _error(String code, String message) => <String, Object?>{
    'error': <String, Object?>{'code': code, 'message': message},
  };

  /// `ext.device_preview.getState` — returns the state shape.
  Future<Map<String, Object?>> getState(Map<String, String> parameters) async =>
      stateShape();

  /// `ext.device_preview.setSimulation` — applies the simulation carried in
  /// the JSON-encoded `simulation` parameter (`"null"` = reset), echoing an
  /// optional opaque `requestId` in the resulting `stateChanged` event.
  ///
  /// Unknown JSON keys are ignored (forward compatibility). Malformed JSON
  /// throws a [FormatException].
  Future<Map<String, Object?>> setSimulation(
    Map<String, String> parameters,
  ) async {
    final Future<void> Function(
      DeviceSimulation?, {
      String source,
      String? requestId,
    })?
    apply = applyTagged;
    if (apply == null) {
      return _error('disabled', 'Device preview simulation is disabled.');
    }
    final String? raw = parameters['simulation'];
    if (raw == null) {
      throw const FormatException('Missing required parameter "simulation".');
    }
    final Object? decoded = jsonDecode(raw);
    final DeviceSimulation? simulation;
    if (decoded == null) {
      simulation = null;
    } else if (decoded is Map) {
      simulation = DeviceSimulation.fromJson(
        decoded.map((Object? key, Object? value) => MapEntry('$key', value)),
      );
    } else {
      throw FormatException(
        'The "simulation" parameter must be a JSON object or null, '
        'got: $decoded',
      );
    }
    await apply(
      simulation,
      source: parameters['source'] ?? 'devtools',
      requestId: parameters['requestId'],
    );
    return stateShape();
  }

  /// `ext.device_preview.reset` — clears the simulation.
  Future<Map<String, Object?>> reset(Map<String, String> parameters) async {
    final Future<void> Function(
      DeviceSimulation?, {
      String source,
      String? requestId,
    })?
    apply = applyTagged;
    if (apply == null) {
      return _error('disabled', 'Device preview simulation is disabled.');
    }
    await apply(
      null,
      source: parameters['source'] ?? 'devtools',
      requestId: parameters['requestId'],
    );
    return stateShape();
  }

  /// `ext.device_preview.listPresets` — built-ins plus registered customs.
  Future<Map<String, Object?>> listPresets(
    Map<String, String> parameters,
  ) async {
    final List<DevicePreset> presets =
        controller?.presets ?? const <DevicePreset>[];
    return <String, Object?>{
      'presets': <Object?>[
        for (final DevicePreset preset in presets) preset.toJson(),
      ],
    };
  }
}

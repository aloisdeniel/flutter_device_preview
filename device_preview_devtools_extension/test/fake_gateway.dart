import 'dart:async';
import 'dart:convert';

import 'package:device_preview_devtools_extension/src/gateway_api.dart';
import 'package:flutter/foundation.dart';

/// Record of one [FakeGateway.call] invocation.
class CallRecord {
  CallRecord(this.method, this.args);

  final String method;
  final Map<String, String>? args;
}

/// Scriptable in-memory [DevicePreviewGateway] implementing the §4 protocol.
class FakeGateway implements DevicePreviewGateway {
  FakeGateway({
    bool connected = false,
    bool available = false,
    this.serviceUri = 'ws://127.0.0.1:9999/token=/',
  })  : connectedNotifier = ValueNotifier<bool>(connected),
        availableNotifier = ValueNotifier<bool>(available);

  final ValueNotifier<bool> connectedNotifier;
  final ValueNotifier<bool> availableNotifier;
  final StreamController<DevicePreviewEvent> eventsController =
      StreamController<DevicePreviewEvent>.broadcast(sync: true);

  /// Scriptable app state.
  bool enabled = true;
  bool canScreenshot = true;
  bool canTargetPlatform = true;
  Map<String, Object?>? simulation;
  List<Map<String, Object?>> presetsJson = <Map<String, Object?>>[];

  /// Per-method exceptions and canned results.
  final Map<String, GatewayException> throwOn = <String, GatewayException>{};
  final Map<String, Map<String, Object?>> cannedResults =
      <String, Map<String, Object?>>{};

  /// Optional gate awaited (after recording the call) before a [call] is
  /// processed — lets tests hold a request in flight.
  Future<void> Function(String method)? delayCall;

  /// Observed interactions.
  final List<CallRecord> calls = <CallRecord>[];
  final List<String> notifications = <String>[];
  final List<Map<String, String>> banners = <Map<String, String>>[];
  String? lastRequestId;

  @override
  ValueListenable<bool> get connected => connectedNotifier;

  @override
  ValueListenable<bool> get extensionAvailable => availableNotifier;

  @override
  Stream<DevicePreviewEvent> get events => eventsController.stream;

  @override
  String? serviceUri;

  List<CallRecord> callsTo(String method) =>
      calls.where((c) => c.method == method).toList();

  Map<String, Object?> stateShape() => <String, Object?>{
        'protocolVersion': 1,
        'enabled': enabled,
        'simulation': simulation == null
            ? null
            : jsonDecode(jsonEncode(simulation)) as Map<String, Object?>,
        'realDevice': <String, Object?>{
          'logicalSize': <String, Object?>{'width': 402.0, 'height': 874.0},
          'devicePixelRatio': 3.0,
          'padding': <String, Object?>{
            'left': 0.0,
            'top': 59.0,
            'right': 0.0,
            'bottom': 34.0,
          },
          'locales': <Object?>['en-US'],
          'platformBrightness': 'light',
          'textScaleFactor': 1.0,
          'targetPlatform': 'iOS',
        },
        'fit': <String, Object?>{
          'scale': 1.0,
          'offset': <String, Object?>{'x': 0.0, 'y': 0.0},
        },
        'capabilities': <String, Object?>{
          'targetPlatform': canTargetPlatform,
          'screenshot': canScreenshot,
        },
      };

  @override
  Future<Map<String, Object?>> call(
    String method, {
    Map<String, String>? args,
  }) async {
    calls.add(CallRecord(method, args));
    final delay = delayCall;
    if (delay != null) await delay(method);
    final exception = throwOn[method];
    if (exception != null) throw exception;
    final canned = cannedResults[method];
    if (canned != null) return canned;
    switch (method) {
      case 'ext.device_preview.getState':
        return stateShape();
      case 'ext.device_preview.listPresets':
        return <String, Object?>{'presets': presetsJson};
      case 'ext.device_preview.setSimulation':
        lastRequestId = args?['requestId'];
        final raw = args?['simulation'];
        if (raw == null || raw == 'null') {
          simulation = null;
        } else {
          simulation =
              Map<String, Object?>.from(jsonDecode(raw) as Map);
        }
        return stateShape();
      case 'ext.device_preview.reset':
        simulation = null;
        return stateShape();
      case 'ext.device_preview.screenshot':
        return <String, Object?>{
          'format': 'png',
          'width': 10,
          'height': 10,
          'bytesBase64': base64Encode(<int>[1, 2, 3]),
        };
    }
    return <String, Object?>{
      'error': <String, Object?>{
        'code': 'unknown_method',
        'message': 'Unknown method $method',
      },
    };
  }

  @override
  void showNotification(String message) => notifications.add(message);

  @override
  void showBannerMessage({
    required String key,
    required String type,
    required String message,
  }) {
    banners.add(<String, String>{
      'key': key,
      'type': type,
      'message': message,
    });
  }

  /// Emits a `device_preview.*` event as the app would.
  void emit(String kind, Map<String, Object?> data) =>
      eventsController.add(DevicePreviewEvent(kind, data));

  @override
  void dispose() {
    unawaited(eventsController.close());
    connectedNotifier.dispose();
    availableNotifier.dispose();
  }
}

/// A preset used across tests.
const Map<String, Object?> testPhonePresetJson = <String, Object?>{
  'id': 'test-phone',
  'name': 'Test Phone',
  'platform': 'android',
  'kind': 'phone',
  'portraitSize': <String, Object?>{'width': 400.0, 'height': 800.0},
  'devicePixelRatio': 2.0,
  'portraitPadding': <String, Object?>{
    'left': 0.0,
    'top': 30.0,
    'right': 0.0,
    'bottom': 10.0,
  },
};

/// A preset carrying frame artwork, like the built-in catalog entries.
const Map<String, Object?> testFramedPresetJson = <String, Object?>{
  'id': 'test-framed',
  'name': 'Test Framed Phone',
  'brand': 'Test',
  'platform': 'android',
  'kind': 'phone',
  'portraitSize': <String, Object?>{'width': 400.0, 'height': 800.0},
  'devicePixelRatio': 2.0,
  'frame': <String, Object?>{
    'size': <String, Object?>{'width': 420.0, 'height': 820.0},
    'screenOffset': <String, Object?>{'x': 10.0, 'y': 10.0},
    'screenPath': 'M 0,0 H 400 V 800 H 0 Z',
    'body': '<svg viewBox="0 0 420 820">'
        '<rect x="0" y="0" width="420" height="820" fill="#101010"/></svg>',
  },
  'systemUi': <String, Object?>{
    'statusBar': <String, Object?>{
      'inset': 12.0,
      'leading': '<svg viewBox="0 0 20 12">'
          '<rect width="20" height="12" fill="currentColor"/></svg>',
    },
    'navigationBar': <String, Object?>{
      'center': '<svg viewBox="0 0 100 4">'
          '<rect width="100" height="4" fill="currentColor"/></svg>',
      'bottomInset': 6.0,
    },
  },
};

/// A second preset (tablet) used across tests.
const Map<String, Object?> testTabletPresetJson = <String, Object?>{
  'id': 'test-tablet',
  'name': 'Test Tablet',
  'platform': 'iOS',
  'kind': 'tablet',
  'portraitSize': <String, Object?>{'width': 800.0, 'height': 1200.0},
  'devicePixelRatio': 2.0,
};

/// A foldable preset with a vertical hinge, used by the rotation tests.
const Map<String, Object?> testFoldablePresetJson = <String, Object?>{
  'id': 'test-fold',
  'name': 'Test Fold',
  'platform': 'android',
  'kind': 'foldable',
  'portraitSize': <String, Object?>{'width': 800.0, 'height': 1104.0},
  'devicePixelRatio': 2.0,
  'displayFeatures': <Object?>[
    <String, Object?>{
      'bounds': <String, Object?>{
        'left': 390.0,
        'top': 0.0,
        'right': 410.0,
        'bottom': 1104.0,
      },
      'type': 'hinge',
      'state': 'postureFlat',
    },
  ],
};

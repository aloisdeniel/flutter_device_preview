import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/service/protocol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeController implements DevicePreviewController {
  DeviceSimulation? current;
  final List<DevicePreset> registered = <DevicePreset>[
    DevicePresets.iPhoneSe3,
    DevicePresets.pixel8,
  ];

  @override
  DeviceSimulation? get simulation => current;

  @override
  ValueListenable<DeviceSimulation?> get simulationListenable =>
      throw UnimplementedError();

  @override
  RealDeviceInfo get realDevice => const RealDeviceInfo(
    logicalSize: ui.Size(402, 874),
    physicalSize: ui.Size(1206, 2622),
    devicePixelRatio: 3.0,
    padding: EdgeInsets.only(top: 59, bottom: 34),
    locales: <ui.Locale>[ui.Locale('en', 'US')],
    platformBrightness: ui.Brightness.dark,
    textScaleFactor: 1.0,
    targetPlatform: TargetPlatform.iOS,
  );

  @override
  FitTransform get fitTransform =>
      const FitTransform(scale: 0.82, offset: ui.Offset(12, 0));

  @override
  Future<void> apply(DeviceSimulation simulation) async => current = simulation;

  @override
  Future<void> update(
    DeviceSimulation Function(DeviceSimulation current) mutate,
  ) async => current = mutate(current ?? const DeviceSimulation());

  @override
  Future<void> applyPreset(
    DevicePreset preset, {
    Orientation orientation = Orientation.portrait,
    bool resetOverrides = false,
  }) async => current = preset.resolve(orientation: orientation);

  @override
  Future<void> setOrientation(Orientation orientation) async {}

  @override
  Future<void> reset() async => current = null;

  @override
  List<DevicePreset> get presets => registered;

  @override
  void registerPreset(DevicePreset preset) => registered.add(preset);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}

void main() {
  late _FakeController controller;
  late List<(DeviceSimulation?, String, String?)> applied;
  late DevicePreviewProtocol protocol;

  setUp(() {
    controller = _FakeController();
    applied = <(DeviceSimulation?, String, String?)>[];
    protocol = DevicePreviewProtocol(
      controller: controller,
      applyTagged:
          (
            DeviceSimulation? simulation, {
            String source = 'programmatic',
            String? requestId,
          }) async {
            applied.add((simulation, source, requestId));
            controller.current = simulation;
          },
      capabilities: () => <String, Object?>{
        'targetPlatform': true,
        'screenshot': true,
      },
    );
  });

  group('getState', () {
    test('returns the complete state shape', () async {
      controller.current = const DeviceSimulation(
        screenSize: ui.Size(375, 667),
        devicePixelRatio: 2.0,
      );
      final Map<String, Object?> state = await protocol.getState(
        const <String, String>{},
      );
      expect(state.keys, <String>{
        'protocolVersion',
        'enabled',
        'simulation',
        'realDevice',
        'fit',
        'capabilities',
      });
      expect(state['protocolVersion'], DevicePreviewProtocol.protocolVersion);
      expect(state['enabled'], isTrue);
      expect(state['simulation'], controller.current!.toJson());
      expect(state['realDevice'], controller.realDevice.toJson());
      expect(state['fit'], <String, Object?>{
        'scale': 0.82,
        'offset': <String, Object?>{'x': 12.0, 'y': 0.0},
      });
      expect(state['capabilities'], <String, Object?>{
        'targetPlatform': true,
        'screenshot': true,
      });
      // The whole shape must be JSON-encodable.
      expect(jsonDecode(jsonEncode(state)), isA<Map<String, Object?>>());
    });

    test('simulation is null when passing through', () async {
      final Map<String, Object?> state = await protocol.getState(
        const <String, String>{},
      );
      expect(state['simulation'], isNull);
    });
  });

  group('setSimulation', () {
    test('applies the decoded simulation with devtools source', () async {
      final String payload = jsonEncode(
        const DeviceSimulation(
          screenSize: ui.Size(375, 667),
          devicePixelRatio: 2.0,
          textScaleFactor: 1.3,
        ).toJson(),
      );
      final Map<String, Object?> state = await protocol.setSimulation(
        <String, String>{'simulation': payload},
      );
      expect(applied, hasLength(1));
      final (DeviceSimulation? simulation, String source, String? requestId) =
          applied.single;
      expect(simulation!.screenSize, const ui.Size(375, 667));
      expect(simulation.textScaleFactor, 1.3);
      expect(source, 'devtools');
      expect(requestId, isNull);
      expect(state['enabled'], isTrue);
      expect(state['simulation'], isNotNull);
    });

    test('echoes the requestId and honors an explicit source', () async {
      await protocol.setSimulation(<String, String>{
        'simulation': '{}',
        'requestId': 'abc-123',
        'source': 'restore',
      });
      final (_, String source, String? requestId) = applied.single;
      expect(source, 'restore');
      expect(requestId, 'abc-123');
    });

    test('"null" resets', () async {
      controller.current = const DeviceSimulation(textScaleFactor: 2.0);
      final Map<String, Object?> state = await protocol.setSimulation(
        <String, String>{'simulation': 'null'},
      );
      expect(applied.single.$1, isNull);
      expect(state['simulation'], isNull);
    });

    test('unknown JSON keys are ignored', () async {
      await protocol.setSimulation(<String, String>{
        'simulation': '{"future_field": 42, "textScaleFactor": 2.0}',
      });
      expect(applied.single.$1!.textScaleFactor, 2.0);
    });

    test('malformed JSON throws FormatException', () async {
      expect(
        () =>
            protocol.setSimulation(<String, String>{'simulation': '{not json'}),
        throwsFormatException,
      );
    });

    test('non-object JSON throws FormatException', () async {
      expect(
        () => protocol.setSimulation(<String, String>{'simulation': '42'}),
        throwsFormatException,
      );
    });

    test('malformed field values throw FormatException', () async {
      expect(
        () => protocol.setSimulation(<String, String>{
          'simulation': '{"textScaleFactor": "big"}',
        }),
        throwsFormatException,
      );
    });

    test('missing simulation parameter throws FormatException', () async {
      expect(
        () => protocol.setSimulation(const <String, String>{}),
        throwsFormatException,
      );
    });
  });

  group('reset', () {
    test('clears and returns the state shape', () async {
      controller.current = const DeviceSimulation(textScaleFactor: 2.0);
      final Map<String, Object?> state = await protocol.reset(
        const <String, String>{},
      );
      expect(applied.single.$1, isNull);
      expect(state['simulation'], isNull);
    });
  });

  group('listPresets', () {
    test('returns the controller presets as JSON', () async {
      final Map<String, Object?> result = await protocol.listPresets(
        const <String, String>{},
      );
      final List<Object?> presets = result['presets']! as List<Object?>;
      expect(presets, hasLength(2));
      expect(presets.first, DevicePresets.iPhoneSe3.toJson());
    });
  });

  group('disabled', () {
    late DevicePreviewProtocol disabled;

    setUp(() {
      disabled = DevicePreviewProtocol(
        controller: null,
        applyTagged: null,
        capabilities: () => <String, Object?>{
          'targetPlatform': false,
          'screenshot': false,
        },
      );
    });

    test('getState reports enabled: false', () async {
      final Map<String, Object?> state = await disabled.getState(
        const <String, String>{},
      );
      expect(state['enabled'], isFalse);
      expect(state['simulation'], isNull);
      expect(state['realDevice'], isNull);
    });

    test('setSimulation returns a disabled error envelope', () async {
      final Map<String, Object?> result = await disabled.setSimulation(
        <String, String>{'simulation': '{}'},
      );
      final Map<String, Object?> error =
          result['error']! as Map<String, Object?>;
      expect(error['code'], 'disabled');
      expect(error['message'], isA<String>());
    });

    test('listPresets returns an empty list', () async {
      final Map<String, Object?> result = await disabled.listPresets(
        const <String, String>{},
      );
      expect(result['presets'], isEmpty);
    });
  });
}

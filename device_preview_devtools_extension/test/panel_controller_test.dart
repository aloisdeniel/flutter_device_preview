import 'dart:async';
import 'dart:convert';

import 'package:device_preview_devtools_extension/src/gateway_api.dart';
import 'package:device_preview_devtools_extension/src/panel_controller.dart';
import 'package:device_preview_devtools_extension/src/platform/platform_io.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_gateway.dart';

void main() {
  late FakeGateway gateway;
  late InMemoryStorage storage;
  PanelController? controller;
  final savedScreenshots = <(String, String)>[];

  PanelController createController() {
    return controller = PanelController(
      gateway: gateway,
      storage: storage,
      saveScreenshot: (bytesBase64, filename) =>
          savedScreenshots.add((bytesBase64, filename)),
      readyEventTimeout: const Duration(milliseconds: 20),
      bannerDelay: const Duration(milliseconds: 5),
    );
  }

  setUp(() {
    gateway = FakeGateway();
    storage = InMemoryStorage();
    savedScreenshots.clear();
  });

  tearDown(() {
    controller?.dispose();
    controller = null;
    gateway.dispose();
  });

  group('status', () {
    test('starts disconnected', () {
      createController();
      expect(controller!.status, PanelStatus.disconnected);
    });

    test('connected without extension reports noBinding and banners', () async {
      createController();
      gateway.connectedNotifier.value = true;
      expect(controller!.status, PanelStatus.noBinding);
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(gateway.banners, hasLength(1));
      expect(gateway.banners.single['type'], 'warning');
      expect(
        gateway.banners.single['message'],
        contains('DevicePreview.enable()'),
      );
    });

    test('availability flip syncs after ready event', () async {
      createController();
      gateway.presetsJson = [testPhonePresetJson];
      gateway.connectedNotifier.value = true;
      gateway.availableNotifier.value = true;
      gateway.emit('device_preview.ready', {'protocolVersion': 1});
      await pumpEventQueue();
      expect(controller!.status, PanelStatus.ready);
      expect(gateway.callsTo('ext.device_preview.getState'), hasLength(1));
      expect(gateway.callsTo('ext.device_preview.listPresets'), hasLength(1));
      expect(controller!.presets.map((p) => p.id), ['test-phone']);
    });

    test('availability flip syncs via fallback timer without ready event',
        () async {
      createController();
      gateway.connectedNotifier.value = true;
      gateway.availableNotifier.value = true;
      // No ready event: fallback fires after readyEventTimeout (20ms).
      expect(gateway.callsTo('ext.device_preview.getState'), isEmpty);
      await Future<void>.delayed(const Duration(milliseconds: 60));
      expect(controller!.status, PanelStatus.ready);
      expect(gateway.callsTo('ext.device_preview.getState'), hasLength(1));
    });

    test('already connected and available at construction syncs immediately',
        () async {
      gateway = FakeGateway(connected: true, available: true);
      createController();
      await pumpEventQueue();
      expect(controller!.status, PanelStatus.ready);
    });

    test('reports disabled when the app says enabled: false', () async {
      gateway = FakeGateway(connected: true, available: true);
      gateway.enabled = false;
      createController();
      await pumpEventQueue();
      expect(controller!.status, PanelStatus.disabled);
    });

    test('reports paused when getState throws an RPCError', () async {
      gateway = FakeGateway(connected: true, available: true);
      gateway.throwOn['ext.device_preview.getState'] = const GatewayException(
        method: 'ext.device_preview.getState',
        message: 'isolate is paused',
        isRpcError: true,
        code: 105,
      );
      createController();
      await pumpEventQueue();
      expect(controller!.status, PanelStatus.paused);
    });

    test('disconnect clears state', () async {
      gateway = FakeGateway(connected: true, available: true);
      gateway.presetsJson = [testPhonePresetJson];
      createController();
      await pumpEventQueue();
      expect(controller!.status, PanelStatus.ready);
      gateway.connectedNotifier.value = false;
      expect(controller!.status, PanelStatus.disconnected);
      expect(controller!.state, isNull);
      expect(controller!.presets, isEmpty);
    });
  });

  group('restart re-push', () {
    Future<void> primeWithSimulation() async {
      gateway = FakeGateway(connected: true, available: true);
      createController();
      await pumpEventQueue();
      await controller!.setTextScaleFactor(2.0);
      expect(gateway.simulation, {'textScaleFactor': 2.0});
    }

    test('re-pushes the stashed simulation when the toggle is on', () async {
      await primeWithSimulation();
      controller!.keepAcrossRestarts = true;

      // Simulate a hot restart: extension vanishes, app state resets.
      gateway.availableNotifier.value = false;
      expect(controller!.status, PanelStatus.noBinding);
      gateway.simulation = null;
      gateway.calls.clear();
      gateway.availableNotifier.value = true;
      gateway.emit('device_preview.ready', {'protocolVersion': 1});
      await pumpEventQueue();

      final setCalls = gateway.callsTo('ext.device_preview.setSimulation');
      expect(setCalls, hasLength(1));
      expect(setCalls.single.args?['source'], 'restore');
      expect(
        jsonDecode(setCalls.single.args!['simulation']!),
        {'textScaleFactor': 2.0},
      );
      // The re-push happened before the state fetch.
      expect(gateway.calls.first.method, 'ext.device_preview.setSimulation');
      expect(gateway.simulation, {'textScaleFactor': 2.0});
      expect(controller!.status, PanelStatus.ready);
      expect(controller!.simulation, {'textScaleFactor': 2.0});
    });

    test('does not re-push when the toggle is off', () async {
      await primeWithSimulation();
      expect(controller!.keepAcrossRestarts, isFalse);

      gateway.availableNotifier.value = false;
      gateway.simulation = null;
      gateway.calls.clear();
      gateway.availableNotifier.value = true;
      gateway.emit('device_preview.ready', {'protocolVersion': 1});
      await pumpEventQueue();

      expect(gateway.callsTo('ext.device_preview.setSimulation'), isEmpty);
      expect(controller!.simulation, isNull);
    });

    test('the toggle is persisted to storage', () async {
      await primeWithSimulation();
      controller!.keepAcrossRestarts = true;
      expect(storage.read('device_preview.keepAcrossRestarts'), 'true');
    });

    test('the stash is persisted to storage keyed by service uri', () async {
      await primeWithSimulation();
      final stored =
          storage.read('device_preview.simulation:${gateway.serviceUri}');
      expect(stored, isNotNull);
      expect(jsonDecode(stored!), {'textScaleFactor': 2.0});
    });
  });

  group('echo suppression', () {
    Future<void> ready() async {
      gateway = FakeGateway(connected: true, available: true);
      createController();
      await pumpEventQueue();
    }

    test('own stateChanged echoes are ignored', () async {
      await ready();
      await controller!.setBrightness('dark');
      final requestId = gateway.lastRequestId;
      expect(requestId, isNotNull);

      // The app echoes our own write: must not clobber local state.
      gateway.emit('device_preview.stateChanged', {
        'simulation': {'platformBrightness': 'light'},
        'fit': {'scale': 1.0, 'offset': {'x': 0.0, 'y': 0.0}},
        'source': 'devtools',
        'requestId': requestId,
      });
      await pumpEventQueue();
      expect(controller!.simulation, {'platformBrightness': 'dark'});
    });

    test('foreign stateChanged events update local state', () async {
      await ready();
      await controller!.setBrightness('dark');

      gateway.emit('device_preview.stateChanged', {
        'simulation': {'platformBrightness': 'light'},
        'fit': {'scale': 0.5, 'offset': {'x': 10.0, 'y': 0.0}},
        'source': 'programmatic',
      });
      await pumpEventQueue();
      expect(controller!.simulation, {'platformBrightness': 'light'});
      expect(controller!.state?.fit['scale'], 0.5);
    });

    test('presetsChanged refetches the preset list', () async {
      await ready();
      gateway.presetsJson = [testPhonePresetJson, testTabletPresetJson];
      gateway.emit('device_preview.presetsChanged', {'count': 2});
      await pumpEventQueue();
      expect(controller!.presets, hasLength(2));
    });
  });

  group('mutations', () {
    Future<void> ready() async {
      gateway = FakeGateway(connected: true, available: true);
      gateway.presetsJson = [testPhonePresetJson, testTabletPresetJson];
      createController();
      await pumpEventQueue();
    }

    test('selectPreset builds metric fields and preserves overrides',
        () async {
      await ready();
      await controller!.setBrightness('dark');
      await controller!
          .selectPreset(const PresetView(testPhonePresetJson));
      expect(gateway.simulation, {
        'platformBrightness': 'dark',
        'presetId': 'test-phone',
        'orientation': 'portrait',
        'screenSize': {'width': 400.0, 'height': 800.0},
        'devicePixelRatio': 2.0,
        'padding': {'left': 0.0, 'top': 30.0, 'right': 0.0, 'bottom': 10.0},
        'viewPadding': {
          'left': 0.0,
          'top': 30.0,
          'right': 0.0,
          'bottom': 10.0,
        },
      });
    });

    test('setOrientation uses the preset landscape metrics (rotation rule)',
        () async {
      await ready();
      await controller!
          .selectPreset(const PresetView(testPhonePresetJson));
      await controller!.setOrientation('landscape');
      expect(gateway.simulation!['orientation'], 'landscape');
      expect(
        gateway.simulation!['screenSize'],
        {'width': 800.0, 'height': 400.0},
      );
      // Rotation rule: left/right = portrait.top, bottom kept, top = 0.
      expect(
        gateway.simulation!['padding'],
        {'left': 30.0, 'top': 0.0, 'right': 30.0, 'bottom': 10.0},
      );
    });

    test('setOrientation applies the rotation rule without a preset',
        () async {
      await ready();
      await controller!.setCustomMetrics(
        width: 400,
        height: 800,
        devicePixelRatio: 2,
        paddingTop: 20,
        paddingBottom: 10,
      );
      await controller!.setOrientation('landscape');
      expect(
        gateway.simulation!['screenSize'],
        {'width': 800.0, 'height': 400.0},
      );
      expect(
        gateway.simulation!['padding'],
        {'left': 20.0, 'top': 0.0, 'right': 20.0, 'bottom': 10.0},
      );
    });

    test('selectRealDevice clears metric fields, keeps overrides', () async {
      await ready();
      await controller!.setBrightness('dark');
      await controller!
          .selectPreset(const PresetView(testPhonePresetJson));
      await controller!.selectRealDevice();
      expect(gateway.simulation, {'platformBrightness': 'dark'});
    });

    test('clearing the last override sends a null simulation', () async {
      await ready();
      await controller!.setBrightness('dark');
      await controller!.setBrightness(null);
      expect(gateway.simulation, isNull);
      final lastSet = gateway.callsTo('ext.device_preview.setSimulation').last;
      expect(lastSet.args?['simulation'], 'null');
    });

    test('accessibility flags are tri-state per flag', () async {
      await ready();
      await controller!.setAccessibilityFlag('boldText', true);
      await controller!.setAccessibilityFlag('reduceMotion', false);
      expect(gateway.simulation, {
        'accessibility': {'boldText': true, 'reduceMotion': false},
      });
      await controller!.setAccessibilityFlag('boldText', null);
      expect(gateway.simulation, {
        'accessibility': {'reduceMotion': false},
      });
      await controller!.setAccessibilityFlag('reduceMotion', null);
      expect(gateway.simulation, isNull);
    });

    test(
        'a mutation issued while another is in flight builds on top of it '
        '(writes are serialized)', () async {
      await ready();
      final gate = Completer<void>();
      gateway.delayCall = (method) {
        if (method != 'ext.device_preview.setSimulation') {
          return Future<void>.value();
        }
        // Hold only the first push in flight.
        gateway.delayCall = null;
        return gate.future;
      };
      final first = controller!.setBrightness('dark');
      final second = controller!.setAccessibilityFlag('boldText', true);
      await pumpEventQueue();
      // Only the first push is on the wire while it is held in flight.
      expect(
        gateway.callsTo('ext.device_preview.setSimulation'),
        hasLength(1),
      );
      gate.complete();
      await first;
      await second;
      final pushes = gateway.callsTo('ext.device_preview.setSimulation');
      expect(pushes, hasLength(2));
      // The second push was built only after the first response reconciled,
      // so it carries BOTH overrides instead of silently reverting the
      // brightness with a stale full-replacement.
      final lastPushed =
          jsonDecode(pushes.last.args!['simulation']!) as Map<String, Object?>;
      expect(lastPushed['platformBrightness'], 'dark');
      expect((lastPushed['accessibility'] as Map)['boldText'], true);
      expect(gateway.simulation!['platformBrightness'], 'dark');
      expect(controller!.simulation!['platformBrightness'], 'dark');
      expect(
        (controller!.simulation!['accessibility'] as Map)['boldText'],
        true,
      );
    });

    test('setOrientation rotates preset display features into landscape',
        () async {
      gateway = FakeGateway(connected: true, available: true);
      gateway.presetsJson = [testFoldablePresetJson];
      createController();
      await pumpEventQueue();
      await controller!.selectPreset(const PresetView(testFoldablePresetJson));
      await controller!.setOrientation('landscape');
      expect(
        gateway.simulation!['screenSize'],
        {'width': 1104.0, 'height': 800.0},
      );
      final features = gateway.simulation!['displayFeatures'] as List;
      // (l, t, r, b) → (t, w − r, b, w − l) with w = 800: the vertical hinge
      // becomes a horizontal band inside the landscape screen.
      expect(
        (features.single as Map)['bounds'],
        {'left': 0.0, 'top': 390.0, 'right': 1104.0, 'bottom': 410.0},
      );
      // Rotating back restores the preset's portrait bounds.
      await controller!.setOrientation('portrait');
      final restored = gateway.simulation!['displayFeatures'] as List;
      expect(
        (restored.single as Map)['bounds'],
        {'left': 390.0, 'top': 0.0, 'right': 410.0, 'bottom': 1104.0},
      );
    });

    test('setOrientation rotates display features without a resolvable preset',
        () async {
      await ready(); // Catalog contains only the phone and tablet presets.
      await controller!.selectPreset(const PresetView(testFoldablePresetJson));
      // `test-fold` is not in the fetched catalog, so this takes the
      // preset-less geometric rotation path.
      await controller!.setOrientation('landscape');
      final features = gateway.simulation!['displayFeatures'] as List;
      expect(
        (features.single as Map)['bounds'],
        {'left': 0.0, 'top': 390.0, 'right': 1104.0, 'bottom': 410.0},
      );
      // And the inverse restores the portrait bounds.
      await controller!.setOrientation('portrait');
      final restored = gateway.simulation!['displayFeatures'] as List;
      expect(
        (restored.single as Map)['bounds'],
        {'left': 390.0, 'top': 0.0, 'right': 410.0, 'bottom': 1104.0},
      );
    });

    test('an error envelope surfaces a notification and keeps state',
        () async {
      await ready();
      await controller!.setBrightness('dark');
      gateway.cannedResults['ext.device_preview.setSimulation'] = {
        'error': {'code': 'boom', 'message': 'it broke'},
      };
      await controller!.setBrightness('light');
      expect(gateway.notifications, contains('Device Preview: it broke'));
      expect(controller!.simulation, {'platformBrightness': 'dark'});
    });

    test('a transport error during mutation surfaces a notification',
        () async {
      await ready();
      gateway.throwOn['ext.device_preview.setSimulation'] =
          const GatewayException(
        method: 'ext.device_preview.setSimulation',
        message: 'connection lost',
      );
      await controller!.setBrightness('dark');
      expect(
        gateway.notifications,
        contains('Device Preview: connection lost'),
      );
    });

    test('takeScreenshot saves the returned PNG', () async {
      await ready();
      await controller!.takeScreenshot();
      expect(savedScreenshots, hasLength(1));
      expect(savedScreenshots.single.$1, base64Encode(<int>[1, 2, 3]));
      expect(savedScreenshots.single.$2, startsWith('device_preview_'));
      expect(savedScreenshots.single.$2, endsWith('.png'));
    });

    test('takeScreenshot surfaces the error envelope', () async {
      await ready();
      gateway.cannedResults['ext.device_preview.screenshot'] = {
        'error': {'code': 'unsupported', 'message': 'no screenshot'},
      };
      await controller!.takeScreenshot();
      expect(savedScreenshots, isEmpty);
      expect(
        gateway.notifications,
        contains('Device Preview: no screenshot'),
      );
    });

    test('resetAll clears the simulation and the stash', () async {
      await ready();
      await controller!.setBrightness('dark');
      expect(
        storage.read('device_preview.simulation:${gateway.serviceUri}'),
        isNotNull,
      );
      await controller!.resetAll();
      expect(gateway.simulation, isNull);
      expect(controller!.simulation, isNull);
      expect(
        storage.read('device_preview.simulation:${gateway.serviceUri}'),
        isNull,
      );
    });
  });
}

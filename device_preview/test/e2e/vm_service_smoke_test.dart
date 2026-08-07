// The DESIGN §6 e2e smoke: exercises the REAL `dart:developer` service
// extension glue (`registerDevicePreviewServiceExtensions`) over an actual VM
// service connection — extension names, JSON envelope encoding, the
// `invalidParams` conversion, and the `device_preview.stateChanged` event, none
// of which the pure protocol handler tests touch.
//
// The test connects back to its own process's VM service. It requires one:
//
//     flutter test --enable-vmservice test/e2e/vm_service_smoke_test.dart
//
// (tool/check_release.sh runs exactly that). Under a plain `flutter test` the
// VM service is absent and the test reports itself as skipped.

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:vm_service/vm_service.dart' as vm;
import 'package:vm_service/vm_service_io.dart' as vm_io;

import '../support/test_binding.dart';

void main() {
  TestDevicePreviewBinding.ensureInitialized();

  test('state-shape round trip and stateChanged event over a real VM '
      'service connection', () async {
    final developer.ServiceProtocolInfo info =
        await developer.Service.getInfo();
    final Uri? serverUri = info.serverUri;
    if (serverUri == null) {
      markTestSkipped(
        'No VM service in this run — execute with '
        '`flutter test --enable-vmservice test/e2e` to exercise the e2e '
        'smoke (tool/check_release.sh does).',
      );
      return;
    }

    final String wsUri = serverUri
        .replace(scheme: 'ws', path: '${serverUri.path}ws')
        .toString();
    final vm.VmService service = await vm_io.vmServiceConnectUri(wsUri);
    addTearDown(() async => service.dispose());
    final String isolateId =
        developer.Service.getIsolateId(Isolate.current)!;

    // Collect device_preview.* events before mutating.
    final List<vm.Event> events = <vm.Event>[];
    final StreamSubscription<vm.Event> subscription =
        service.onExtensionEvent.listen((vm.Event event) {
      if ((event.extensionKind ?? '').startsWith('device_preview.')) {
        events.add(event);
      }
    });
    addTearDown(subscription.cancel);
    await service.streamListen(vm.EventStreams.kExtension);

    // 1. getState: the advertised shape of a real 3.0 app.
    final vm.Response initial = await service.callServiceExtension(
      'ext.device_preview.getState',
      isolateId: isolateId,
    );
    expect(initial.json!['protocolVersion'], 3);
    expect(initial.json!['enabled'], true);
    expect(initial.json!['capabilities'], isA<Map<Object?, Object?>>());
    expect(initial.json!['realDevice'], isA<Map<Object?, Object?>>());

    // 2. setSimulation: full round trip, echoed requestId on the event.
    final Map<String, Object?> pushed = <String, Object?>{
      'screenSize': <String, Object?>{'width': 375.0, 'height': 667.0},
      'devicePixelRatio': 2.0,
      'platformBrightness': 'dark',
    };
    final vm.Response applied = await service.callServiceExtension(
      'ext.device_preview.setSimulation',
      isolateId: isolateId,
      args: <String, String>{
        'simulation': jsonEncode(pushed),
        'requestId': 'e2e-1',
        'source': 'e2e',
      },
    );
    final Map<String, Object?> appliedSimulation =
        (applied.json!['simulation'] as Map<Object?, Object?>)
            .cast<String, Object?>();
    expect(appliedSimulation['screenSize'], <String, Object?>{
      'width': 375.0,
      'height': 667.0,
    });
    expect(appliedSimulation['platformBrightness'], 'dark');
    expect(applied.json!['fit'], isA<Map<Object?, Object?>>());

    // 3. The stateChanged event arrived over the wire with our requestId.
    await _waitFor(
      () => events.any(
        (vm.Event e) =>
            e.extensionKind == 'device_preview.stateChanged' &&
            e.extensionData?.data['requestId'] == 'e2e-1',
      ),
      'device_preview.stateChanged with requestId e2e-1',
    );
    final vm.Event changed = events.lastWhere(
      (vm.Event e) => e.extensionKind == 'device_preview.stateChanged',
    );
    expect(changed.extensionData?.data['source'], 'e2e');

    // 4. A malformed payload surfaces as an invalidParams RPC error — the
    // contract the DevTools panel's rejected-payload handling relies on.
    await expectLater(
      service.callServiceExtension(
        'ext.device_preview.setSimulation',
        isolateId: isolateId,
        args: <String, String>{
          'simulation': jsonEncode(<String, Object?>{
            'locales': <String>['ab-cd-ef-gh'],
          }),
          'requestId': 'e2e-2',
        },
      ),
      throwsA(
        isA<vm.RPCError>().having(
          (vm.RPCError e) => e.code,
          'code',
          -32602, // ServiceExtensionResponse.invalidParams
        ),
      ),
    );

    // 5. reset: back to pass-through.
    final vm.Response cleared = await service.callServiceExtension(
      'ext.device_preview.reset',
      isolateId: isolateId,
    );
    expect(cleared.json!['simulation'], isNull);

    // 6. listPresets serves the built-in catalog over the wire.
    final vm.Response presets = await service.callServiceExtension(
      'ext.device_preview.listPresets',
      isolateId: isolateId,
    );
    expect(presets.json!['presets'], isA<List<Object?>>());
    expect(presets.json!['presets'], isNotEmpty);
  });
}

Future<void> _waitFor(bool Function() condition, String description) async {
  final Stopwatch stopwatch = Stopwatch()..start();
  while (!condition()) {
    if (stopwatch.elapsed > const Duration(seconds: 10)) {
      fail('Timed out waiting for $description');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/model/pointer_rewrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

ui.PointerData datum({
  ui.PointerChange change = ui.PointerChange.down,
  ui.PointerDeviceKind kind = ui.PointerDeviceKind.mouse,
  ui.PointerSignalKind? signalKind,
  int device = 1,
  double x = 100,
  double y = 200,
  int buttons = 1,
  Duration timeStamp = Duration.zero,
}) => ui.PointerData(
  viewId: 0,
  timeStamp: timeStamp,
  change: change,
  kind: kind,
  signalKind: signalKind,
  device: device,
  physicalX: x,
  physicalY: y,
  buttons: buttons,
);

void main() {
  group('retargetPointerKind', () {
    test('relabels the pointer, keeping everything else', () {
      final ui.PointerData source = datum(x: 12, y: 34);
      final ui.PointerData? result = retargetPointerKind(
        source,
        ui.PointerDeviceKind.touch,
      );
      expect(result, isNotNull);
      expect(result!.kind, ui.PointerDeviceKind.touch);
      expect(result.change, ui.PointerChange.down);
      expect(result.physicalX, 12);
      expect(result.physicalY, 34);
      expect(result.device, source.device);
      expect(result.buttons, source.buttons);
      expect(result.viewId, source.viewId);
    });

    test('drops hover, which a finger cannot produce', () {
      expect(
        retargetPointerKind(
          datum(change: ui.PointerChange.hover),
          ui.PointerDeviceKind.touch,
        ),
        isNull,
      );
      // Every other change survives.
      for (final ui.PointerChange change in <ui.PointerChange>[
        ui.PointerChange.add,
        ui.PointerChange.remove,
        ui.PointerChange.down,
        ui.PointerChange.move,
        ui.PointerChange.up,
        ui.PointerChange.cancel,
      ]) {
        expect(
          retargetPointerKind(
            datum(change: change),
            ui.PointerDeviceKind.touch,
          ),
          isNotNull,
          reason: '$change',
        );
      }
    });

    test('keeps hover for kinds that can hover', () {
      final ui.PointerData? result = retargetPointerKind(
        datum(change: ui.PointerChange.hover, kind: ui.PointerDeviceKind.touch),
        ui.PointerDeviceKind.stylus,
      );
      expect(result?.kind, ui.PointerDeviceKind.stylus);
    });

    test('leaves pointer signals with their real kind', () {
      final ui.PointerData wheel = datum(
        change: ui.PointerChange.hover,
        signalKind: ui.PointerSignalKind.scroll,
      );
      final ui.PointerData? result = retargetPointerKind(
        wheel,
        ui.PointerDeviceKind.touch,
      );
      // Untouched — and specifically not dropped, so the wheel keeps working.
      expect(identical(result, wheel), isTrue);
    });

    test('data already of the requested kind is returned untouched', () {
      final ui.PointerData touch = datum(kind: ui.PointerDeviceKind.touch);
      expect(
        identical(retargetPointerKind(touch, ui.PointerDeviceKind.touch), touch),
        isTrue,
      );
    });
  });

  group('through the binding', () {
    final TestDevicePreviewBinding binding =
        TestDevicePreviewBinding.ensureInitialized();

    tearDown(() async {
      await binding.devicePreview?.reset();
    });

    /// Drags [distance] upward from the middle of the view with a [kind]
    /// pointer, in real physical coordinates.
    Future<void> dragWith(
      WidgetTester tester,
      ui.PointerDeviceKind kind, {
      double distance = 200,
    }) async {
      final double ratio = tester.view.devicePixelRatio;
      final ui.Offset start = ui.Offset(
        tester.view.physicalSize.width / 2,
        tester.view.physicalSize.height / 2,
      );
      int time = 0;
      void send(ui.PointerChange change, ui.Offset at, {int buttons = 1}) {
        binding.debugInjectPointerData(
          ui.PointerDataPacket(
            data: <ui.PointerData>[
              ui.PointerData(
                viewId: tester.view.viewId,
                timeStamp: Duration(milliseconds: time += 16),
                change: change,
                kind: kind,
                device: 1,
                physicalX: at.dx,
                physicalY: at.dy,
                buttons: buttons,
              ),
            ],
          ),
        );
      }

      send(ui.PointerChange.down, start);
      for (int step = 1; step <= 5; step++) {
        send(
          ui.PointerChange.move,
          start.translate(0, -distance * ratio * step / 5),
        );
        await tester.pump(const Duration(milliseconds: 16));
      }
      send(ui.PointerChange.up, start.translate(0, -distance * ratio), buttons: 0);
      await tester.pump(const Duration(milliseconds: 16));
      await tester.pumpAndSettle();
    }

    Widget list(ScrollController controller) => MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          controller: controller,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) =>
              SizedBox(height: 60, child: Text('item $index')),
        ),
      ),
    );

    testWidgets('a mouse drag does not scroll a list, a simulated touch does', (
      WidgetTester tester,
    ) async {
      final ScrollController controller = ScrollController();
      addTearDown(controller.dispose);
      await binding.devicePreview!.apply(
        const DeviceSimulation(
          screenSize: ui.Size(400, 800),
          devicePixelRatio: 2,
        ),
      );
      await tester.pumpWidget(list(controller));

      // The host's mouse: `ScrollBehavior.dragDevices` excludes it, so
      // dragging selects nothing and scrolls nothing.
      await dragWith(tester, ui.PointerDeviceKind.mouse);
      expect(controller.offset, 0);

      // The same drag, with the pointer reported as a finger.
      await binding.devicePreview!.update(
        (DeviceSimulation s) =>
            s.copyWith(pointerKind: ui.PointerDeviceKind.touch),
      );
      await dragWith(tester, ui.PointerDeviceKind.mouse);
      expect(controller.offset, greaterThan(100));
    });

    testWidgets('a tap still works, and lands where the pointer is', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(
          screenSize: ui.Size(400, 800),
          devicePixelRatio: 2,
          pointerKind: ui.PointerDeviceKind.touch,
        ),
      );
      final List<ui.PointerDeviceKind> taps = <ui.PointerDeviceKind>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (PointerDownEvent event) => taps.add(event.kind),
            child: const SizedBox.expand(),
          ),
        ),
      );

      final ui.Offset center = ui.Offset(
        tester.view.physicalSize.width / 2,
        tester.view.physicalSize.height / 2,
      );
      binding.debugInjectPointerData(
        ui.PointerDataPacket(
          data: <ui.PointerData>[
            ui.PointerData(
              viewId: tester.view.viewId,
              change: ui.PointerChange.down,
              kind: ui.PointerDeviceKind.mouse,
              device: 1,
              physicalX: center.dx,
              physicalY: center.dy,
              buttons: 1,
            ),
          ],
        ),
      );
      await tester.pump();
      expect(taps, <ui.PointerDeviceKind>[ui.PointerDeviceKind.touch]);
    });

    testWidgets('turning touch on sends the host mouse out of the window', (
      WidgetTester tester,
    ) async {
      // Whatever the mouse was hovering must stop being hovered: its hover
      // events are about to disappear, and the app would otherwise keep the
      // highlight forever.
      final List<bool> hovering = <bool>[];
      await binding.devicePreview!.apply(
        const DeviceSimulation(screenSize: ui.Size(400, 800)),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: MouseRegion(
            onEnter: (_) => hovering.add(true),
            onExit: (_) => hovering.add(false),
            child: const SizedBox.expand(),
          ),
        ),
      );

      final ui.Offset center = ui.Offset(
        tester.view.physicalSize.width / 2,
        tester.view.physicalSize.height / 2,
      );
      binding.debugInjectPointerData(
        ui.PointerDataPacket(
          data: <ui.PointerData>[
            ui.PointerData(
              viewId: tester.view.viewId,
              change: ui.PointerChange.hover,
              kind: ui.PointerDeviceKind.mouse,
              device: 7,
              physicalX: center.dx,
              physicalY: center.dy,
            ),
          ],
        ),
      );
      await tester.pump();
      expect(hovering, <bool>[true]);

      await binding.devicePreview!.update(
        (DeviceSimulation s) =>
            s.copyWith(pointerKind: ui.PointerDeviceKind.touch),
      );
      await tester.pump();
      expect(hovering, <bool>[true, false]);
    });

    testWidgets('hover stops reaching the app while touch is simulated', (
      WidgetTester tester,
    ) async {
      final List<PointerHoverEvent> hovers = <PointerHoverEvent>[];
      await binding.devicePreview!.apply(
        const DeviceSimulation(screenSize: ui.Size(400, 800)),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerHover: hovers.add,
            child: const SizedBox.expand(),
          ),
        ),
      );

      // The middle of the host window, which maps inside the simulated screen.
      final ui.Offset center = ui.Offset(
        tester.view.physicalSize.width / 2,
        tester.view.physicalSize.height / 2,
      );
      void hover() => binding.debugInjectPointerData(
        ui.PointerDataPacket(
          data: <ui.PointerData>[
            ui.PointerData(
              viewId: tester.view.viewId,
              change: ui.PointerChange.hover,
              kind: ui.PointerDeviceKind.mouse,
              device: 1,
              physicalX: center.dx,
              physicalY: center.dy,
            ),
          ],
        ),
      );

      hover();
      await tester.pump();
      expect(hovers, hasLength(1));

      await binding.devicePreview!.update(
        (DeviceSimulation s) =>
            s.copyWith(pointerKind: ui.PointerDeviceKind.touch),
      );
      hover();
      await tester.pump();
      expect(hovers, hasLength(1), reason: 'a finger cannot hover');

      // Clearing the override brings the host pointer back as it is.
      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(pointerKind: null),
      );
      hover();
      await tester.pump();
      expect(hovers, hasLength(2));
    });
  });

  group('simulation model', () {
    test('round-trips through JSON', () {
      const DeviceSimulation simulation = DeviceSimulation(
        pointerKind: ui.PointerDeviceKind.touch,
      );
      expect(simulation.toJson()['pointerKind'], 'touch');
      expect(DeviceSimulation.fromJson(simulation.toJson()), simulation);
      expect(simulation.isEmpty, isFalse);
      expect(
        () => DeviceSimulation.fromJson(
          const <String, Object?>{'pointerKind': 'finger'},
        ),
        throwsFormatException,
      );
    });

    test('copyWith clears it when passed null explicitly', () {
      const DeviceSimulation simulation = DeviceSimulation(
        pointerKind: ui.PointerDeviceKind.touch,
      );
      expect(simulation.copyWith().pointerKind, ui.PointerDeviceKind.touch);
      expect(simulation.copyWith(pointerKind: null).pointerKind, isNull);
    });
  });
}

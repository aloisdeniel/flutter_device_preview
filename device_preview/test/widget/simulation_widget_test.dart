import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_view_configuration.dart';
import 'package:flutter/material.dart';
import '../support/test_binding.dart';
import 'package:flutter/rendering.dart' show RenderView, ViewConfiguration;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TestDevicePreviewBinding binding =
      TestDevicePreviewBinding.ensureInitialized();

  tearDown(() async {
    await binding.devicePreview?.reset();
  });

  Widget probe(void Function(BuildContext context) onBuild) => MaterialApp(
    home: Builder(
      builder: (BuildContext context) {
        onBuild(context);
        return const SizedBox.expand();
      },
    ),
  );

  group('seam composition under flutter_test (pinned)', () {
    testWidgets('binding.platformDispatcher stays the TestPlatformDispatcher', (
      WidgetTester tester,
    ) async {
      // Pinned: the dispatcher getter seam CANNOT be interposed under
      // flutter_test — TestWidgetsFlutterBinding narrows the getter type to
      // TestPlatformDispatcher, so the wrapper flows through the wrapper
      // view instead (View + MediaQuery + createViewConfigurationFor).
      expect(binding.platformDispatcher, isA<TestPlatformDispatcher>());
      final ui.FlutterView wrapper = binding.previewImplicitView!;
      expect(
        identical(binding.platformDispatcher, wrapper.platformDispatcher),
        isFalse,
      );
      // The wrapper's host is the test view, and identities are stable.
      expect(wrapper.viewId, tester.view.viewId);
      expect(identical(wrapper, binding.previewImplicitView), isTrue);
    });

    testWidgets(
      'metric simulation flows via the wrapper view: the RenderView gets a '
      'PreviewViewConfiguration',
      (WidgetTester tester) async {
        await binding.devicePreview!.apply(
          const DeviceSimulation(
            screenSize: ui.Size(200, 400),
            devicePixelRatio: 2.0,
          ),
        );
        await tester.pumpWidget(probe((_) {}));
        final RenderView renderView = binding.renderViews.single;
        expect(
          identical(renderView.flutterView, binding.previewImplicitView),
          isTrue,
        );
        final ViewConfiguration configuration = renderView.configuration;
        expect(configuration, isA<PreviewViewConfiguration>());
        expect(renderView.size, const Size(200, 400));
        // Host 800×600@3, sim 200×400 → scale clamped to 1, centered offset
        // (300, 100) logical → translation (900, 300) physical.
        final Matrix4 matrix = configuration.toMatrix();
        expect(matrix.getTranslation().x, 900);
        expect(matrix.getTranslation().y, 300);
      },
    );

    testWidgets('without simulation the test configuration is untouched', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(probe((_) {}));
      final RenderView renderView = binding.renderViews.single;
      expect(renderView.configuration, isNot(isA<PreviewViewConfiguration>()));
      expect(renderView.size, const Size(800, 600));
    });
  });

  group('MediaQuery simulation', () {
    testWidgets('pass-through equivalence when no simulation is active', (
      WidgetTester tester,
    ) async {
      late MediaQueryData observed;
      await tester.pumpWidget(
        probe((BuildContext context) => observed = MediaQuery.of(context)),
      );
      final MediaQueryData control = MediaQueryData.fromView(tester.view);
      expect(observed.size, control.size);
      expect(observed.devicePixelRatio, control.devicePixelRatio);
      expect(observed.padding, control.padding);
      expect(observed.viewPadding, control.viewPadding);
      expect(observed.viewInsets, control.viewInsets);
      expect(observed.platformBrightness, control.platformBrightness);
      expect(observed.textScaler.scale(10), control.textScaler.scale(10));
      expect(observed.displayFeatures, control.displayFeatures);
    });

    testWidgets('applying a preset reflects size/padding/DPR in MediaQuery', (
      WidgetTester tester,
    ) async {
      late MediaQueryData observed;
      await tester.pumpWidget(
        probe((BuildContext context) => observed = MediaQuery.of(context)),
      );
      await binding.devicePreview!.applyPreset(DevicePresets.iPhone16);
      await tester.pump();
      expect(observed.size, const Size(393, 852));
      expect(observed.devicePixelRatio, 3.0);
      expect(observed.padding, const EdgeInsets.only(top: 59, bottom: 34));
      expect(
        observed.viewPadding,
        const EdgeInsets.only(top: 59, bottom: 34),
      );
    });

    testWidgets('brightness and text scale simulate through the wrapper '
        'dispatcher', (WidgetTester tester) async {
      late MediaQueryData observed;
      await tester.pumpWidget(
        probe((BuildContext context) => observed = MediaQuery.of(context)),
      );
      expect(observed.platformBrightness, Brightness.light);
      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(
          platformBrightness: Brightness.dark,
          textScaleFactor: 2.0,
        ),
      );
      await tester.pump();
      expect(observed.platformBrightness, Brightness.dark);
      expect(observed.textScaler.scale(10), 20);
      expect(observed.boldText, isFalse);

      await binding.devicePreview!.update(
        (DeviceSimulation s) => s.copyWith(
          accessibility: const SimulatedAccessibilityFeatures(boldText: true),
        ),
      );
      await tester.pump();
      expect(observed.boldText, isTrue);
    });

    testWidgets('reset matches a control run', (WidgetTester tester) async {
      late MediaQueryData observed;
      await tester.pumpWidget(
        probe((BuildContext context) => observed = MediaQuery.of(context)),
      );
      final Size controlSize = observed.size;
      final EdgeInsets controlPadding = observed.padding;
      final double controlRatio = observed.devicePixelRatio;

      await binding.devicePreview!.applyPreset(
        DevicePresets.iPhone16Pro,
        orientation: Orientation.landscape,
      );
      await tester.pump();
      expect(observed.size, const Size(874, 402));
      expect(binding.devicePreview!.simulation, isNotNull);

      await binding.devicePreview!.reset();
      await tester.pump();
      expect(binding.devicePreview!.simulation, isNull);
      expect(binding.devicePreview!.fitTransform, FitTransform.identity);
      expect(observed.size, controlSize);
      expect(observed.padding, controlPadding);
      expect(observed.devicePixelRatio, controlRatio);
    });
  });

  group('pointer remapping', () {
    ui.PointerData pointerDatum(
      ui.PointerChange change,
      Offset realPhysical, {
      required int viewId,
    }) => ui.PointerData(
      viewId: viewId,
      change: change,
      kind: ui.PointerDeviceKind.touch,
      device: 1,
      physicalX: realPhysical.dx,
      physicalY: realPhysical.dy,
    );

    testWidgets(
      'debugInjectPointerData maps real physical coordinates onto the '
      'simulated widget tree',
      (WidgetTester tester) async {
        await binding.devicePreview!.apply(
          const DeviceSimulation(
            screenSize: ui.Size(200, 400),
            devicePixelRatio: 2.0,
          ),
        );
        int taps = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 50,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => taps += 1,
                ),
              ),
            ),
          ),
        );

        // Simulated logical (50, 25) → real logical (50 + 300, 25 + 100)
        // → real physical ×3 = (1050, 375).
        final int viewId = tester.view.viewId;
        binding.debugInjectPointerData(
          ui.PointerDataPacket(
            data: <ui.PointerData>[
              pointerDatum(
                ui.PointerChange.down,
                const Offset(1050, 375),
                viewId: viewId,
              ),
            ],
          ),
        );
        binding.debugInjectPointerData(
          ui.PointerDataPacket(
            data: <ui.PointerData>[
              pointerDatum(
                ui.PointerChange.up,
                const Offset(1050, 375),
                viewId: viewId,
              ),
            ],
          ),
        );
        await tester.pump();
        expect(taps, 1);

        // A tap in the letterbox maps out of bounds and is naturally inert:
        // real logical (10, 10) → simulated (-290, -90).
        binding.debugInjectPointerData(
          ui.PointerDataPacket(
            data: <ui.PointerData>[
              pointerDatum(
                ui.PointerChange.down,
                const Offset(30, 30),
                viewId: viewId,
              ),
              pointerDatum(
                ui.PointerChange.up,
                const Offset(30, 30),
                viewId: viewId,
              ),
            ],
          ),
        );
        await tester.pump();
        expect(taps, 1);
      },
    );

    testWidgets('tester.tap works in simulated-logical coordinates', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(
          screenSize: ui.Size(200, 400),
          devicePixelRatio: 2.0,
        ),
      );
      int taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 100,
              height: 50,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => taps += 1,
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      expect(taps, 1);
    });

    testWidgets('pass-through: injected events reach widgets unmapped when '
        'no simulation is active', (WidgetTester tester) async {
      int taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 50,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => taps += 1,
              ),
            ),
          ),
        ),
      );
      final int viewId = tester.view.viewId;
      // Logical (50, 25) at the test DPR of 3 → physical (150, 75).
      binding.debugInjectPointerData(
        ui.PointerDataPacket(
          data: <ui.PointerData>[
            pointerDatum(
              ui.PointerChange.down,
              const Offset(150, 75),
              viewId: viewId,
            ),
            pointerDatum(
              ui.PointerChange.up,
              const Offset(150, 75),
              viewId: viewId,
            ),
          ],
        ),
      );
      await tester.pump();
      expect(taps, 1);
    });
  });

  group('controller state', () {
    testWidgets('fitTransform tracks the applied simulation', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.apply(
        const DeviceSimulation(
          screenSize: ui.Size(200, 400),
          devicePixelRatio: 2.0,
        ),
      );
      expect(
        binding.devicePreview!.fitTransform,
        const FitTransform(scale: 1, offset: ui.Offset(300, 100)),
      );
      // Larger than the host: scaled down to fit (1600×1200 → scale 0.5).
      await binding.devicePreview!.apply(
        const DeviceSimulation(screenSize: ui.Size(1600, 1200)),
      );
      expect(binding.devicePreview!.fitTransform.scale, 0.5);
    });

    testWidgets('realDevice reports the host (test) metrics', (
      WidgetTester tester,
    ) async {
      await binding.devicePreview!.applyPreset(DevicePresets.iPhone16);
      final RealDeviceInfo real = binding.devicePreview!.realDevice;
      expect(real.logicalSize, const Size(800, 600));
      expect(real.devicePixelRatio, 3.0);
    });

    testWidgets('setOrientation swaps dimensions via the preset', (
      WidgetTester tester,
    ) async {
      late MediaQueryData observed;
      await tester.pumpWidget(
        probe((BuildContext context) => observed = MediaQuery.of(context)),
      );
      await binding.devicePreview!.applyPreset(DevicePresets.iPhone16);
      await tester.pump();
      expect(observed.size, const Size(393, 852));
      await binding.devicePreview!.setOrientation(Orientation.landscape);
      await tester.pump();
      expect(observed.size, const Size(852, 393));
      expect(
        observed.padding,
        const EdgeInsets.only(left: 59, right: 59, bottom: 21),
      );
    });
  });
}

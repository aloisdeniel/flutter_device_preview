// Pins the release-default (disabled) path of DevicePreviewBindingMixin:
// with `enabled: false` no wrapper objects, controller, or view
// configurations may be installed — the binding must be behaviorally
// identical to the plain stack (DESIGN §6 pass-through equivalence, threat
// matrix row "Release safety").
//
// This lives in its own file because a latched configuration is fixed for
// the binding's lifetime and flutter_test runs each file in its own process
// (every other binding-level test latches `enabled: true`).

import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_view_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderView, ViewConfiguration;
import 'package:flutter_test/flutter_test.dart';

/// A test binding with the mixin applied but simulation DISABLED — the
/// release default. Also latches an [DeviceSimulation] to pin that
/// `initialSimulation` is a silent no-op when disabled.
class DisabledDevicePreviewBinding extends AutomatedTestWidgetsFlutterBinding
    with DevicePreviewBindingMixin {
  static DisabledDevicePreviewBinding? _instance;

  static DisabledDevicePreviewBinding ensureInitialized() {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: false,
        initialSimulation: DevicePresets.iPhone16.resolve(),
      );
      DisabledDevicePreviewBinding();
    }
    return _instance!;
  }

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  /// Exposes the `@protected` dispatcher seam for the identity assertion.
  ui.PlatformDispatcher get exposedPreviewPlatformDispatcher =>
      previewPlatformDispatcher;
}

void main() {
  final DisabledDevicePreviewBinding binding =
      DisabledDevicePreviewBinding.ensureInitialized();

  testWidgets('no controller is created and initialSimulation is silently '
      'dropped', (WidgetTester tester) async {
    expect(binding.simulationEnabled, isFalse);
    expect(binding.devicePreview, isNull);
  });

  testWidgets('no wrapper view or dispatcher is installed', (
    WidgetTester tester,
  ) async {
    expect(binding.previewImplicitView, isNull);
    // The dispatcher seam passes straight through to the host: repeated
    // reads return the very same (non-wrapper) instance.
    expect(
      identical(
        binding.exposedPreviewPlatformDispatcher,
        binding.platformDispatcher,
      ),
      isTrue,
    );
    expect(
      identical(
        binding.exposedPreviewPlatformDispatcher,
        binding.exposedPreviewPlatformDispatcher,
      ),
      isTrue,
    );
  });

  testWidgets('the RenderView keeps the plain test configuration', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SizedBox.expand()));
    final RenderView renderView = binding.renderViews.single;
    final ViewConfiguration configuration = renderView.configuration;
    expect(configuration, isNot(isA<PreviewViewConfiguration>()));
    expect(renderView.size, const Size(800, 600));
  });

  testWidgets('MediaQuery equals the real-view control (pass-through '
      'equivalence)', (WidgetTester tester) async {
    late MediaQueryData observed;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            observed = MediaQuery.of(context);
            return const SizedBox.expand();
          },
        ),
      ),
    );
    final MediaQueryData control = MediaQueryData.fromView(tester.view);
    // The latched iPhone16 initialSimulation must have left no trace.
    expect(observed.size, control.size);
    expect(observed.size, isNot(const Size(393, 852)));
    expect(observed.devicePixelRatio, control.devicePixelRatio);
    expect(observed.padding, control.padding);
    expect(observed.viewPadding, control.viewPadding);
    expect(observed.platformBrightness, control.platformBrightness);
    expect(observed.textScaler.scale(10), control.textScaler.scale(10));
    expect(observed.displayFeatures, control.displayFeatures);
  });

  testWidgets('debugInjectPointerData passes events through unmapped', (
    WidgetTester tester,
  ) async {
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
    ui.PointerData datum(ui.PointerChange change) => ui.PointerData(
      viewId: viewId,
      change: change,
      kind: ui.PointerDeviceKind.touch,
      device: 1,
      // Logical (50, 25) at the test DPR of 3 → physical (150, 75).
      physicalX: 150,
      physicalY: 75,
    );
    binding.debugInjectPointerData(
      ui.PointerDataPacket(
        data: <ui.PointerData>[
          datum(ui.PointerChange.down),
          datum(ui.PointerChange.up),
        ],
      ),
    );
    await tester.pump();
    expect(taps, 1);
  });
}

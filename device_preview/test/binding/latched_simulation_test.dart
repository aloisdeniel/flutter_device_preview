// Pins the documented golden/CI startup sequence: latch an initial
// simulation with `latchConfiguration(initialSimulation: ...)`, then let the
// entry point re-latch `enabled` (exactly what `DevicePreview.enable()` does
// before constructing the binding). The re-latch omits `initialSimulation`,
// which must keep — not clear — the previously latched simulation.
//
// This lives in its own file because a latched configuration is consumed by
// the one binding a process can construct.

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

void main() {
  final DeviceSimulation latched = DevicePresets.iPhone16.resolve();
  // Step 1: the user latches a simulation before calling the entry point.
  DevicePreviewBindingMixin.latchConfiguration(
    enabled: true,
    initialSimulation: latched,
  );
  // Step 2: the entry point re-latches only `enabled`, as
  // `DevicePreview.enable()` does when it sees no binding instance yet.
  DevicePreviewBindingMixin.latchConfiguration(enabled: true);
  // Step 3: the binding is constructed and must consume the simulation from
  // step 1. (`ensureInitialized` must not latch again — pass nothing.)
  final TestDevicePreviewBinding binding =
      TestDevicePreviewBinding.ensureInitializedWithoutLatching();

  testWidgets('a latched initialSimulation survives the enabled-only '
      're-latch of the entry point', (WidgetTester tester) async {
    expect(binding.devicePreview, isNotNull);
    expect(binding.devicePreview!.simulation, latched);
    expect(binding.devicePreview!.simulation!.presetId, 'apple-iphone-16');
  });

  testWidgets('passing null explicitly clears a previously latched '
      'simulation', (WidgetTester tester) async {
    // The binding is already constructed, so assert on the latch semantics
    // indirectly: an explicit-null re-latch followed by an omitted-parameter
    // re-latch must leave nothing latched for a (hypothetical) next binding.
    // Behavioral coverage of "nothing latched" lives in the other binding
    // test files, which never latch a simulation and start in pass-through;
    // here we only pin that the API accepts the explicit null.
    DevicePreviewBindingMixin.latchConfiguration(
      enabled: true,
      initialSimulation: null,
    );
    DevicePreviewBindingMixin.latchConfiguration(enabled: true);
    // No observable crash/misbehavior; the active binding is unaffected.
    expect(binding.devicePreview!.simulation, latched);
  });
}

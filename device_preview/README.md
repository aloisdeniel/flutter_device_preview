# device_preview

> **Work in progress** — version 3 is a from-scratch rebuild. APIs described
> here may change before the first stable release.

Simulate the characteristics of another device — screen metrics, safe areas,
locale, brightness, text scale, accessibility flags, target platform — from a
DevTools extension or programmatically, with full framework fidelity: every
`MediaQuery`, layout pass, pointer event and locale resolution reads the
simulated device.

## How it works: the binding strategy

`device_preview` ships a drop-in replacement for `WidgetsFlutterBinding` that
interposes at the engine-abstraction level through exactly three framework
seams:

1. **`BindingBase.platformDispatcher`** — returns a wrapper
   `PlatformDispatcher` (and wrapper implicit `FlutterView`) that merges
   simulated values over the real host values. `MediaQueryData.fromView` reads
   only from these two objects, so the whole `MediaQuery` surface is covered.
2. **`RendererBinding.createViewConfigurationFor`** — lays out the root at the
   simulated logical size and applies a scale-to-fit transform (centered
   letterbox, never upscaled), so painting, hit testing, and semantics
   geometry stay consistent for free.
3. **`BindingBase.initServiceExtensions`** — registers
   `ext.device_preview.*` VM service extensions (debug/profile only) that the
   DevTools extension drives.

When simulation is disabled (the default in release builds) the binding is
behaviorally identical to `WidgetsFlutterBinding`: the wrappers are never
installed and everything passes straight through.

## Usage

```dart
void main() {
  DevicePreviewBinding.ensureInitialized();
  runApp(const MyApp()); // runs as usual — now simulatable
}
```

Programmatic control:

```dart
final c = DevicePreviewBinding.controller;
await c.applyPreset(DevicePresets.iPhoneSe3);
await c.update((s) => s.copyWith(textScaleFactor: 2.0, platformBrightness: Brightness.dark));
await c.setOrientation(Orientation.landscape);
await c.reset();
```

Device presets live in a separate, tree-shakable library:

```dart
import 'package:device_preview/presets.dart';
```

## Testing under a simulated device

The simulation machinery is a public mixin, so you can layer it onto
`flutter_test`'s binding in your own test suite. The package deliberately does
**not** ship this class from `lib/` — that would force `flutter_test` into the
regular dependencies of every app using `device_preview`. Copy this small
recipe into your `test/` folder instead:

```dart
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class TestDevicePreviewBinding extends AutomatedTestWidgetsFlutterBinding
    with DevicePreviewBindingMixin {
  static TestDevicePreviewBinding? _instance;

  static TestDevicePreviewBinding ensureInitialized({
    DeviceSimulation? initialSimulation,
  }) {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: true,
        initialSimulation: initialSimulation,
      );
      TestDevicePreviewBinding();
    }
    return _instance!;
  }

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  @override
  Widget wrapWithDefaultView(Widget rootWidget) {
    final ui.FlutterView? wrapperView = previewImplicitView;
    if (wrapperView != null) {
      return View(view: wrapperView, child: rootWidget);
    }
    return super.wrapWithDefaultView(rootWidget);
  }
}
```

Then:

```dart
void main() {
  final binding = TestDevicePreviewBinding.ensureInitialized();

  testWidgets('renders like an iPhone SE', (tester) async {
    await binding.devicePreview!.applyPreset(DevicePresets.iPhoneSe3);
    await tester.pumpWidget(const MyApp());
    // MediaQuery now reports 375×667 @2x with the SE safe areas.
  });
}
```

With that in place, `MediaQuery` reflects the applied simulation inside
`testWidgets`, the root lays out at the simulated size, `tester.tap` works in
simulated-logical coordinates, and
`binding.debugInjectPointerData(...)` lets you feed real-physical pointer
packets through the same remapping an engine-delivered event would take.

Under the hood the simulation machinery is a mixin,
`DevicePreviewBindingMixin`, that can be layered onto other binding stacks
(apply it **last**). One caveat pins the shape of test compositions:
`flutter_test`'s `TestWidgetsFlutterBinding` narrows the type of its
`platformDispatcher` getter to `TestPlatformDispatcher`, so a binding built
on it can never return the wrapper dispatcher from
`binding.platformDispatcher` (it would be an invalid override). That is why
the mixin leaves the `platformDispatcher` override to concrete bindings
(`DevicePreviewBinding` overrides it as `=> previewPlatformDispatcher`), and
why the recipe above routes simulation through the wrapper **view**
instead (the root widget is wrapped in a `View` built on
`previewImplicitView`). What that composition does *not* cover is framework
reads that go through `binding.platformDispatcher` directly (for example
`WidgetsApp`'s locale list); those are only interposed by the real
`DevicePreviewBinding`.

## Status

The model layer, the binding/interposition layer, the controller, the
`ext.device_preview.*` service extensions (including the optional screenshot
module) and the DevTools extension app are all implemented and covered by
tests. What remains before a stable release is field testing: real DevTools
sessions across platforms, and API feedback.

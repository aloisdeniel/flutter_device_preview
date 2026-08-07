# device_preview

> **Work in progress** — version 3 is a from-scratch rebuild. APIs described
> here may change before the first stable release.

Switch your **running** Flutter app to another device — an old 320pt phone, a
tablet in landscape, a notched display, a half-width desktop window —
instantly, with no rebuild and no simulator.

Screen size, pixel ratio, safe areas, orientation, folds, keyboard insets,
locales, brightness, text scale, accessibility settings and target platform
all change with it, and your app reads them through the same `MediaQuery` it
always used. Layout problems that normally reach a customer — a clipped
headline, a button under the home indicator, an overflow at 200% text —
show up while you are still writing the screen.

Control it from **Flutter DevTools**, from **Dart**, or from your **tests**.

## What can be simulated

| | |
|---|---|
| **Screen size & pixel ratio** | Any resolution and density; the app is scaled to fit your window, so a screen bigger than your monitor still previews whole. |
| **Safe areas** | Notches, punch-holes and home indicators, per device and per orientation. |
| **Orientation** | Portrait ⇄ landscape, with safe areas rotating as the real device rotates them. |
| **Folds & hinges** | Display features for foldables. |
| **Keyboard insets** | See what the software keyboard covers. |
| **Locales** | An ordered locale list; locale resolution, translations and `Intl` formatting follow. |
| **Brightness** | Light and dark, applied live. |
| **Text scale** | Up to 200% and beyond — the fastest way to find overflows. |
| **Accessibility** | Bold text, reduce motion, high contrast, invert colors, disable animations, accessible navigation, switch labels — each on, off, or left as the real device. |
| **24-hour time** | For date and time UI. |
| **Target platform** | Material/Cupertino behaviour across iOS, Android, macOS, Windows and Linux (debug builds only). |
| **Device frame** | The real device drawn around your app: rounded screen corners clip it, the body is painted behind it. Artwork ships with the DevTools catalog, not in your app. |

Simulation is active in debug and profile builds and completely off in release
builds, where the package adds no behaviour of any kind.

## Usage

```dart
void main() {
  DevicePreview.enable();
  runApp(const MyApp()); // runs as usual — now simulatable
}
```

`enable()` takes an optional positional flag. Left out, it resolves to
`!kReleaseMode` — on in debug and profile, off in release:

```dart
DevicePreview.enable();            // debug + profile
DevicePreview.enable(kDebugMode);  // debug only
DevicePreview.enable(false);       // never
```

Programmatic control:

```dart
final c = DevicePreview.controller;
await c.applyPreset(DevicePresets.iPhoneSe3);
await c.update((s) => s.copyWith(textScaleFactor: 2.0, platformBrightness: Brightness.dark));
await c.setOrientation(Orientation.landscape);
await c.reset();
```

Device presets live in a separate import, so the ones you never reference are dropped from your build:

```dart
import 'package:device_preview/presets.dart';
```

## Testing under a simulated device

Widget tests can run under a simulated device too, so you can assert that a
screen fits an iPhone SE, or that nothing overflows at 200% text, and capture
goldens for a whole matrix of devices in CI.

Add this small test binding to your `test/` folder. (It is not shipped from
`lib/`, so that `flutter_test` never lands in your app's own dependencies.)

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
    final controller = devicePreview;
    if (wrapperView != null) {
      return View(
        view: wrapperView,
        // Only needed for device frames (screen clipping + body artwork).
        child: controller == null
            ? rootWidget
            : DevicePreviewFrame(
                simulation: controller.simulationListenable,
                child: rootWidget,
              ),
      );
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

Inside `testWidgets`, `MediaQuery` then reports the simulated device, the
screen lays out at its size, and `tester.tap` works in its coordinates.
`DevicePreviewBindingMixin` composes with `integration_test`'s binding the
same way.

> **One limitation in tests:** `WidgetsApp`'s own locale resolution is not
> simulated under `flutter_test` (everything else is). Assert on locale
> behaviour in an integration test, or against `MediaQuery` directly.

## Device frames

A simulation can also carry the device's *appearance* — the outline its screen
is clipped to, and the body drawn behind it:

```dart
await c.update((s) => s.copyWith(
  frame: DeviceFrame.fromJson(jsonDecode(specSource)['frame']),
));
```

Picking a device in DevTools does this for you. The artwork lives in the
repository's [`device_specs/`](https://github.com/aloisdeniel/flutter_device_preview/tree/master/device_specs)
catalog and travels over the simulation protocol, so your app only ever holds
the device it is currently simulating — this package ships no images and no
SVG dependency. Frames are described in portrait and rotate with the device.

The SVG subset renderer used to draw them is embedded, dependency-free, and
exported on its own (`package:device_preview/svg.dart`) if you need it.

## Status

Everything described above is implemented and covered by tests. What remains
before a stable release is field testing across platforms and API feedback —
please open an issue if something doesn't fit your workflow.

## How it works

The simulation happens below the widget layer, which is why it reaches
`MediaQuery`, layout, gestures and locale resolution without any change to
your widget tree. If you want the full architecture — the framework seams
used, the scale-to-fit and pointer maths, the DevTools protocol — see
[DESIGN.md](../DESIGN.md).

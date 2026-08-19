# device_preview

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
| **System UI** | A simulated status bar and gesture pill, laid out from the device's safe areas and tinted from your app's `SystemUiOverlayStyle` — so a status bar style is visible while you write it. Toggle it off to inspect a screen bare. |
| **Touch input** | Your mouse reported to the app as a finger, so dragging scrolls a list the way a thumb does and gestures take their touch paths. Follows the simulated device unless you say otherwise: on for a phone, tablet or foldable, off for a desktop window. |

Simulation is active in debug and profile builds and completely off in release
builds, where the package adds no behaviour of any kind.

## Usage

```dart
void main() {
  DevicePreview.enable();
  runApp(const MyApp()); // runs as usual — now simulatable
}
```

`enable()` takes an optional `enabled` flag. Left out, it resolves to
`!kReleaseMode` — on in debug and profile, off in release:

```dart
DevicePreview.enable();                     // debug + profile
DevicePreview.enable(enabled: kDebugMode);  // debug only
DevicePreview.enable(enabled: false);       // never
```

It can also reserve padding around the simulated device and choose the
background painted behind it. By default that is a `DotGridDecoration` — a
dark grey with a subtle dot pattern that keeps the device body readable; any
`Decoration` works, and `null` leaves the area unpainted. The safe areas of
the hosting platform (a real notch, status bar, or home indicator) are
automatically added to the padding, so the simulated device never hides
under the host's own system UI:

```dart
DevicePreview.enable(
  padding: const EdgeInsets.all(16),
  backgroundDecoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF1D1D25), Color(0xFF38383F)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
);
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
screen fits a small phone, or that nothing overflows at 200% text, and capture
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

  testWidgets('renders like an iPhone 16', (tester) async {
    await binding.devicePreview!.applyPreset(DevicePresets.iPhone16);
    await tester.pumpWidget(const MyApp());
    // MediaQuery now reports 393×852 @3x with the iPhone 16 safe areas.
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

Picking a device in DevTools does this for you, and every built-in
`DevicePresets` entry already carries its frame and system UI, so
`applyPreset` shows the framed device without DevTools attached. The artwork
is generated from the repository's
[`device_specs/`](https://github.com/aloisdeniel/flutter_device_preview/tree/master/device_specs)
catalog into plain `const` data — no images, no SVG dependency, and presets
your app never references tree-shake away, artwork included. Frames are
described in portrait and rotate with the device.

Devices also carry a simulated **system UI** (`DeviceSimulation.systemUi`): a
static status bar and gesture pill — the clock reads 9:41 and never moves —
drawn over your app in the device's safe areas. Its colors are not artwork:
they follow your app's live `SystemUiOverlayStyle`, whether you set it with
`SystemChrome.setSystemUIOverlayStyle` or through the `AnnotatedRegion` an
`AppBar` installs, so you can see a status bar style while you write it.
`DeviceSimulation.showSystemUi` (the panel's **System UI** switch) hides the
bars without changing the safe areas they sit in, so the app lays out the same
either way.

The SVG subset renderer used to draw all of this is embedded,
dependency-free, and exported on its own
(`package:device_preview/svg.dart`) if you need it.

## Touch input

On a desktop or the web the host's mouse is not a drag device — Flutter's
`ScrollBehavior.dragDevices` excludes it — so dragging a list in a phone
preview does nothing, which is exactly the interaction you wanted to try.

So it is on by default wherever it makes sense. `touchInput` is a tri-state
and it starts unset, which means *auto*: the simulated device decides — a
phone, a tablet or a foldable is a touchscreen, a desktop window is not, and
neither is your real device when no screen is simulated. Override it either
way when you need to:

```dart
await c.update((s) => s.copyWith(touchInput: true));   // force touch
await c.update((s) => s.copyWith(touchInput: false));  // force the real pointer
await c.update((s) => s.copyWith(touchInput: null));   // back to auto
```

When it resolves to touch, every pointer is reported to the app as a finger:
drags scroll, gestures take their touch paths, text selection follows the
touch rules, and hovering stops — a finger cannot hover, so hover events are
dropped rather than relabelled, and whatever the mouse was hovering is
released. The scroll wheel and trackpad gestures keep their real kind, so
wheel scrolling still works. The panel has an **Auto / On / Off** row for it.

## How it works

The simulation happens below the widget layer, which is why it reaches
`MediaQuery`, layout, gestures and locale resolution without any change to
your widget tree. If you want the full architecture — the framework seams
used, the scale-to-fit and pointer maths, the DevTools protocol — see
[DESIGN.md](../DESIGN.md).

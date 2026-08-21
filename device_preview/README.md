# device_preview

Switch your **running** Flutter app to another device — an old 320pt phone, a
tablet in landscape, a notched display, a half-width desktop window —
instantly, with no rebuild and no simulator.

Screen size, pixel ratio, safe areas, orientation, folds, the software
keyboard, locales, brightness, text scale, accessibility settings and target
platform all change with it, and your app reads them through the same `MediaQuery` it
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
| **Keyboard** | The device's software keyboard, raised on demand at the height it really covers, in either orientation — so a form can be checked against it from a desktop, which has no keyboard of its own. Measured per device (every iPhone and iPad today), and the only thing `viewInsets` reports while simulating: the host's own keyboard stays out of the simulated screen. |
| **Locales** | An ordered locale list; locale resolution, translations and `Intl` formatting follow. |
| **Brightness** | Light and dark, applied live. |
| **Text scale** | Up to 200% and beyond — the fastest way to find overflows. |
| **Accessibility** | Bold text, reduce motion, high contrast, invert colors, disable animations, accessible navigation, switch labels — each on, off, or left as the real device. |
| **24-hour time** | For date and time UI. |
| **Target platform** | Material/Cupertino behaviour across iOS, Android, macOS, Windows and Linux (debug builds only). |
| **Device frame** | The real device drawn around your app: rounded screen corners clip it, the body is painted behind it. Artwork is `const` data on the preset — only the devices you name are compiled in — or pushed by the DevTools catalog. |
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

`DevicePreview.controller` throws when simulation is off — which is every
release build. Code that ships (a debug menu compiled into the app, a
demo screen) should go through `DevicePreview.maybeController`, which is
null instead:

```dart
DevicePreview.maybeController?.applyPreset(DevicePresets.iPhone16);
```

Device presets live in a separate import, so the ones you never reference are dropped from your build:

```dart
import 'package:device_preview/presets.dart';
```

Naming a preset is what compiles it in; the whole catalog (≈300 KB of `const`
data, artwork included) is only pulled in if you reach for `DevicePresets.all`
or `DevicePresets.byId`, which walk every entry.

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
import 'package:device_preview/presets.dart';

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
static status bar and gesture pill — the clock is a still drawing that never
ticks —
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

## Custom devices

A device that is not in the catalog can be registered from Dart —
`registerPreset(DevicePreset(...))` makes it appear in the DevTools picker
alongside the built-ins — or supplied as JSON in the
[`device_specs/`](https://github.com/aloisdeniel/flutter_device_preview/tree/master/device_specs)
format (which is exactly `DevicePreset.toJson()`, frame artwork and system UI
included):

```dart
await c.applyJson(specSource); // registers it as a preset and applies it
```

The DevTools panel has the same thing in its picker — **New device from
JSON…** validates a pasted spec, applies it immediately and keeps it under
**My devices** for later sessions.

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

## The software keyboard

Half the layout bugs a phone user meets are under the keyboard: the submit
button it covers, the field that does not scroll into view, the sheet that
loses its bottom padding. On a desktop host there is no keyboard to raise, so
those bugs normally wait for a real device.

A simulated device brings its own. A device declares the height its stock
keyboard covers, per orientation — measured on the real thing, so today that
is every iPhone and iPad in the catalog; an Android keyboard's height belongs
to the installed keyboard app rather than to the device, and none is claimed
until it can be measured as reliably. Raising it is one switch in the DevTools
panel — or one field from Dart:

```dart
final preset = DevicePresets.iPhone16Pro;
await c.applyPreset(preset);
await c.update(
  (s) => s.copyWith(keyboardInset: preset.keyboardHeight(s.orientation)),
);
// …and back down:
await c.update((s) => s.copyWith(keyboardInset: null));
```

`keyboardInset` reaches the app as `MediaQuery.viewInsets.bottom`, so
everything that reacts to a real keyboard reacts to this one: a `Scaffold`
body shrinks, `resizeToAvoidBottomInset` applies, a scroll view keeps the
focused field visible, and the bottom safe area collapses under it exactly as
the engines collapse it. Where the keyboard would be, the package paints a
dark hatched band at 80% opacity — translucent on purpose, so you can still
read the part of your screen it covers, which is usually the thing you wanted
to see — carrying a small monoline keyboard mark. It names the space; it is
not a keyboard layout with keys to press. The **System UI** switch hides the
band without changing the inset, so the layout is identical either way.

A raised keyboard follows the device: switch to another phone and it comes
back at *that* phone's height, rotate and it takes the landscape height. A
device that declares no keyboard — a desktop window, or one whose height has
not been measured — cannot raise one, and the switch says so by staying off.

While a device is simulated, this is the *only* keyboard your app sees:
`viewInsets` is the simulated keyboard or zero, never the host's. Previewing
on a real phone therefore no longer scrolls your text field clear of the
phone's own keyboard — raise the simulated one instead, which is the keyboard
the layout should be checked against anyway. The
host's own keyboard, if it has one, still maps into simulated space as it
always did; the two never stack — the deeper inset wins.

## Migrating from 2.x

3.0 is a from-scratch rebuild. The integration shrinks to one line and the
in-app toolbar is gone — the UI now lives in DevTools.

Before (2.x):

```dart
void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ),
);

// ...and on your app widget:
MaterialApp(
  useInheritedMediaQuery: true,
  locale: DevicePreview.locale(context),
  builder: DevicePreview.appBuilder,
)
```

After (3.0):

```dart
void main() {
  DevicePreview.enable(); // !kReleaseMode is already the default
  runApp(const MyApp());
}
```

Delete the `DevicePreview(builder:)` wrapper and all three `MaterialApp`
lines — `useInheritedMediaQuery`, `locale:` and `builder:` are not needed
because the simulation now happens below the widget layer, where the
framework itself reads locales and metrics.

What replaced what:

| 2.x | 3.0 |
|---|---|
| The in-app toolbar | The **device_preview** tab in Flutter DevTools |
| `DevicePreview(enabled: ...)` | `DevicePreview.enable(enabled: ...)` |
| `Devices.ios.iPhone13` | `DevicePresets.iPhone16` etc. (`package:device_preview/presets.dart`) |
| `tools:`, custom plugins | `DevicePreview.controller` — build any UI or automation on top |
| `storage:` | Panel state persists in DevTools; app-side state is yours to latch via `latchConfiguration` |
| `device_frame` package | Frames are data on the preset (`DeviceFrame`), artwork included |

Custom devices built with `DeviceInfo` become `DevicePreset`s — either in
Dart via `registerPreset`, or as JSON (the
[`device_specs/`](https://github.com/aloisdeniel/flutter_device_preview/tree/master/device_specs)
format) via `applyJson` or the panel's **New device from JSON…** entry.

## How it works

The simulation happens below the widget layer, which is why it reaches
`MediaQuery`, layout, gestures and locale resolution without any change to
your widget tree. If you want the full architecture — the framework seams
used, the scale-to-fit and pointer maths, the DevTools protocol — see
[DESIGN.md](https://github.com/aloisdeniel/flutter_device_preview/blob/master/DESIGN.md).

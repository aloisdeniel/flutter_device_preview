# device_preview example

Two apps in one package:

- **`lib/main.dart`** — the pub.dev example: a *Characteristics* tab that
  displays every value the simulation controls (size, pixel ratio, safe
  areas, locales, brightness, text scale, accessibility flags, display
  features), and a *Playground* tab that drives
  `DevicePreview.controller` from inside the app (`applyPreset`,
  `setOrientation`, `update`, `reset`).
- **`lib/showcase.dart`** — the "device lab" demo embedded in the
  [landing page](https://aloisdeniel.github.io/flutter_device_preview/):
  edge-to-edge header under the simulated status bar, labeled safe-area
  bands, a locale-aware clock, a hinge-aware two-pane layout, and an
  animation that honors `disableAnimations`.

Run either on any device or desktop target:

```sh
flutter run                          # main.dart
flutter run -t lib/showcase.dart     # the device lab
```

Then open **Flutter DevTools → device_preview** and pick a device — or use
the Playground tab. The integration is the single `DevicePreview.enable()`
line at the top of each `main()`.

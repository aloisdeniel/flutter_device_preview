<p align="center">
  <img src="https://github.com/aloisdeniel/flutter_device_preview/raw/master/logo.png" alt="Device Preview for Flutter" />
</p>

<h4 align="center">Simulate any device — screen, safe areas, locale, accessibility — with full framework fidelity.</h4>

<p align="center">
  <a href="https://pub.dartlang.org/packages/device_preview"><img src="https://img.shields.io/pub/v/device_preview.svg"></a>
  <a href="https://www.buymeacoffee.com/aloisdeniel">
    <img src="https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat">
  </a>
</p>

You build on one screen; your users arrive on hundreds. Device Preview switches your **running** app to another device — an old 320pt phone, a tablet in landscape, a notched display, a half-width desktop window — instantly, with no rebuild and no simulator.

Screen size, pixel ratio, safe areas, orientation, folds, the software keyboard, locales, brightness, text scale, accessibility settings and target platform all change with it, and your app reads them through the same `MediaQuery` it always used. So the problems that normally surface in front of a customer — a clipped headline, a button under the home indicator, an overflow at 200% text — surface in front of you instead.

Control it from **Flutter DevTools**, from **Dart**, or from your **tests**.

## Quickstart

```yaml
dependencies:
  device_preview: <latest version>
```

```dart
void main() {
  DevicePreview.enable();
  runApp(const MyApp()); // runs as usual — now simulatable
}
```

That's the whole integration. Open DevTools, select the **device_preview** tab, and pick a device.

`enable()` is safe to call unconditionally: simulation is active in debug and profile builds and completely off in release, so nothing ships to your users. Pass a value to decide yourself — `DevicePreview.enable(enabled: kDebugMode)` for debug only, `DevicePreview.enable(enabled: false)` to turn it off.

Programmatic control:

```dart
import 'package:device_preview/presets.dart';

final c = DevicePreview.controller;
await c.applyPreset(DevicePresets.iPhone16Pro);
await c.setOrientation(Orientation.landscape);
await c.update((s) => s.copyWith(textScaleFactor: 2.0, platformBrightness: Brightness.dark));
await c.reset();
```

`DevicePreview.controller` throws when simulation is off (every release build); use `DevicePreview.maybeController?.…` from code that ships.

See [`device_preview/README.md`](device_preview/README.md) for the full package documentation, including widget-test support via `DevicePreviewBindingMixin`.

## Documentation

<a href='https://aloisdeniel.github.io/flutter_device_preview/' target='_blank'>Open the website</a> · [Design document](DESIGN.md)

## Repository structure

| Directory | Contents |
|---|---|
| [`device_preview`](device_preview) | The published package: binding, controller, presets, service extensions, bundled DevTools extension build. |
| [`device_preview_devtools_extension`](device_preview_devtools_extension) | Source of the DevTools extension web app (never published; built into `device_preview/extension/devtools/build`). |
| [`device_specs`](device_specs) | The device catalog: one JSON per device — metrics, screen outline and body artwork. Generated into both the extension catalog and the package's built-in `DevicePresets`; see [its README](device_specs/README.md) to add a device. |
| [`device_frame`](device_frame) | **Legacy** device frame drawings package from the 2.x era. Nothing in the 3.0 release depends on it — 3.0 renders frames from the [`device_specs`](device_specs) artwork, carried by the built-in presets and pushed over the DevTools protocol. |
| [`docs`](docs) | The website, including its interactive demo — `docs/demo` is the counter example built for the web, `docs/device_catalog.json` the catalog its HTML panel pushes to it. Rebuild both with [`tool/build_demo.sh`](tool/build_demo.sh). |

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

Device Preview 3 simulates the characteristics of another device — screen size, pixel ratio, safe areas, orientation, display features, locales, brightness, text scale, accessibility flags, target platform — **at the `WidgetsBinding` level**. The framework itself reads the simulated device, so every `MediaQuery`, layout pass, pointer event and locale resolution follows along: responsive breakpoints, `SafeArea` insets, orientation branches, `Intl` formatting and platform-adaptive widgets all behave as they would on the real hardware. The app renders scale-to-fit, letterboxed and centered, inside your real window.

Simulation is driven:

- **from Flutter DevTools**, via a first-class DevTools extension that appears automatically for any app depending on `device_preview`, or
- **programmatically**, through a small controller API.

## Quickstart

```yaml
dependencies:
  device_preview: <latest version>
```

```dart
void main() {
  DevicePreviewBinding.ensureInitialized();
  runApp(const MyApp()); // runs as usual — now simulatable
}
```

That's the whole integration. Open DevTools, select the **device_preview** tab, and pick a device. Simulation is enabled in debug builds by default and fully disabled (zero interposition, tree-shaken service extensions) in release builds.

Programmatic control:

```dart
final c = DevicePreviewBinding.controller;
await c.applyPreset(DevicePresets.iPhone16Pro);
await c.setOrientation(Orientation.landscape);
await c.update((s) => s.copyWith(textScaleFactor: 2.0, platformBrightness: Brightness.dark));
await c.reset();
```

See [`device_preview/README.md`](device_preview/README.md) for the full package documentation, including widget-test support via `DevicePreviewBindingMixin`.

## Documentation

<a href='https://aloisdeniel.github.io/flutter_device_preview/' target='_blank'>Open the website</a> · [Design document](DESIGN.md)

## Repository structure

| Directory | Contents |
|---|---|
| [`device_preview`](device_preview) | The published package: binding, controller, presets, service extensions, bundled DevTools extension build. |
| [`device_preview_devtools_extension`](device_preview_devtools_extension) | Source of the DevTools extension web app (never published; built into `device_preview/extension/devtools/build`). |
| [`device_frame`](device_frame) | Device frame drawings package (independent of the preview machinery). |
| [`docs`](docs) | The website. |

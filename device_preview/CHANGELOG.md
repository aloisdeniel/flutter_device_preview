# Changelog

## 3.0.0-dev.2

- Simulated system UI: `DeviceSimulation.systemUi` (`SystemUiSimulation`)
  draws a static status bar and gesture pill over the app, laid out from the
  simulated safe areas, and tinted from the app's live `SystemUiOverlayStyle`
  (`SystemUiColors.resolve`). The binding tracks that style through both
  `SystemChrome.setSystemUIOverlayStyle` and `AnnotatedRegion` — the latter
  needing its own annotation lookup, since the framework's probes assume a
  plain device-pixel-ratio root transform and miss under scale-to-fit.
- `DeviceSimulation.showSystemUi` shows or hides those bars without touching
  the safe areas they occupy.
- `DeviceSimulation.touchInput` (`bool?`) reports the host's pointers to the
  app as touches, so dragging scrolls (the mouse is not a drag device on
  desktop or the web). Unset — the default — means *auto*: the simulated
  device decides, through the new `DeviceSimulation.deviceKind` that presets
  fill in. A phone, tablet or foldable is a touchscreen; a desktop window is
  not, and neither is a custom size that names no device. Hovers are dropped
  rather than relabelled, pointer signals (wheel, trackpad) keep their real
  kind, and the host's hover state is released when the mode changes.
- `DeviceKind` moved to the core library (still exported from
  `presets.dart`), since a simulation carries it too. Protocol version 3.
- `SvgDrawing.paint(currentColor:)` tints every shape that inherited its fill,
  which is what makes one drawing serve as a tintable icon set.
- Device frames: `DeviceSimulation.frame` (`DeviceFrame`) carries the screen
  outline the app is clipped to and the SVG body painted behind it, described
  in portrait and rotated with the device. The scale-to-fit letterbox and the
  screenshot capture now cover the whole body
  (`DeviceSimulation.contentBounds`, `FitTransform.compute(contentBounds:)`).
- `DevicePreviewFrame` / `RenderDevicePreviewFrame`, installed automatically
  by the binding around the root widget.
- Embedded, dependency-free SVG subset renderer exported as
  `package:device_preview/svg.dart` (`SvgDrawing`, `parseSvgPathData`,
  `parseXmlDocument`).
- `DevicePreset` gains `brand` and `frame`; the JSON form matches the
  `device_specs/` catalog at the root of the repository.
- Protocol version 2: `simulation.frame` and the `frame` capability flag.

## 3.0.0-dev.1

- From-scratch rebuild (work in progress).
- Pure model layer: `DeviceSimulation`, `SimulatedAccessibilityFeatures`,
  `SimulatedDisplayFeature`, `RealDeviceInfo`, `FitTransform`, pointer
  rewrite, and the `DevicePresets` catalog.
- Binding layer: `DevicePreview` and `DevicePreviewBindingMixin` with
  the wrapper `PlatformDispatcher`/`FlutterView` pair, the scale-to-fit
  `ViewConfiguration`, and pointer remapping.
- `DevicePreviewController` (apply/update/applyPreset/setOrientation/reset,
  live `realDevice`, `fitTransform`, custom preset registration).
- `ext.device_preview.*` service extensions: `getState`, `setSimulation`,
  `reset`, `listPresets`, plus the optional capability-flagged `screenshot`
  module, and the `device_preview.ready` / `stateChanged` / `presetsChanged`
  events.

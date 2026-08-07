# Changelog

## 3.0.0-dev.2

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

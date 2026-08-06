# Changelog

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

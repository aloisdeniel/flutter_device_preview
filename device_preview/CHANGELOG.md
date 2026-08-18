# Changelog

## Unreleased

- The iPhone and iPad frames are now derived from the official iOS
  Simulator bezel artwork (Xcode's "Show Device Bezels" chrome): exact
  body sizes, bezel borders, Apple's own outer corner radii, and the true
  continuous-curvature display outlines from the simulator framebuffer
  masks, notch and Dynamic Island included. See
  `.claude/skills/simulator-specs/` for the extraction process.
- Apple metrics are now verified against a live simulator: a probe app is
  booted per device type and reports the safe areas UIKit actually applies.
  The iPhone values were confirmed exact; every iPad's bottom safe-area
  inset was corrected from 20 to 25 logical pixels (both orientations), in
  the specs and the built-in `DevicePresets`.
- Compatibility with Flutter 3.47: `PreviewPlatformDispatcher` forwards
  the new `PlatformDispatcher.onHitTest` callback. The minimum Flutter
  version is now 3.47.0.
- Four foldable presets — the catalog's first: Pixel 10 Pro Fold
  (`DevicePresets.pixel10ProFold`), Galaxy Z Fold8 (`galaxyZFold8`),
  Galaxy Z Fold8 Ultra (`galaxyZFold8Ultra`) and Galaxy Z Flip8
  (`galaxyZFlip8`), 26 devices in all. Each simulates its unfolded inner
  display and reports the crease as a `fold` display feature
  (`postureFlat`), so hinge-aware layouts such as two-pane split at the
  fold, in both orientations.
- `package:device_preview/presets.dart` now re-exports
  `SimulatedDisplayFeature`, which the foldable presets carry.

## 3.0.0-prerelease3

- `DevicePreview.enable` gained `padding` and `backgroundDecoration`
  parameters: `padding` reserves room around the simulated device when it is
  fitted into the real window, and `backgroundDecoration` paints the window
  behind the device (the letterbox). Both are latched at enable time, like
  `enabled`.
- The safe areas of the hosting platform (a real notch, status bar, or home
  indicator) are now automatically added to the padding, so the simulated
  device stays clear of the host's own system UI.
- **Breaking**: `DevicePreview.enable`'s positional flag became the named
  `enabled` parameter — `DevicePreview.enable(kDebugMode)` is now
  `DevicePreview.enable(enabled: kDebugMode)`.
- The example gained a "device lab" showcase app (`example/lib/showcase.dart`)
  that makes every simulated characteristic visible: labeled safe-area bands,
  a locale- and 24-hour-aware clock, a hinge-aware two-pane layout, and an
  animation that honors `disableAnimations`.

## 3.0.0-prerelease2

Device catalog refreshed to the two latest generations — 22 devices:

- Added iPhone 16 Plus and iPhone 16e (completing the 16 line), iPad Pro
  11", iPad Air 11" and 13", Pixel 10, Galaxy S25, and the Galaxy Tab S10+
  and Tab S11 tablets.
- Removed iPhone SE (3rd gen) (`DevicePresets.iPhoneSe3`), Pixel 8
  (`DevicePresets.pixel8`) and Pixel Tablet (`DevicePresets.pixelTablet`);
  the generic desktop windows remain. Apps that referenced the removed
  presets can keep the metrics as custom `DevicePreset`s via
  `registerPreset`.
- The bundled DevTools extension ships the matching regenerated catalog
  (frame artwork included) for every device above.

## 3.0.0-prerelease1

The 3.0 release is a from-scratch rebuild: a custom `WidgetsBinding` that
simulates device characteristics (screen metrics, safe areas, locale,
brightness, text scale, accessibility flags, target platform) at the
engine-abstraction level. There is no in-app UI — the simulation is driven
programmatically through `DevicePreview.controller` and from the bundled
Flutter DevTools extension. See the README for the full feature tour and the
2.x migration notes, and the `3.0.0-dev.*` entries below for the rebuild's
incremental history.

Changes since 3.0.0-dev.2:

- `DevicePreviewBindingMixin.latchConfiguration` is now sentinel-based:
  `DevicePreview.enable()` after `latchConfiguration(initialSimulation: ...)`
  no longer silently discards the latched simulation (the documented
  golden/CI startup sequence).
- `setOrientation` keeps the active `frame` and `systemUi` artwork when the
  simulation was pushed from DevTools (rotation is not a device switch).
- `applyPreset` and `setOrientation` now preserve `touchInput` and
  `showSystemUi`, matching the DevTools panel's definition of
  device-switch-surviving overrides.
- Simulated `MediaQuery.padding` now collapses where the real keyboard's
  `viewInsets` overlap it, matching real engine behavior.
- SVG artwork: `fill="currentColor"` now follows the paint-time tint (the
  app's `SystemUiOverlayStyle`) even nested under groups with an explicit or
  `none` fill, per CSS `currentColor` semantics.
- DevTools panel: landscape `viewPadding` now falls back through
  `landscapePadding` exactly like `DevicePreset.resolve`, so DevTools and
  `applyPreset` produce identical metrics for every catalog device.
- DevTools panel: a rejected payload (`invalidParams`) no longer flips the
  panel to the "isolate paused" empty state; the panel re-fetches the app's
  actual state instead.
- DevTools panel: the in-memory simulation stash is cleared on disconnect, so
  a previous app's simulation is never pushed into a different app on
  reconnect (the persisted stash stays keyed per VM-service URI).
- New test layers: a VM-service e2e smoke over the real service-extension
  glue (`tool/check_release.sh` runs it), a production-composition
  host-resize seam test, and screenshot capture tests.

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

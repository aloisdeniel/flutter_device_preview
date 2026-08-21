# Changelog

## 3.0.0-prerelease7

The 3.0 candidate — a from-scratch rebuild of Device Preview, feature-complete
and awaiting field feedback before the stable release. If you are coming from
2.x, see **Migrating from 2.x** in the README: the integration is now a single
line and the in-app toolbar is gone.

The one-paragraph version: a custom `WidgetsBinding` simulates device
characteristics (screen metrics, safe areas, orientation, folds, keyboard
insets, locales, brightness, text scale, accessibility flags, 24-hour time,
target platform) at the engine-abstraction level, so your app reads them
through the same `MediaQuery`, layout and locale-resolution paths it uses on a
real device — no widget wrapper, no in-app UI, nothing shipped in release
builds. The simulation is driven from the bundled **Flutter DevTools
extension**, from Dart through `DevicePreview.controller`, or from widget
tests via `DevicePreviewBindingMixin`.

Highlights, relative to 2.x:

- **One-line integration**: `DevicePreview.enable(); runApp(MyApp());` — no
  builder wrapper, no `useInheritedMediaQuery`, no `locale`/`builder` glue on
  your `MaterialApp`. Off in release builds by default, with zero footprint.
- **Full framework fidelity**: because the simulation sits below the widget
  layer, safe areas, hit-testing, locale resolution, text scaling and
  accessibility flags behave exactly as they do on device — including
  third-party packages that never heard of Device Preview.
- **The UI moved to DevTools**: a device picker with framed previews, locale
  and accessibility controls, orientation, text scale, dark mode, a
  screenshot button, and a "New device from JSON…" entry that saves custom
  devices in the browser.
- **Programmatic + test control**: `applyPreset`, `setOrientation`,
  `update(copyWith)`, `applyJson`, `registerPreset`, `reset` — and the same
  simulation in widget tests for golden matrices over many devices.
- **A rebuilt device catalog** (33 devices): every Apple frame and metric is
  extracted from the real iOS Simulator (Xcode 26.6 / iOS 26.5) and the
  Pixels from the official Android emulator skins (Android 16), artwork
  included; four foldables report their hinge as a display feature; generic
  phone/tablet/desktop windows round it out. Presets carry their frame and
  simulated system UI and tree-shake away when unreferenced.
- **Device frames & system UI in-app too**: `applyPreset` shows the framed
  device with a live-tinted status bar and gesture pill even without DevTools
  attached (goldens, CI), painted over the default `DotGridDecoration`
  letterbox.
- **Touch input simulation**: the mouse is reported to the app as a finger on
  touch devices (auto by default), so drags scroll and gestures take their
  touch paths.
- **A simulated software keyboard**: every device carries the height its
  keyboard covers, per orientation — probed from its own simulator for the
  iPhones and iPads, one shared default for the Android devices, whose
  keyboard height belongs to the installed IME — and one switch in DevTools (or
  `DeviceSimulation.keyboardInset` from Dart) raises it. It arrives as
  `MediaQuery.viewInsets.bottom`, so `resizeToAvoidBottomInset`,
  scroll-into-view and the collapsing bottom safe area all behave as they do
  on the device — which is how a form gets checked against the keyboard from
  a desktop that has none. While a device is simulated it is also the *only*
  keyboard the app sees: the host's own keyboard inset is no longer mapped
  into the simulated screen, where it stood for a length of the wrong
  display.
- The simulated system bars now follow the **simulated device's** operating
  system, not the host's: `SystemUiSimulation.platform` (stamped from the
  preset by `DevicePreset.resolve` and by the DevTools panel) decides the
  platform-specific paint behavior, so an app running on an Android host no
  longer tints a simulated iPhone's status bar and home-indicator band with
  its Android `SystemUiOverlayStyle` background colors.

Breaking (from the prereleases, for completeness): `DevicePreview.enable`'s
flag is the named `enabled` parameter; iPad preset ids/names carry their chip
(`iPadPro11M4`, …); minimum Flutter is 3.47.0 / Dart 3.8.

## 3.0.0-prerelease6

- The iPhone SE (3rd gen) home button ring is now a dark grey instead of the
  white Xcode strokes it with, so it no longer glows against the dark
  letterbox.

## 3.0.0-prerelease5

- The built-in `DevicePresets` are now generated from the shared device spec
  catalog (`device_specs/` at the repository root) and carry the **complete
  spec — frame artwork and system UI included** — identical to what the
  DevTools panel pushes. `applyPreset` therefore shows the framed device
  without DevTools attached (golden tests, CI). Every preset keeps its name
  and id; unreferenced presets still tree-shake away, artwork included.
  Regenerate with `dart run tool/generate_presets.dart` after editing a spec
  (a guard test fails when the checked-in catalog is stale).
- The area around the simulated device is now painted by default with the
  new `DotGridDecoration`: a dark grey with a subtle dot pattern (in real
  pixels, so its density does not change with the device or the fit scale),
  which keeps dark device bodies readable where the engine's plain black
  swallowed them. `DevicePreview.enable`'s `backgroundDecoration` now
  accepts any `Decoration` (not only `BoxDecoration`), is painted in real
  logical pixels, and `null` now explicitly leaves the area unpainted.
- New `DevicePreviewController.applyJson(json)`: decodes a device spec
  (a JSON string or map in the `device_specs/*.json` / `DevicePreset.toJson()`
  format, frame artwork and system UI included), registers it as a preset and
  applies it.
- DevTools: the device picker gains a "New device from JSON…" entry. Pasted
  specs are validated, applied immediately, saved in the browser and listed
  under "My devices" in later sessions (with a remove button).
- The Apple catalog now mirrors the iOS 26.5 simulator line-up (21 devices,
  33 in all), every one derived from its real simulator: added iPhone 17 Pro
  Max, iPhone SE (3rd gen) — back as `DevicePresets.iPhoneSe3`, with the
  Home-button chassis, a 20 pt status bar and no other safe area — iPad Pro
  11"/13" (M5), iPad Air 11"/13" (M2) and (M4), iPad (A16) and iPad (10th
  gen). The iPad Airs' M3 entries became the M4 generation (same chassis and
  metrics). Removed iPhone 16e (`DevicePresets.iPhone16e`), which Xcode no
  longer offers as an iOS 26.5 destination.
- **Breaking**: the iPad ids and preset names now carry their chip so the
  generations can coexist: `apple-ipad-pro-11` → `apple-ipad-pro-11-m4`
  (`DevicePresets.iPadPro11M4`), `apple-ipad-air-11` →
  `apple-ipad-air-11-m4` (`iPadAir11M4`), and likewise for the 13" models;
  `apple-ipad-mini` keeps its id but is named "iPad mini (A17 Pro)".

## 3.0.0-prerelease4

- The iPhone and iPad frames are now derived from the official iOS
  Simulator bezel artwork (Xcode's "Show Device Bezels" chrome): exact
  body sizes, bezel borders, Apple's own outer corner radii, and the true
  continuous-curvature display outlines from the simulator framebuffer
  masks, notch and Dynamic Island included. See
  `.claude/skills/extract-cupertino-specs/` for the extraction process.
- Apple metrics are now verified against a live simulator: a probe app is
  booted per device type and reports the safe areas UIKit actually applies.
  The iPhone values were confirmed exact; every iPad's bottom safe-area
  inset was corrected from 20 to 25 logical pixels (both orientations), in
  the specs and the built-in `DevicePresets`.
- Every Apple device in the catalog now has its own real simulator (Xcode
  26.6 device profiles, probed on iOS 26.5): the iPhone 16e, 17, 17 Pro,
  17e and Air no longer borrow another model's artwork or hand-modelled
  metrics — the 16e/17e notch outline and the Air's squircle come from
  Apple's own framebuffer masks, and the iPad Airs use the M3 chassis (59
  pt bezel). Safe areas follow iOS 26: every iPad's top inset is 32 (was
  24), landscape iPhones report a 20 pt bottom inset (was 21), and the
  iPhone Air's Dynamic Island band is 68 (was 62). Specs, `DevicePresets`,
  fixtures and the bundled catalog updated together.
- The Google Pixel specs are now derived the same way, by an Android
  counterpart skill (`.claude/skills/extract-pixel-specs/`): frame artwork,
  screen shape and the camera punch-hole cutout come from the official
  emulator device skins (Android Studio 2026.1), and the metrics from a
  booted Android 16 emulator. Pixel 9/10 sizes are now the exact
  411.43×923.43 a device reports (was the rounded 412×923), the fold is
  851.69×882.87 with its crease recentred accordingly, and the safe areas
  match today's Android 16 system bars — including its taller status bar
  (54 dp portrait / 52 landscape on the slabs; 36/56 on the fold, bottom
  24 and 32 respectively). Specs, built-in `DevicePresets` and the bundled
  catalog all updated together; the frames now show each device's punch
  hole (top-centre on the slabs, top-right on the fold's inner display).
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

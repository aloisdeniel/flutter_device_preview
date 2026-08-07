# Judge Scores

| Criterion (1–10) | Design A (minimalist) | Design B (maximalist) |
|---|---|---|
| SDK-correctness vs. researched 3.44 internals | **9** — every claim matches the research; gesture-slop formula omits fit-scale | **9** — equally well-cited; letterbox "paint outside bounds" and `OffsetLayer.toImage` claims are the two spots not backed by the research |
| Robustness across Flutter versions | **9** — smallest surface, compile-loud drift strategy, nothing depends on unclipped roots | **7** — letterbox chrome, screenshot, and the pointer policy state machine each add version-sensitive assumptions |
| API ergonomics | **7.5** — clean but atomic-override a11y struct is awkward; no partial-update helper; binding-hosted API mixes concerns | **8.5** — controller + `update(mutate)`, tri-state a11y flags, `initialSimulation` for CI are all better; options object slightly over-engineered |
| DevTools protocol quality | **7** — sound but no versioning, no echo suppression, no restart re-push | **9** — `protocolVersion`, `capabilities`, `requestId` echo, `ready` event, restart re-push are exactly right |
| Testability | **8** — excellent pure-unit decomposition; but the real binding only ever runs in one e2e smoke | **8.5** — same decomposition **plus** the mixin (`TestDevicePreviewBinding` on the test binding) which closes A's biggest gap |

**Verdict**: A's core (three override seams, stateless pointer remap, no letterbox chrome, compile-loud wrappers) is the right skeleton. B wins on API shape (controller, tri-state a11y, mixin), protocol design, viewInsets mapping, and the fit-scale-aware gesture-slop formula. The synthesis below is A's core with B's controller/protocol/testing grafted on; letterbox painting and the pointer policy machine are cut; screenshot is a capability-flagged optional module.

---

# device_preview 3.0 — Final Design Document

A custom `WidgetsBinding` that simulates device characteristics (screen metrics, safe areas, locale, brightness, text scale, accessibility flags, target platform) at the engine-abstraction level. **No in-app UI.** Driven programmatically and by a DevTools extension over VM service extensions. All SDK file:line references are Flutter 3.44.0 per the research report.

**Design invariants (non-negotiable for implementers):**

1. Exactly **three framework override seams**: `BindingBase.platformDispatcher` (getter, `foundation/binding.dart:249`), `RendererBinding.createViewConfigurationFor` (`rendering/binding.dart:369`), `BindingBase.initServiceExtensions`. Nothing else in the framework is overridden — no `handlePointerEvent`, no `hitTestInView`. *(As built: device frames added a fourth, `wrapWithDefaultView` — see §8.1.)*
2. Wrapper objects use `implements` + explicit delegation, **no `noSuchMethod`**. SDK interface drift is a compile error by design — loud, immediate, trivially fixable (the same trade flutter_test accepts).
3. One `PreviewPlatformDispatcher` and one `PreviewFlutterView` instance for process lifetime (identity is load-bearing: `platform_dispatcher.dart:243-251`, `widgets/view.dart:908-911`).
4. When disabled, the `platformDispatcher` getter returns the host dispatcher directly — zero interposition, behaviorally identical to `WidgetsFlutterBinding`.
5. All simulation state and math lives outside the binding in pure, binding-free, unit-testable classes. The binding is a thin composition shell.

---

## 1. Package / repo layout

```
repo/
  device_specs/                            # device catalog SOURCE: one JSON per device (metrics + frame artwork)
  device_preview/                          # THE published package (depends on flutter only)
    lib/
      device_preview.dart                  # public API (binding, mixin, controller, simulation, frame)
      presets.dart                         # DevicePreset + catalog (separate library, tree-shakable)
      svg.dart                             # embedded SVG subset renderer (separate library)
      test_support.dart                    # TestDevicePreviewBinding + debugInjectPointerData
      src/
        binding/
          binding.dart                     # DevicePreview + DevicePreviewBindingMixin
          preview_platform_dispatcher.dart # implements ui.PlatformDispatcher
          preview_flutter_view.dart        # implements ui.FlutterView
          preview_values.dart              # PreviewViewPadding, PreviewAccessibilityFeatures
          preview_view_configuration.dart  # ViewConfiguration subclass (fit matrix)
        model/
          simulation.dart                  # DeviceSimulation, SimulatedAccessibilityFeatures, JSON
          real_device_info.dart
          fit_transform.dart               # pure fit math + pointer inverse mapping
          pointer_rewrite.dart             # pure PointerData rewrite function
        controller/
          controller.dart                  # DevicePreviewController (concrete)
        service/
          protocol.dart                    # pure request handlers (no dart:developer)
          extensions.dart                  # registerExtension glue + postEvent
          screenshot.dart                  # OPTIONAL MODULE (capability-flagged, isolated)
    extension/
      devtools/
        config.yaml
        build/                             # committed pre-compiled web output
        .pubignore                         # "!build" (build/ is gitignored but pub-included)
    example/
    test/

  device_preview_devtools_extension/       # Flutter web app, publish_to: none, NEVER published
    lib/
      main.dart
      src/
        gateway.dart                       # the only file touching serviceManager
        panel_controller.dart              # ChangeNotifier mirroring app state
        panel.dart                         # single-screen UI, sections as private widgets
```

**Decision — no shared protocol package.** The extension app does not import `device_preview` and there is no `device_preview_protocol` package. The extension fetches the preset catalog and all state from the running app over the VM service, treats JSON loosely (unknown keys ignored), and pins compatibility via `protocolVersion`. Rationale: one published package; catalog/protocol can never version-skew because the app is the single source of truth.

Dependencies: `device_preview` → `flutter` only (`sdk: '>=3.8.0 <4.0.0'`, `flutter: '>=3.44.0'` — **no hard upper Flutter bound**; drift is handled by beta-channel CI and fast patch releases, not by constraint solving). Extension app → `devtools_extensions: ^0.5.1`, `devtools_app_shared: ^0.5.1`.

`extension/devtools/config.yaml`:

```yaml
name: device_preview
issueTracker: https://github.com/aloisdeniel/flutter_device_preview/issues
version: 3.0.0
materialIconCodePoint: '0xe154'   # Icons.devices
requiresConnection: true
```

Build pipeline (CI): `dart run devtools_extensions build_and_copy --source=. --dest=../device_preview/extension/devtools` then `dart run devtools_extensions validate --package=../device_preview`.

---

## 2. Public API sketch

```dart
// ---------------------------------------------------------------------------
// package:device_preview/device_preview.dart
// Public surface: 2 binding types, 1 controller, 4 value types.
// ---------------------------------------------------------------------------

/// Drop-in replacement for [WidgetsFlutterBinding] that can simulate the
/// characteristics of another device.
///
/// ```dart
/// void main() {
///   DevicePreview.enable();
///   runApp(const MyApp()); // completely unmodified
/// }
/// ```
///
/// When [enabled] is false (the default in release builds), no wrapper
/// objects are installed and the binding is behaviorally identical to
/// [WidgetsFlutterBinding].
class DevicePreview extends BindingBase
    with GestureBinding, SchedulerBinding, ServicesBinding, PaintingBinding,
        SemanticsBinding, RendererBinding, WidgetsBinding,
        DevicePreviewBindingMixin {

  /// Enables simulation, then initializes (once) and returns the ambient
  /// binding.
  ///
  /// [enabled] is latched forever at first call. When null — the default —
  /// it resolves to `!kReleaseMode`: on in debug and profile, off in
  /// release (target-platform simulation stays debug-only regardless).
  ///
  /// To start under a given simulation before the first frame (golden/CI
  /// scenarios without DevTools), apply it through the controller straight
  /// after enabling, or latch one via
  /// `DevicePreviewBindingMixin.latchConfiguration`.
  static WidgetsBinding enable([bool? enabled]);

  /// The active controller, or null when the ambient binding is not a
  /// device-preview binding or simulation is disabled.
  static DevicePreviewController? get maybeController;

  /// The active controller. Throws [StateError] when unavailable.
  static DevicePreviewController get controller;
}

/// The simulation machinery as a mixin, so it can be layered onto other
/// binding stacks (test / integration-test bindings). Apply it LAST.
mixin DevicePreviewBindingMixin
    on BindingBase, GestureBinding, SchedulerBinding, ServicesBinding,
       PaintingBinding, SemanticsBinding, RendererBinding, WidgetsBinding {

  /// Whether simulation machinery is installed. Latched before init.
  bool get simulationEnabled;

  /// The controller, or null when [simulationEnabled] is false.
  DevicePreviewController? get devicePreview;

  @override
  ui.PlatformDispatcher get platformDispatcher; // wrapper over super's, or super's

  @override
  ViewConfiguration createViewConfigurationFor(RenderView renderView);

  @override
  void initServiceExtensions(); // registers ext.device_preview.* (!kReleaseMode)
}

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

/// Programmatic control surface. All mutation methods are safe any time
/// after binding initialization; returned futures complete when the change
/// has fully propagated (only [DeviceSimulation.targetPlatform] changes do
/// heavy work — a debug-only reassemble).
abstract class DevicePreviewController implements Listenable {
  /// The active simulation, or null when passing through (real device).
  DeviceSimulation? get simulation;
  ValueListenable<DeviceSimulation?> get simulationListenable;

  /// Metrics of the real host device (never simulated, always live).
  RealDeviceInfo get realDevice;

  /// The current scale-to-fit mapping. [FitTransform.identity] when no
  /// metric simulation is active.
  FitTransform get fitTransform;

  /// Replaces the active simulation wholesale. `null` fields = real device.
  Future<void> apply(DeviceSimulation simulation);

  /// Partial update on top of the current simulation (empty simulation if
  /// none active):
  /// `await c.update((s) => s.copyWith(platformBrightness: Brightness.dark));`
  Future<void> update(DeviceSimulation Function(DeviceSimulation current) mutate);

  /// Builds a simulation from [preset] and applies it, preserving active
  /// non-metric overrides (locale, brightness, text scale, accessibility,
  /// platform) unless [resetOverrides] is true.
  Future<void> applyPreset(
    DevicePreset preset, {
    Orientation orientation = Orientation.portrait,
    bool resetOverrides = false,
  });

  /// Swaps screen dimensions and rotates safe areas (uses the preset's
  /// per-orientation safe areas when [DeviceSimulation.presetId] resolves,
  /// else the documented rotation rule).
  Future<void> setOrientation(Orientation orientation);

  /// Clears the simulation entirely (pass-through).
  Future<void> reset();

  /// Presets reported to DevTools. Seeded with [DevicePresets.all].
  List<DevicePreset> get presets;

  /// Appends a custom preset and posts `device_preview.presetsChanged`.
  void registerPreset(DevicePreset preset);
}

// ---------------------------------------------------------------------------
// Simulation model (pure Dart values, JSON round-trippable)
// ---------------------------------------------------------------------------

/// Immutable set of simulated characteristics. Every field is optional;
/// null = "use the real device value" (merged live — real-device changes
/// keep propagating for null fields).
@immutable
class DeviceSimulation {
  const DeviceSimulation({
    this.presetId,                    // informational; round-tripped to DevTools
    this.orientation = Orientation.portrait, // orientation the metric fields are in
    this.screenSize,                  // simulated LOGICAL size, orientation-resolved
    this.devicePixelRatio,
    this.padding,                     // MediaQuery.padding, logical px
    this.viewPadding,                 // defaults to [padding] when null and screenSize != null
    this.systemGestureInsets,         // logical px; zero while simulating if null
    this.displayFeatures,             // folds/hinges/cutouts, logical px
    this.locales,                     // first entry = PlatformDispatcher.locale
    this.platformBrightness,
    this.textScaleFactor,             // linear; drives textScaleFactor AND scaleFontSize
    this.accessibility,               // tri-state flags, see below
    this.alwaysUse24HourFormat,
    this.targetPlatform,              // DEBUG-ONLY (reassemble); capability-flagged
  });

  final String? presetId;
  final Orientation orientation;
  final Size? screenSize;
  final double? devicePixelRatio;
  final EdgeInsets? padding;
  final EdgeInsets? viewPadding;
  final EdgeInsets? systemGestureInsets;
  final List<SimulatedDisplayFeature>? displayFeatures;
  final List<Locale>? locales;
  final Brightness? platformBrightness;
  final double? textScaleFactor;
  final SimulatedAccessibilityFeatures? accessibility;
  final bool? alwaysUse24HourFormat;
  final TargetPlatform? targetPlatform;

  bool get isEmpty;                    // all fields null
  bool get simulatesMetrics;           // screenSize != null

  /// Sentinel-based copyWith: `copyWith(textScaleFactor: null)` CLEARS the
  /// override (implemented with a private `_unset` sentinel default).
  DeviceSimulation copyWith({...});

  Map<String, Object?> toJson();       // null fields absent
  factory DeviceSimulation.fromJson(Map<String, Object?> json); // unknown keys ignored
  // ==, hashCode, toString over all fields.
}

/// Tri-state accessibility flags: null = real device value for that flag.
@immutable
class SimulatedAccessibilityFeatures {
  const SimulatedAccessibilityFeatures({
    this.accessibleNavigation, this.invertColors, this.disableAnimations,
    this.boldText, this.reduceMotion, this.highContrast, this.onOffSwitchLabels,
  });
  final bool? accessibleNavigation;
  final bool? invertColors;
  final bool? disableAnimations;
  final bool? boldText;
  final bool? reduceMotion;
  final bool? highContrast;
  final bool? onOffSwitchLabels;
  // copyWith, ==, hashCode, toJson/fromJson
}

/// dart:ui-free, JSON-serializable mirror of ui.DisplayFeature (logical px).
@immutable
class SimulatedDisplayFeature {
  const SimulatedDisplayFeature({
    required this.bounds, required this.type, required this.state,
  });
  final Rect bounds;
  final ui.DisplayFeatureType type;
  final ui.DisplayFeatureState state;
  // toJson/fromJson, ==, hashCode
}

/// Read-only live snapshot of the real host device.
@immutable
class RealDeviceInfo {
  final Size logicalSize;
  final Size physicalSize;
  final double devicePixelRatio;
  final EdgeInsets padding;
  final List<Locale> locales;
  final Brightness platformBrightness;
  final double textScaleFactor;
  final TargetPlatform targetPlatform;
  Map<String, Object?> toJson();
}

/// Pure value: the scale-to-fit mapping. Exposed for tests and overlays.
@immutable
class FitTransform {
  const FitTransform({required this.scale, required this.offset});
  static const FitTransform identity = FitTransform(scale: 1, offset: Offset.zero);
  final double scale;    // simulated-logical → real-logical (uniform, ≤ 1.0)
  final Offset offset;   // letterbox origin in real logical px
  Offset toRealLogical(Offset simulatedLogical);
  Offset toSimulatedLogical(Offset realLogical);
}

// ---------------------------------------------------------------------------
// package:device_preview/presets.dart
// ---------------------------------------------------------------------------

/// Metrics-only description of a device. No frame artwork, no images.
@immutable
class DevicePreset {
  const DevicePreset({
    required this.id,                  // stable, e.g. 'apple-iphone-16-pro'
    required this.name,                // 'iPhone 16 Pro'
    required this.platform,
    required this.portraitSize,        // logical px
    required this.devicePixelRatio,
    this.portraitPadding = EdgeInsets.zero,
    this.portraitViewPadding,          // defaults to portraitPadding
    this.landscapePadding,             // null → derived by the rotation rule
    this.landscapeViewPadding,
    this.systemGestureInsets = EdgeInsets.zero,
    this.displayFeatures = const [],   // foldables
    this.kind = DeviceKind.phone,
  });

  /// Resolves into a metric-only [DeviceSimulation] (presetId set).
  DeviceSimulation resolve({Orientation orientation = Orientation.portrait});

  Map<String, Object?> toJson();
  factory DevicePreset.fromJson(Map<String, Object?> json);
}

enum DeviceKind { phone, tablet, foldable, desktop }

/// Built-in catalog (~15 static const entries; unreferenced ones tree-shake).
abstract final class DevicePresets {
  static const DevicePreset iPhoneSe3 = ...;
  static const DevicePreset iPhone16 = ...;
  static const DevicePreset iPhone16Pro = ...;
  static const DevicePreset iPhone16ProMax = ...;
  static const DevicePreset iPadPro13 = ...;
  static const DevicePreset iPadMini = ...;
  static const DevicePreset pixel8 = ...;
  static const DevicePreset pixel9 = ...;
  static const DevicePreset pixelTablet = ...;
  static const DevicePreset galaxyS24 = ...;
  static const DevicePreset smallDesktopWindow = ...;   // 1024×640 @1x
  static const DevicePreset largeDesktopWindow = ...;   // 1920×1080 @2x
  static const List<DevicePreset> all = [...];
  static DevicePreset? byId(String id);
}
```

**Rotation rule** (when a preset-less simulation or a preset without `landscapePadding` is rotated to landscape): `landscape.padding = EdgeInsets.only(left: portrait.top, right: portrait.top, bottom: portrait.bottom)` (notch mirrored to both sides, home indicator kept). Same rule for `viewPadding`.

Usage:

```dart
void main() {
  DevicePreview.enable();
  runApp(const MyApp());
}

final c = DevicePreview.controller;
await c.applyPreset(DevicePresets.iPhoneSe3);
await c.update((s) => s.copyWith(textScaleFactor: 2.0, platformBrightness: Brightness.dark));
await c.setOrientation(Orientation.landscape);
await c.reset();
```

---

## 3. Internal architecture

### 3.1 Interposition layer (the core)

**Seam 1 — `platformDispatcher` getter.** The mixin overrides it:

```dart
@override
ui.PlatformDispatcher get platformDispatcher {
  if (!simulationEnabled) return super.platformDispatcher;
  return _dispatcher ??= PreviewPlatformDispatcher(host: super.platformDispatcher, state: _state);
}
```

Lazy `??=` creation inside the getter eliminates all init-order concerns (`GestureBinding.initInstances` reads the getter first; `renderView` is `late final` on `platformDispatcher.implicitView!` at `rendering/binding.dart:301` — both resolve through the override from the first touch). Delegating to **`super.platformDispatcher`** (not `ui.PlatformDispatcher.instance`) is what makes the mixin layerable over `TestWidgetsFlutterBinding`'s `TestPlatformDispatcher` in tests. Per the research §1 registration table, every binding callback registration, `wrapWithDefaultView`'s `platformDispatcher.implicitView!` (`widgets/binding.dart:1628-1650`), and the deprecated `renderView` route through this one getter. The direct `PlatformDispatcher.instance` uses in the framework are audited harmless (frame scheduling, messaging, announce).

**`PreviewPlatformDispatcher implements ui.PlatformDispatcher`** — one cached instance forever, no `noSuchMethod`:

- **Simulatable getters** (`locale`, `locales`, `platformBrightness`, `textScaleFactor`, `accessibilityFeatures`, `alwaysUse24HourFormat`): return `simulated ?? host`. `accessibilityFeatures` returns a `PreviewAccessibilityFeatures implements ui.AccessibilityFeatures` merging tri-state simulated flags over the host's flags (private upstream ctor — flutter_test fake pattern; must implement `supportsAnnounce`, `autoPlayAnimatedImages`, `autoPlayVideos`, `deterministicCursor` as host-delegating).
- **`scaleFontSize(x)`**: `simTextScale != null ? x * simTextScale : host.scaleFontSize(x)`. Overridden **atomically with** `textScaleFactor` — `SystemTextScaler` binds the dispatcher at construction, calls `scaleFontSize` per measurement, and keys equality on `textScaleFactor` (`media_query.dart:2408-2414`). Linear only.
- **`computePlatformResolvedLocale(supported)`**: when locales are simulated, run the framework's basic best-match algorithm against the simulated list; else delegate (`WidgetsApp` calls it at `widgets/binding.dart:1751`).
- **`implicitView`**: cached `PreviewFlutterView`. **`view(id:)`**: returns the wrapper when `id == host.implicitView!.viewId`, else delegates — mandatory: a null return **drops pointer events** (`converter.dart:69-71`). **`views`**: host views with the implicit one swapped for the wrapper (secondary views pass through untouched — multi-view is explicitly unsupported for simulation).
- **Callback setters — store-and-forward**: setting `onX` stores the framework's callback and registers a trampoline on the host. Trampoline policy per field: if that dimension is currently simulated, refresh cached real values (so `realDevice` and null-field merging stay live) and **swallow** the upward notification; otherwise **forward**. The real `onMetricsChanged` trampoline additionally always recomputes `FitTransform` (window resize / host rotation changes the fit) and calls `handleMetricsChanged()` when metric simulation is active.
- **`onPointerDataPacket` setter**: stores the framework handler; registers the rewriting trampoline (§3.3) on the host.
- **Everything with engine side effects** (`sendPlatformMessage`, `scheduleFrame`, `updateSemantics`, `setSemanticsTreeEnabled`, `setApplicationLocale`, `requestViewFocusChange`, `registerBackgroundIsolate`, …): pure delegation.

**`PreviewFlutterView implements ui.FlutterView`** — one cached instance forever:

- `viewId` = **real** implicit viewId (load-bearing: pointer `datum.viewId`, `_viewIdToRenderView` keying at `rendering/binding.dart:343-349`, render/semantics natives, `ViewFocusEvent`).
- When `simulatesMetrics`: `physicalSize` = simLogical × simDPR; `devicePixelRatio` = simDPR; `physicalConstraints` = `ViewConstraints.tight(simPhysical)` (public ctor); `padding` / `viewPadding` = `PreviewViewPadding implements ui.ViewPadding` (config logical × simDPR; fake pattern — private upstream ctor); `systemGestureInsets` = simulated value or zero; `displayFeatures` = simulated list or `const []`; `displayCornerRadii` = `null` (interface member new in 3.44 — must be implemented).
- **`viewInsets`** (keyboard): NOT forced to zero. The real inset is mapped into simulated space: `simInsetLogical = hostInsetPhysical / realDPR / fit.scale`, returned as `PreviewViewPadding` at simDPR. Real inset changes arrive via the real `onMetricsChanged` trampoline → `handleMetricsChanged()`. Text fields keep avoiding the real keyboard; geometry is host-faithful, not device-faithful (documented).
- **`gestureSettings`**: `GestureSettings(physicalTouchSlop: hostSlop / realDPR / fit.scale * simDPR)` — because `DeviceGestureSettings.fromView` divides by the wrapper's (simulated) DPR (`gestures/gesture_settings.dart:29-34`), this makes a drag require the same **physical finger travel on the real screen** as without simulation. (Fit-scale term included — B's formula, adopted over A's.)
- `display` = delegate (nothing in the framework reads it).
- **`render(scene, {size})`**: delegate to the host view, passing `size: realPhysicalSize` explicitly (belt-and-braces with `toPhysicalSize`, §3.2). **`updateSemantics`**: delegate.
- When `simulation == null`, every member is a one-line delegation.

### 3.2 Scale-to-fit rendering

Pure math (`fit_transform.dart`), recomputed on every apply and every real metrics change:

```
realLogical = host.physicalSize / realDPR
scale  = min(realLogical.w / simLogical.w, realLogical.h / simLogical.h).clamp(0, 1)
offset = (realLogical − simLogical × scale) / 2      // centered letterbox, real logical px
```

**Decision — no upscaling** (scale clamped ≤ 1): a simulated screen smaller than the host renders 1:1 centered. Rationale: upscaled text/AA looks wrong and misleads previews; no option flag, keep the surface small.

**Seam 2 — `createViewConfigurationFor`** returns, for RenderViews whose `flutterView` is our wrapper **and** metrics are simulated, a `PreviewViewConfiguration extends ViewConfiguration` (public const superclass, `rendering/view.dart:24`); otherwise `super`:

- `logicalConstraints = BoxConstraints.tight(simLogicalSize)` — root layout is exactly the simulated size (`rendering/view.dart:195-203, 288-296`).
- `toMatrix()` = `translate(offset × realDPR) · scale(realDPR × fit.scale)` — becomes the root `TransformLayer` (`view.dart:267-274`) and folds into `applyPaintTransform` (`view.dart:333-337`), so painting, `localToGlobal`, and **semantics geometry** stay consistent for free.
- `shouldUpdateMatrix(old)` compares full matrices (base class compares only DPR — insufficient).
- `toPhysicalSize(_)` = **real** `physicalSize` — the default would compute simulated-physical, which is an undefined-rendering bug (`compositeFrame` passes it to `render`, research §3/§8.5). Debug-asserted.

Activation: `handleMetricsChanged()` reassigns per-view configuration and forces a frame (`rendering/binding.dart:401-415`).

**Decision — letterbox is engine clear color (black).** No `wrapWithDefaultView` chrome, no painting outside bounds. B's `_LetterboxChrome` depends on the root never clipping — an undocumented invariant. Cut; revisit only on demonstrated demand.

### 3.3 Pointer remapping

Single interception point: the trampoline registered on the host's `onPointerDataPacket`. A **pure function** (`pointer_rewrite.dart`) rewrites each `ui.PointerData` (public const ctor) before invoking the stored framework handler:

```
realLogical    = (physicalX, physicalY) / realDPR
simLogical     = (realLogical − fit.offset) / fit.scale
physicalX'/Y'  = simLogical × simDPR         // converter.dart:62-80 divides by the
                                             // wrapper view's simDPR → simLogical
k              = simDPR / (realDPR × fit.scale)
physicalDelta' = physicalDelta × k
radiusMajor/Minor/Min/Max, pan, panDelta, scrollDelta: × k   // converter.dart:77-80, 250-252, 284
viewId: untouched (real id → matches _viewIdToRenderView)
```

Hit testing receives positions **untransformed** by the root matrix (`rendering/view.dart:307-311`, `rendering/binding.dart:674-678`), so simulated-logical positions are exactly right for hit tests, recognizers, and MouseTracker hover (same `hitTestInView` path, `rendering/binding.dart:455-461`).

**Decision — no letterbox pointer policy machine.** Events landing in the letterbox map to out-of-bounds simulated coordinates, miss hit testing, and are naturally inert; in-progress gestures wandering outside behave like drags off-screen on a real device (Flutter handles this). Stateless, no clamping, no synthetic cancels. When `simulation == null` or `!simulatesMetrics`, the trampoline forwards the packet object untouched (zero allocation fast path).

Test seam: `@visibleForTesting debugInjectPointerData(ui.PointerDataPacket)` in `test_support.dart` invokes the trampoline directly.

### 3.4 Change propagation

`DevicePreviewController.apply/update/reset` diffs old vs. new and calls only the binding's own `@protected` handlers (research §5 — never `reassembleApplication` except for platform):

| Changed fields | Trigger |
|---|---|
| screenSize / devicePixelRatio / padding / viewPadding / systemGestureInsets / displayFeatures / orientation / alwaysUse24HourFormat | recompute `FitTransform`, then `handleMetricsChanged()` |
| textScaleFactor | `handleTextScaleFactorChanged()` |
| platformBrightness | `handlePlatformBrightnessChanged()` |
| locales | `handleLocaleChanged()` |
| accessibility | `handleAccessibilityFeaturesChanged()` (re-caches in `SemanticsBinding`, `semantics/binding.dart:207-209`) |
| targetPlatform | `debugDefaultTargetPlatformOverride = x; await reassembleApplication()` — **kDebugMode only**; in profile, reports a `FlutterError` and the field is surfaced as unsupported in `capabilities` |

MediaQuery rebuild happens through the stock chain: handler → observer notification → `_MediaQueryFromViewState._updateData()` → fresh `MediaQueryData.fromView(wrapperView)` (`media_query.dart:2288-2367`) — `fromView` reads only `view.*` and `view.platformDispatcher.*` (`media_query.dart:299-352`), so the wrapper pair covers 100% of MediaQuery. After propagation: notify `simulationListenable`, post `device_preview.stateChanged`.

Debug diagnostic: applying a brightness simulation while `debugBrightnessOverride != null` prints a one-time `FlutterError` hint (they silently compete in `media_query.dart:2377-2384`).

### 3.5 Screenshot (OPTIONAL MODULE — capability-flagged, failure-isolated)

`ext.device_preview.screenshot` renders `renderView.layer` (the root `TransformLayer`, an `OffsetLayer`) via `toImage(bounds, pixelRatio:)`: bounds = `fit.offset × realDPR & simLogical × fit.scale × realDPR`; `pixelRatio = simDPR / (fit.scale × realDPR)` → exactly simLogical × simDPR pixels; PNG → base64. Entirely inside `service/screenshot.dart`; any failure returns a protocol error envelope and can never affect the simulation core. Advertised via `capabilities.screenshot`; DevTools hides the button when false. This is the **only** optional module in v1.

### 3.6 Threat matrix

| Threat | Mitigation |
|---|---|
| New `PlatformDispatcher`/`FlutterView` interface members in future SDKs | No `noSuchMethod` → compile break; beta-channel CI compile job; fast patch release. Same exposure flutter_test accepts. |
| Wrapper identity churn (`implicitView` assert, `_DeprecatedRawViewKey` identical-check) | Both wrappers `late final` singletons; never recreated. |
| `renderView` initialized before override active | Getter override is live from first touch (lazy `??=` in getter); our code never touches `renderView` during init. |
| Pointer events dropped (`view(id:)` → null) | Wrapper maps the real implicit id; unit-tested. |
| `render` with simulated physical size → undefined rendering | `toPhysicalSize` **and** explicit `size:` in the wrapper's `render` both use real physical size; debug assert. |
| Stale `SystemTextScaler` | `textScaleFactor` + `scaleFontSize` changed atomically, then `handleTextScaleFactorChanged()`. |
| Real device changes lost while simulating | Store-and-forward trampolines: swallow only simulated dimensions, always refresh cached real values, always recompute fit on real metrics changes. |
| Touch slop wrong under simulated DPR + fit scale | Rescaled `GestureSettings` (§3.1 formula, fit-scale-aware). |
| Third-party code holding raw `ui.PlatformDispatcher.instance` | Framework-internal uses audited clean; third-party reads see real values — documented limitation. `viewId` equality covers all hit-test/render paths. |
| `_updateSystemChrome` probes simulated padding → status-bar style follows simulated layout | Cosmetic; documented. |
| Multi-view / `runWidget` apps | Secondary views pass through untouched; documented as unsupported for simulation. Unknown protocol keys ignored = forward-compatible if per-view simulation ever lands. |
| Release safety | `enabled` resolves to `!kReleaseMode` when null; disabled path returns host dispatcher directly; extensions inside `if (!kReleaseMode)` → tree-shaken. |

---

## 4. Service extension protocol

All registered via raw `developer.registerExtension` (own `ext.device_preview.` prefix — never `ext.flutter.`), inside `if (!kReleaseMode)` so release builds tree-shake them. All request params are strings (VM contract): complex payloads travel as one JSON-encoded string param. Handlers never throw: failures return `{"error": {"code", "message"}}` inside a success response; only malformed JSON returns `ServiceExtensionResponse.error(invalidParams, …)`. Target platform is carried in `simulation.targetPlatform` and applied app-side — DevTools never calls `ext.flutter.platformOverride` (one writer).

`protocolVersion` is **2**: version 1 shipped without `simulation.frame` (the screen outline and body artwork) and without the `frame` capability flag. Both are additive — a version-1 panel talking to a version-2 app simply never sends a frame.

### Methods

| Method | Args | Result |
|---|---|---|
| `ext.device_preview.getState` | — | **State shape** (below) |
| `ext.device_preview.setSimulation` | `{"simulation": "<JSON of DeviceSimulation.toJson() or null>", "requestId": "<opaque string, optional>"}` | State shape. `"null"` = reset. Unknown JSON keys ignored (forward compat). |
| `ext.device_preview.reset` | — | State shape |
| `ext.device_preview.listPresets` | — | `{"presets": [DevicePreset.toJson(), …]}` (built-ins + registered customs) |
| `ext.device_preview.screenshot` *(optional module)* | `{"pixelRatio": "3.0"}` (optional) | `{"format": "png", "width": 1206, "height": 2622, "bytesBase64": "…"}` or error envelope |

**State shape** (returned by `getState`, `setSimulation`, `reset`):

```json
{
  "protocolVersion": 2,
  "enabled": true,
  "simulation": { /* DeviceSimulation.toJson(), or null when passing through */ },
  "realDevice": {
    "logicalSize": {"width": 402.0, "height": 874.0},
    "devicePixelRatio": 3.0,
    "padding": {"left": 0, "top": 59, "right": 0, "bottom": 34},
    "locales": ["en-US"],
    "platformBrightness": "dark",
    "textScaleFactor": 1.0,
    "targetPlatform": "iOS"
  },
  "fit": {"scale": 0.82, "offset": {"x": 12.0, "y": 0.0}},
  "capabilities": {"targetPlatform": true, "screenshot": true, "frame": true}
}
```

**`DeviceSimulation.toJson()` shape** (absent field = no override):

```json
{
  "presetId": "apple-iphone-se-3",
  "orientation": "portrait",
  "screenSize": {"width": 375.0, "height": 667.0},
  "frame": {"size": {"width": 403.0, "height": 805.0},
            "screenOffset": {"x": 14.0, "y": 62.0},
            "screenPath": "M 0,0 H 375 …",
            "body": "<svg viewBox=\"0 0 403 805\">…</svg>"},
  "devicePixelRatio": 2.0,
  "padding": {"left": 0, "top": 20, "right": 0, "bottom": 0},
  "viewPadding": {"left": 0, "top": 20, "right": 0, "bottom": 0},
  "systemGestureInsets": {"left": 0, "top": 0, "right": 0, "bottom": 0},
  "displayFeatures": [{"bounds": {"left": 0, "top": 0, "right": 0, "bottom": 0},
                       "type": "hinge", "state": "postureFlat"}],
  "locales": ["fr-FR", "en-US"],
  "platformBrightness": "dark",
  "textScaleFactor": 1.3,
  "accessibility": {"boldText": true, "disableAnimations": false},
  "alwaysUse24HourFormat": true,
  "platform": "iOS"
}
```

### Events (`developer.postEvent` — full JSON maps allowed)

| Event kind | Data | When |
|---|---|---|
| `device_preview.ready` | `{"protocolVersion": 2}` | Once from `initServiceExtensions` — i.e. again after every hot restart. The DevTools re-push trigger. |
| `device_preview.stateChanged` | `{"simulation": {…} \| null, "fit": {…}, "source": "programmatic" \| "devtools" \| "restore", "requestId": "<echoed if provided>"}` | After every successful apply/reset, whatever the source. `requestId` echo lets the panel suppress its own echoes. |
| `device_preview.presetsChanged` | `{"count": 17}` | On `registerPreset` — panel refetches `listPresets`. |

---

## 5. DevTools extension app

Single-screen panel; no routing, no state-management package.

```dart
void main() => runApp(const DevToolsExtension(child: DevicePreviewPanel()));
```

**`gateway.dart`** — the only file touching `serviceManager`:
- `Future<Map<String, Object?>> call(String method, {Map<String, String>? args})` wrapping `serviceManager.callServiceExtensionOnMainIsolate`, try/catch surfacing `RPCError` (isolate paused → status, not a hang).
- Availability: `serviceManager.serviceExtensionManager.hasServiceExtension('ext.device_preview.getState')` (`ValueListenable<bool>` — survives hot restart correctly).
- Per-connection `serviceManager.service!.onExtensionEvent` subscription filtered on `extensionKind.startsWith('device_preview.')`, re-subscribed on every `connectedState` transition.

**`panel_controller.dart`** — `PanelController extends ChangeNotifier`, constructor-injected with the gateway interface (testable with a fake):
- Status: `disconnected | noBinding | disabled | paused | ready`.
- On availability flip false→true: wait for `device_preview.ready` (or a 500 ms fallback timer), then — if "Keep across restarts" is on and a last simulation is stashed — `setSimulation` with `source`-echo `restore`; then `getState` + `listPresets`.
- Sync-in: `stateChanged` events update local state unless `requestId` matches a pending own write. Sync-out: mutations build the full simulation JSON locally, send `setSimulation` with a fresh `requestId`; UI reconciles from the response (app is the single source of truth).
- Last simulation stashed in memory + `window.localStorage` keyed by `serviceManager.serviceUri` (survives extension iframe reloads).
- Raw-JSON-backed lightweight view models — the extension does **not** re-model the domain.
- `extensionManager.showNotification` on apply errors; `showBannerMessage` for the no-binding state.

**`panel.dart`** (uses `devtools_app_shared/ui.dart` components, `Theme.of(context)` colors only → free light/dark):

1. **Toolbar** — status dot, active preset name, Reset button, Screenshot button (shown only when `capabilities.screenshot`; triggers a browser download via `package:web` anchor), overflow menu: "Keep across restarts" toggle.
2. **Device** — searchable preset dropdown grouped by `kind`/platform (data from `listPresets`), "Real device" entry (clears metric fields, preserves non-metric overrides), "Custom…" expander (width/height/DPR/padding numeric fields). Orientation segmented toggle (enabled only when a screen size is active).
3. **Display** — brightness segmented control (system/light/dark), text-scale slider (0.5–3.0, "system" reset chip), 24-hour toggle (tri-state).
4. **Locale** — language-tag text field with validation + common-locales dropdown; ordered multi-locale list; clear chip.
5. **Accessibility** — seven tri-state (system/on/off) controls mapping to the nullable flags.
6. **Platform** — `TargetPlatform` dropdown + "real"; disabled with tooltip when `capabilities.targetPlatform == false`; note that applying triggers a reassemble.
7. **Empty states** — not connected / connected-but-no-extension ("Add `DevicePreview.enable()` before `runApp`.") / registered-but-disabled / isolate paused.

Local dev: `flutter run -d chrome --dart-define=use_simulated_environment=true` against `device_preview/example`.

---

## 6. Testing strategy

Constraint: the concrete binding cannot run under `flutter_test` (`AutomatedTestWidgetsFlutterBinding` owns the same seams). Answer: the binding is a thin shell; the mixin closes the widget-test gap.

1. **Pure Dart units (no binding)** — the bulk of coverage:
   - `FitTransform`: fit math, forward/inverse round-trip property tests, upscale clamp, degenerate sizes (sim larger than real, zero-size guard).
   - `pointer_rewrite.dart` (pure `PointerData Function(PointerData, FitTransform, realDpr, simDpr)`): positions, deltas, radii, pan/scroll scaling, identity fast path — `PointerData` has a public const ctor, fabricate freely.
   - `DeviceSimulation` / `DevicePreset` / `SimulatedAccessibilityFeatures`: JSON round-trips, unknown-key tolerance, `copyWith` sentinel semantics, `resolve()` orientation swap + rotation rule, tri-state merge semantics.
   - `PreviewViewConfiguration`: `toMatrix()` vs. hand-computed matrices, `shouldUpdateMatrix` on fit-only change, `toPhysicalSize` returns real physical size.
   - `protocol.dart`: handlers are pure `Future<Map<String, Object?>> Function(Map<String, String>)` over a `DevicePreviewController` interface — tested with a fake controller: malformed JSON, error envelopes, `requestId` echo, state-shape completeness.
2. **Wrapper tests with injected hosts** — `PreviewPlatformDispatcher(host:)` / `PreviewFlutterView(host:)` take their real counterparts by constructor; tests inject hand-written `implements` fakes. Verified: per-member delegate-vs-simulate for **every** interface member (checklist test per interface — this doubles as the drift canary), `view(id:)` mapping, `views` swap, store-and-forward + swallow-vs-forward policy, `scaleFontSize`/`textScaleFactor` coherence, viewInsets mapping, gesture-slop rescale.
3. **Widget tests via the mixin** — `test_support.dart` ships `TestDevicePreviewBinding extends AutomatedTestWidgetsFlutterBinding with DevicePreviewBindingMixin`, layering the wrapper over `TestPlatformDispatcher` (works because the wrapper's host is `super.platformDispatcher`). Exercises the real propagation chain inside `testWidgets`: `apply` → `handleMetricsChanged` → MediaQuery rebuild; per-preset `MediaQueryData` assertions; pointer remap via `debugInjectPointerData` verifying taps land on the right widgets; pass-through equivalence (simulation off → `MediaQueryData` identical to control). The interaction with the test binding's own 800×600 `createViewConfigurationFor` behavior is itself a pinned test target.
4. **Integration tests (example app)** — `IntegrationTestWidgetsFlutterBinding with DevicePreviewBindingMixin` on macOS desktop in CI: end-to-end MediaQuery + pointer assertions, targetPlatform reassemble, screenshot smoke.
5. **VM-service e2e smoke** — plain Dart harness (`package:vm_service`) launching the example via `flutter run` headless: calls `ext.device_preview.setSimulation` with a preset, asserts the state-shape round trip and the `stateChanged` event. One test; the protocol logic itself is covered in (1).
6. **DevTools extension** — `PanelController` units against a fake gateway (availability flips, restart re-push, echo suppression, paused-isolate path); widget tests per section; `dart run devtools_extensions validate` in CI; manual pass in the simulated environment.
7. **Version-drift CI** — build matrix on stable + beta; a compile-only job exists solely to catch new `PlatformDispatcher`/`FlutterView` members.
8. **Manual release checklist** — pointer fidelity at simulated-screen corners; TalkBack/VoiceOver pass on a letterboxed simulated screen (semantics geometry flows through `applyPaintTransform` and should be correct, but screen-reader interaction is verified by hand).

---

## 7. Resolved decisions & risk register

Every open question from both inputs, decided:

| # | Question | **Decision** | Rationale |
|---|---|---|---|
| 1 | Keyboard `viewInsets` while simulating | **Map real insets into simulated space** (B), not zero (A) | Pure math, no SDK risk, and text fields keep avoiding the real keyboard; strictly better than zero. |
| 2 | SDK interface drift policy | **No hard upper Flutter bound**; beta CI compile job + fast patch releases; per-member checklist test as canary | Hard caps punish users on every Flutter release; compile-loud drift plus CI is the honest mitigation. |
| 3 | Nonlinear (Android 14+) text scaling | **Linear forever; no curve table** | Engine-native scaler is unreachable; linear matches flutter_test; approximations would mislead more than help. |
| 4 | Letterbox background | **Engine clear color (black); no chrome painting** | B's paint-outside-bounds trick rests on an undocumented no-root-clip invariant; cosmetic gain, structural risk. |
| 5 | Letterbox pointer policy | **Stateless natural miss — no policy enum, no clamping state machine** | Out-of-bounds coords miss hit testing and behave like off-screen drags on real devices; zero state, zero risk. |
| 6 | Upscaling small simulated screens | **Never (scale clamped ≤ 1); no option** | Upscaled AA misleads previews; smaller API. |
| 7 | Accessibility override semantics | **Tri-state per flag (null = real)**, B's shape | Atomic all-or-nothing struct (A) makes "just bold text" silently clear real flags. |
| 8 | Display features / foldables | **Field included** (public ctor, MediaQuery reads it, ~free); **no foldable presets in v1 catalog** | Capability is cheap; curating foldable metrics is not — users can register custom presets. |
| 9 | `alwaysUse24HourFormat` | **Included** (propagates via `handleMetricsChanged`) | Trivial getter override; commonly requested for date UI previews. |
| 10 | Screenshot | **Ship as the single optional module**, capability-flagged, isolated in `screenshot.dart`, error-enveloped | High demo/CI value; risk fully contained — failure can never touch the core. |
| 11 | Shared protocol package | **No** — extension reads everything from the app; `protocolVersion` field pins compatibility | One published package; app is the single source of truth, skew impossible. |
| 12 | Mixin vs. concrete-only binding | **Ship `DevicePreviewBindingMixin` publicly**; wrapper host = `super.platformDispatcher` | It is the testability keystone (test + integration bindings) and costs nothing at runtime. |
| 13 | Controller vs. binding-hosted API | **Separate `DevicePreviewController`**, reached via `DevicePreview.controller` | Protocol handlers and tests depend on an interface, not on a binding. |
| 14 | Profile-mode support | **On by default in profile** — `enable([bool? enabled])` resolves null to `!kReleaseMode`; `targetPlatform` capability-flagged false in profile | Extensions work in profile but platform sim cannot (`platform.dart:105`, const-folded); flags keep the UI honest. |
| 15 | Custom preset discovery timing | **`device_preview.presetsChanged` event on `registerPreset`** | One `postEvent` line removes the staleness window. |
| 16 | Hot-restart persistence | **DevTools-side re-push**, gated on the `device_preview.ready` event (+ fallback timer), stashed in memory + localStorage | The app can't remember across restarts; the panel can. `ready` closes B's race (#8). |
| 17 | Multi-view / multi-window | **Pass-through only, documented unsupported; no reserved protocol fields** | Unknown-keys-ignored already gives forward compat; reserving fields now is speculation. |
| 18 | `debugBrightnessOverride` competition | **One-time debug `FlutterError` diagnostic** when both are set | Cheap detection beats documentation alone. |
| 19 | Gesture slop formula | **Fit-scale-aware: `hostSlop / realDPR / fit.scale × simDPR`** (B) | Preserves physical finger travel on the real screen — what a human at the device actually feels. |
| 20 | Orientation representation | **Metric fields stored orientation-resolved + `orientation` label** (B); `setOrientation` swaps via preset lookup or the documented rotation rule | Wrappers stay dumb; swap logic is pure and unit-tested. |

**Residual risks, ranked** (all accepted): (1) `implements`-interface drift — structural cost of the approach, mitigated per #2; (2) third-party code holding raw `ui.PlatformDispatcher.instance` sees real values — documented limitation, framework paths audited clean; (3) keyboard geometry is host-faithful, not simulated-device-faithful — documented; (4) `_updateSystemChrome` status-bar cosmetics follow simulated padding — documented; (5) screenshot `OffsetLayer.toImage` coordinate assumptions across SDK versions — isolated module, error-enveloped; (6) screen-reader UX on letterboxed screens — manual checklist item per release.
---

## 8. As-built deviations (implementation addendum)

The implementation follows this document with these reviewed deviations:

1. **`platformDispatcher` override placement** — lives on the concrete `DevicePreview`, not the mixin: `TestWidgetsFlutterBinding` narrows the getter's return type to `TestPlatformDispatcher`, so a mixin-level override would be an invalid override when layered over test bindings. Test compositions route simulation through the wrapper *view* instead (`wrapWithDefaultView` → `View(view: previewImplicitView)`), which covers MediaQuery, root layout, the fit matrix, and pointer remap — but not framework reads of `binding.platformDispatcher` (e.g. `WidgetsApp` locale resolution).
2. **No `lib/test_support.dart`** — shipping it would force `flutter_test` into consumers' regular dependencies. The `TestDevicePreviewBinding` recipe is documented in the README and used internally from `test/support/test_binding.dart`. A separate `device_preview_test` package is the future home if demand appears.
3. **Display features rotate with orientation** — `SimulatedDisplayFeature.rotatedToLandscape/rotatedToPortrait` applied by `resolve()`, `setOrientation`, and mirrored in the DevTools panel. `systemGestureInsets` deliberately do *not* rotate (edge semantics are orientation-stable on real platforms); pinned by test.
4. **Controller mutations are serialized** — `apply`/`update`/`applyPreset`/`setOrientation` run through an internal queue; state commits before the (debug-only) targetPlatform reassemble await, and `stateChanged` posts in a `finally`. DevTools panel writes are serialized the same way.
5. **`sendPortPlatformMessage(Object port)`** — the web `dart:ui` interface declares `Object`, native declares `SendPort`; `Object` is the only signature valid on both compilers.
6. **`setSimulation` accepts an extra `source` arg** (`devtools`/`restore`) so restore pushes are correctly labeled in `stateChanged`; unknown-keys-ignored keeps it forward-compatible.

### 8.1 Device frames (protocol version 2)

Simulating a device's *appearance* — the outline its screen is clipped to and the body painted behind it — added a fourth override seam and moved the catalog. Both contradict decisions taken earlier in this document, deliberately:

7. **A fourth framework seam: `wrapWithDefaultView`** (§0 claimed exactly three). `DevicePreviewBindingMixin` wraps the root widget in `DevicePreviewFrame` — a `RenderProxyBox` that paints the body **outside its own bounds** and pushes a clip path around the app. The alternative, a custom `RenderView`, is not reachable: since the multi-view refactor the `View` widget owns its `RenderView`. The wrapper is inert without a frame (no clip layer, no painting), and compositions that build their own `View` (test bindings) opt in by wrapping with `DevicePreviewFrame` themselves — the same one line the README recipe now carries.
8. **The device catalog moved into the extension** (§1 decision 11 said the app is the single source of truth). Frames carry artwork; shipping ~12 device bodies inside the published package would tax every app for something only DevTools users see. The catalog is now `device_specs/*.json` at the repository root, generated by `device_preview_devtools_extension/tool/generate_device_catalog.dart` into one `device_catalog.g.dart`, and pushed device-by-device over `setSimulation`. `listPresets` still works and is still merged in (app-registered customs only, deduplicated by id), so the protocol did not lose a capability — only the *default* catalog changed sides. The spec JSON is exactly `DevicePreset.toJson()` plus `brand` and `frame`, so `DevicePreset.fromJson` reads a spec file directly.
9. **Frames are described in portrait and rotated at paint time** — a quarter turn mapping `(x, y) → (y, portraitWidth − x)`, the same rotation display features use. `setOrientation` therefore leaves `frame` untouched, and `DeviceFrame` needs no landscape variant.
10. **The letterbox fits the body, not the screen** — `FitTransform.compute` takes an optional `contentBounds` (`DeviceSimulation.contentBounds`: the screen rectangle grown to the body, usually starting at negative coordinates). `offset` remains the position of the simulated origin, so pointer remapping, the root paint matrix and the state shape are unchanged. The screenshot module captures the same rectangle, so a framed device screenshots with its body.
11. **An embedded SVG subset renderer** (`package:device_preview/svg.dart`) — filled paths/rects/circles/ellipses/polygons, groups, transforms, clip paths, flat colors. No dependency was acceptable in a package that depends on flutter alone, and device artwork needs nothing more. Malformed artwork is failure-isolated: reported once through `FlutterError.reportError`, then skipped.

# Device specs

One JSON file per device, `<id>.json`. This directory is the **source of
truth** for the device catalog: everything the DevTools panel offers and
everything it pushes to the previewed app comes from here.

```console
# regenerate both generated catalogs after any change
cd device_preview_devtools_extension && dart run tool/generate_device_catalog.dart
cd ../device_preview && dart run tool/generate_presets.dart
```

The extension generator writes
`device_preview_devtools_extension/lib/src/devices/device_catalog.g.dart` and
validates every spec on the way (unknown keys, unknown platforms, screens
larger than their body, …); the package generator writes
`device_preview/lib/src/presets.g.dart` — the built-in `DevicePresets`, one
`const DevicePreset` per spec, frame artwork and system UI included.
`device_catalog_test.dart` and `presets_generated_test.dart` fail their
suites when a checked-in output is stale, and the latter also proves each
generated preset equals its spec decoded by `DevicePreset.fromJson`.

An app therefore holds only the presets it references (`const` entries
tree-shake, artwork included); a device picked in DevTools still travels over
the simulation protocol.

## Format

A spec is exactly `DevicePreset.toJson()` (see
`device_preview/lib/presets.dart`) plus `brand` and `frame`, so a spec file can
also be loaded directly by an app:

```dart
final preset = DevicePreset.fromJson(jsonDecode(specSource));
await DevicePreview.controller.applyPreset(preset);
```

| Key | Type | Meaning |
|---|---|---|
| `id` | string, **required** | Stable identifier; must match the file name. |
| `name` | string, **required** | Display name, e.g. `iPhone 16 Pro`. |
| `brand` | string | Manufacturer, e.g. `Apple`. Groups and sorts the picker. |
| `year` | integer | Release year, e.g. `2025`. Shown in the picker, which sorts each brand newest first, and matched by its search field. |
| `platform` | string, **required** | `TargetPlatform` name: `android`, `fuchsia`, `iOS`, `linux`, `macOS`, `windows`. |
| `kind` | string | `phone` (default), `tablet`, `foldable`, `desktop`. |
| `portraitSize` | `{width, height}`, **required** | Logical resolution, portrait. |
| `devicePixelRatio` | number, **required** | Pixel density. The physical resolution is `portraitSize × devicePixelRatio`. |
| `portraitPadding` | `{left, top, right, bottom}` | Safe area (`MediaQuery.padding`), portrait. |
| `portraitViewPadding` | insets | Defaults to `portraitPadding`. |
| `landscapePadding` | insets | Defaults to the rotation rule: `left = right = portrait.top`, `bottom` kept. |
| `landscapeViewPadding` | insets | Defaults to `landscapePadding`. |
| `systemGestureInsets` | insets | Orientation-invariant. |
| `displayFeatures` | array | `{bounds: {left, top, right, bottom}, type, state}`, in portrait coordinates. |
| `frame` | object | The device's appearance — see below. |
| `systemUi` | object | The device's status bar and gesture pill — see below. |

All lengths are logical pixels.

## `frame`

```jsonc
"frame": {
  "size": { "width": 432, "height": 896 },      // body, portrait
  "screenOffset": { "x": 15, "y": 11 },         // screen top-left inside the body
  "screenPath": "M 50,0 H 352 A 50,50 0 0 1 …", // screen outline, screen coordinates
  "body": ["<svg viewBox=\"0 0 432 896\">", "…", "</svg>"]
}
```

Everything is described **in portrait**, in the coordinate space of the
screen — the screen's top-left corner is the origin, so the body starts at
`-screenOffset`:

```
      ┌───────────────────┐  ← body: size, at -screenOffset
      │  ┌─────────────┐  │
      │  │   screen    │  │  ← origin (0, 0)
      │  └─────────────┘  │
      └───────────────────┘
```

The iPhone and iPad frames are derived from the official iOS Simulator bezel
artwork; `.claude/skills/extract-cupertino-specs/` documents the extraction
process and holds the script that regenerates them.
`.claude/skills/extract-pixel-specs/` is its Android counterpart, deriving
the Google Pixel specs from the official emulator device skins and a live
emulator probe (it needs a recent Android Studio for current-generation
skins).

Landscape is not described separately: the whole frame is rotated a quarter
turn at paint time, like turning the real device around. The app is laid out
inside the screen and the letterbox is computed from the **body** bounds, so
the device always stays fully visible.

- `screenPath` — SVG path data (the `d` attribute), in screen coordinates.
  The app is clipped to it: this is what rounds the display corners. Omit it
  for a plain rectangular screen.

  **Cutouts** are part of this outline, because that is what they physically
  are — a hole in the panel, which the app never paints and the body shows
  through. A notch is an indentation of the top edge (see
  `apple-iphone-17e`). A Dynamic Island floats, so it is a second subpath
  wound *counter-clockwise* against the clockwise outline (see
  `apple-iphone-17-pro`): the clip is built with the non-zero fill rule, so
  opposite winding punches a hole. The island every current model carries is
  125 × 37, 11 below the top edge, horizontally centred.
- `body` — an SVG document drawn **behind** the screen, so anything
  overlapping the screen area is hidden. Its view box should cover `size`.
  A string, or an array of lines joined with newlines (only for readability —
  the generator joins them).

### Supported SVG

`device_preview` embeds its own renderer (no dependencies, see
`package:device_preview/svg.dart`) and covers only what device artwork needs:

- **Structure** — `<svg>` (`viewBox`, or `width`/`height`), `<g>`, `<defs>`,
  `<clipPath>`.
- **Shapes** — `<path>` (full path data grammar, arcs included), `<rect>`
  (with `rx`/`ry`), `<circle>`, `<ellipse>`, `<polygon>`.
- **Paint** — `fill` (`#rgb`, `#rgba`, `#rrggbb`, `#rrggbbaa`, `rgb()`,
  `rgba()`, a few named colors, `none`), `fill-opacity`, `fill-rule`,
  `opacity`, and the same properties inside `style="…"`.
- **Geometry** — `transform` (`matrix`, `translate`, `scale`, `rotate`,
  `skewX`, `skewY`) and `clip-path="url(#id)"`.

Strokes, gradients, filters, text, images and masks are **ignored**: draw
shading as flat filled paths, and use a clipped translucent shape for a
highlight. Group `opacity` multiplies into descendant fills rather than
compositing a layer.

Malformed artwork is never fatal for a previewed app: the failure is reported
once through `FlutterError.reportError` and that part of the frame is skipped.

## `systemUi`

The platform's own on-screen furniture, drawn **over** the app: a status bar
at the top, a gesture pill or navigation bar at the bottom.

```jsonc
"systemUi": {
  "statusBar": {
    "inset": 30,                                  // horizontal edge inset
    "leading": ["<svg viewBox=\"0 0 31 14\">", "…"],   // the clock
    "trailing": ["<svg viewBox=\"0 0 74 12\">", "…"]   // signal, wifi, battery
  },
  "navigationBar": {
    "center": ["<svg viewBox=\"0 0 144 5\">", "…"],    // the home indicator
    "bottomInset": 8                              // from the screen's edge
  }
}
```

Neither bar declares a height or a position. Each fills the **safe area** on
its side of the screen — the padding already resolved for the current
orientation — so an iPhone's status bar disappears in landscape, a
home-button device gets no gesture pill, and nothing needs a landscape
variant:

```
 ┌──────────────────────────────────┐
 │ ⟨inset⟩ leading  center  trailing │  ← padding.top
 ├──────────────────────────────────┤
 │              the app             │
 ├──────────────────────────────────┤
 │              center              │  ← padding.bottom
 └──────────────────────────────────┘
```

Artwork is drawn at its natural size (its view box), never stretched, and is
centered vertically in the bar unless `bottomInset` pins it to the outer edge.
`leading` and `trailing` swap under a right-to-left directionality.

Everything is static — the clock always reads the same time, the battery never
moves. The iOS elements (clock glyphs, cellular bars, wifi, the battery with
its percentage knocked out so the app shows through) come from one reference
drawing: each group is emitted with its path data **verbatim**, under a
`<g transform="scale(…) translate(…)">` that maps the reference coordinates
onto the element's own view box. Editing them means editing that drawing and
re-emitting, not retouching coordinates by hand.

A simulation can hide the bars without dropping the device
(`DeviceSimulation.showSystemUi`, the panel's **System UI** switch); the safe
areas they sit in are unaffected, so the app lays out identically either way.

### Colors

Nothing in the artwork carries its own color: every shape uses
`fill="currentColor"` (or no `fill` at all) and is tinted at paint time from
the app's live `SystemUiOverlayStyle` — whether it comes from
`SystemChrome.setSystemUIOverlayStyle` or from an `AnnotatedRegion`, e.g. the
one an `AppBar` installs:

| What | Comes from |
|---|---|
| Status bar icons | `statusBarIconBrightness`, else the inverse of `statusBarBrightness`, else the inverse of the simulated platform brightness |
| Navigation bar icons | `systemNavigationBarIconBrightness`, else the status bar icon color |
| Bar backgrounds, divider | `statusBarColor`, `systemNavigationBarColor`, `systemNavigationBarDividerColor` — **Android only**, since no other platform can tint its bars |

Use `fill-opacity` for secondary detail (a battery outline, an empty signal
bar): it is preserved through the tint.

## Adding a device

1. Copy the closest existing spec to `<brand>-<model>.json`.
2. Fix the metrics, keeping the file name and `id` in sync, and set `year`.
3. Draw the body with the screen cut-out in mind — it is *behind* the app.
   For the system UI, copy the closest device's `systemUi` and adjust the
   insets; keep every fill on `currentColor` so styling still works.
4. Regenerate both catalogs (see above), then run `flutter test` in
   `device_preview_devtools_extension` and in `device_preview`. A brand-new
   device may also deserve a doc-comment entry in
   `device_preview/tool/generate_presets.dart` (`kDescriptions`).

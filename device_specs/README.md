# Device specs

One JSON file per device, `<id>.json`. This directory is the **source of
truth** for the device catalog: everything the DevTools panel offers and
everything it pushes to the previewed app comes from here.

```console
# regenerate the extension's catalog after any change
cd device_preview_devtools_extension
dart run tool/generate_device_catalog.dart
```

The generator writes a single file —
`device_preview_devtools_extension/lib/src/devices/device_catalog.g.dart` —
and validates every spec on the way (unknown keys, unknown platforms, screens
larger than their body, …). `device_catalog_test.dart` fails the suite when
the checked-in output is stale.

The published `device_preview` package contains **no artwork**: the selected
device's frame travels over the simulation protocol, so an app only ever holds
the one device it is currently simulating.

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

Landscape is not described separately: the whole frame is rotated a quarter
turn at paint time, like turning the real device around. The app is laid out
inside the screen and the letterbox is computed from the **body** bounds, so
the device always stays fully visible.

- `screenPath` — SVG path data (the `d` attribute), in screen coordinates.
  The app is clipped to it: this is what rounds the display corners. Omit it
  for a plain rectangular screen.
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

## Adding a device

1. Copy the closest existing spec to `<brand>-<model>.json`.
2. Fix the metrics, keeping the file name and `id` in sync.
3. Draw the body with the screen cut-out in mind — it is *behind* the app.
4. Regenerate the catalog, then run `flutter test` in
   `device_preview_devtools_extension`.

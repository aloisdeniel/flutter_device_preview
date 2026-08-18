---
name: simulator-bezels
description: Extract the official iOS Simulator bezel artwork from the locally installed Xcode, convert it to the device_preview SVG subset, and update the Apple device specs in device_specs/. Use when iPhone/iPad frame visuals need to be (re)derived from Apple's own chrome.
---

# iOS Simulator bezels → device specs

Rebuilds the `frame` object (`size`, `screenOffset`, `screenPath`, `body`) of
every Apple spec in `device_specs/` from the bezel artwork that ships inside
the locally installed Xcode — the same artwork the Simulator uses for
*Window ▸ Show Device Bezels*. Metrics (sizes, paddings, system UI) are left
untouched.

## 1. Locate the artwork — never hardcode paths

Apple moves this artwork between Xcode versions, and Xcode itself may be
installed under a versioned name (e.g. `/Applications/Xcode-16.2.0.app`).
Always discover, in this order:

```sh
xcode-select -p                      # the active developer dir
ls /Applications | grep -i xcode     # fallback: versioned installs
```

From the developer dir (`$DEV`), the three relevant sources are:

1. **Device type bundles** — one per simulated device:
   `$DEV/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/DeviceTypes/<name>.simdevicetype/Contents/Resources/`
   (an identical tree exists under `/Library/Developer/CoreSimulator/Profiles/DeviceTypes/`).
   `profile.plist` is the index; the keys that matter:
   - `chromeIdentifier` — e.g. `com.apple.dt.devicekit.chrome.phone11`; the
     last component names the chrome bundle below.
   - `framebufferMask` — UUID of a PDF next to the plist **and** in
     `DeviceKit/FramebufferMasks/`: the exact vector outline of the display
     (multi-cubic "squircle" corners; notch devices carve the notch into the
     top edge). Coordinates are **physical pixels, y-up**.
   - `mainScreenWidth/Height/Scale` — physical resolution; divide by scale
     for logical points. Use this to sanity-check against the spec's
     `portraitSize` before touching anything.
   - `sensorBarImage` — a PDF that is **empty** on modern devices: the
     Dynamic Island / notch content is rendered by iOS itself, so the island
     is *not* in the mask. Keep the island pill our specs already carry.

2. **Chrome bundles** — the bezel drawing per device family:
   `$DEV/Platforms/iPhoneOS.platform/Library/Developer/DeviceKit/Chrome/<chrome>.devicechrome/Contents/Resources/`
   - `chrome.json` — layout metadata. Beware: some bundles (tablet2/3) have
     `//` comments and trailing commas; parse leniently. Keys that matter:
     - `images.sizing.leftWidth` … — bezel border thickness in points when
       there is no composite (tablets, phone4).
     - `paths.simpleOutsideBorder.cornerRadius[X|Y]` + `insets` — Apple's own
       outer corner radius for the body silhouette (it shapes the actual
       Simulator window).
   - `PhoneComposite.pdf` (phones) — the whole bezel on one page. Page size =
     body size; the screen is centered, so border = (page − logical screen)/2.
     Drawn as concentric rounded-rect *strokes* centered on the screen rect
     (paint order outer→inner) plus interior fills; the last opaque fill is
     the screen face.
   - `iPadTL.pdf` / `Phone TL.pdf` etc. (9-slice corners/edges, used when
     there is no composite) — corner tiles paint at **natural size**, and the
     ring insets read directly off the tile's nested fills (typically shadow
     at 0, gray hairline at 1, dark at 2, near-black from 7).
   - Button PDFs are drawn *under* the chrome at rest (invisible); the
     Simulator shows no protruding buttons, so specs derived here have none.

3. **If neither is found** (future Xcode): search broadly —
   `find "$DEV/.." -iname "*bezel*" -o -iname "*chrome*"`, look for
   `Assets.car` in `Simulator.app` (`xcrun assetutil --info Assets.car` to
   inspect; a third-party extractor such as Asset Catalog Tinkerer or
   `acextract` to dump), and for loose `.tiff/.png` in
   `Simulator.app/Contents/Resources` on very old versions.

## 2. Convert to the spec's SVG subset

The embedded renderer (`package:device_preview/svg.dart`) supports **flat
fills only** — no strokes, no gradients, no images. The conversion is
therefore geometric, not a file-format transcode:

- **`screenPath`** — parse the framebuffer-mask PDF *content stream*: the
  outline lives in a `W*` **clip path**, not in a fill (`get_drawings()`
  misses it; read the stream operators `m l c v y h re`). Divide by the
  screen scale, flip y (`y' = H − y`), emit `M/L/C/Z` rounded to 2 decimals.
  The resulting outline is wound clockwise (in y-down SVG space); if the old
  spec's `screenPath` had extra subpaths (the Dynamic Island pill, wound
  counter-clockwise so `nonZero` punches the hole), re-append them verbatim.
- **`body` SVG** — nested rounded-rect fills replace the stroke stack
  exactly (a stroke of width *w* centered at inset *c* becomes a fill at
  inset *c − w/2*, covered inside by the next ring). Corner radius at inset
  *k* is `simpleOutsideBorder.cornerRadius − k`. Colors come from the PDF
  fill/stroke colors (`#7e7e7e` gray hairline, `#2c2c2c` dark ring, black).
- **`size` / `screenOffset`** — composite page size and centered border for
  phones; `logical + 2 × sizing` and `(sizing, sizing)` for tablets.

## 3. Devices Xcode doesn't know yet

Specs for unreleased/absent devices reuse a **donor**:

- Same logical panel → use the donor's mask as-is (e.g. iPhone 17/17 Pro ←
  iPhone 16 Pro; 16e/17e ← iPhone 14, whose mask already carries the notch).
- Different size → 9-slice retarget the donor path: coordinates past the
  panel midpoint shift by Δw/Δh, corner clusters translate rigidly, centered
  subpaths (island) shift by Δw/2 (e.g. iPhone Air ← iPhone 16 Pro).

The device→simulator mapping (with donors) lives at the top of
`extract_bezels.py` next to this file — extend it when adding devices.

## 4. Run it

```sh
python3 -m venv /tmp/bezels-venv && /tmp/bezels-venv/bin/pip install pymupdf
/tmp/bezels-venv/bin/python .claude/skills/simulator-bezels/extract_bezels.py   # add --dry-run to preview
```

The script refuses to touch a spec whose `portraitSize`/`devicePixelRatio`
disagree with the simulator profile. After it writes:

```sh
cd device_preview_devtools_extension && dart run tool/generate_device_catalog.dart
flutter test                                  # extension suite
cd ../device_preview && flutter test          # package suite
../tool/build_devtools_extension.sh           # committed extension bundle
../tool/build_demo.sh                         # docs demo
```

## Licensing note

The artwork inside Xcode is Apple's copyrighted material. This process does
not redistribute it: it derives geometry (sizes, radii, paths) and a handful
of flat colors, and the drawn frames are our own minimal SVG. For
marketing-grade imagery use the official Apple Design Resources ("Product
Bezels") instead, which come with clearer usage terms.

---
name: extract-cupertino-specs
description: Rebuild the Apple device specs in device_specs/ from the locally installed iOS Simulator — frame artwork from Xcode's bezel chrome, plus screen size, scale and safe areas probed from a booted simulator. Use when iPhone/iPad specs need to be (re)derived from Apple's own definitions.
---

# iOS Simulator → device specs

Rebuilds every Apple spec in `device_specs/` from the simulator that ships
with the locally installed Xcode, using two complementary sources:

1. **Static artwork** — the bezel chrome and framebuffer masks inside Xcode
   rebuild the `frame` object (`size`, `screenOffset`, `screenPath`, `body`):
   the same artwork the Simulator uses for *Window ▸ Show Device Bezels*.
2. **A live probe** — a throwaway simulator per device type is booted and a
   tiny UIKit app reports the metrics iOS actually applies: `portraitSize`,
   `devicePixelRatio`, `portraitPadding` and `landscapePadding` (safe areas
   in both orientations). Safe areas exist in **no static file** — UIKit
   computes them at runtime, so asking a booted simulator is the only
   faithful source.

Hand-authored content the simulator cannot know is preserved: `year`,
`systemUi` artwork, the Dynamic Island pill (see below), and every metric of
donor-based devices.

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
     for logical points. Cross-check against the probe and the spec's
     `portraitSize` before touching anything.
   - `sensorBarImage` — a PDF that is **empty** on modern devices: the
     Dynamic Island / notch content is rendered by iOS itself, so the island
     is *not* in the mask. Keep the island pill our specs already carry.
   `capabilities.plist` also carries `DeviceCornerRadius`, `marketing-name`,
   `modelIdentifier` and the device idiom — useful for sanity checks.

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
     the screen face. Some generations use nested symmetric fills instead,
     with translucent asymmetric fills as button nubs.
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

## 2. Convert artwork to the spec's SVG subset

The embedded renderer (`package:device_preview/svg.dart`) supports **flat
fills only** — no strokes, no gradients, no images. The conversion is
therefore geometric, not a file-format transcode:

- **`screenPath`** — parse the framebuffer-mask PDF *content stream*: on
  phones the outline is a `W*` **clip path** (`get_drawings()` misses it),
  on iPads a plain fill under a `cm` translate — so track the CTM and read
  the operators `m l c v y h re` directly. Divide by the screen scale, flip
  y (`y' = H − y`), emit `M/L/C/Z` rounded to 2 decimals. The resulting
  outline is wound clockwise (in y-down SVG space); if the old spec's
  `screenPath` had extra subpaths (the Dynamic Island pill, wound
  counter-clockwise so `nonZero` punches the hole), re-append them verbatim.
- **`body` SVG** — nested rounded-rect fills replace the stroke stack
  exactly (a stroke of width *w* centered at inset *c* becomes a fill at
  inset *c − w/2*, covered inside by the next ring). Corner radius at inset
  *k* is `simpleOutsideBorder.cornerRadius − k`. Colors come from the PDF
  fill/stroke colors (`#7e7e7e` gray hairline, `#2c2c2c` dark ring, black).
- **`size` / `screenOffset`** — composite page size and centered border for
  phones; `logical + 2 × sizing` and `(sizing, sizing)` for tablets.

## 3. Probe the live metrics

`probe.swift` (next to this file) is a UIKit app with no Xcode project —
built by the script with:

```sh
SDKROOT=$(xcrun --sdk iphonesimulator --show-sdk-path) \
  xcrun swiftc -target arm64-apple-ios16.0-simulator probe.swift -o Probe.app/Probe
```

**SDKROOT is load-bearing**: with the default macOS sysroot the linker
stamps a macOS SDK version into `LC_BUILD_VERSION` and UIKit letterboxes
the app into a smaller compatibility size (e.g. an iPhone 16 Pro reports
390×844 instead of 402×874), silently corrupting every metric. The same
letterboxing hits apps without a `UILaunchScreen` Info.plist entry. The
script verifies the probed size against `profile.plist` and aborts on
mismatch.

Per device the script runs `simctl create` (throwaway device, newest iOS
runtime) → `boot` → `bootstatus -b` → `install` → `launch --console-pty`,
reads the app's single `SPECPROBE {json}` line — screen bounds, scale,
`safeAreaInsets` in portrait, then again after a
`requestGeometryUpdate(.landscapeRight)` — and always shuts down and
deletes the device. Expect ~30–60 s per device.

## 4. Devices Xcode doesn't know yet

Specs for unreleased/absent devices reuse a **donor** (marked `donor` in
the mapping table at the top of `extract_specs.py` — extend it when adding
devices). Donors contribute **frame artwork only**; the probe never
overwrites a donor-based spec's hand-authored metrics:

- Same logical panel → use the donor's mask as-is (e.g. iPhone 17/17 Pro ←
  iPhone 16 Pro; 16e/17e ← iPhone 14, whose mask already carries the notch).
- Different size → 9-slice retarget the donor path: coordinates past the
  panel midpoint shift by Δw/Δh, corner clusters translate rigidly, centered
  subpaths (island) shift by Δw/2 (e.g. iPhone Air ← iPhone 16 Pro).

## 5. Run it

```sh
python3 -m venv /tmp/specs-venv && /tmp/specs-venv/bin/pip install pymupdf
/tmp/specs-venv/bin/python .claude/skills/extract-cupertino-specs/extract_specs.py
# --no-probe   frames only, no simulators booted (fast)
# --dry-run    report without writing
# ids...       limit to specific spec ids
```

The script prints every metric it changes and refuses to touch a spec whose
size disagrees with the simulator profile. After it writes:

```sh
cd device_preview_devtools_extension && dart run tool/generate_device_catalog.dart
flutter test                                  # extension suite
cd ../device_preview && flutter test          # package suite
../tool/build_devtools_extension.sh           # committed extension bundle
../tool/build_demo.sh                         # docs demo
```

## Licensing note

The artwork inside Xcode is Apple's copyrighted material. This process does
not redistribute it: it derives geometry (sizes, radii, paths, insets) and a
handful of flat colors, and the drawn frames are our own minimal SVG. For
marketing-grade imagery use the official Apple Design Resources ("Product
Bezels") instead, which come with clearer usage terms.

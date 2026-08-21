---
name: extract-pixel-specs
description: Rebuild the Google Pixel specs in device_specs/ from the official Android emulator device skins and a live emulator probe — frame artwork, screen shape with the camera punch hole, and safe areas from a booted AVD. Use when Pixel specs need to be (re)derived from Google's own definitions.
---

# Android emulator → Pixel device specs

The Android counterpart of `extract-cupertino-specs`: rebuilds the Google
Pixel specs in `device_specs/` from what Google itself ships, using two
complementary sources:

1. **Official device skins** (static) — the artwork the emulator draws
   around the screen when a skin is enabled. A skin gives the body art, the
   exact screen placement, the screen's rounded-corner radius **and the
   camera punch-hole geometry** — rebuilt into the `frame` object.
2. **A live probe** (dynamic) — a headless AVD of the device profile is
   booted and `adb` reads the metrics Android actually applies: `wm size` /
   `wm density` for `portraitSize` and `devicePixelRatio`, and the
   status/navigation bar frames from `dumpsys window` for
   `portraitPadding` / `landscapePadding`. Like iOS safe areas, these bar
   heights live in no simple static file — the window manager computes
   them, so a booted emulator is the faithful source.

## 1. Locate the skins — never hardcode paths

Skins move between Android Studio / SDK versions. Search, in order:

- `$ANDROID_HOME/skins/<name>/` (also `~/Library/Android/sdk/skins/`) —
  installed with some emulator/SDK packages.
- `Android Studio*.app/Contents/plugins/android/resources/device-art-resources/<name>/`
  — bundled with Android Studio; **the newest installed Studio has the
  newest Pixel line-up**, older Studios stop at older devices. Upgrading
  Android Studio is the supported way to obtain newer official skins (they
  are also visible in the AOSP `tools/adt/idea` artwork tree).
- Any directory passed via `--skins-dir`.

A usable skin is a directory containing a `layout` file. The script prints
every skin it can find when a mapped one is missing.

## 2. Read a skin

`layout` is a simple `key value` / `key { … }` tree (line-oriented; parse
generically):

- `parts.device.display` — screen size and position **in physical pixels**.
- `layouts.portrait` — the canvas size and each part's offset; the `device`
  part's offset plus the display position give the screen's top-left inside
  the artwork.
- `parts.portrait.background.image` → `back.webp`, the body art.
  `parts.portrait.foreground.mask` → `mask.webp`; there may also be a
  `cutout <type>` hint.

The rasters are **photorealistic, not vector** (unlike Apple's chrome
PDFs), so conversion is measurement, not transcode — everything in px,
divided by `devicePixelRatio` at the end:

- **Body silhouette**: the canvas includes shadow margins — take the
  bounding box of pixels with alpha ≥ 250 in `back.webp`. The body corner
  radius is the distance to the first solid pixel on the box's top row
  (for a circular corner of radius r, row 0 starts at x = r).
- **Body colors**: the art is full of gradients the spec renderer cannot
  paint (flat fills only) — quantize to a few nested rounded-rect rings:
  an edge ring sampled ~1 px inside the silhouette at the four edge
  midpoints, and a face color sampled deeper into the bezel band. This
  deliberately trades photorealism for the catalog's minimal flat style.
- **Screen mask semantics** (the non-obvious part): in `mask.webp`,
  **opaque pixels are what covers the screen** — the four corner overlays
  and the camera punch hole; transparent means the display shows through.
  The screen corner radius is the opaque run length at row 0 from each
  corner. Any opaque blob away from the corners is the punch hole: its
  bounding box gives the cutout circle.
- **`screenPath`**: rounded rect (clockwise) + the punch-hole circle as a
  counter-clockwise subpath, so `nonZero` filling punches the hole — same
  convention as the iPhone Dynamic Island.

Buttons in the art protrude past the silhouette box and are deliberately
dropped, matching the iOS skill's Simulator-at-rest look.

## 3. Probe the live metrics

No APK is needed — everything comes from the shell:

```sh
avdmanager create avd -n specprobe-tmp -k <system-image> -d <device-id> --force
emulator -avd specprobe-tmp -no-window -no-audio -no-boot-anim -no-snapshot
adb shell getprop sys.boot_completed   # poll until "1"
adb shell wm size ; adb shell wm density
adb shell dumpsys window               # InsetsSource STATUS_BAR / NAVIGATION_BAR frames
```

- `devicePixelRatio` = density / 160; logical size = px / dpr.
- Bar frames appear as `InsetsSource type=ITYPE_STATUS_BAR frame=[l,t][r,b]`
  (API ≤ 33) or `type=statusBars` (newer) — the parser accepts both, and on
  current APIs only the `dumpsys window displays` subcommand still lists
  them. Each bar hugs one display edge; the frame thickness on that edge is
  the inset.
- **SystemUI settles late**: `sys.boot_completed` fires while the bars are
  still transitional (a default-height status bar that later grows — on
  Android 16 a Pixel's settles at 54 dp — and zero-area navigation bars).
  Wait a grace period, then poll until both bars report non-degenerate
  frames that are identical on two consecutive reads.
- **Landscape needs a foreground app that allows rotation** — the launcher
  is portrait-locked and `cmd window user-rotation lock 1` silently does
  nothing until e.g. `am start -a android.settings.SETTINGS` is in front.
- Device profiles (`avdmanager list device`) also come from the installed
  tooling — a newer Android Studio / cmdline-tools brings newer Pixels.
- The AVD is always shut down (`adb emu kill`) and deleted afterwards.

### Keyboard heights are a shared default, not a probe

`portraitKeyboardHeight` / `landscapeKeyboardHeight` are **the same 336 / 252
on every Android device** in `device_specs/` — the height Gboard covered on a
booted Pixel 9 emulator once its layout settled, rounded, applied catalog-wide
rather than probed per device. This script does not write them: edit the specs
if a better source appears.

The attempt is recorded because it looks easy and is not: a Flutter probe app
with an autofocused field (`MediaQuery.viewInsets.bottom`, the same number the
Cupertino probe reads) does raise the emulator's Gboard, but the height it
reports on `android-36;google_apis;arm64-v8a` / `pixel_9` is **not
reproducible** — 194, 300, 312 and 336 dp across four consecutive runs of the
same AVD, as Gboard resizes itself while its suggestion strip and first-run
chrome settle, and `dumpsys window`'s `mImeHeight` follows the same wobble.
Unlike iOS, the height is also not a device property at all: it belongs to
whichever IME is installed.

Making per-device numbers trustworthy needs Gboard pinned to a known state
(first-run UI dismissed, suggestion strip on, one-handed/emoji rows off) and a
settling rule — several identical samples in a row — before a number is
written. Until then one representative default beats ten fabricated ones, and
it is a single value to correct.

### Known limits

- The emulator's **cutout overlays** (`cmd overlay list` →
  `…display.cutout.emulation.*`) are generic shapes, not per-device
  geometry — that's why the punch hole is taken from the skin mask instead.
  Consequently the probed status-bar height is the cutout-less default;
  prefer it only when it is ≥ the spec's current value.
- With no per-device system image, `dumpsys display` reports zero rounded
  corners — the skin mask is the source for those too.
- Foldables (Pixel Fold line) have skins but a folded/unfolded layout this
  pipeline does not model — they are marked `skip` in the mapping.

## 4. Devices the local tooling doesn't know

The mapping table at the top of `extract_pixel_specs.py` mirrors the
Cupertino skill: `skin` + `avd_device` per catalog id, `donor: True` for
devices reusing another device's panel art (metrics stay hand-authored),
`skip` for the unsupported. A missing skin or device profile is a warning
listing what *is* available — install a newer Android Studio and re-run.

## 5. Run it

```sh
/tmp/specs-venv/bin/pip install pillow          # PyMuPDF not needed here
/tmp/specs-venv/bin/python .claude/skills/extract-pixel-specs/extract_pixel_specs.py
# --no-probe            frames only, no emulator booted
# --dry-run             report without writing
# --skins-dir DIR       extra skin search roots (repeatable)
# --preview NAME        analyze any available skin without touching specs
#                       (add --probe-device ID to also probe that profile)
```

Then the usual pipeline: regenerate the catalog, run both test suites,
rebuild the extension bundle and the docs demo (see
`device_specs/README.md`).

## Licensing note

Skin artwork is Google's. As with the Cupertino skill, nothing is
redistributed: the script derives geometry and a handful of flat colors,
and the drawn frames are our own minimal SVG.

#!/usr/bin/env python3
"""Rebuild the Google Pixel specs in device_specs/ from the official Android
emulator device skins and a live emulator probe.

See SKILL.md next to this file for the sources and their semantics.
Requires Pillow (`pip install pillow`). Usage:

    python extract_pixel_specs.py [--dry-run] [--no-probe]
                                  [--skins-dir DIR ...] [ids...]
    python extract_pixel_specs.py --preview pixel_6_pro [--probe-device pixel_6]
"""

import argparse
import glob
import json
import os
import re
import shutil
import subprocess
import sys
import time

from PIL import Image

# Catalog id -> how to derive it from the emulator.
#   skin:       skin directory name (official artwork)
#   avd_device: `avdmanager list device` id for the metrics probe
#   donor:      True when the skin belongs to another device that shares the
#               panel — frame artwork only, keep hand-authored metrics
#   skip:       reason this device cannot be derived yet
DEVICES = {
    "google-pixel-9": {"skin": "pixel_9", "avd_device": "pixel_9"},
    # Pixel 10: same 412x923 @2.625 panel as the Pixel 9.
    "google-pixel-10": {"skin": "pixel_9", "avd_device": "pixel_9",
                        "donor": True},
    "google-pixel-10-pro-fold": {
        "skip": "foldable: the skin's folded/unfolded layout is not modeled"},
}

SKILL_DIR = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(os.path.dirname(os.path.dirname(SKILL_DIR)))
SPECS = os.path.join(REPO, "device_specs")

SOLID_ALPHA = 250  # below this it's the drop shadow around the body art
OPAQUE = 128


def fmt(value):
    rounded = round(value, 2)
    if rounded == int(rounded):
        return str(int(rounded))
    return f"{rounded:g}"


def fmt_json(value):
    return int(value) if value == int(value) else round(value, 2)


# --- skin discovery and parsing ----------------------------------------------

def sdk_root():
    for candidate in (os.environ.get("ANDROID_HOME"),
                      os.environ.get("ANDROID_SDK_ROOT"),
                      os.path.expanduser("~/Library/Android/sdk"),
                      os.path.expanduser("~/Android/Sdk")):
        if candidate and os.path.isdir(candidate):
            return candidate
    return None


def skin_roots(extra):
    roots = list(extra)
    sdk = sdk_root()
    if sdk:
        roots.append(os.path.join(sdk, "skins"))
    for app in sorted(glob.glob("/Applications/Android Studio*.app")):
        roots.append(os.path.join(
            app, "Contents/plugins/android/resources/device-art-resources"))
    return [r for r in roots if os.path.isdir(r)]


def find_skin(name, roots):
    for root in roots:
        path = os.path.join(root, name)
        if os.path.isfile(os.path.join(path, "layout")):
            return path
    return None


def available_skins(roots):
    found = set()
    for root in roots:
        for path in glob.glob(os.path.join(root, "*", "layout")):
            found.add(os.path.basename(os.path.dirname(path)))
    return sorted(found)


def parse_layout(path):
    """The emulator skin `layout` format: line-oriented `key value` pairs
    and `key { ... }` blocks."""
    root, stack = {}, []
    node = root
    for raw in open(path):
        line = raw.strip()
        if not line:
            continue
        if line.endswith("{"):
            child = {}
            node[line[:-1].strip()] = child
            stack.append(node)
            node = child
        elif line == "}":
            node = stack.pop()
        else:
            key, _, value = line.partition(" ")
            node[key] = value.strip()
    return root


def skin_geometry(skin_dir):
    layout = parse_layout(os.path.join(skin_dir, "layout"))
    display = layout["parts"]["device"]["display"]
    portrait = layout["layouts"]["portrait"]
    device_offset = None
    for key, part in portrait.items():
        if isinstance(part, dict) and part.get("name") == "device":
            device_offset = (int(part["x"]), int(part["y"]))
    if device_offset is None:
        sys.exit(f"error: no device part in {skin_dir}/layout")
    images = layout["parts"]["portrait"]
    return {
        "screen_px": (int(display["width"]), int(display["height"])),
        "screen_pos": (device_offset[0] + int(display.get("x", 0)),
                       device_offset[1] + int(display.get("y", 0))),
        "back": os.path.join(skin_dir, images["background"]["image"]),
        "mask": os.path.join(skin_dir, images["foreground"]["mask"])
        if "foreground" in images and "mask" in images["foreground"]
        else None,
    }


# --- raster analysis ---------------------------------------------------------

def median_color(pixels):
    channels = list(zip(*[p[:3] for p in pixels]))
    return tuple(sorted(c)[len(c) // 2] for c in channels)


def hex_color(rgb):
    return "#%02x%02x%02x" % rgb


def analyze_back(back_path, screen_pos, screen_px):
    """Body bounds (alpha >= SOLID_ALPHA), outer corner radius, and two
    quantized ring colors from the photorealistic body art: the metallic
    edge just inside the silhouette, and the front-face bezel sampled 75%
    of the way from the body edge to the screen edge."""
    image = Image.open(back_path).convert("RGBA")
    alpha = image.getchannel("A")
    solid = alpha.point(lambda v: 255 if v >= SOLID_ALPHA else 0)
    bounds = solid.getbbox()
    if bounds is None:
        sys.exit(f"error: fully transparent body art {back_path}")
    x0, y0, x1, y1 = bounds
    radius = next(
        (i for i in range(x1 - x0)
         if solid.getpixel((x0 + i, y0)) and solid.getpixel((x0 + i, y0 + 1))),
        0)
    cx, cy = (x0 + x1) // 2, (y0 + y1) // 2
    edge = median_color([
        image.getpixel((x0 + 1, cy)), image.getpixel((x1 - 2, cy)),
        image.getpixel((cx, y0 + 1)), image.getpixel((cx, y1 - 2)),
    ])
    sx, sy = screen_pos
    face = median_color([
        image.getpixel((x0 + max(1, round((sx - x0) * 0.75)), cy)),
        image.getpixel((x1 - max(2, round((x1 - sx - screen_px[0]) * 0.75)),
                        cy)),
        image.getpixel((cx, y0 + max(1, round((sy - y0) * 0.75)))),
        image.getpixel((cx, y1 - max(2, round((y1 - sy - screen_px[1])
                                              * 0.75)))),
    ])
    return {"bounds": bounds, "radius": radius, "edge": edge, "face": face}


def analyze_mask(mask_path, screen_px):
    """Screen corner radius and camera punch hole from the mask overlay:
    opaque pixels are what covers the screen (corners + punch hole)."""
    if mask_path is None or not os.path.exists(mask_path):
        return {"radius": 0, "hole": None}
    alpha = Image.open(mask_path).convert("RGBA").getchannel("A")
    w, h = alpha.size
    top = [alpha.getpixel((x, 0)) for x in range(w)]

    def run_from(sequence):
        count = 0
        for value in sequence:
            if value < OPAQUE:
                break
            count += 1
        return count

    radius = max(run_from(top), run_from(reversed(top)))
    # The punch hole: opaque pixels in the top strip, clear of the corners
    # (the x window excludes the corner overlays entirely).
    xs, ys = [], []
    for y in range(0, min(h, max(radius * 3, h // 8))):
        for x in range(radius + 4, w - radius - 4):
            if alpha.getpixel((x, y)) >= OPAQUE:
                xs.append(x)
                ys.append(y)
    hole = None
    if xs:
        hx0, hx1, hy0, hy1 = min(xs), max(xs), min(ys), max(ys)
        hole = {"cx": (hx0 + hx1 + 1) / 2, "cy": (hy0 + hy1 + 1) / 2,
                "r": max(hx1 - hx0, hy1 - hy0) / 2 + 0.5}
    return {"radius": radius, "hole": hole}


# --- frame construction ------------------------------------------------------

def rounded_rect_path(w, h, r):
    return (f"M {fmt(r)},0 H {fmt(w - r)} "
            f"A {fmt(r)},{fmt(r)} 0 0 1 {fmt(w)},{fmt(r)} V {fmt(h - r)} "
            f"A {fmt(r)},{fmt(r)} 0 0 1 {fmt(w - r)},{fmt(h)} H {fmt(r)} "
            f"A {fmt(r)},{fmt(r)} 0 0 1 0,{fmt(h - r)} V {fmt(r)} "
            f"A {fmt(r)},{fmt(r)} 0 0 1 {fmt(r)},0 Z")


def circle_ccw_path(cx, cy, r):
    return (f"M {fmt(cx)},{fmt(cy - r)} "
            f"A {fmt(r)},{fmt(r)} 0 1 0 {fmt(cx)},{fmt(cy + r)} "
            f"A {fmt(r)},{fmt(r)} 0 1 0 {fmt(cx)},{fmt(cy - r)} Z")


def build_frame(skin_dir, dpr):
    geometry = skin_geometry(skin_dir)
    back = analyze_back(geometry["back"], geometry["screen_pos"],
                        geometry["screen_px"])
    mask = analyze_mask(geometry["mask"], geometry["screen_px"])
    bx0, by0, bx1, by1 = back["bounds"]
    sw, sh = geometry["screen_px"]
    sx, sy = geometry["screen_pos"]

    def dp(v):
        return v / dpr

    body_w, body_h = dp(bx1 - bx0), dp(by1 - by0)
    offset = (dp(sx - bx0), dp(sy - by0))
    if offset[0] < 0 or offset[1] < 0 or \
            offset[0] + dp(sw) > body_w or offset[1] + dp(sh) > body_h:
        sys.exit(f"error: screen escapes the body in {skin_dir}")

    path = rounded_rect_path(dp(sw), dp(sh), dp(mask["radius"]))
    if mask["hole"]:
        hole = mask["hole"]
        path += " " + circle_ccw_path(dp(hole["cx"]), dp(hole["cy"]),
                                      dp(hole["r"]))

    radius = dp(back["radius"])
    body = [
        f'<svg viewBox="0 0 {fmt(body_w)} {fmt(body_h)}">',
        f'  <rect x="0" y="0" width="{fmt(body_w)}" height="{fmt(body_h)}"'
        f' rx="{fmt(radius)}" fill="{hex_color(back["edge"])}"/>',
        f'  <rect x="1" y="1" width="{fmt(body_w - 2)}"'
        f' height="{fmt(body_h - 2)}" rx="{fmt(max(0.0, radius - 1))}"'
        f' fill="{hex_color(back["face"])}"/>',
        "</svg>",
    ]
    return {
        "size": {"width": fmt_json(body_w), "height": fmt_json(body_h)},
        "screenOffset": {"x": fmt_json(offset[0]), "y": fmt_json(offset[1])},
        "screenPath": path,
        "body": body,
    }, (dp(sw), dp(sh))


# --- live metrics probe ------------------------------------------------------

class EmulatorProbe:
    def __init__(self):
        self.sdk = sdk_root()
        if self.sdk is None:
            sys.exit("error: no Android SDK found (set ANDROID_HOME)")
        self.avdmanager = self._tool("cmdline-tools/latest/bin/avdmanager")
        self.emulator = self._tool("emulator/emulator")
        self.adb = self._tool("platform-tools/adb", which="adb")

    def _tool(self, relative, which=None):
        path = os.path.join(self.sdk, relative)
        if os.path.exists(path):
            return path
        if which:
            found = shutil.which(which)
            if found:
                return found
        sys.exit(f"error: missing Android tool: {relative}")

    def system_image(self):
        images = []
        for path in glob.glob(os.path.join(self.sdk, "system-images",
                                           "android-*", "*", "*")):
            api = int(path.split("android-")[1].split(os.sep)[0])
            parts = path.split(os.sep)
            images.append((api, f"system-images;android-{api};"
                                f"{parts[-2]};{parts[-1]}"))
        if not images:
            sys.exit("error: no emulator system images installed")
        return max(images)[1]

    def shell(self, *args, timeout=60):
        return subprocess.run([self.adb, "shell", *args], capture_output=True,
                              text=True, timeout=timeout).stdout

    def bar_insets(self, dpr):
        dump = subprocess.run([self.adb, "shell", "dumpsys", "window"],
                              capture_output=True, text=True,
                              timeout=60).stdout
        display = re.search(r"mDisplayFrame=Rect\((\d+), (\d+) - (\d+), (\d+)",
                            dump)
        if not display:
            sys.exit("error: no mDisplayFrame in dumpsys window")
        dw = int(display.group(3)) - int(display.group(1))
        dh = int(display.group(4)) - int(display.group(2))
        insets = {"left": 0, "top": 0, "right": 0, "bottom": 0}
        seen = set()
        pattern = (r"type=(?:ITYPE_)?(STATUS_BAR|statusBars|"
                   r"NAVIGATION_BAR|navigationBars)\b.*?"
                   r"frame=\[(\d+),(\d+)\]\[(\d+),(\d+)\]")
        for kind, l, t, r, b in re.findall(pattern, dump):
            key = kind.lower().replace("_", "").replace("bars", "bar")
            if key in seen:
                continue  # dumpsys repeats the state per window
            seen.add(key)
            l, t, r, b = int(l), int(t), int(r), int(b)
            if t == 0 and b < dh:
                insets["top"] = max(insets["top"], round((b - t) / dpr))
            elif b == dh and t > 0:
                insets["bottom"] = max(insets["bottom"], round((b - t) / dpr))
            elif l == 0 and r < dw:
                insets["left"] = max(insets["left"], round((r - l) / dpr))
            elif r == dw and l > 0:
                insets["right"] = max(insets["right"], round((r - l) / dpr))
        return insets, dw > dh

    def probe(self, avd_device):
        create = subprocess.run(
            [self.avdmanager, "create", "avd", "-n", "specprobe-tmp",
             "-k", self.system_image(), "-d", avd_device, "--force"],
            input="no\n", capture_output=True, text=True)
        if create.returncode != 0:
            sys.exit(f"error: avdmanager create failed for {avd_device!r}:\n"
                     f"{create.stderr.strip()}")
        process = subprocess.Popen(
            [self.emulator, "-avd", "specprobe-tmp", "-no-window", "-no-audio",
             "-no-boot-anim", "-no-snapshot"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        try:
            deadline = time.time() + 300
            while time.time() < deadline:
                if self.shell("getprop", "sys.boot_completed").strip() == "1":
                    break
                time.sleep(3)
            else:
                sys.exit("error: emulator never finished booting")
            size = re.search(r"(\d+)x(\d+)",
                             self.shell("wm", "size"))
            density = re.search(r"density: (\d+)",
                                self.shell("wm", "density"))
            if not size or not density:
                sys.exit("error: wm size/density unreadable")
            dpr = int(density.group(1)) / 160
            portrait, landscape_now = self.bar_insets(dpr)
            if landscape_now:
                sys.exit("error: display started in landscape unexpectedly")
            # Rotation only applies with a rotatable foreground app.
            self.shell("am", "start", "-a", "android.settings.SETTINGS")
            time.sleep(3)
            self.shell("cmd", "window", "user-rotation", "lock", "1")
            landscape = None
            for _ in range(10):
                time.sleep(2)
                landscape, is_landscape = self.bar_insets(dpr)
                if is_landscape:
                    break
            else:
                sys.exit("error: emulator never rotated to landscape")
            return {
                "width": int(size.group(1)) / dpr,
                "height": int(size.group(2)) / dpr,
                "dpr": dpr,
                "portrait": portrait,
                "landscape": landscape,
            }
        finally:
            subprocess.run([self.adb, "emu", "kill"], capture_output=True)
            process.wait(timeout=30)
            subprocess.run([self.avdmanager, "delete", "avd", "-n",
                            "specprobe-tmp"], capture_output=True)


# --- spec update -------------------------------------------------------------

def merge_metrics(spec, metrics):
    changes = []

    def assign(key, value):
        if spec.get(key) != value:
            changes.append(f"{key}: {spec.get(key)} -> {value}")
        spec[key] = value

    assign("portraitSize", {"width": fmt_json(metrics["width"]),
                            "height": fmt_json(metrics["height"])})
    assign("devicePixelRatio", float(metrics["dpr"]))
    for key, values in (("portraitPadding", metrics["portrait"]),
                        ("landscapePadding", metrics["landscape"])):
        assign(key, {side: fmt_json(values[side])
                     for side in ("left", "top", "right", "bottom")})
    for change in changes:
        print(f"  {change}")


def update_spec(spec_id, mapping, roots, probe, dry_run):
    if "skip" in mapping:
        print(f"{spec_id}: skipped — {mapping['skip']}")
        return
    spec_path = os.path.join(SPECS, f"{spec_id}.json")
    original = open(spec_path).read()
    spec = json.loads(original)

    skin_dir = find_skin(mapping["skin"], roots)
    if skin_dir is None:
        print(f"{spec_id}: skin {mapping['skin']!r} not installed — skipped.\n"
              f"  available: {', '.join(available_skins(roots)) or 'none'}\n"
              f"  (a newer Android Studio ships newer Pixel skins)")
        return
    donor = mapping.get("donor", False)
    print(f"{spec_id} (skin {mapping['skin']}"
          f"{', donor' if donor else ''}"
          f"{', probed' if probe and not donor else ''})")

    if probe is not None and not donor:
        metrics = probe.probe(mapping["avd_device"])
        merge_metrics(spec, metrics)

    dpr = spec["devicePixelRatio"]
    frame, screen_dp = build_frame(skin_dir, dpr)
    size = spec["portraitSize"]
    # Specs may carry Android's rounded dp (412) where px/dpr is fractional
    # (411.43) — tolerate sub-dp drift, refuse anything larger.
    if abs(screen_dp[0] - size["width"]) > 1 or \
            abs(screen_dp[1] - size["height"]) > 1:
        sys.exit(f"error: {spec_id} is {size['width']}x{size['height']} but "
                 f"the skin display is {screen_dp[0]:g}x{screen_dp[1]:g} dp — "
                 "fix the mapping")
    spec["frame"] = frame

    print(f"  frame: body {frame['size']['width']}x{frame['size']['height']}"
          f" offset {frame['screenOffset']['x']},{frame['screenOffset']['y']}")
    if not dry_run:
        text = json.dumps(spec, indent=2)
        if original.endswith("\n"):
            text += "\n"
        open(spec_path, "w").write(text)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("ids", nargs="*", default=None)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--no-probe", action="store_true")
    parser.add_argument("--skins-dir", action="append", default=[])
    parser.add_argument("--preview", metavar="SKIN",
                        help="analyze any available skin without touching "
                             "specs")
    parser.add_argument("--probe-device", metavar="ID",
                        help="with --preview: also probe this AVD device "
                             "profile")
    args = parser.parse_args()
    roots = skin_roots(args.skins_dir)
    print(f"skin roots: {', '.join(roots) or 'none'}")

    if args.preview:
        skin_dir = find_skin(args.preview, roots)
        if skin_dir is None:
            sys.exit(f"error: skin {args.preview!r} not found; available: "
                     f"{', '.join(available_skins(roots)) or 'none'}")
        dpr = 2.625
        if args.probe_device:
            metrics = EmulatorProbe().probe(args.probe_device)
            dpr = metrics["dpr"]
            print(json.dumps(metrics, indent=2))
        frame, screen_dp = build_frame(skin_dir, dpr)
        print(f"screen {fmt(screen_dp[0])}x{fmt(screen_dp[1])} dp @ {dpr}")
        print(json.dumps(frame, indent=2))
        return

    probe = None
    ids = args.ids or sorted(DEVICES)
    if not args.no_probe and any(
            "skip" not in DEVICES[i] and not DEVICES[i].get("donor")
            and find_skin(DEVICES[i]["skin"], roots) for i in ids):
        probe = EmulatorProbe()
    for spec_id in ids:
        update_spec(spec_id, DEVICES[spec_id], roots, probe, args.dry_run)


if __name__ == "__main__":
    main()

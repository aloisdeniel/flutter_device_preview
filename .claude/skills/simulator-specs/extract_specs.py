#!/usr/bin/env python3
"""Rebuild the Apple specs in device_specs/ from the locally installed
iOS Simulator.

Two sources, per device:

* Static artwork (always): the framebuffer mask and DeviceKit chrome inside
  Xcode rebuild the `frame` object (body, bezel, exact display outline).
* A live probe (unless --no-probe): a tiny UIKit app is compiled with
  swiftc, installed on a throwaway simulator of that device type, and
  reports the metrics UIKit actually applies — screen size, scale, and the
  portrait/landscape safe areas — which rewrite `portraitSize`,
  `devicePixelRatio`, `portraitPadding` and `landscapePadding`.

Devices marked `donor` in DEVICES have no simulated counterpart (unreleased
hardware): their frame artwork is derived from the donor device type, and
the probe never overwrites their hand-authored metrics.

See SKILL.md next to this file for the discovery process and the geometry
model. Requires pymupdf (`pip install pymupdf`). Usage:

    python extract_specs.py [--dry-run] [--no-probe] [ids...]
"""

import argparse
import glob
import json
import os
import plistlib
import re
import shutil
import subprocess
import sys
import tempfile

import pymupdf

# Catalog id -> how to derive it from the simulator.
#   sim:      the .simdevicetype name (the donor's for unreleased devices)
#   retarget: (width, height) to 9-slice-stretch the donor mask to
#   donor:    True when `sim` is a stand-in — frame artwork only, keep the
#             spec's hand-authored metrics
DEVICES = {
    "apple-iphone-16": {"sim": "iPhone 16"},
    "apple-iphone-16-plus": {"sim": "iPhone 16 Plus"},
    "apple-iphone-16-pro": {"sim": "iPhone 16 Pro"},
    "apple-iphone-16-pro-max": {"sim": "iPhone 16 Pro Max"},
    # iPhone 16e / 17e: same 390x844 notch panel as the iPhone 14.
    "apple-iphone-16e": {"sim": "iPhone 14", "donor": True},
    "apple-iphone-17e": {"sim": "iPhone 14", "donor": True},
    # iPhone 17 / 17 Pro: same 402x874 island panel as the iPhone 16 Pro.
    "apple-iphone-17": {"sim": "iPhone 16 Pro", "donor": True},
    "apple-iphone-17-pro": {"sim": "iPhone 16 Pro", "donor": True},
    # iPhone Air: no simulated counterpart; stretch the 16 Pro artwork.
    "apple-iphone-air": {"sim": "iPhone 16 Pro", "donor": True,
                         "retarget": (420, 912)},
    "apple-ipad-pro-11": {"sim": "iPad Pro 11-inch (M4)"},
    "apple-ipad-pro-13": {"sim": "iPad Pro 13-inch (M4)"},
    "apple-ipad-air-11": {"sim": "iPad Air 11-inch (M2)"},
    "apple-ipad-air-13": {"sim": "iPad Air 13-inch (M2)"},
    "apple-ipad-mini": {"sim": "iPad mini (A17 Pro)"},
}

SKILL_DIR = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(os.path.dirname(os.path.dirname(SKILL_DIR)))
SPECS = os.path.join(REPO, "device_specs")

PROBE_BUNDLE_ID = "dev.devicepreview.specprobe"
PROBE_INFO_PLIST = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key><string>Probe</string>
  <key>CFBundleIdentifier</key><string>{bundle}</string>
  <key>CFBundleName</key><string>Probe</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>MinimumOSVersion</key><string>16.0</string>
  <key>UILaunchScreen</key><dict/>
  <key>UIDeviceFamily</key><array><integer>1</integer><integer>2</integer></array>
  <key>UISupportedInterfaceOrientations</key>
  <array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
  </array>
</dict>
</plist>
"""


def developer_dir():
    try:
        dev = subprocess.run(["xcode-select", "-p"], capture_output=True,
                             text=True, check=True).stdout.strip()
        if os.path.isdir(dev):
            return dev
    except (OSError, subprocess.CalledProcessError):
        pass
    for app in sorted(glob.glob("/Applications/Xcode*.app")):
        dev = os.path.join(app, "Contents", "Developer")
        if os.path.isdir(dev):
            return dev
    sys.exit("error: no Xcode installation found")


def find_device_type(dev, name):
    bundle = f"{name}.simdevicetype"
    for root in (
        os.path.join(dev, "Platforms/iPhoneOS.platform/Library/Developer/"
                          "CoreSimulator/Profiles/DeviceTypes"),
        "/Library/Developer/CoreSimulator/Profiles/DeviceTypes",
    ):
        path = os.path.join(root, bundle)
        if os.path.isdir(path):
            return path
    sys.exit(f"error: device type not found: {bundle}")


def chrome_resources(dev, chrome_id):
    short = chrome_id.rsplit(".", 1)[-1]
    path = os.path.join(dev, "Platforms/iPhoneOS.platform/Library/Developer/"
                             "DeviceKit/Chrome", f"{short}.devicechrome",
                        "Contents/Resources")
    if not os.path.isdir(path):
        sys.exit(f"error: chrome bundle not found: {short}")
    return path


def load_chrome_json(resources):
    """chrome.json may contain // comments and trailing commas."""
    src = open(os.path.join(resources, "chrome.json")).read()
    src = re.sub(r"^\s*//.*$", "", src, flags=re.M)
    src = re.sub(r",(\s*[}\]])", r"\1", src)
    return json.loads(src)


def fmt(value):
    rounded = round(value, 2)
    if rounded == int(rounded):
        return str(int(rounded))
    return f"{rounded:g}"


def fmt_json(value):
    return int(value) if value == int(value) else round(value, 2)


# --- live metrics probe ------------------------------------------------------

class Simctl:
    """Wraps `xcrun simctl` and the one-off probe app build."""

    def __init__(self, dev):
        self.dev = dev
        self.env = {**os.environ, "DEVELOPER_DIR": dev}
        self.app_dir = None
        self._device_types = None

    def run(self, *args, timeout=120, check=True):
        return subprocess.run(["xcrun", "simctl", *args], env=self.env,
                              capture_output=True, text=True, check=check,
                              timeout=timeout)

    def device_type_id(self, name):
        if self._device_types is None:
            listing = json.loads(self.run("list", "devicetypes", "-j").stdout)
            self._device_types = {
                t["name"]: t["identifier"] for t in listing["devicetypes"]
            }
        if name not in self._device_types:
            sys.exit(f"error: simctl knows no device type named {name!r}")
        return self._device_types[name]

    def newest_ios_runtime(self):
        listing = json.loads(self.run("list", "runtimes", "-j").stdout)
        ios = [r for r in listing["runtimes"]
               if r["isAvailable"] and r["platform"] == "iOS"]
        if not ios:
            sys.exit("error: no available iOS simulator runtime")
        return max(ios, key=lambda r: [int(p) for p in
                                       r["version"].split(".")])["identifier"]

    def build_probe(self, workdir):
        """Compile probe.swift against the iphonesimulator SDK.

        SDKROOT must point at the simulator SDK: with the default macOS
        sysroot the linker stamps a macOS SDK version and UIKit letterboxes
        the app into a compatibility size, which corrupts every metric.
        """
        sdk = subprocess.run(
            ["xcrun", "--sdk", "iphonesimulator", "--show-sdk-path"],
            env=self.env, capture_output=True, text=True, check=True,
        ).stdout.strip()
        app = os.path.join(workdir, "Probe.app")
        os.makedirs(app)
        with open(os.path.join(app, "Info.plist"), "w") as f:
            f.write(PROBE_INFO_PLIST.format(bundle=PROBE_BUNDLE_ID))
        subprocess.run(
            ["xcrun", "swiftc", "-target", "arm64-apple-ios16.0-simulator",
             os.path.join(SKILL_DIR, "probe.swift"),
             "-o", os.path.join(app, "Probe")],
            env={**self.env, "SDKROOT": sdk}, check=True,
        )
        self.app_dir = app

    def probe(self, sim_name):
        """Boot a throwaway simulator of `sim_name` and run the probe app."""
        device_type = self.device_type_id(sim_name)
        runtime = self.newest_ios_runtime()
        udid = self.run("create", "specprobe-tmp", device_type,
                        runtime).stdout.strip()
        try:
            self.run("boot", udid)
            self.run("bootstatus", udid, "-b", timeout=300)
            self.run("install", udid, self.app_dir)
            out = self.run("launch", "--console-pty", udid,
                           PROBE_BUNDLE_ID, timeout=180).stdout
            for line in out.splitlines():
                if line.startswith("SPECPROBE "):
                    return json.loads(line[len("SPECPROBE "):])
            sys.exit(f"error: probe produced no metrics on {sim_name}:\n{out}")
        finally:
            self.run("shutdown", udid, check=False)
            self.run("delete", udid, check=False)


def merge_metrics(spec_id, spec, metrics):
    """Write the probed metrics into the spec, reporting every change."""
    if not metrics.get("landscapeIsLandscape"):
        sys.exit(f"error: probe never reached landscape on {spec_id}")

    def pad(values):
        return {side: fmt_json(values[side])
                for side in ("left", "top", "right", "bottom")}

    changes = []

    def assign(key, value):
        if spec.get(key) != value:
            changes.append(f"{key}: {spec.get(key)} -> {value}")
        spec[key] = value

    assign("portraitSize", {"width": fmt_json(metrics["width"]),
                            "height": fmt_json(metrics["height"])})
    assign("devicePixelRatio", float(metrics["scale"]))
    assign("portraitPadding", pad(metrics["padding"]))
    assign("landscapePadding", pad(metrics["landscapePadding"]))
    for change in changes:
        print(f"  {change}")
    return changes


# --- framebuffer mask -> screenPath ------------------------------------------

def mask_subpaths(pdf_path):
    """Parse the mask's content stream and return the display outline as
    subpaths of (op, points) segments, in PDF page space (pixels, y-up).

    Depending on the device generation the outline is either a `W*` clip
    path (phones — invisible to get_drawings()) or a plain fill under a
    translate transform (iPads); of all candidate paths we keep the one with
    the most curves. Only the operators these masks actually use are
    handled: path construction, q/Q/cm, and the painting/clipping ops.
    """
    doc = pymupdf.open(pdf_path)
    page = doc[0]
    stream = b" ".join(doc.xref_stream(x) for x in page.get_contents())
    tokens = stream.decode("latin-1").split()
    best, current, stack = None, [], []
    ctm, saved = (1, 0, 0, 1, 0, 0), []

    def apply(x, y):
        a, b, c, d, e, f = ctm
        return (a * x + c * y + e, b * x + d * y + f)

    def points(nums):
        out = []
        for i in range(0, len(nums), 2):
            out.extend(apply(nums[i], nums[i + 1]))
        return out

    def keep_best():
        nonlocal best
        curves = sum(1 for sub in current for op, _ in sub if op == "C")
        if current and (best is None or curves > best[0]):
            best = (curves, current)

    for token in tokens:
        try:
            stack.append(float(token))
            continue
        except ValueError:
            pass
        if token == "q":
            saved.append(ctm)
        elif token == "Q":
            ctm = saved.pop() if saved else (1, 0, 0, 1, 0, 0)
        elif token == "cm":
            a, b, c, d, e, f = stack[-6:]
            A, B, C, D, E, F = ctm
            ctm = (a * A + b * C, a * B + b * D, c * A + d * C,
                   c * B + d * D, e * A + f * C + E, e * B + f * D + F)
        elif token == "m":
            current.append([("M", points(stack[-2:]))])
        elif token == "l":
            current[-1].append(("L", points(stack[-2:])))
        elif token == "c":
            current[-1].append(("C", points(stack[-6:])))
        elif token == "v":
            x0, y0 = current[-1][-1][1][-2:]
            current[-1].append(("C", [x0, y0] + points(stack[-4:])))
        elif token == "y":
            p2 = points(stack[-2:])
            current[-1].append(("C", points(stack[-4:-2]) + p2 + p2))
        elif token == "re":
            pass  # page-rect clips, not the outline
        elif token == "h":
            if current:
                current[-1].append(("Z", []))
        elif token in ("W", "W*"):
            keep_best()
        elif token in ("n", "S"):
            current = []
        elif token in ("f", "f*", "F", "b", "b*", "B", "B*"):
            keep_best()
            current = []
        stack = stack[-6:]
    if best is None or best[0] == 0:
        sys.exit(f"error: no outline path found in {pdf_path}")
    return best[1], page.rect.height


def screen_path(pdf_path, scale, donor_size, retarget):
    subpaths, page_h = mask_subpaths(pdf_path)
    dw = dh = 0
    if retarget is not None:
        dw = retarget[0] - donor_size[0]
        dh = retarget[1] - donor_size[1]

    def point(x, y):
        x, y = x / scale, (page_h - y) / scale
        if x > donor_size[0] / 2:
            x += dw
        if y > donor_size[1] / 2:
            y += dh
        return f"{fmt(x)},{fmt(y)}"

    parts = []
    for sub in subpaths:
        for op, nums in sub:
            if op == "Z":
                parts.append("Z")
            else:
                pairs = [point(nums[i], nums[i + 1])
                         for i in range(0, len(nums), 2)]
                parts.append(op + " " + " ".join(pairs))
        if sub[-1][0] != "Z":  # clips close implicitly, `d` strings don't
            parts.append("Z")
    return " ".join(parts)


# --- chrome -> body SVG ------------------------------------------------------

def hex_color(rgb):
    return "#%02x%02x%02x" % tuple(round(c * 255) for c in rgb)


def composite_shapes(resources, chrome, border):
    """Shapes from PhoneComposite.pdf, in paint order.

    Composites come in two flavors — concentric rounded-rect strokes
    (stroke of width w centered on the screen rect -> full fill at inset
    border - w/2, covered inside by whatever paints next) and nested
    symmetric fills. Translucent symmetric fills are drop shadows / guide
    tints that end up fully covered; translucent asymmetric fills are the
    button nubs on the edges, kept as-is.
    """
    composite = os.path.join(
        resources, chrome["images"]["composite"] + ".pdf")
    page = pymupdf.open(composite)[0]
    W, H = page.rect.width, page.rect.height
    shapes = []
    for item in page.get_drawings():
        rect = item["rect"]
        if item["type"] == "s" and item.get("width"):
            shapes.append(("ring", border - item["width"] / 2,
                           item["color"], 1.0))
            continue
        if item["type"] != "f":
            continue
        symmetric = abs((W - rect.x1) - rect.x0) < 1.5 and \
            abs((H - rect.y1) - rect.y0) < 1.5 and \
            abs(rect.x0 - rect.y0) < 1.5
        if item["fill_opacity"] >= 1.0 and symmetric:
            shapes.append(("ring", round(rect.x0, 2), item["fill"], 1.0))
        elif item["fill_opacity"] < 1.0 and not symmetric:
            shapes.append(("rect", rect, item["fill"],
                           item["fill_opacity"]))
    if not any(shape[0] == "ring" for shape in shapes):
        sys.exit(f"error: no bezel shapes in {composite}")
    return shapes


def slice_rings(resources, chrome):
    """Ring list from the top-left 9-slice corner tile, whose nested fills
    paint at natural size (inset = distance from the tile edge)."""
    tile = os.path.join(resources, chrome["images"]["topLeft"] + ".pdf")
    page = pymupdf.open(tile)[0]
    rings = []
    for item in page.get_drawings():
        rect = item["rect"]
        # A ring fill starts on the tile diagonal and spans to its far edge;
        # anything else (button shadows, ...) is not part of the bezel stack.
        if item["type"] != "f" or abs(rect.x0 - rect.y0) > 0.5 or \
                rect.x1 < page.rect.width - 1 or rect.y1 < page.rect.height - 1:
            continue
        rings.append(("ring", round(rect.x0), item["fill"],
                      item["fill_opacity"]))
    if not rings:
        sys.exit(f"error: no ring fills in {tile}")
    return rings


def body_svg(size, shapes, radius):
    w, h = size
    lines = [f'<svg viewBox="0 0 {fmt(w)} {fmt(h)}">']
    for shape in shapes:
        kind, color, opacity = shape[0], shape[-2], shape[-1]
        if kind == "ring":
            inset = shape[1]
            r = max(0.0, radius - inset)
            attrs = (f'x="{fmt(inset)}" y="{fmt(inset)}" '
                     f'width="{fmt(w - 2 * inset)}" '
                     f'height="{fmt(h - 2 * inset)}" rx="{fmt(r)}"')
        else:
            rect = shape[1]
            attrs = (f'x="{fmt(rect.x0)}" y="{fmt(rect.y0)}" '
                     f'width="{fmt(rect.width)}" '
                     f'height="{fmt(rect.height)}" rx="1"')
        attrs += f' fill="{hex_color(color)}"'
        if opacity < 1.0:
            attrs += f' fill-opacity="{fmt(opacity)}"'
        lines.append(f"  <rect {attrs}/>")
    lines.append("</svg>")
    return lines


# --- spec update -------------------------------------------------------------

def update_spec(dev, spec_id, mapping, simctl, dry_run):
    sim_name = mapping["sim"]
    retarget = mapping.get("retarget")
    spec_path = os.path.join(SPECS, f"{spec_id}.json")
    original = open(spec_path).read()
    spec = json.loads(original)

    device_type = find_device_type(dev, sim_name)
    profile = plistlib.load(
        open(os.path.join(device_type, "Contents/Resources/profile.plist"),
             "rb"))
    scale = profile["mainScreenScale"]
    donor = (profile["mainScreenWidth"] / scale,
             profile["mainScreenHeight"] / scale)
    logical = retarget or donor
    probed = simctl is not None and not mapping.get("donor")
    print(f"{spec_id} (from {sim_name}"
          f"{' retargeted' if retarget else ''}"
          f"{', probed' if probed else ''})")

    if probed:
        metrics = simctl.probe(sim_name)
        if (metrics["width"], metrics["height"]) != donor or \
                metrics["scale"] != scale:
            sys.exit(f"error: probe reported "
                     f"{metrics['width']}x{metrics['height']}"
                     f"@{metrics['scale']} but {sim_name}'s profile says "
                     f"{donor[0]:g}x{donor[1]:g}@{scale:g} — the probe app "
                     "was letterboxed, check its build")
        merge_metrics(spec_id, spec, metrics)

    size = spec["portraitSize"]
    if (size["width"], size["height"]) != logical or \
            spec["devicePixelRatio"] != scale:
        sys.exit(f"error: {spec_id} is {size['width']}x{size['height']}"
                 f"@{spec['devicePixelRatio']}, simulator artwork is "
                 f"{logical[0]:g}x{logical[1]:g}@{scale:g} — fix the mapping")

    resources = chrome_resources(dev, profile["chromeIdentifier"])
    chrome = load_chrome_json(resources)
    outside = chrome["paths"]["simpleOutsideBorder"]
    if any(outside["insets"].values()) or \
            outside["cornerRadiusX"] != outside["cornerRadiusY"]:
        sys.exit(f"error: unsupported simpleOutsideBorder in {resources}")
    radius = outside["cornerRadiusX"]

    composite_name = chrome["images"].get("composite")
    if composite_name and os.path.exists(
            os.path.join(resources, composite_name + ".pdf")):
        page = pymupdf.open(
            os.path.join(resources, composite_name + ".pdf"))[0].rect
        border = (page.width - donor[0]) / 2
        if border != (page.height - donor[1]) / 2 or border <= 0:
            sys.exit(f"error: off-center composite for {spec_id}")
        shapes = composite_shapes(resources, chrome, border)
    else:
        border = chrome["images"]["sizing"]["leftWidth"]
        shapes = slice_rings(resources, chrome)
    body = (logical[0] + 2 * border, logical[1] + 2 * border)

    mask = os.path.join(device_type, "Contents/Resources",
                        profile["framebufferMask"] + ".pdf")
    path = screen_path(mask, scale, donor, retarget)
    # The mask has no Dynamic Island cutout (iOS draws the island itself);
    # keep the pill subpaths the spec already models, wound opposite to the
    # outline so nonZero filling punches the hole.
    old_subpaths = [p.strip() for p in
                    re.split(r"\s*(?=M)", spec["frame"]["screenPath"])
                    if p.strip()]
    extras = old_subpaths[1:]
    if extras:
        path = " ".join([path] + extras)

    spec["frame"] = {
        "size": {"width": fmt_json(body[0]), "height": fmt_json(body[1])},
        "screenOffset": {"x": fmt_json(border), "y": fmt_json(border)},
        "screenPath": path,
        "body": body_svg(body, shapes, radius),
    }

    print(f"  frame: body {fmt(body[0])}x{fmt(body[1])} border {fmt(border)}"
          f" radius {radius} shapes {len(shapes)}")
    if not dry_run:
        text = json.dumps(spec, indent=2)
        if original.endswith("\n"):
            text += "\n"
        open(spec_path, "w").write(text)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("ids", nargs="*", default=None)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--no-probe", action="store_true",
                        help="skip the booted-simulator metrics probe and "
                             "only rebuild the frame artwork")
    args = parser.parse_args()
    dev = developer_dir()
    print(f"developer dir: {dev}")

    ids = args.ids or sorted(DEVICES)
    simctl = None
    workdir = None
    if not args.no_probe and any(not DEVICES[i].get("donor") for i in ids):
        simctl = Simctl(dev)
        workdir = tempfile.mkdtemp(prefix="specprobe-")
        simctl.build_probe(workdir)
    try:
        for spec_id in ids:
            update_spec(dev, spec_id, DEVICES[spec_id], simctl, args.dry_run)
    finally:
        if workdir:
            shutil.rmtree(workdir, ignore_errors=True)


if __name__ == "__main__":
    main()

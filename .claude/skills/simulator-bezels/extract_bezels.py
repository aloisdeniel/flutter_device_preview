#!/usr/bin/env python3
"""Rebuild the Apple `frame` objects in device_specs/ from the iOS Simulator
bezel artwork inside the locally installed Xcode.

See SKILL.md next to this file for the discovery process and the geometry
model. Requires pymupdf (`pip install pymupdf`). Usage:

    python extract_bezels.py [--dry-run] [ids...]
"""

import argparse
import glob
import json
import os
import plistlib
import re
import subprocess
import sys

import pymupdf

# Catalog id -> (simdevicetype name, retarget) where retarget is None for a
# device whose logical panel matches the simulated one, or the target
# (width, height) for a 9-slice retarget of the donor mask. Devices absent
# from the installed Xcode list a donor device type here.
DEVICES = {
    "apple-iphone-16": ("iPhone 16", None),
    "apple-iphone-16-plus": ("iPhone 16 Plus", None),
    "apple-iphone-16-pro": ("iPhone 16 Pro", None),
    "apple-iphone-16-pro-max": ("iPhone 16 Pro Max", None),
    # iPhone 16e / 17e: same 390x844 notch panel as the iPhone 14.
    "apple-iphone-16e": ("iPhone 14", None),
    "apple-iphone-17e": ("iPhone 14", None),
    # iPhone 17 / 17 Pro: same 402x874 island panel as the iPhone 16 Pro.
    "apple-iphone-17": ("iPhone 16 Pro", None),
    "apple-iphone-17-pro": ("iPhone 16 Pro", None),
    # iPhone Air: no simulated counterpart; stretch the 16 Pro artwork.
    "apple-iphone-air": ("iPhone 16 Pro", (420, 912)),
    "apple-ipad-pro-11": ("iPad Pro 11-inch (M4)", None),
    "apple-ipad-pro-13": ("iPad Pro 13-inch (M4)", None),
    "apple-ipad-air-11": ("iPad Air 11-inch (M2)", None),
    "apple-ipad-air-13": ("iPad Air 13-inch (M2)", None),
    "apple-ipad-mini": ("iPad mini (A17 Pro)", None),
}

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))
SPECS = os.path.join(REPO, "device_specs")


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

def update_spec(dev, spec_id, sim_name, retarget, dry_run):
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

    print(f"{spec_id}: body {fmt(body[0])}x{fmt(body[1])} border {fmt(border)}"
          f" radius {radius} shapes {len(shapes)}"
          f" (from {sim_name}{' retargeted' if retarget else ''})")
    if not dry_run:
        text = json.dumps(spec, indent=2)
        if original.endswith("\n"):
            text += "\n"
        open(spec_path, "w").write(text)


def fmt_json(value):
    return int(value) if value == int(value) else round(value, 2)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("ids", nargs="*", default=None)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    dev = developer_dir()
    print(f"developer dir: {dev}")
    for spec_id in args.ids or sorted(DEVICES):
        sim_name, retarget = DEVICES[spec_id]
        update_spec(dev, spec_id, sim_name, retarget, args.dry_run)


if __name__ == "__main__":
    main()

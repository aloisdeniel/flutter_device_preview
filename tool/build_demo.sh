#!/usr/bin/env bash
#
# Builds the interactive demo of the landing page:
#
#   * `docs/demo/`               — the counter example (`example/lib/counter.dart`)
#                                  compiled for the web,
#   * `docs/device_catalog.json` — the device catalog the page's panel pushes
#                                  to it.
#
# Usage: tool/build_demo.sh   (from anywhere)
#
# Then serve `docs/` over HTTP — `python3 -m http.server -d docs 8080` — and
# open http://localhost:8080. Opening `index.html` from the file system will
# not work: both the demo and the catalog are fetched.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
example="$root/device_preview/example"
out="$root/docs/demo"

echo "==> Generating docs/device_catalog.json"
(cd "$root" && dart tool/generate_demo_catalog.dart)

echo "==> Building the demo app (release, web)"
(cd "$example" && flutter build web --release --target lib/counter.dart)

echo "==> Copying to docs/demo"
rm -rf "$out"
mkdir -p "$out"
cp -R "$example/build/web/." "$out/"

# The site is served from a subdirectory on GitHub Pages and from the root
# locally, so the demo has to resolve its own assets relatively. Flutter
# refuses a relative `--base-href`, hence the rewrite. The transparent
# background lets the letterbox around the simulated device show the page
# through, and the app is never scrolled by the browser: the device is
# already fitted to the iframe.
perl -0pi -e 's|<base href="/">|<base href="./">|' "$out/index.html"
perl -0pi -e 's|</head>|  <style>\n    html, body { background: transparent; margin: 0; height: 100%; overflow: hidden; }\n  </style>\n</head>|' "$out/index.html"
perl -0pi -e 's|<title>.*?</title>|<title>device_preview demo</title>|s' "$out/index.html"

# `--web-resources-cdn` (on by default) makes the loader fetch CanvasKit from
# gstatic.com, keyed by the engine revision baked into flutter_bootstrap.js, so
# the 37 MB the build copies next to it is never read. Dropping it takes the
# published demo from ~40 MB to ~3 MB.
rm -rf "$out/canvaskit"

echo "==> Done: $out"
du -sh "$out"

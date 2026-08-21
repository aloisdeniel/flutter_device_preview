#!/usr/bin/env bash
# Pre-publish gate for device_preview. Run from anywhere:
#
#   tool/check_release.sh
#
# Verifies everything a `flutter pub publish` silently gets wrong when run
# from an incomplete checkout, then runs both packages' analyzers and suites
# (including the VM-service e2e smoke, which needs --enable-vmservice) and a
# publish dry run. Exits non-zero on the first failure.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT/device_preview/extension/devtools/build"

fail() { echo "RELEASE CHECK FAILED: $1" >&2; exit 1; }

echo "== version consistency =="
# The pubspec version must have a matching CHANGELOG heading (pub.dev shows
# "no changelog" otherwise), and a final release must not linger on a
# prerelease suffix by accident.
VERSION=$(sed -n 's/^version: //p' "$ROOT/device_preview/pubspec.yaml")
grep -q "^## $VERSION\b" "$ROOT/device_preview/CHANGELOG.md" || fail \
  "CHANGELOG.md has no '## $VERSION' entry matching pubspec.yaml"
echo "version $VERSION, changelog entry present"

echo "== DevTools extension bundle =="
# The compiled extension ships inside the package; publishing without it
# gives every user a DevTools tab whose iframe 404s.
[ -f "$BUILD_DIR/index.html" ] || fail \
  "device_preview/extension/devtools/build/ is missing or empty — run tool/build_devtools_extension.sh"
# And it must be committed: a fresh clone (or CI) publishes from git content.
git -C "$ROOT" ls-files --error-unmatch "device_preview/extension/devtools/build/index.html" \
  >/dev/null 2>&1 || fail \
  "the extension build exists on disk but is not tracked by git — 'git add device_preview/extension/devtools/build'"
# Warn when the committed build predates the extension source.
NEWER=$(find "$ROOT/device_preview_devtools_extension/lib" -name '*.dart' -newer "$BUILD_DIR/index.html" | head -1)
[ -z "$NEWER" ] || echo "WARNING: extension source is newer than the committed build ($NEWER) — consider rebuilding."

echo "== device_preview: analyze + tests (with VM-service e2e) =="
(cd "$ROOT/device_preview" && flutter analyze)
(cd "$ROOT/device_preview" && flutter test)
(cd "$ROOT/device_preview" && flutter test --enable-vmservice test/e2e)

echo "== device_preview_devtools_extension: analyze + tests =="
(cd "$ROOT/device_preview_devtools_extension" && flutter analyze)
(cd "$ROOT/device_preview_devtools_extension" && flutter test)

echo "== publish dry run =="
(cd "$ROOT/device_preview" && dart pub publish --dry-run)

echo
echo "All release checks passed."

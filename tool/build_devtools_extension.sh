#!/usr/bin/env bash
# Rebuilds the DevTools extension web app and copies the compiled output into
# device_preview/extension/devtools/build/ — the directory bundled into the
# published package and served by the DevTools server. The output is committed
# (see .gitignore's re-include); run this and commit whenever the extension
# source under device_preview_devtools_extension/ changes.
set -euo pipefail

cd "$(dirname "$0")/../device_preview_devtools_extension"

dart run devtools_extensions build_and_copy \
  --source=. \
  --dest=../device_preview/extension/devtools

dart run devtools_extensions validate --package=../device_preview

echo "Extension rebuilt into device_preview/extension/devtools/build/."
echo "Remember to commit the refreshed build output."

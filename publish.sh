pushd device_preview_devtools_extension

flutter pub get
dart run devtools_extensions build_and_copy --source=. --dest=../device_preview/extension/devtools

popd

pushd device_preview
# flutter pub publish
popd
# device_preview_example

A simple example of an application that uses `device_preview` for testing on different device configurations.

## Web

To launch on web, dont forget to active Skia rendering 

```
flutter run -d chrome --release --dart-define=FLUTTER_WEB_USE_SKIA=true
```
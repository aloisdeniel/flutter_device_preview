# Plugin : Screenshot

![illustration](images/screenshot.png ':size=150')

## Install

Declare it as any other dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  device_preview_screenshot: <latest version>
```

Then, add a `DevicePreviewScreenshot` to your `DevicePreview`'s `tools` property.

```dart
import 'package:device_preview_screenshot/device_preview_screenshot.dart';

DevicePreview(
    // ...
    tools: [
        ...DevicePreview.defaultTools,
        const DevicePreviewScreenshot(),
    ],
),
```

## Usage

Click on the dedicated button from the toolbar to create a capture of your preview.

### Screenshot storage

You can customize the way your screenshots are saved by updating the `onScreenshot` property of the plugin.

By default, the screenshots are displayed as base64 image data in the console *(and saved in your Clipboard)*.

You can also choose to save the screenshot in the local storage of your device by using `screenshotAsFiles(Directory directory)` , or to implement a custom `ScreenshotProcessor`.

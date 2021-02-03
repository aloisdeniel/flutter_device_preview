# Plugin : Screenshot

![illustration](images/screenshot.png ':size=150')

## Configure

Add a `ScreenshotPlugin` to your `DevicePreview`'s `plugins` property.

```dart
import 'package:device_preview/plugins.dart';

DevicePreview(
    // ...
    plugins: [
        const ScreenshotPlugin(),
    ],
),
```

## Usage

Click on the dedicated button from the toolbar to create a capture of your preview. A link to download the screenshot is then copied to your clipboard and displayed in your device debugging console.

# Plugin : File explorer

## Configure

Add a `ScreenshotPlugin` to your `DevicePreview`'s `plugins` property.

```dart
DevicePreview(
    // ...
    plugins: [
        const FileExplorerPlugin(),
    ],
),
```

## Usage

Click on the dedicated button from the toolbar to open the file explorer.

You will have access to all files from the various internal directories of your app and you will be able to preview text file content.
# Plugin : Shared Preferences explorer


## Configure

Add a `SharedPreferencesExplorerPlugin` to your `DevicePreview`'s `plugins` property.

```dart
DevicePreview(
    // ...
    plugins: [
        const SharedPreferencesExplorerPlugin(),
    ],
),
```

## Usage

Click on the dedicated button from the toolbar to open the shared preferences explorer.

You will have inspect all of your app's shared  preference keys and values.

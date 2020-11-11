# Options

 This section descrive the options available for customizing the behaviours of `DevicePreview`.

## **enabled**

**Defaults to :** `true`

If not `enabled`, the `child` is used directly.

##### Example

```dart
DevicePreview(
  enabled: !kReleaseMode, // Ensures that it is disabled in release mode
  builder: (context) => MyApp(),
)
```

## **storage** 

**Defaults to :** `const PreferencesDevicePreviewStorage()`

Indicates how the configuration should be persisted between sessions. Defaults to `PreferencesDevicePreviewStorage` which save all preferences as a JSON document in the shared preferences.

To deactivate persistence, use `NoDevicePreviewStorage`.

If you use a lot of plugins, the `FileDevicePreviewStorage` may be a better option too.

##### Example

```dart
DevicePreview(
  storage: const NoDevicePreviewStorage(), // No persistence
  builder: (context) => MyApp(),
)
```

## **isToolbarVisible**

**Defaults to :** `true`

Indicates whether the settings toolbar should be visible.

##### Example

```dart
DevicePreview(
  isToolbarVisible: false, // Hides toolbar
  builder: (context) => MyApp(),
)
```

## **style**

**Defaults to :** `DevicePreviewStyle.fallback(context)`

Set the visual aspect of the device preview.

##### Example

```dart
DevicePreview(
  style: DevicePreviewStyle(
    background: BoxDecoration(color: const Color(0xFFFF0000)),
    toolbar: DevicePreviewToolBarStyle.light(),
  ),
  builder: (context) => MyApp(),
)
```

## **plugins**

**Defaults to :** `const <DevicePreviewPlugin>[]`

Add plugin buttons to the toolbar.

See the [plugins section](/context/plugins/screenshots.) for more details.

##### Example

```dart
import 'package:device_preview/plugins.dart';

DevicePreview(
  plugins: [
    const ScreenshotPlugin(),
    const FileExplorerPlugin(),
  ]
  builder: (context) => MyApp(),
)
```

## **availableLocales**

**Defaults to :** `defaultAvailableLocales (see lib/src/locales/default_locales.dart)`

The locales that are available on the simulated device.

```dart
DevicePreview(
  availableLocales: [
    Locale('en_US'),
    Locale('fr_FR'),
  ]
  builder: (context) => MyApp(),
)
```
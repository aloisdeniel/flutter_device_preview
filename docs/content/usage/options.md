# Options

 This section descrive the options available for customizing the behaviours of `DevicePreview`.

## **enabled**

**Defaults to :** `true`

If not `enabled`, the `builder`'s result is used directly and the preview is ignored.

##### Example

```dart
DevicePreview(
  enabled: !kReleaseMode, // Ensures that it is disabled in release mode
  builder: (context) => MyApp(),
)
```

## **storage** 

**Defaults to :** `DevicePreviewStorage.preferences()`

Indicates how the device preview settings should be persisted between sessions. Defaults to `DevicePreviewStorage.preferences()` which save all preferences as a JSON document in the shared preferences.

To disable persistence between sessions, use `DevicePreviewStorage.none()`.

##### Example

```dart
DevicePreview(
  storage: const DevicePreviewStorage.none(), // No persistence
  builder: (context) => MyApp(),
)
```

## **isToolbarVisible**

**Defaults to :** `true`

Indicates whether the settings toolbar should be visible.

##### Example

```dart
DevicePreview(
  isToolbarVisible: false, // Hides toolbar but keep preview active
  builder: (context) => MyApp(),
)
```

## **tools**

**Defaults to :** `DevicePreview.defaultTools`

All of the tools available from the Device Preview menu.

By default, the available sections are : 

*  `DeviceSection()` : a device model, the screen orientation, the frame visibility, the keyboard visibility
*  `SystemSection()` : the current device locale, the theme (light or dark)
*  `AccessibilitySection()` : text scaling factory, color and navigation accessibility options
*  `SettingsSection()` : the Device Preview theme (light or dark).

See the [plugins section](/content/plugins/screenshot) to learn more on how to add additionnal sections like ScreenshotSection or a custom one.

##### Example

```dart
import 'package:device_preview/plugins.dart';

DevicePreview(
  builder: (context) => const MyApp(),
  tools: [
    ...DevicePreview.defaultTools,
    const DevicePreviewScreenshot(),
  ],
)
```

## **availableLocales**

**Defaults to :** `defaultAvailableLocales (see lib/src/locales/default_locales.dart)`

The locales that are available from the locale menu.

```dart
DevicePreview(
  availableLocales: [
    Locale('en_US'),
    Locale('fr_FR'),
  ]
  builder: (context) => MyApp(),
)
```

## **data**

**Defaults to :** `null`

Allow to override the tool configuration (selected device and other options).

```dart
DevicePreview(
  builder: (context) => const MyApp(),
  data: DevicePreviewData(
    deviceIdentifier: Devices.ios.iPhone11.toString(),
    isFrameVisible: false,
    locale: 'fr_FR',
  ),
),
```

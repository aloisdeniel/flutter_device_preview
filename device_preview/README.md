<p align="center">
  <img src="https://github.com/aloisdeniel/flutter_device_preview/raw/master/logo.png" alt="Device Preview for Flutter" />
</p>

<h4 align="center">Approximate how your app looks and performs on another device.</h4>

<p align="center">
  <a href="https://pub.dartlang.org/packages/device_preview"><img src="https://img.shields.io/pub/v/device_preview.svg"></a>
  <a href="https://www.buymeacoffee.com/aloisdeniel">
    <img src="https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat">
  </a>
</p>

<p align="center">
  <img src="https://github.com/aloisdeniel/flutter_device_preview/raw/master/device_preview.gif" alt="Device Preview for Flutter" />
</p>

## Features

* Preview any device from any device
* Change device orientation
* Dynamic system configuration: language, dark mode, text scaling factor
* Freeform device with adjustable resolution and safe areas
* Keep the application state
* Take screenshots
* Customizable plugins

## Quickstart

Wrap your app's root widget in a `DevicePreview` and inject the dedicated `builder` and `locale` into your app.

```dart
import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
    plugins: [
      const ScreenshotPlugin(),
    ]
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
      builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
      home: HomePage(),
    );
  }
}
```

## Plugins

Each provided plugin adds a button in the toolbar.

### ScreenshotPlugin

Takes a screenshot of the device preview as an image.

### FileExplorerPlugin

Allow to inspect the local storage of the application.

### SharedPreferencesExplorerPlugin

Allow to inspect shared preferences.

### Custom

You can provide a custom `DevicePreviewPlugin` to add your own debugging tools.

```dart
class MyAwesomePlugin extends DevicePreviewPlugin {
  const FileExplorerPlugin()
      : super(
          identifier: 'my_awesome_plugin',
          name: 'My awesome plugin',
          icon: Icons.star,
          windowSize: const Size(320, 480),
        );

  @override
  Widget buildData(
      BuildContext context, Map<String, dynamic> data, updateData) {
     return PopoverScaffold(
      title: PopoverBar(
        title: Text('Awesome'),
      ),
      body: Center(
        Text('This is my own window'),
      ),
    );
  }
}
```

## Customization

### `enabled`

This property can be used to disable the preview.

##### Example

```dart
DevicePreview(
  enabled: !kReleaseMode, // Ensures that it is disabled in release mode
  builder: (context) => MyApp(),
)
```

### `storage`

Indicates how the configuration should be persisted between sessions. Defaults to `PreferencesDevicePreviewStorage` which save all preferences as a JSON document in the shared preferences.

To deactivate persistence, use `NoDevicePreviewStorage`.

If you use a lot of plugins, the `FileDevicePreviewStorage` may be a better option too.

##### Example

```dart
DevicePreview(
  storage: const NoDevicePreviewStorage(),
  builder: (context) => MyApp(),
)
```

### `isToolbarVisible`

Indicates whether the settings menu should be visible.

##### Example

```dart
DevicePreview(
  isToolbarVisible: false,
  builder: (context) => MyApp(),
)
```

### `background`

The decoration used as the preview window background.

##### Example

```dart
DevicePreview(
  background: BoxDecoration(color: Colors.red),
  builder: (context) => MyApp(),
)
```

### `toolBarStyle`

The style of the bottom toolbar.

```dart

DevicePreview(
  toolBarStyle: DevicePreviewToolBarStyle.light(),
  builder: (context) => MyApp(),
)
```

### `onScreenshot`

The processor used when the user takes a new screenshots.

By default, all screenshots are uploaded to [file.io](https://file.io/) 
and the links are printed into the debugging console.


##### Example

```dart
DevicePreview(
  onScreenshot: (screenshot) {
    final bytes = screenshot.bytes;
    //  Send the bytes to a drive, to the file system, to 
    // the device gallery for example. It may be useful for
    // preparing your app release for example.
  },
  builder: (context) => MyApp(),
)
```

## Limitations

Think of Device Preview as a first-order approximation of how your app looks and feels on a mobile device. With Device Mode you don't actually run your code on a mobile device. You simulate the mobile user experience from your laptop, desktop or tablet.

There are some aspects of mobile devices that Device Preview will never be able to simulate. When in doubt, your best bet is to actually run your app on a real device.

## FAQ

> What devices can I use for previewing?

If you are running the `stable`, `beta` or `dev` channel of Flutter, you can use Android or iOS.
If you are running the `master` channel of Flutter, you can use macOS, Android or iOS.

> What about Windows?

Since Flutter is still in technical preview on Windows, the `path_provider` dependency can be satisfied by adding this dependency in your `pubspec.yaml` if you are on the `master` channel of Flutter:

```yaml
device_preview:
shared_preferences_fde:
  git:
    url: https://github.com/google/flutter-desktop-embedding/
    path: plugins/flutter_plugins/shared_preferences_fde
```
This is a temporary solution only. More information about this plug-in can be found [here](https://github.com/google/flutter-desktop-embedding/blob/master/plugins/flutter_plugins/README.md).

## Ideas and roadmap

* Status bar
* Override WidgetsBinding
  * Simulate physical button
  * Simulate lifecycle events
* Favorite devices
* More device filters : device type, search by name.
* Storage explorer
* Add custom predefineded devices 
* Desktop devices
* TV devices
* Complete documentation

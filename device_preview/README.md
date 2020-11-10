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
      locale: DevicePreview.locale(context), // <--- /!\ Add the locale
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

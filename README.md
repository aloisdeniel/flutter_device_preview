## Important

Working fork for flutter beta channel (with null safety braking changes). 

Probably obsolote after 3. March 2021

This branch can be used per direct git dependency:

```yml
  device_preview:
    git:
      url: https://github.com/FluentChange/flutter_device_preview.git
      path: device_preview
      ref: nnbd_git_dependency
```

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

## Main features

* Preview any device from any device
* Change the device orientation
* Dynamic system configuration (*language, dark mode, text scaling factor, ...)*
* Freeform device with adjustable resolution and safe areas
* Keep the application state
* Plugin system (*Screenshot, File explorer, ...*)
* Customizable plugins

## Quickstart

Wrap your app's root widget in a `DevicePreview` and inject the dedicated `builder` and `locale` into your app.

> Make sure to provide `locale` and `builder` to your `WidgetsApp`. If not defined, `MediaQuery` won't be simulated for the selected device and selected locale won't be applied.

```dart
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder, // Add the builder here
      home: HomePage(),
    );
  }
}
```

## Documentation

<a href='https://aloisdeniel.github.io/flutter_device_preview/' target='_blank'>Open the website</a>

## Demo

<a href='https://flutter-device-preview.firebaseapp.com/' target='_blank'>Open the demo</a>

## Limitations

Think of Device Preview as a first-order approximation of how your app looks and feels on a mobile device. With Device Mode you don't actually run your code on a mobile device. You simulate the mobile user experience from your laptop, desktop or tablet.

!> There are some aspects of mobile devices that Device Preview will never be able to simulate. When in doubt, your best bet is to actually run your app on a real device.

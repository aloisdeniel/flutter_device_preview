<p align="center">
  <img src="https://github.com/aloisdeniel/flutter_device_preview/raw/master/logo.png" alt="Device Preview for Flutter" />
</p>

<h4 align="center">Approximate how your app looks and performs on a mobile device.</h4>

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
* Dynamic system configuration : language, dark mode, text scaling factor
* Freeform device with adjustable resolution and safe areas
* Keep the application state
* Take screenshots

## Quickstart

```dart
void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);
```


```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale, // <--- Add the locale 
      builder: DevicePreview.appBuilder, // <--- Add the builder 
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

## Limitations

Think of Device Preview as a first-order approximation of how your app looks and feels on a mobile device. With Device Mode you don't actually run your code on a mobile device. You simulate the mobile user experience from your laptop, desktop or tablet.

There are some aspects of mobile devices that Device Preview will never be able to simulate. When in doubt, your best bet is to actually run your app on a real device.

## FAQ

> Can I use device preview with Desktop embedding ?

Yes, you just have to add thoses dependencies in your `pubspec.yaml` :

```yaml
device_preview:
path_provider_fde:
  git:
    url: https://github.com/google/flutter-desktop-embedding/
    path: plugins/flutter_plugins/path_provider_fde
```

## Ideas and roadmap

- Status bar
- Override WidgetsBinding
  - Simulate physical button
  - Simulate lifecycle events
- Storage explorer
- Add custom devices state
- Desktop devices
- TV devices
- Complete documentation
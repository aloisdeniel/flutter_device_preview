# device_preview

![gif](https://github.com/aloisdeniel/flutter_device_preview/raw/master/device_preview.gif)

Preview of your app on various device screen configurations from one of your devices and save time when adapting your app visuals for various form factors.

Targeted features :

* Preview any device from any device
* Change device orientation
* Freeform device with adjustable resolution and safe areas
* Dynamic system configuration : language, dark mode, text scaling factor
* Display device frames 
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

## Roadmap

[ ] Status bar
[ ] Storage explorer
[ ] Add custom devices state
[ ] Desktop devices
[ ] TV devices
[ ] Documentation
[ ] Clean code
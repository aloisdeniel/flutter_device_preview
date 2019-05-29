# flutter_device_preview (WIP)

Preview of your app on various device screen configurations from one of your devices.

## Quickstart

```dart
void main() => runApp(DevicePreview(
    child: MyApp(),
  ),
);
```

## Note

Until the `WidgetsApp` offers a way to override `MediaQuery` (I made a proposal [here](https://github.com/flutter/flutter/issues/33384)), you will have to wrap your page in a `MediaQuery`. A good candidate is `onGeneratedRoute`.

```dart
 return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MediaQuery(
              data: DevicePreview.mediaQuery(context),
              child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
```

## Roadmap

[ ] Hide frame
[ ] Android devices
[ ] Landscape mode
[ ] Screenshot (share, mode)
[ ] Documentation
[ ] Clean code
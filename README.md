# flutter_device_preview (WIP)

![gif](https://github.com/aloisdeniel/flutter_device_preview/raw/master/device_preview.gif)

Preview of your app on various device screen configurations from one of your devices and save time when adapting your app visuals for various form factors.

Targeted features :

* Preview any device from any device
* Change Device orientation
* Display a device frames 
* Change the device at any time but keep the application state
* Take screenshots

## Quickstart

```dart
void main() => runApp(DevicePreview(
    child: MyApp(),
  ),
);
```

## Note

It is recommanded to run the app on a device with a big device (tablet/desktop).

Until the `WidgetsApp` offers a way to override `MediaQuery` (I made a proposal [here](https://github.com/flutter/flutter/issues/33384)), you will have to wrap your pages in a `MediaQuery` with `DevicePreview.mediaQuery` A good candidate is `onGeneratedRoute`.

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

[ ] Show/Hide frame
[ ] Android devices
[ ] Desktop devices
[ ] TV devices
[ ] Orientations
[ ] Screenshot (share, mode)
[ ] Documentation
[ ] Clean code
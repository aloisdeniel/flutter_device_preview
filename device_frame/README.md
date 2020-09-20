# device_frame

<p>
  <a href="https://pub.dartlang.org/packages/device_frame"><img src="https://img.shields.io/pub/v/device_frame.svg"></a>
  <a href="https://www.buymeacoffee.com/aloisdeniel">
    <img src="https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat">
  </a>
</p>

<p>
  <img src="https://github.com/aloisdeniel/flutter_device_preview/raw/master/device_frame/example/example.gif" alt="Device Frame for Flutter" />
</p>


Mockups for common devices.

## Quickstart

```Dart
DeviceFrame.identifier(
    identifier: Devices.ios.iPhone11,
    isFrameVisible: true,
    orientation: Orientation.portrait,
    screen: Container(
        color: Colors.blue,
        child: Text('Hello Android'),
    ),
)
```

## Usage

### Displaying virtual keyboard

```dart
DeviceFrame.identifier(
    identifier: Devices.ios.iPhone11,
    orientation: orientation,
    screen: VirtualKeyboard(
        isEnabled: true,
        child: // ...
    ),
)
```

### Maintain device media query and theme in an encapsulated app

```dart
DeviceFrame.identifier(
    identifier: Devices.ios.iPhone11,
    orientation: orientation,
    screen: Builder(
        builder: (deviceContext) => MaterialApp(
            theme: Theme.of(context),
            builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(deviceContext),
                child: Theme(
                    data: Theme.of(deviceContext),
                    child: widget,
                ),
            ),
        ),
    ),
),
```
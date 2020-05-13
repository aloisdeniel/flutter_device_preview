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

```dart
CupertinoDeviceFrame(
    orientation: Orientation.portrait,
    device: AndroidDevice.iPhoneXs,
    child: Container(
        child: Text('Hello iOS'),
    ),
),
```

```dart
AndroidDeviceFrame(
    orientation: Orientation.portrait,
    device: AndroidDevice.mediumPhone,
    child: Container(
        child: Text('Hello Android'),
    ),
),
```

## Usage

### Change global theme

```dart
DeviceFrameTheme(
    style: DeviceFrameStyle.light(),
    child: /* any frame child will have this style by default */
)
```

### Change local style

```dart
AndroidDeviceFrame(
    style: DeviceFrameStyle.light(),
    // ...
),
```
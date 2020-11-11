# Only frames as widgets

The [device_frame](https://pub.dev/packages/device_frame) package allows to include only one of the devices frames as a widget in your application, without all the tools around.

## Install

```yaml
dependencies:
  device_frame: <latest version>
```

## Usage

```dart
import 'package:device_frame/device_frame.dart';

DeviceFrame(
    device: IosDevices.iPhone11,
    screen: YourScreen(),
),
```
# Install

This section describes how to install and configure Device Preview.

## Add dependency to your pubspec file

Since Device Preview is a simple Dart package, you have to declare it as any other dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  device_preview: <latest version>
```

## Add DevicePreview

Wrap your app's root widget in a `DevicePreview` and inject the dedicated `builder` and `locale` into your app.

!> Make sure to provide `locale` and `builder` to your `WidgetsApp`. If not defined, `MediaQuery` won't be simulated for the selected device and selected locale won't be applied.

```dart
import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';

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
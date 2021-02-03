# Writing your own plugin

Making custom plugins can be really useful to add your own debugging tools.

You can easily add a button to the tool bar that opens a window with your custom content.

## Define your plugin

```dart
import 'package:device_preview/plugins.dart';

class CustomPlugin extends DevicePreviewPlugin {
  const CustomPlugin() : super(
          identifier: 'custom', // Unique identifier
          name: 'Custom', // Window's title
          icon: Icons.battery_unknown, // Button's icon
          windowSize: const Size(220, 220), // Window's size
        );

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data, // You plugin preferences (saved with other device preview's preferences)
    DevicePreviewPluginDataUpdater updateData,  // update your plugin's data and triggers a rebuild.
  ) {
    // Build the window's content here.
    return Center(
        child: Text('Hello !'), 
    );
  }
}
```

## Configure

Add your plugin instance to your `DevicePreview`'s `plugins` property.

```dart
DevicePreview(
    // ...
    plugins: [
        const CustomPlugin(),
    ],
),
```
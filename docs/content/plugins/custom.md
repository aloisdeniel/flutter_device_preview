# Writing your own plugin

Making custom plugins can be really useful to add your own debugging tools to the device preview menu.

## Define your plugin

A plugin is nothing more than a regular [Sliver] that is added to the main Device Preview menu.

To make things more aligned with built-in sections, you can add the `ToolPanelSection` widget and the `package:flutter/material.dart` widgets.

```dart
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class CustomPlugin extends StatelessWidget {
  const CustomPlugin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolPanelSection(
      title: 'Screenshot',
      children: [
        ListTile(
          title: const Text('Print in console'),
          onTap: () {
            print('Hey, this is a custom plugin!');
          },
        )
      ],
    );
  }
}
```

## Configure

![illustration](images/custom.png ':size=700')

Add your plugin instance to your `DevicePreview`'s `tools` property.

```dart
DevicePreview(
    // ...
    tools: [
        ...DevicePreview.defaultTools,
        const CustomPlugin(),
    ],
),
```

## Observing Device Preview's state

If you need to check the current `DevicePreview` state, you can use one of the available methods :

* `DevicePreview.isEnabled(BuildContext context)` : indicate whether the preview is currently enabled or not
* `DevicePreview.selectedDevice(BuildContext context)` : get the currently selected device
* `DevicePreview.locale(BuildContext context)` : get the currently selected locale

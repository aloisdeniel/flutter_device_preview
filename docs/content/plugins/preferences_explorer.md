# Plugin : Shared Preferences explorer

![illustration](images/preferences_explorer.png ':size=250')

## Configure

Add a `SharedPreferencesExplorerPlugin` to your `DevicePreview`'s `plugins` property.

```dart
import 'package:device_preview/plugins.dart';

DevicePreview(
    // ...
    plugins: [
        const SharedPreferencesExplorerPlugin(),
    ],
),
```

## Usage

Click on the dedicated button from the toolbar to open the shared preferences explorer.

You will have inspect all of your app's shared  preference keys and values.

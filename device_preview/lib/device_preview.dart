library device_preview;

import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/configuration/preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'src/binding/binding.dart';
import 'src/configuration/configuration.dart';

export 'src/configuration/configuration.dart';
export 'src/configuration/preference.dart';
export 'package:device_frame/device_frame.dart' show Devices;

class DevicePreview {
  /// Enables the device preview.
  ///
  /// A [device] can be precised to initialise the preview.
  ///
  /// By default it is not enabled in release mode, until [release] is set to
  /// `true`.
  static void enable({
    bool release = false,
    DeviceInfo? device,
    Orientation? orientation,
    Brightness? brightness,
  }) {
    if (release || kDebugMode) {
      PreviewWidgetsFlutterBinding.ensureInitialized();
      if (device != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          configuration = PreviewConfiguration(
            isEnabled: true,
            device: PreviewDeviceConfiguration(
              device: PreviewPreference.overriden(device),
              orientation: PreviewPreference.fromNullable(orientation),
              brightness: PreviewPreference.fromNullable(brightness),
            ),
          );
        });
      }
    }
  }

  /// The current configuration.
  static PreviewConfiguration? get configuration =>
      PreviewWidgetsFlutterBinding.instance.previewConfiguration;

  /// Updates the current configuration.
  static set configuration(PreviewConfiguration? value) {
    PreviewWidgetsFlutterBinding.instance.previewConfiguration = value;
  }
}

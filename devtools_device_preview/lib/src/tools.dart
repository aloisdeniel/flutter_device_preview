import 'package:device_frame/device_frame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'binding/binding.dart';
import 'binding/window.dart';

abstract class DevicePreviewDevtools {
  static void enable() {
    print(
        'Enabled, available devices : [ ${Devices.all.map((x) => x.identifier.toString()).join(',')} ]');
    PreviewWidgetsFlutterBinding.ensureInitialized();
  }

  static void setBrightness(Brightness? value) {
    PreviewWidgetsFlutterBinding.previewWindow.platformBrightness = value;
  }

  static void setBoldText(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      boldText: value,
    );
  }

  static void setHighContrast(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      highContrast: value,
    );
  }

  static void setAccessibleNavigation(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      accessibleNavigation: value,
    );
  }

  static void setReduceMotion(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      reduceMotion: value,
    );
  }

  static void setLocale(Locale? value) {
    PreviewWidgetsFlutterBinding.previewWindow.locale = value;
  }

  static void setTextScaleFactor(double? value) {
    PreviewWidgetsFlutterBinding.previewWindow.textScaleFactor = value;
  }

  static void setOrientation(Orientation orientation) {
    PreviewWidgetsFlutterBinding.previewBinding.orientation = orientation;
  }

  static Future<void> setDevice(DeviceInfo? device) async {
    PreviewWidgetsFlutterBinding.previewBinding.device = device;
    if (WidgetsBinding.instance != null) {
      await WidgetsBinding.instance!.reassembleApplication();
    }
  }
}

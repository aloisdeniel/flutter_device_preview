// ignore_for_file: avoid_print

import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding/binding.dart';
import 'binding/window.dart';
import 'configuration/configuration.dart';
import 'menu/menu.dart';
import 'services/memory.dart';
import 'services/service.dart';

abstract class DevicePreview {
  static void initialize([
    PreviewService? service,
  ]) async {
    if (kDebugMode) {
      final effectiveService = service ?? MemoryPreviewService();

      PreviewMenu(effectiveService);

      effectiveService.updates.listen(update);
      print(
        'Enabled, available devices :'
        ' [ ${Devices.all.map((x) => x.identifier.toString()).join(',')} ]',
      );
      PreviewWidgetsFlutterBinding.ensureInitialized();

      final initialConfiguration = await effectiveService.get();
      update(initialConfiguration);
    }
  }

  static void update(PreviewConfiguration configuration) async {
    final window = PreviewWidgetsFlutterBinding.previewWindow;
    final binding = PreviewWidgetsFlutterBinding.previewBinding;

    // Device
    final device = configuration.device;
    window.platformBrightness = device.brightness.asNullable();
    binding
      ..device = device.device.asNullable()
      ..orientation = device.orientation.asNullable() ?? Orientation.portrait;

    // Accessibility
    final a11y = configuration.accessibility;
    window
      ..textScaleFactor = a11y.textScaleFactor.asNullable()
      ..accessibilityFeatures = PreviewAccessibilityFeatures.merge(
        PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
        boldText: a11y.boldText.asNullable(),
        accessibleNavigation: a11y.accessibleNavigation.asNullable(),
        disableAnimations: a11y.disableAnimations.asNullable(),
        highContrast: a11y.highContrast.asNullable(),
        invertColors: a11y.invertColors.asNullable(),
        onOffSwitchLabels: a11y.onOffSwitchLabels.asNullable(),
        reduceMotion: a11y.reduceMotion.asNullable(),
      );

    // Internationnalization
    final i11n = configuration.internationalization;
    window.locale = i11n.locale.asNullable();

    // Resassemble
    await WidgetsBinding.instance.reassembleApplication();
  }
}

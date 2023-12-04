import 'package:device_preview/src/configuration/configuration.dart';

class JsonConfigurationSerializer {
  dynamic serialize(PreviewConfiguration value) {
    final a11y = value.accessibility;
    final i11n = value.internationalization;
    final device = value.device;
    return <String, dynamic>{
      'isEnabled': value.isEnabled,
      'accessibility': <String, dynamic>{
        'accessibleNavigation': a11y.accessibleNavigation.asNullable(),
        'boldText': a11y.boldText.asNullable(),
        'disableAnimations': a11y.disableAnimations.asNullable(),
        'highContrast': a11y.highContrast.asNullable(),
        'invertColors': a11y.invertColors.asNullable(),
        'onOffSwitchLabels': a11y.onOffSwitchLabels.asNullable(),
        'reduceMotion': a11y.reduceMotion.asNullable(),
        'textScaleFactor': a11y.textScaleFactor.asNullable(),
      },
      'internationalization': <String, dynamic>{
        'locale': i11n.locale.toString(),
      },
      'device': <String, dynamic>{
        'device': device.device.asNullable()?.identifier.toString(),
        'orientation': device.orientation.asNullable()?.index,
        'brightness': device.brightness.asNullable()?.index,
      },
    };
  }
}

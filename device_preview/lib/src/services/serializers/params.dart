import 'package:device_preview/src/configuration/configuration.dart';

class ParamsConfigurationSerializer {
  const ParamsConfigurationSerializer();

  PreviewConfiguration? deserialize(Map<String, String> value) {
    return PreviewConfiguration(
      isEnabled: value['isEnabled'] == 'true',
      internationalization: PreviewInternationalizationConfiguration.fromJson(
        value['internationalization'],
      ),
      device: PreviewDeviceConfiguration.fromJson(
        value['device'],
      ),
      accessibility: PreviewAccessibilityConfiguration.fromJson(
        value['accessibility'],
      ),
    );
  }

  Map<String, String>? serialize(PreviewConfiguration? value) {
    if (value == null) {
      return null;
    }
    final a11y = value.accessibility;
    final i11n = value.internationalization;
    final device = value.device;
    return <String, String>{
      'isEnabled': value.isEnabled.toString(),
      'accessibility': a11y.toJson(),
      'internationalization': i11n.toJson(),
      'device': device.toJson(),
    };
  }
}

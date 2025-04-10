// ignore_for_file: invalid_use_of_protected_member

import 'package:device_preview/src/configuration/configuration.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import '../services/serializers/params.dart';

const extensionIdentifier = 'ext.flutter.device_preview';

extension DevicePreviewServiceExtension on BindingBase {
  /// Registers a service extension method for device preview.
  void registerPreviewServiceExtension({
    required AsyncValueSetter<PreviewConfiguration?> setter,
  }) {
    registerServiceExtension(
      name: extensionIdentifier,
      callback: (Map<String, String> parameters) async {
        final state =
            const ParamsConfigurationSerializer().deserialize(parameters);
        setter(state);
        return const <String, dynamic>{};
      },
    );
  }

  void sendStateToPreviewServiceExtension({
    required AsyncValueGetter<PreviewConfiguration?> getter,
  }) async {
    final state =
        const ParamsConfigurationSerializer().serialize(await getter());
    if (state != null) developer.postEvent(extensionIdentifier, state);
  }
}

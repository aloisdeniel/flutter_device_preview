import 'dart:async';

import 'package:device_preview/src/configuration/configuration.dart';

abstract class PreviewService {
  Stream<PreviewConfiguration> get updates;
  Future<PreviewConfiguration> get();
  Future<void> update(PreviewConfiguration configuration);
  void dispose();
}

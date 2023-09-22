import 'dart:async';

import 'package:devtools_device_preview/src/configuration/configuration.dart';
import 'package:flutter/widgets.dart';

import 'service.dart';

class MemoryPreviewService extends PreviewService {
  MemoryPreviewService({
    PreviewConfiguration initialConfiguration = const PreviewConfiguration(),
  }) : _configuration = initialConfiguration;
  PreviewConfiguration _configuration;

  @protected
  final updatesController = StreamController<PreviewConfiguration>.broadcast();

  @override
  Stream<PreviewConfiguration> get updates => updatesController.stream;

  @override
  Future<void> update(PreviewConfiguration configuration) {
    _configuration = configuration;
    updatesController.add(configuration);
    return Future.value();
  }

  @override
  Future<PreviewConfiguration> get() {
    return Future.value(_configuration);
  }

  @override
  void dispose() {
    updatesController.close();
  }
}

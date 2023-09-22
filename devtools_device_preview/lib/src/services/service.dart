import 'dart:async';

import 'package:devtools_device_preview/src/configuration/configuration.dart';
import 'package:flutter/material.dart';

abstract class PreviewService {
  Stream<PreviewConfiguration> get updates;
  Future<PreviewConfiguration> get();
  Future<void> update(PreviewConfiguration configuration);
  void dispose();
}

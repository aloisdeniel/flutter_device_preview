import 'dart:io';

import 'package:devtools_device_preview/src/menu/menu.macos.dart';
import 'package:devtools_device_preview/src/services/service.dart';

import 'menu.platform.dart';

class PreviewMenu {
  PreviewMenu(this.service)
      : _platform = (() {
          if (Platform.isMacOS) {
            return MacOsPreviewMenu(service);
          }
          return const PlatformPreviewMenu();
        }());

  final PreviewService service;
  final PlatformPreviewMenu _platform;

  void dispose() {
    _platform.dispose();
  }
}

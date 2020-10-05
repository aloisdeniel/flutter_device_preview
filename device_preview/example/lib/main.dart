import 'package:device_preview/device_preview.dart';
import 'package:device_preview_example/gallery/l10n/gallery_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'gallery/studies/starter/app.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(DevicePreview(
    enabled: false,
    availableLocales: GalleryLocalizations.supportedLocales,
    builder: (context) => StarterApp(),
  ));
}

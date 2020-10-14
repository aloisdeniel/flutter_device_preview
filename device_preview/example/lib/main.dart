import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';
import 'package:device_preview_example/gallery/l10n/gallery_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'gallery/studies/starter/app.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(Row(
    textDirection: TextDirection.ltr,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      /*Expanded(
        child: Container(color: Colors.red),
      ),*/
      Expanded(
        child: DevicePreview(
          plugins: [
            const FileExplorerPlugin(),
            const ScreenshotPlugin(),
            const SharedPreferencesExplorerPlugin(),
          ],
          availableLocales: GalleryLocalizations.supportedLocales,
          builder: (context) => StarterApp(),
        ),
      ),
    ],
  ));
}

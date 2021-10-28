import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'basic.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /*Expanded(
        child: Container(color: Colors.red),
      ),*/
        Expanded(
          child: DevicePreview(
            enabled: true,
            builder: (context) => const BasicApp(),
          ),
        ),
      ],
    ),
  );
}

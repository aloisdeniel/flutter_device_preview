// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../../l10n/gallery_localizations.dart';
import '../../studies/starter/home.dart';

const _primaryColor = Color(0xFF6200EE);

class StarterApp extends StatelessWidget {
  const StarterApp();

  static const String defaultRoute = '/starter';

  @override
  Widget build(BuildContext context) {
    final isDark =
        MediaQuery.of(context)?.platformBrightness == Brightness.dark;
    return MaterialApp(
      title: 'Starter',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context), // <--
      builder: DevicePreview.appBuilder, // <--
      supportedLocales: DevicePreview.allLocales(context),
      localizationsDelegates: GalleryLocalizations.localizationsDelegates,
      initialRoute: StarterApp.defaultRoute,
      routes: {
        StarterApp.defaultRoute: (context) => const HomePage(),
      },

      home: const HomePage(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: _primaryColor,
        highlightColor: Colors.transparent,
        colorScheme: const ColorScheme(
          primary: _primaryColor,
          primaryVariant: Color(0xFF3700B3),
          secondary: Color(0xFF03DAC6),
          secondaryVariant: Color(0xFF018786),
          background: Colors.black,
          surface: Colors.black,
          onBackground: Colors.white,
          error: Color(0xFFB00020),
          onError: Colors.black,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
        dividerTheme: const DividerThemeData(
          thickness: 1,
          color: Color(0xFFE5E5E5),
        ),
        platform: Theme.of(context).platform,
      ),
      theme: ThemeData(
        primaryColor: _primaryColor,
        highlightColor: Colors.transparent,
        colorScheme: const ColorScheme(
          primary: _primaryColor,
          primaryVariant: Color(0xFF3700B3),
          secondary: Color(0xFF03DAC6),
          secondaryVariant: Color(0xFF018786),
          background: Colors.white,
          surface: Colors.white,
          onBackground: Colors.black,
          error: Color(0xFFB00020),
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        dividerTheme: const DividerThemeData(
          thickness: 1,
          color: Color(0xFFE5E5E5),
        ),
        platform: Theme.of(context).platform,
      ),
    );
  }
}

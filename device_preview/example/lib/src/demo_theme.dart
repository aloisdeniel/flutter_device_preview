// The landing-page palette (docs/index.html) as Material schemes, shared by
// the two demo apps embedded in that page (`counter.dart` and
// `showcase.dart`).

import 'package:flutter/material.dart';

/// `--cyan` on the landing page.
const Color demoCyan = Color(0xFF4FD1FF);

/// `--amber` on the landing page.
const Color demoAmber = Color(0xFFFFB454);

/// `--green` on the landing page.
const Color demoGreen = Color(0xFF7EE2A8);

/// Dark scheme: the page's own colors, straight off `:root`.
final ColorScheme demoDarkScheme =
    ColorScheme.fromSeed(
      seedColor: demoCyan,
      brightness: Brightness.dark,
    ).copyWith(
      primary: demoCyan,
      onPrimary: const Color(0xFF05263A),
      primaryContainer: const Color(0xFF10395A),
      onPrimaryContainer: demoCyan,
      secondary: demoAmber,
      onSecondary: const Color(0xFF2B1A00),
      tertiary: demoGreen,
      onTertiary: const Color(0xFF04291A),
      surface: const Color(0xFF081527), // --paper
      onSurface: const Color(0xFFDBE9F7), // --ink
      surfaceContainerLowest: const Color(0xFF060F1D), // --paper-sunken
      surfaceContainer: const Color(0xFF0C1E36), // --paper-raised
      surfaceContainerHigh: const Color(0xFF102743),
      onSurfaceVariant: const Color(0xFF7E9AB8), // --ink-dim
      outline: const Color(0xFF1F4166), // --line-strong
      outlineVariant: const Color(0xFF16324F), // --line
    );

/// Light scheme: the same hues, re-weighted for a light background.
final ColorScheme demoLightScheme =
    ColorScheme.fromSeed(seedColor: demoCyan).copyWith(
      primary: const Color(0xFF00688F),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFC7ECFB),
      onPrimaryContainer: const Color(0xFF00344A),
      secondary: const Color(0xFF9A5B00),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF186B45),
      surface: const Color(0xFFF3F8FD),
      onSurface: const Color(0xFF0A1C30),
      surfaceContainerLowest: Colors.white,
      surfaceContainer: Colors.white,
      surfaceContainerHigh: const Color(0xFFE7F0F8),
      onSurfaceVariant: const Color(0xFF4A6784),
      outline: const Color(0xFFB6CCE0),
      outlineVariant: const Color(0xFFD7E5F0),
    );

/// The demo [ThemeData] over [scheme] ([demoLightScheme] or
/// [demoDarkScheme]).
ThemeData demoTheme(ColorScheme scheme) {
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surfaceContainer,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        // Named explicitly so the style keeps a real face under
        // `flutter_test`, where an unnamed family falls back to the
        // block-glyph test font (see test/screenshots/).
        fontFamily: 'Roboto',
        fontSize: 19,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      shape: Border(bottom: BorderSide(color: scheme.outlineVariant)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
    ),
  );
}

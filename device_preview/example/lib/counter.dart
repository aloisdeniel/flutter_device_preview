// The stock Flutter counter app, restyled with the palette of the
// device_preview landing page, and used as the interactive demo embedded in
// that page (`docs/index.html`).
//
// Everything here is an ordinary Flutter app. The two device_preview-specific
// lines are in [main]:
//
//  * [DevicePreview.enable] installs the simulation binding, and
//  * [connectDemoPanel] bridges the controller to the HTML panel hosting this
//    app in an iframe — the same role Flutter DevTools plays for a real app,
//    except the messages travel over `window.postMessage` instead of the VM
//    service. It is a no-op outside the web.
//
// Build it with `tool/build_demo.sh` at the root of the repository.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'src/demo_bridge.dart';

void main() {
  // `true` rather than the default: the demo is a *release* web build, where
  // simulation would otherwise be off. A real app calls `DevicePreview
  // .enable()` with no argument, which keeps release builds untouched.
  DevicePreview.enable(enabled: true);
  connectDemoPanel(DevicePreview.maybeController);
  runApp(const CounterApp());
}

// -----------------------------------------------------------------------------
// Theme — the landing page palette (docs/index.html) as a Material scheme.
// -----------------------------------------------------------------------------

const Color _cyan = Color(0xFF4FD1FF);
const Color _amber = Color(0xFFFFB454);
const Color _green = Color(0xFF7EE2A8);

/// Dark scheme: the page's own colors, straight off `:root`.
final ColorScheme _darkScheme =
    ColorScheme.fromSeed(
      seedColor: _cyan,
      brightness: Brightness.dark,
    ).copyWith(
      primary: _cyan,
      onPrimary: const Color(0xFF05263A),
      primaryContainer: const Color(0xFF10395A),
      onPrimaryContainer: _cyan,
      secondary: _amber,
      onSecondary: const Color(0xFF2B1A00),
      tertiary: _green,
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
final ColorScheme _lightScheme =
    ColorScheme.fromSeed(seedColor: _cyan).copyWith(
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

ThemeData _theme(ColorScheme scheme) {
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

/// Root widget — a stock [MaterialApp] with a light and a dark theme, so the
/// panel's brightness switch is visible immediately.
class CounterApp extends StatelessWidget {
  /// Creates the demo app.
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'device_preview counter',
      debugShowCheckedModeBanner: false,
      // ThemeMode.system follows MediaQuery.platformBrightnessOf — i.e. the
      // simulated brightness.
      theme: _theme(_lightScheme),
      darkTheme: _theme(_darkScheme),
      home: const CounterPage(title: 'device_preview demo'),
    );
  }
}

/// The counter screen.
class CounterPage extends StatefulWidget {
  /// Creates the counter screen.
  const CounterPage({super.key, required this.title});

  /// The title shown in the app bar.
  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_counter',
                style: theme.textTheme.displayLarge!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
import 'src/demo_theme.dart';

void main() {
  // `true` rather than the default: the demo is a *release* web build, where
  // simulation would otherwise be off. A real app calls `DevicePreview
  // .enable()` with no argument, which keeps release builds untouched.
  DevicePreview.enable(enabled: true, padding: const EdgeInsets.all(16));
  connectDemoPanel(DevicePreview.maybeController);
  runApp(const CounterApp());
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
      theme: demoTheme(demoLightScheme),
      darkTheme: demoTheme(demoDarkScheme),
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

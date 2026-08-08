// Entry point of the landing-page bundle (`tool/build_demo.sh`): the demo
// apps compiled together, selected by the page through the `app` query
// parameter of the iframe URL:
//
//   demo/index.html?app=counter    → the stock counter (`counter.dart`)
//   demo/index.html?app=todo       → the todo app (`todo.dart`)
//   demo/index.html?app=showcase   → the device lab (`showcase.dart`)
//
// The panel's demo picker simply reloads the iframe with another value.
// Everything else — enable(), the postMessage bridge — is identical to the
// standalone entry points.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'counter.dart' show CounterApp;
import 'showcase.dart' show ShowcaseApp;
import 'src/demo_bridge.dart';
import 'todo.dart' show TodoApp;

void main() {
  // `true` rather than the default: the demo is a *release* web build, where
  // simulation would otherwise be off.
  DevicePreview.enable(enabled: true, padding: const EdgeInsets.all(16));
  connectDemoPanel(DevicePreview.maybeController);
  runApp(switch (Uri.base.queryParameters['app']) {
    'todo' => const TodoApp(),
    'showcase' => const ShowcaseApp(),
    _ => const CounterApp(),
  });
}

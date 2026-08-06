import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

import 'src/gateway.dart';
import 'src/panel.dart';
import 'src/panel_controller.dart';

/// Entry point of the device_preview DevTools extension web app.
///
/// [DevToolsExtension] initializes the `serviceManager` / `extensionManager` /
/// `dtdManager` globals and wraps the panel in a DevTools-themed
/// [MaterialApp]; the panel is page content only.
void main() => runApp(const DevToolsExtension(child: _DevicePreviewShell()));

/// Creates the real gateway + controller below the [DevToolsExtension] widget
/// (the devtools_extensions globals throw when accessed above it).
class _DevicePreviewShell extends StatefulWidget {
  const _DevicePreviewShell();

  @override
  State<_DevicePreviewShell> createState() => _DevicePreviewShellState();
}

class _DevicePreviewShellState extends State<_DevicePreviewShell> {
  late final ServiceManagerGateway _gateway;
  late final PanelController _controller;

  @override
  void initState() {
    super.initState();
    _gateway = ServiceManagerGateway();
    _controller = PanelController(gateway: _gateway);
  }

  @override
  void dispose() {
    _controller.dispose();
    _gateway.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreviewPanel(controller: _controller);
  }
}

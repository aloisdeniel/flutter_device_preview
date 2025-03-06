import 'package:flutter/material.dart';

class ToolsPanelModel {
  /// List of tools on the side.
  final List<Widget> tools;

  /// The panel width when not modal.
  final double panelWidth;

  ToolsPanelModel({
    required this.tools,
    this.panelWidth = 320,
  });
}

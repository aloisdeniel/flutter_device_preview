import 'package:device_preview/src/model/tools_panel_model.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tool_panel/tool_panel.dart';

/// The tool layout when the screen is small.
class DevicePreviewSmallLayout extends StatelessWidget {
  const DevicePreviewSmallLayout({
    super.key,
    required this.maxMenuHeight,
    required this.scaffoldKey,
    required this.onMenuVisibleChanged,
    required this.isRight,
    required this.toolsPanelRight,
    required this.toolsPanelLeft,
  });

  /// The maximum modal menu height.
  final double maxMenuHeight;
  final bool isRight;

  /// The key of the [Scaffold] that must be used to show the modal menu.
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// Invoked each time the menu is shown or hidden.
  final ValueChanged<bool> onMenuVisibleChanged;

  final ToolsPanelModel toolsPanelRight;
  final ToolsPanelModel toolsPanelLeft;

  @override
  Widget build(BuildContext context) {
    final toolbarTheme = context.select(
      (DevicePreviewStore store) => store.settings.toolbarTheme,
    );
    return Theme(
      data: toolbarTheme.asThemeData(),
      child: SafeArea(
        top: false,
        child: _BottomToolbar(
          toolsPanelRight: toolsPanelRight,
          toolsPanelLeft: toolsPanelLeft,
          showPanel: (model) async {
            onMenuVisibleChanged(true);
            final sheet = scaffoldKey.currentState?.showBottomSheet(
              (context) => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ToolPanel(
                  isModal: true,
                  isRight: isRight,
                  slivers: model.tools,
                ),
              ),
              constraints: BoxConstraints(
                maxHeight: maxMenuHeight,
              ),
              backgroundColor: Colors.transparent,
            );
            await sheet?.closed;
            onMenuVisibleChanged(false);
          },
        ),
      ),
    );
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    required this.showPanel,
    required this.toolsPanelRight,
    required this.toolsPanelLeft,
  });

  final Function(ToolsPanelModel model) showPanel;
  final ToolsPanelModel toolsPanelRight;
  final ToolsPanelModel toolsPanelLeft;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (toolsPanelLeft.tools.isNotEmpty)
              IconButton(
                onPressed: () => showPanel(toolsPanelLeft),
                icon: const Icon(Icons.tune),
              ),
            if (toolsPanelRight.tools.isNotEmpty)
              IconButton(
                onPressed: () => showPanel(toolsPanelRight),
                icon: const Icon(Icons.tune),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';

import 'tool_panel/bottom_toolbar.dart';
import 'tool_panel/tool_panel.dart';

class DevicePreviewSmallLayout extends StatelessWidget {
  const DevicePreviewSmallLayout({
    Key? key,
    required this.maxMenuHeight,
    required this.scaffoldKey,
    required this.onMenuVisibleChanged,
  }) : super(key: key);

  final double maxMenuHeight;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ValueChanged<bool> onMenuVisibleChanged;

  @override
  Widget build(BuildContext context) {
    final toolbarTheme = context.select(
      (DevicePreviewStore store) => store.settings.toolbarTheme,
    );
    return Theme(
      data: toolbarTheme.asThemeData(),
      child: SafeArea(
        top: false,
        child: BottomToolbar(
          showPanel: () async {
            onMenuVisibleChanged(true);
            try {
              final sheet = scaffoldKey.currentState?.showBottomSheet(
                (context) => const ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: ToolPanel(
                    isModal: true,
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: maxMenuHeight,
                ),
              );
              await sheet?.closed;
            } catch (e) {}

            onMenuVisibleChanged(false);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tool_panel/bottom_toolbar.dart';
import 'tool_panel/tool_panel.dart';

class DevicePreviewSmallLayout extends StatelessWidget {
  const DevicePreviewSmallLayout({
    Key? key,
    required this.maxMenuHeight,
    required this.currentTheme,
    required this.scaffoldKey,
    required this.onMenuVisibleChanged,
  }) : super(key: key);

  final double maxMenuHeight;
  final ThemeData currentTheme;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ValueChanged<bool> onMenuVisibleChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: currentTheme,
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

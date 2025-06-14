import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/tool_panel_widget.dart';

/// The panel which contains all the tools.
///
/// This is the main entry point for the tool panel that can be displayed
/// either modally or as a persistent sidebar. It provides device preview
/// tools and settings through a customizable interface.
class ToolPanel extends StatelessWidget {
  /// Create a new panel from the given tools grouped as [slivers].
  ///
  /// The [isModal] indicates whether the panel is shown modally as a new page
  /// or stays visible on one side of the parent layout.
  ///
  /// Example:
  /// ```dart
  /// ToolPanel(
  ///   slivers: [
  ///     DeviceSection(),
  ///     SystemSection(),
  ///   ],
  ///   isModal: false,
  ///   enableQuickDevicesTools: true,
  /// )
  /// ```
  const ToolPanel({
    super.key,
    required this.slivers,
    this.isModal = false,
    this.quickDevices = const [],
    this.enableQuickDevicesTools = false,
    this.showDeviceToast = false,
    this.showThemeToggle = true,
  });

  /// Indicates whether the panel is shown modally as a new page, or if it
  /// stays visible on one side of the parent layout.
  final bool isModal;

  /// The sections containing the tools.
  ///
  /// They must be [Sliver]s and will be displayed in the tool panel
  /// when device preview is enabled.
  final List<Widget> slivers;

  /// The list of devices available for quick selection.
  ///
  /// When [enableQuickDevicesTools] is true, these devices will be
  /// displayed as quick selection options.
  final List<DeviceInfo> quickDevices;

  /// Enables quick device selection tools.
  ///
  /// When enabled, users can quickly switch between devices using
  /// a compact interface without opening the full device selector.
  final bool enableQuickDevicesTools;

  /// Shows a toast message when a device is selected instead of tooltip.
  ///
  /// When enabled, device selection will show a toast message with device
  /// information instead of displaying tooltip on hover.
  final bool showDeviceToast;

  /// Shows a theme toggle button in the toolbar.
  ///
  /// When enabled, displays a theme toggle icon for quick switching
  /// between dark and light themes.
  final bool showThemeToggle;

  /// The panel width when not modal.
  ///
  /// This constant defines the standard width for the tool panel
  /// when displayed as a sidebar.
  static const double panelWidth = 320;

  @override
  Widget build(BuildContext context) {
    final rootContext = context;
    return Navigator(
      onGenerateInitialRoutes: (nav, name) {
        return [
          MaterialPageRoute(
            builder: (context) {
              final toolbarTheme = context.select(
                (DevicePreviewStore store) => store.settings.toolbarTheme,
              );
              return Theme(
                data: toolbarTheme.asThemeData(),
                child: ToolPanelWidget(
                  sections: slivers,
                  isModal: isModal,
                  quickDevices: quickDevices,
                  enableQuickDevicesTools: enableQuickDevicesTools,
                  showDeviceToast: showDeviceToast,
                  showThemeToggle: showThemeToggle,
                  onClose: () {
                    Navigator.maybePop(rootContext);
                  },
                ),
              );
            },
          ),
        ];
      },
    );
  }
}

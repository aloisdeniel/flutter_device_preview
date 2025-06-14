import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'compact_quick_devices_view.dart';

/// The main tool panel widget that displays device preview tools and settings.
///
/// This widget provides the main interface for device preview tools,
/// including quick device selection and full tool sections.
class ToolPanelWidget extends StatelessWidget {
  /// Creates a tool panel widget with the specified configuration.
  ///
  /// The [sections] parameter contains the list of tool sections to display.
  /// The [isModal] parameter determines the display mode and available actions.
  ///
  /// Example:
  /// ```dart
  /// ToolPanelWidget(
  ///   sections: [DeviceSection(), SystemSection()],
  ///   isModal: false,
  ///   quickDevices: Devices.all,
  ///   onClose: () => Navigator.pop(context),
  /// )
  /// ```
  const ToolPanelWidget({
    super.key,
    required this.isModal,
    required this.onClose,
    required this.sections,
    required this.quickDevices,
    required this.enableQuickDevicesTools,
    required this.showDeviceToast,
    this.showThemeToggle = true,
  });

  /// Whether the panel is displayed modally.
  ///
  /// When true, shows a close button and different navigation behavior.
  final bool isModal;

  /// Callback called when the panel should be closed.
  ///
  /// This is typically used to navigate back or dismiss the modal.
  final VoidCallback onClose;

  /// The list of tool sections to display in the panel.
  ///
  /// These should be Sliver widgets that will be displayed
  /// in a CustomScrollView when device preview is enabled.
  final List<Widget> sections;

  /// The list of devices available for quick selection.
  final List<DeviceInfo> quickDevices;

  /// Whether quick device selection tools are enabled.
  final bool enableQuickDevicesTools;

  /// Whether to show toast messages when devices are selected.
  final bool showDeviceToast;

  /// Whether to show the theme toggle button.
  final bool showThemeToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Device Preview',
          style: theme.textTheme.titleLarge,
        ),
        leading: isModal
            ? IconButton(
                icon: const Icon(Icons.close),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: onClose,
              )
            : null,
        actions: [
          if (!isModal)
            Switch(
              value: isEnabled,
              onChanged: (v) {
                final state = context.read<DevicePreviewStore>();
                state.data = state.data.copyWith(isEnabled: v);
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: !isEnabled && enableQuickDevicesTools
                ? CompactQuickDevicesView(
                    key: const ValueKey('quickDevicesView'),
                    quickDevices: quickDevices,
                    showDeviceToast: showDeviceToast,
                    showThemeToggle: showThemeToggle,
                    onDeviceSelected: (device) {
                      final state = context.read<DevicePreviewStore>();
                      state.selectDevice(device.identifier);
                      state.data = state.data.copyWith(
                        isEnabled: true,
                        quickDeviceTools: true,
                      );
                    },
                  )
                : CustomScrollView(
                    key: const ValueKey('normalView'),
                    slivers: sections,
                  ),
          ),
          if (!enableQuickDevicesTools)
            IgnorePointer(
              ignoring: isEnabled,
              child: AnimatedOpacity(
                opacity: isEnabled ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  color: const Color(0xCC000000),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

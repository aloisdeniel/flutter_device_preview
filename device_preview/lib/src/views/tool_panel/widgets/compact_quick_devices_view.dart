import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'compact_device_icon.dart';

/// A compact widget that displays quick device selection with small icons.
///
/// This widget provides a compact interface for quickly switching between
/// different device configurations without opening the full device selector.
/// It shows devices as small icons in a vertical layout.
class CompactQuickDevicesView extends StatelessWidget {
  /// Creates a compact quick devices view with small icons.
  ///
  /// The [quickDevices] parameter contains the list of devices to display.
  /// The [onDeviceSelected] callback is called when a device is selected.
  ///
  /// Example:
  /// ```dart
  /// CompactQuickDevicesView(
  ///   quickDevices: [Devices.ios.iPhone13, Devices.android.pixel5],
  ///   showDeviceToast: true,
  ///   onDeviceSelected: (device) {
  ///     // Handle device selection
  ///   },
  /// )
  /// ```
  const CompactQuickDevicesView({
    super.key,
    required this.quickDevices,
    required this.onDeviceSelected,
    this.showDeviceToast = false,
    this.showThemeToggle = true,
  });

  /// The list of quick devices to display.
  ///
  /// Each device will be shown as a compact icon that users can tap
  /// to quickly switch to that device configuration.
  final List<DeviceInfo> quickDevices;

  /// Callback when a device is selected.
  ///
  /// This function is called with the selected [DeviceInfo] when
  /// a user taps on a device icon.
  final ValueChanged<DeviceInfo> onDeviceSelected;

  /// Shows a toast message when a device is selected instead of tooltip.
  ///
  /// When true, selecting a device will display a [SnackBar] with
  /// device information instead of showing a tooltip on hover.
  final bool showDeviceToast;

  /// Shows a theme toggle button above the "No Device" option.
  ///
  /// When true, displays a theme toggle icon that allows quick switching
  /// between dark and light themes.
  final bool showThemeToggle;

  /// Shows a toast message with device information.
  ///
  /// This method displays a [SnackBar] with the selected device name.
  /// It automatically clears any existing SnackBars before showing the new one.
  ///
  /// The [deviceName] parameter should contain the display name for the device.
  void _showDeviceToast(BuildContext context, String deviceName) {
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context) ??
        DevicePreview.scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      // Clear any existing SnackBars before showing the new one
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Device selected: $deviceName'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Devices',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Compact device grid
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Theme toggle (if enabled)
                  if (showThemeToggle) ...[
                    const DevicePreviewThemeToggle(),
                    const SizedBox(height: 8),
                  ],
                  // No Device option
                  Builder(
                    builder: (context) {
                      final isNoDeviceSelected = context.select(
                        (DevicePreviewStore store) =>
                            !store.data.quickDeviceTools,
                      );
                      return CompactDeviceIcon(
                        icon: Icons.phone_android_outlined,
                        isSelected: isNoDeviceSelected,
                        onTap: () {
                          final state = context.read<DevicePreviewStore>();
                          state.data = state.data.copyWith(
                            quickDeviceTools: false,
                          );
                          if (showDeviceToast) {
                            _showDeviceToast(context, 'No Device');
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  // Quick devices
                  ...quickDevices.expand(
                    (device) => [
                      Builder(
                        builder: (context) {
                          final currentDeviceId = context.select(
                            (DevicePreviewStore store) =>
                                store.deviceInfo.identifier,
                          );
                          final isSelected =
                              currentDeviceId == device.identifier &&
                                  context.select(
                                    (DevicePreviewStore store) =>
                                        store.data.quickDeviceTools,
                                  );

                          return CompactDeviceIcon(
                            icon: _getDeviceIcon(device),
                            isSelected: isSelected,
                            onTap: () {
                              final state = context.read<DevicePreviewStore>();
                              state.selectDevice(device.identifier);
                              state.data = state.data.copyWith(
                                quickDeviceTools: true,
                              );
                              if (showDeviceToast) {
                                _showDeviceToast(
                                  context,
                                  '${device.name} (${device.identifier.name})',
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Gets the appropriate icon for a device based on its type and platform.
  ///
  /// This method returns the most suitable [IconData] for the given device
  /// based on its [DeviceType]. It provides visual consistency across
  /// the device selection interface.
  ///
  /// Returns:
  /// - [Icons.phone_android] for phones
  /// - [Icons.tablet] for tablets
  /// - [Icons.computer] for desktops
  /// - [Icons.laptop] for laptops
  /// - [Icons.tv] for TVs
  /// - [Icons.phone_android] as default fallback
  IconData _getDeviceIcon(DeviceInfo device) {
    switch (device.identifier.type) {
      case DeviceType.phone:
        return Icons.phone_android;
      case DeviceType.tablet:
        return Icons.tablet;
      case DeviceType.desktop:
        return Icons.computer;
      case DeviceType.laptop:
        return Icons.laptop;
      case DeviceType.tv:
        return Icons.tv;
      default:
        return Icons.phone_android;
    }
  }
}

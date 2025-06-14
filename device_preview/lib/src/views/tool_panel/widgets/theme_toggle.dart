import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A theme toggle button widget for DevicePreview.
///
/// This widget displays a toggle button that allows users to switch between
/// dark and light themes. The icon changes based on the current theme:
/// - Light theme: Shows moon icon (indicating dark mode can be activated)
/// - Dark theme: Shows sun icon (indicating light mode can be activated)
class DevicePreviewThemeToggle extends StatelessWidget {
  /// Creates a new theme toggle widget.
  ///
  const DevicePreviewThemeToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );
    final theme = Theme.of(context);

    final icon = !isDark ? Icons.light_mode : Icons.dark_mode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: !isDark
            ? theme.colorScheme.primary.withOpacity(0.1)
            : theme.colorScheme.surface,
        border: Border.all(
          color: !isDark
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withOpacity(0.3),
          width: !isDark ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleTheme(context),
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            size: 20,
            color: !isDark
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  /// Toggles the theme between dark and light.
  void _toggleTheme(BuildContext context) {
    final state = context.read<DevicePreviewStore>();
    state.toggleDarkMode();
  }
}

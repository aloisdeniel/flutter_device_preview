import 'package:flutter/material.dart';

/// A compact icon widget for displaying individual device options.
///
/// This widget provides a small, tappable icon representation of a device
/// with visual feedback for selection state and hover interactions.
/// It's designed to be used in compact device selection interfaces.
class CompactDeviceIcon extends StatelessWidget {
  /// Creates a compact device icon with the given properties.
  ///
  /// The [icon] parameter specifies the icon to display.
  /// The [tooltip] parameter provides accessible text for screen readers.
  /// The [isSelected] parameter controls the visual selection state.
  /// The [onTap] callback is called when the icon is tapped.
  ///
  /// Example:
  /// ```dart
  /// CompactDeviceIcon(
  ///   icon: Icons.phone_android,
  ///   tooltip: 'iPhone 13',
  ///   isSelected: true,
  ///   onTap: () {
  ///     // Handle device selection
  ///   },
  /// )
  /// ```
  const CompactDeviceIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  /// The icon to display.
  ///
  /// This should be an appropriate icon that represents the device type,
  /// such as [Icons.phone_android] for phones or [Icons.tablet] for tablets.
  final IconData icon;

  /// Whether this device is currently selected.
  ///
  /// When true, the icon will be highlighted with the theme's primary color
  /// and will have a stronger border to indicate selection state.
  final bool isSelected;

  /// Callback when the icon is tapped.
  ///
  /// This function is called when the user taps on the device icon.
  /// It should handle the device selection logic.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withOpacity(0.1)
            : theme.colorScheme.surface,
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            size: 20,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}

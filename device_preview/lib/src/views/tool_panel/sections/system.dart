import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/tool_panel/sections/subsections/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'section.dart';

/// All the simulated system settings.
class SystemSection extends StatelessWidget {
  /// Create a new menu section with simulated systel properties.
  const SystemSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

    final locales = context.select(
      (DevicePreviewStore store) => store.locales,
    );

    final selectedLocale = locales.firstWhere(
      (element) =>
          element.code ==
          context.select(
            (DevicePreviewStore store) => store.data.locale,
          ),
      orElse: () => locales.first,
    );

    return ToolPanelSection(
      title: 'System',
      children: [
        ListTile(
          title: const Text('Locale'),
          subtitle: Text(selectedLocale.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.language),
              Icon(Icons.chevron_right_rounded),
            ],
          ),
          onTap: () {
            final theme = Theme.of(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Theme(
                  data: theme,
                  child: const LocalePicker(),
                ),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Theme'),
          subtitle: Text(isDarkMode ? 'Dark' : 'Light'),
          trailing: Icon(
            isDarkMode ? Icons.brightness_3 : Icons.brightness_high,
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.toggleDarkMode();
          },
        ),
      ],
    );
  }
}

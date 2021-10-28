import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/tool_panel/sections/subsections/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'section.dart';

class SystemSection extends StatelessWidget {
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
      icon: Icons.device_hub_rounded,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LocalePicker(),
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

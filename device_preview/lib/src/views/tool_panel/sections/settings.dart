import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'section.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBackgroundThemeDark = context.select(
          (DevicePreviewStore store) => store.settings.backgroundTheme,
        ) ==
        DevicePreviewBackgroundThemeData.dark;
    final theme = Theme.of(context);
    final currentTheme =
        isBackgroundThemeDark ? ThemeData.dark() : ThemeData.light();
    return ToolPanelSection(
      title: 'Preview settings',
      icon: Icons.device_hub_rounded,
      children: [
        ListTile(
          title: const Text('Background color'),
          subtitle: Text(
            isBackgroundThemeDark ? 'Dark' : 'Light',
          ),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentTheme.scaffoldBackgroundColor,
              border: Border.all(
                color: theme.backgroundColor,
                width: 1,
              ),
            ),
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.settings = state.settings.copyWith(
              backgroundTheme: isBackgroundThemeDark
                  ? DevicePreviewBackgroundThemeData.light
                  : DevicePreviewBackgroundThemeData.dark,
            );
          },
        ),
      ],
    );
  }
}

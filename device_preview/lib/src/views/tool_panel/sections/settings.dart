import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/theme.dart';
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
    final backgroundTheme = context.select(
      (DevicePreviewStore store) => store.settings.backgroundTheme,
    );
    final toolbarTheme = context.select(
      (DevicePreviewStore store) => store.settings.toolbarTheme,
    );
    final background = backgroundTheme.asThemeData();
    final toolbar = toolbarTheme.asThemeData();
    return ToolPanelSection(
      title: 'Preview settings',
      icon: Icons.device_hub_rounded,
      children: [
        ListTile(
          title: const Text('Background color'),
          subtitle: Text(
            backgroundTheme == DevicePreviewBackgroundThemeData.dark
                ? 'Dark'
                : 'Light',
          ),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background.scaffoldBackgroundColor,
              border: Border.all(
                color: toolbar.backgroundColor,
                width: 1,
              ),
            ),
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.settings = state.settings.copyWith(
              backgroundTheme:
                  backgroundTheme == DevicePreviewBackgroundThemeData.dark
                      ? DevicePreviewBackgroundThemeData.light
                      : DevicePreviewBackgroundThemeData.dark,
            );
          },
        ),
        ListTile(
          title: const Text('Tools theme'),
          subtitle: Text(
            toolbarTheme == DevicePreviewToolBarThemeData.dark
                ? 'Dark'
                : 'Light',
          ),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: toolbar.scaffoldBackgroundColor,
              border: Border.all(
                color: toolbar.backgroundColor,
                width: 1,
              ),
            ),
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.settings = state.settings.copyWith(
              toolbarTheme: toolbarTheme == DevicePreviewToolBarThemeData.dark
                  ? DevicePreviewToolBarThemeData.light
                  : DevicePreviewToolBarThemeData.dark,
            );
          },
        ),
      ],
    );
  }
}

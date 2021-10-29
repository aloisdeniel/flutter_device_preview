import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'sections/section.dart';

class ToolPanel extends StatelessWidget {
  const ToolPanel({
    Key? key,
    required this.sections,
    this.isModal = false,
  }) : super(key: key);

  final bool isModal;
  final List<Widget> sections;

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
                child: _ToolPanel(
                  sections: sections,
                  isModal: isModal,
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

class _ToolPanel extends StatelessWidget {
  const _ToolPanel({
    Key? key,
    required this.isModal,
    required this.onClose,
    required this.sections,
  }) : super(key: key);

  final bool isModal;
  final VoidCallback onClose;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device preview',
          style: theme.textTheme.headline6?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: (theme.colorScheme.brightness == Brightness.dark
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onPrimary),
          ),
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
          CustomScrollView(
            slivers: sections,
          ),
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

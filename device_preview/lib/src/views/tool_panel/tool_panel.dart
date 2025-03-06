import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The panel which contains all the tools.
class ToolPanel extends StatelessWidget {
  /// Create a new panel from the given tools grouped as [slivers].
  ///
  /// The [isModal] indicates whether the panel is shown modally as a new page, or if it
  /// stays visible on one side of the parent layout.
  const ToolPanel({
    super.key,
    required this.slivers,
    this.isModal = false,
    required this.isRight,
  });

  /// Indicates whether the panel is shown modally as a new page, or if it
  /// stays visible on one side of the parent layout.
  final bool isModal;

  final bool isRight;

  /// The sections containing the tools.
  ///
  /// They must be [Sliver]s.
  final List<Widget> slivers;

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
                  sections: slivers,
                  isModal: isModal,
                  isRight: isRight,
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
    required this.isModal,
    required this.isRight,
    required this.onClose,
    required this.sections,
  });

  final bool isModal;
  final bool isRight;
  final VoidCallback onClose;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late bool isEnabled;
    if (isRight) {
      isEnabled = context.select(
        (DevicePreviewStore store) => store.data.isToolbarVisibleRight,
      );
    } else {
      isEnabled = context.select(
        (DevicePreviewStore store) => store.data.isToolbarVisibleLeft,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device preview',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: (theme.colorScheme.brightness == Brightness.dark
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onPrimary),
          ),
        ),
        leading: _getLeading(
          context: context,
          isModal: isModal,
          isRight: isRight,
          onClose: onClose,
        ),
        actions: [
          if (!isModal && isRight)
            Switch(
              value: isEnabled,
              onChanged: (v) {
                final state = context.read<DevicePreviewStore>();
                if (isRight) {
                  state.data = state.data.copyWith(
                    isToolbarVisibleRight: v,
                  );
                } else {
                  state.data = state.data.copyWith(
                    isToolbarVisibleLeft: v,
                  );
                }
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: sections,
          ),
        ],
      ),
    );
  }

  Widget _getLeading({
    required BuildContext context,
    required bool isModal,
    required bool isRight,
    required VoidCallback onClose,
  }) {
    late bool isEnabled;
    if (isRight) {
      isEnabled = context.select(
        (DevicePreviewStore store) => store.data.isToolbarVisibleRight,
      );
    } else {
      isEnabled = context.select(
        (DevicePreviewStore store) => store.data.isToolbarVisibleLeft,
      );
    }

    if (!isRight) {
      return Switch(
        value: isEnabled,
        onChanged: (v) {
          final state = context.read<DevicePreviewStore>();
          if (isRight) {
            state.data = state.data.copyWith(
              isToolbarVisibleRight: v,
            );
          } else {
            state.data = state.data.copyWith(
              isToolbarVisibleLeft: v,
            );
          }
        },
      );
    }
    if (isModal) {
      return IconButton(
        icon: const Icon(Icons.close),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: onClose,
      );
    }
    return const SizedBox.shrink();
  }
}

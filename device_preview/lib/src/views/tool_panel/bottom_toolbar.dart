import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({
    Key? key,
    required this.showPanel,
  }) : super(key: key);

  final VoidCallback showPanel;

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );
    return Material(
      child: ListTile(
        title: const Text('Device Preview'),
        onTap: isEnabled ? showPanel : null,
        leading: const Icon(Icons.tune),
        trailing: Switch(
          value: isEnabled,
          onChanged: (v) {
            final state = context.read<DevicePreviewStore>();
            state.data = state.data.copyWith(isEnabled: v);
          },
        ),
      ),
    );
  }
}

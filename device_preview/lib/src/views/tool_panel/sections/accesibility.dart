import 'package:device_preview/src/state/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'section.dart';

class AccessibilitySection extends StatelessWidget {
  const AccessibilitySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = context.select(
      (DevicePreviewStore store) => store.data.textScaleFactor,
    );
    final accessibleNavigation = context.select(
      (DevicePreviewStore store) => store.data.accessibleNavigation,
    );
    final invertColors = context.select(
      (DevicePreviewStore store) => store.data.invertColors,
    );
    return ToolPanelSection(
      title: 'Accessibility',
      icon: Icons.device_hub_rounded,
      children: [
        ListTile(
          title: const Text('Accessible navigation'),
          subtitle: Text(accessibleNavigation ? 'Enabled' : 'Disabled'),
          trailing: Icon(
            accessibleNavigation
                ? Icons.accessible_forward
                : Icons.accessible_rounded,
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.data = state.data.copyWith(
              accessibleNavigation: !accessibleNavigation,
            );
          },
        ),
        ListTile(
          title: const Text('Invert colors'),
          subtitle: Text(invertColors ? 'Enabled' : 'Disabled'),
          trailing: Icon(
            invertColors
                ? Icons.format_color_reset_rounded
                : Icons.format_color_reset_outlined,
          ),
          onTap: () {
            final state = context.read<DevicePreviewStore>();
            state.data = state.data.copyWith(
              invertColors: !invertColors,
            );
          },
        ),
        ListTile(
          title: const Text('Text scaling factor'),
          subtitle: Text(textScaleFactor.toString()),
          trailing: Transform(
            alignment: Alignment.center,
            transform: (Matrix4.identity()
              ..scale(
                textScaleFactor >= 2 ? 1.0 : (textScaleFactor < 1 ? 0.25 : 0.6),
              )),
            child: const Icon(Icons.text_format),
          ),
        ),
        ListTile(
          key: const Key('text-scaling-slider'),
          title: Slider(
            value: textScaleFactor,
            onChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(textScaleFactor: v);
            },
            min: 0.25,
            max: 3,
            divisions: 11,
          ),
        )
      ],
    );
  }
}

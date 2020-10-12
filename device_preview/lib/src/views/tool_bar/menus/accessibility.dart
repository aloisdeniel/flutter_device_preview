import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AccessibilityPopOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Selector(
          selector: (context, DevicePreviewStore store) =>
              store.data.textScaleFactor,
          builder: (context, textScaleFactor, _) => SliderTile(
            title: 'Text scale factor',
            value: textScaleFactor,
            onValueChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(textScaleFactor: v);
            },
            min: 0.25,
            max: 3,
            divisions: 11,
          ),
        ),
        Selector(
          selector: (context, DevicePreviewStore store) =>
              store.data.invertColors,
          builder: (context, invertColors, _) => AccessibilityCheckTile(
            title: 'Invert colors',
            value: invertColors,
            icon: Icons.invert_colors,
            onValueChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(invertColors: v);
            },
          ),
        ),
        Selector(
          selector: (context, DevicePreviewStore store) =>
              store.data.accessibleNavigation,
          builder: (context, accessibleNavigation, _) => AccessibilityCheckTile(
            title: 'Accessible navigation',
            value: accessibleNavigation,
            icon: Icons.accessible_forward,
            onValueChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(accessibleNavigation: v);
            },
          ),
        ),
        Selector(
          selector: (context, DevicePreviewStore store) =>
              store.data.disableAnimations,
          builder: (context, disableAnimations, _) => AccessibilityCheckTile(
            title: 'Disable animations',
            value: disableAnimations,
            icon: Icons.movie,
            onValueChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(disableAnimations: v);
            },
          ),
        ),
        Selector(
          selector: (context, DevicePreviewStore store) => store.data.boldText,
          builder: (context, boldText, _) => AccessibilityCheckTile(
            title: 'Bold text',
            value: boldText,
            icon: Icons.format_bold,
            onValueChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(boldText: v);
            },
          ),
        ),
      ],
    );
  }
}

class AccessibilityCheckTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onValueChanged;

  AccessibilityCheckTile({
    @required this.title,
    @required this.icon,
    @required this.value,
    @required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    return GestureDetector(
      onTap: () => onValueChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: toolBarStyle.foregroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              _SelectBox(
                icon: icon,
                value: value,
                onValueChanged: onValueChanged,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onValueChanged;

  const _SelectBox({
    @required this.icon,
    @required this.value,
    @required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: toolBarStyle.foregroundColor.withOpacity(
            value ? 0.0 : 0.3,
          ),
        ),
        borderRadius: BorderRadius.circular(2),
        color: Theme.of(context).accentColor.withOpacity(
              value ? 1 : 0.0,
            ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: value
            ? Icon(
                icon,
                color: toolBarStyle.foregroundColor,
                size: 11,
              )
            : Icon(
                icon,
                color: toolBarStyle.foregroundColor.withOpacity(0.3),
                size: 11,
              ),
      ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onValueChanged;

  const SliderTile({
    @required this.title,
    @required this.min,
    @required this.max,
    @required this.divisions,
    @required this.value,
    @required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          final range = (max - min);
          onValueChanged(
            value == max ? range / 2 : (value + (range / divisions)),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 12,
                          color: toolBarStyle.foregroundColor,
                        ),
                      ),
                    ),
                    Text(
                      value?.toString() ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: toolBarStyle.foregroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                Slider(
                  divisions: divisions, // 11,
                  value: value,
                  onChanged: onValueChanged,
                  min: min, //0.25,
                  max: max, // 3.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../device_preview.dart';

class AccessibilityPopOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        AccessibilityTextScaleTile(
          title: 'Text scale factor',
          value: preview.textScaleFactor,
          onValueChanged: (v) => preview.textScaleFactor = v,
        ),
        AccessibilityCheckTile(
          title: 'Invert colors',
          value: preview.invertColors,
          icon: Icons.invert_colors,
          onValueChanged: (v) => preview.invertColors = v,
        ),
        AccessibilityCheckTile(
          title: 'Accessible navigation',
          value: preview.accessibleNavigation,
          icon: Icons.accessible_forward,
          onValueChanged: (v) => preview.accessibleNavigation = v,
        ),
        AccessibilityCheckTile(
          title: 'Disable animations',
          value: preview.disableAnimations,
          icon: Icons.movie,
          onValueChanged: (v) => preview.disableAnimations = v,
        ),
        AccessibilityCheckTile(
          title: 'Bold text',
          value: preview.boldText,
          icon: Icons.format_bold,
          onValueChanged: (v) => preview.boldText = v,
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

class AccessibilityTextScaleTile extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onValueChanged;

  AccessibilityTextScaleTile({
    @required this.title,
    @required this.value,
    @required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => onValueChanged(value == 2.0 ? 1.0 : (value + 0.5)),
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
                          fontSize: 12.0,
                          color: toolBarStyle.foregroundColor,
                        ),
                      ),
                    ),
                    Text(
                      value?.toString() ?? '',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: toolBarStyle.foregroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                Slider(
                  divisions: 11,
                  value: value,
                  onChanged: onValueChanged,
                  min: 0.25,
                  max: 3.0,
                )
              ],
            ),
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

import 'package:device_preview/src/state/state.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StylePopOver extends StatelessWidget {
  final GestureTapCallback close;

  StylePopOver(this.close);

  @override
  Widget build(BuildContext context) {
    final settings = context.select(
      (DevicePreviewStore store) => store.settings,
    );

    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final lightBackground = DevicePreviewStyle.light();
    final darkBackground = DevicePreviewStyle.dark();
    final media = MediaQuery.of(context);
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        WrapOptionsTile(
          title: 'Background theme',
          options: <Widget>[
            SelectBox(
              isSelected: settings.backgroundTheme ==
                  DevicePreviewBackgroundThemeData.light,
              onTap: () {
                final state = context.read<DevicePreviewStore>();
                state.settings = settings.copyWith(
                    backgroundTheme: DevicePreviewBackgroundThemeData.light);
              },
              child: Container(
                decoration: lightBackground.background,
              ),
            ),
            SelectBox(
              isSelected: settings.backgroundTheme ==
                  DevicePreviewBackgroundThemeData.dark,
              onTap: () {
                final state = context.read<DevicePreviewStore>();
                state.settings = settings.copyWith(
                    backgroundTheme: DevicePreviewBackgroundThemeData.dark);
              },
              child: Container(
                decoration: darkBackground.background,
              ),
            ),
          ],
        ),
        WrapOptionsTile(
          title: 'Toolbar theme',
          options: <Widget>[
            SelectBox(
              isSelected:
                  settings.toolbarTheme == DevicePreviewToolBarThemeData.light,
              onTap: () {
                final state = context.read<DevicePreviewStore>();
                state.settings = settings.copyWith(
                    toolbarTheme: DevicePreviewToolBarThemeData.light);
              },
              child: Container(
                decoration: lightBackground.background,
              ),
            ),
            SelectBox(
              isSelected:
                  settings.toolbarTheme == DevicePreviewToolBarThemeData.dark,
              onTap: () {
                final state = context.read<DevicePreviewStore>();
                state.settings = settings.copyWith(
                    toolbarTheme: DevicePreviewToolBarThemeData.dark);
              },
              child: Container(
                decoration: darkBackground.background,
              ),
            ),
          ],
        ),
        WrapOptionsTile(
          title: 'Toolbar position',
          options: <Widget>[
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.left, media.size.width))
              SelectBox(
                isSelected: settings.toolbarPosition ==
                    DevicePreviewToolBarPositionData.left,
                onTap: () {
                  final state = context.read<DevicePreviewStore>();
                  state.settings = settings.copyWith(
                      toolbarPosition: DevicePreviewToolBarPositionData.left);
                },
                child: Icon(
                  Icons.border_left,
                  color: toolBarStyle.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.top, media.size.width))
              SelectBox(
                isSelected: settings.toolbarPosition ==
                    DevicePreviewToolBarPositionData.top,
                onTap: () {
                  final state = context.read<DevicePreviewStore>();
                  state.settings = settings.copyWith(
                      toolbarPosition: DevicePreviewToolBarPositionData.top);
                },
                child: Icon(
                  Icons.border_top,
                  color: toolBarStyle.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.right, media.size.width))
              SelectBox(
                isSelected: settings.toolbarPosition ==
                    DevicePreviewToolBarPositionData.right,
                onTap: () {
                  final state = context.read<DevicePreviewStore>();
                  state.settings = settings.copyWith(
                      toolbarPosition: DevicePreviewToolBarPositionData.right);
                },
                child: Icon(
                  Icons.border_right,
                  color: toolBarStyle.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.bottom, media.size.width))
              SelectBox(
                isSelected: settings.toolbarPosition ==
                    DevicePreviewToolBarPositionData.bottom,
                onTap: () {
                  final state = context.read<DevicePreviewStore>();
                  state.settings = settings.copyWith(
                      toolbarPosition: DevicePreviewToolBarPositionData.bottom);
                },
                child: Icon(
                  Icons.border_bottom,
                  color: toolBarStyle.foregroundColor,
                  size: 11,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class WrapOptionsTile extends StatelessWidget {
  final String title;
  final List<Widget> options;

  WrapOptionsTile({
    @required this.title,
    @required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: toolBarStyle.foregroundColor,
            ),
          ),
          SizedBox(height: 6),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options,
          )
        ],
      ),
    );
  }
}

class SelectBox extends StatelessWidget {
  final bool isSelected;
  final GestureTapCallback onTap;
  final Widget child;

  const SelectBox({
    @required this.isSelected,
    @required this.onTap,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: toolBarStyle.foregroundColor.withOpacity(
              isSelected ? 0.0 : 0.3,
            ),
          ),
          borderRadius: BorderRadius.circular(2),
          color: Theme.of(context).accentColor.withOpacity(
                isSelected ? 1 : 0.0,
              ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: SizedBox(
            child: child,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}

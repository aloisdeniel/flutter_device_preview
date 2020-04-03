import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../device_preview.dart';

class StylePopOver extends StatelessWidget {
  final GestureTapCallback close;

  StylePopOver(this.close);

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final style = DevicePreviewTheme.of(context);
    final lightBackground = DevicePreviewStyle.light();
    final darkBackground = DevicePreviewStyle.dark();
    final media = MediaQuery.of(context);
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        _StyleTile(
          title: 'Background theme',
          options: <Widget>[
            _SelectBox(
              isSelected: style.background == lightBackground.background,
              onTap: () => preview.style =
                  style.copyWith(background: lightBackground.background),
              child: Container(
                decoration: lightBackground.background,
              ),
            ),
            _SelectBox(
              isSelected: style.background == darkBackground.background,
              onTap: () => preview.style =
                  style.copyWith(background: darkBackground.background),
              child: Container(
                decoration: darkBackground.background,
              ),
            ),
          ],
        ),
        _StyleTile(
          title: 'Toolbar theme',
          options: <Widget>[
            _SelectBox(
              isSelected: style.toolBar.backgroundColor ==
                  darkBackground.toolBar.backgroundColor,
              onTap: () => preview.style = style.copyWith(
                toolBar: darkBackground.toolBar
                    .copyWith(position: style.toolBar.position),
              ),
              child: Container(
                decoration: lightBackground.background,
              ),
            ),
            _SelectBox(
              isSelected: style.toolBar.backgroundColor ==
                  lightBackground.toolBar.backgroundColor,
              onTap: () => preview.style = style.copyWith(
                toolBar: lightBackground.toolBar
                    .copyWith(position: style.toolBar.position),
              ),
              child: Container(
                decoration: darkBackground.background,
              ),
            ),
          ],
        ),
        _StyleTile(
          title: 'Toolbar position',
          options: <Widget>[
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.left, media.size.width))
              _SelectBox(
                isSelected:
                    style.toolBar.position == DevicePreviewToolBarPosition.left,
                onTap: () {
                  close();
                  preview.style = style.copyWith(
                      toolBar: style.toolBar.copyWith(
                          position: DevicePreviewToolBarPosition.left));
                },
                child: Icon(
                  Icons.border_left,
                  color: style.toolBar.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.top, media.size.width))
              _SelectBox(
                isSelected:
                    style.toolBar.position == DevicePreviewToolBarPosition.top,
                onTap: () {
                  close();
                  preview.style = style.copyWith(
                      toolBar: style.toolBar.copyWith(
                          position: DevicePreviewToolBarPosition.top));
                },
                child: Icon(
                  Icons.border_top,
                  color: style.toolBar.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.right, media.size.width))
              _SelectBox(
                isSelected: style.toolBar.position ==
                    DevicePreviewToolBarPosition.right,
                onTap: () {
                  close();
                  preview.style = style.copyWith(
                      toolBar: style.toolBar.copyWith(
                          position: DevicePreviewToolBarPosition.right));
                },
                child: Icon(
                  Icons.border_right,
                  color: style.toolBar.foregroundColor,
                  size: 11,
                ),
              ),
            if (DevicePreviewTheme.isPositionAvailableForWidth(
                DevicePreviewToolBarPosition.bottom, media.size.width))
              _SelectBox(
                isSelected: style.toolBar.position ==
                    DevicePreviewToolBarPosition.bottom,
                onTap: () {
                  close();
                  preview.style = style.copyWith(
                      toolBar: style.toolBar.copyWith(
                          position: DevicePreviewToolBarPosition.bottom));
                },
                child: Icon(
                  Icons.border_bottom,
                  color: style.toolBar.foregroundColor,
                  size: 11,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StyleTile extends StatelessWidget {
  final String title;
  final List<Widget> options;

  _StyleTile({
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
              fontSize: 12.0,
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

class _SelectBox extends StatelessWidget {
  final bool isSelected;
  final GestureTapCallback onTap;
  final Widget child;

  const _SelectBox({
    @required this.isSelected,
    @required this.onTap,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return GestureDetector(
      onTap: !isSelected ? onTap : null,
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../device_preview_style.dart';

class PopoverScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  const PopoverScaffold({
    Key key,
    @required this.body,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: title,
        ),
        Expanded(
          child: body,
        ),
      ],
    );
  }
}

class PopoverBar extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;

  const PopoverBar({
    @required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Container(
      decoration: BoxDecoration(
        color: toolBarStyle.backgroundColor,
      ),
      padding: toolBarStyle.spacing.regular,
      child: Row(
        children: <Widget>[
          if (leading != null) ...[
            leading,
            SizedBox(
              width: 6,
            ),
          ],
          if (leading == null && Navigator.of(context).canPop()) ...[
            PopoverIconButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(
              width: 6,
            ),
          ],
          Expanded(
            child: title,
          ),
          if (trailing != null) ...[
            trailing,
            SizedBox(
              width: 6,
            ),
          ],
        ],
      ),
    );
  }
}

class PopoverTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onTap;

  const PopoverTile({
    @required this.title,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = DevicePreviewTheme.of(context);
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Row(
            children: <Widget>[
              if (leading != null) ...[
                leading,
                SizedBox(
                  width: theme.toolBar.spacing.small.top,
                ),
              ],
              Expanded(
                child: title,
              ),
              if (trailing != null) ...[
                trailing,
                SizedBox(
                  width: theme.toolBar.spacing.small.top,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PopoverIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const PopoverIconButton({
    @required this.icon,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = DevicePreviewTheme.of(context);
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Icon(
            icon,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class PopoverPageRoute<T> extends PageRoute<T> {
  PopoverPageRoute({
    RouteSettings settings,
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 0),
    this.reverseTransitionDuration = const Duration(milliseconds: 0),
  })  : assert(builder != null),
        super(
          settings: settings,
          fullscreenDialog: true,
        );

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque = true;

  @override
  final bool barrierDismissible = false;

  @override
  final Color barrierColor = Colors.transparent;

  @override
  final String barrierLabel = '';

  @override
  final bool maintainState = false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class PopoverSearchField extends StatefulWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onTextChanged;

  const PopoverSearchField({
    Key key,
    @required this.hintText,
    @required this.onTextChanged,
    this.text = '',
  }) : super(key: key);

  @override
  _PopoverSearchFieldState createState() => _PopoverSearchFieldState();
}

class _PopoverSearchFieldState extends State<PopoverSearchField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.text,
    );
    _searchTECListener();
    super.initState();
  }

  void _searchTECListener() {
    _controller.addListener(() {
      setState(() {
        widget.onTextChanged(
          _controller.text.replaceAll(' ', '').toLowerCase(),
        );
      });
    });
  }

  @override
  void didUpdateWidget(covariant PopoverSearchField oldWidget) {
    if (widget.text != _controller.text) {
      _controller.text = widget.text;
    }

    super.didUpdateWidget(oldWidget);
  }

  void _clear() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Container(
      child: Material(
        child: Container(
          color: toolBarStyle.backgroundColor,
          height: 48,
          padding: EdgeInsets.only(
            left: toolBarStyle.spacing.regular.top,
            top: toolBarStyle.spacing.small.top,
            right: toolBarStyle.spacing.regular.top,
            bottom: toolBarStyle.spacing.regular.top,
          ),
          child: TextField(
            style: TextStyle(
              color: toolBarStyle.foregroundColor,
              fontSize: 12,
            ),
            controller: _controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: toolBarStyle.foregroundColor.withOpacity(0.5),
                fontSize: 12,
              ),
              hintText: widget.hintText, // 'Search by device name...',
              contentPadding: EdgeInsets.only(
                left: toolBarStyle.spacing.regular.top,
                right: toolBarStyle.spacing.regular.top,
                bottom: toolBarStyle.spacing.big.top,
              ),
              filled: true,
              fillColor: toolBarStyle.foregroundColor.withOpacity(0.12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: toolBarStyle.foregroundColor.withOpacity(0.5),
                size: 14,
              ),
              suffix: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: toolBarStyle.spacing.small.top,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: toolBarStyle.foregroundColor.withOpacity(0.5),
                  ),
                ),
                onTap: _clear,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

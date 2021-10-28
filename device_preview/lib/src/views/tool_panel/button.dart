import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToolBarButton extends StatelessWidget {
  final bool isRounded;
  final IconData? icon;
  final Widget? child;
  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// Called when the user taps this button.
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  const ToolBarButton({
    Key? key,
    this.title,
    this.icon,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.isRounded = false,
    this.onTap,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        shape: isRounded ? _RoundedBorder() : null,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon),
        ],
      ),
      onPressed: onTap,
    );
  }
}

class _RoundedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    return const RoundedRectangleBorder(); // TODO
  }
}

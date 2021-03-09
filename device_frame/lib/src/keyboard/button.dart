import 'package:flutter/widgets.dart';

/// A [VirtualKeyboard] button.
class VirtualKeyboardButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const VirtualKeyboardButton({
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 6,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

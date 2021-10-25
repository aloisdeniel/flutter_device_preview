import 'package:flutter/widgets.dart';

/// A [VirtualKeyboard] button.
class VirtualKeyboardButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const VirtualKeyboardButton({
    Key? key,
    required this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 6,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

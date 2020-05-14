import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class VirtualKeyboard extends StatelessWidget {
  static const double minHeight = 214;
  final double height;

  const VirtualKeyboard({
    double height,
  }) : this.height = height ?? minHeight;

  Widget _row(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 12.0,
      ),
      child: Row(
        children: children,
      ),
    );
  }

  List<Widget> _letters(
      List<String> letters, Color backgroundColor, Color foregroundColor) {
    return letters
        .map<Widget>(
          (x) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Text(
                  x,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: foregroundColor,
                  ),
                ),
                backgroundColor: backgroundColor,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DeviceFrameTheme.of(context).keyboardStyle;
    return Container(
      height: height,
      color: theme.backgroundColor,
      child: Column(
        children: <Widget>[
          _row(_letters(
            ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
            theme.button1BackgroundColor,
            theme.button1ForegroundColor,
          )),
          _row(_letters(
            ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
            theme.button1BackgroundColor,
            theme.button1ForegroundColor,
          )),
          _row([
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.keyboard_capslock,
                  color: theme.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: theme.button2BackgroundColor,
              ),
            ),
            ..._letters(
              ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
              theme.button1BackgroundColor,
              theme.button1ForegroundColor,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.backspace,
                  color: theme.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: theme.button2BackgroundColor,
              ),
            ),
          ]),
          _row([
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Text(
                  '123',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: theme.button2ForegroundColor,
                  ),
                ),
                backgroundColor: theme.button2BackgroundColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.insert_emoticon,
                  color: theme.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: theme.button2BackgroundColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 12.0,
                ),
                child: VirtualKeyboardButton(
                  child: Text(
                    'space',
                    style: TextStyle(
                        fontSize: 14.0, color: theme.button2ForegroundColor),
                  ),
                  backgroundColor: theme.button2BackgroundColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Text(
                  'return',
                  style: TextStyle(
                      fontSize: 14.0, color: theme.button2ForegroundColor),
                ),
                backgroundColor: theme.button2BackgroundColor,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

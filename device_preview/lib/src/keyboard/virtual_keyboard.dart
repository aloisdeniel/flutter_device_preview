import 'package:device_preview/src/keyboard/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VirtualKeyboard extends StatelessWidget {
  static const double minHeight = 214;
  final double height;
  const VirtualKeyboard({
    @required this.height,
  });

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

  List<Widget> _letters(List<String> letters) {
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
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Color(0xFF6D6D6E),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: const Color(0xFF2B2B2D).withOpacity(0.95),
      child: Column(
        children: <Widget>[
          _row(_letters(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'])),
          _row(_letters(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'])),
          _row([
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.keyboard_capslock,
                  color: Colors.white,
                  size: 16,
                ),
                backgroundColor: Color(0xFF4A4A4B),
              ),
            ),
            ..._letters(['Z', 'X', 'C', 'V', 'B', 'N', 'M']),
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.backspace,
                  color: Colors.white,
                  size: 16,
                ),
                backgroundColor: Color(0xFF4A4A4B),
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
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Color(0xFF4A4A4B),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
              child: VirtualKeyboardButton(
                child: Icon(
                  Icons.insert_emoticon,
                  color: Colors.white,
                  size: 16,
                ),
                backgroundColor: Color(0xFF4A4A4B),
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
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Color(0xFF4A4A4B),
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
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Color(0xFF4A4A4B),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

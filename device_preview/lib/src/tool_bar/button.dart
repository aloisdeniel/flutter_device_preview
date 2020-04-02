import 'package:flutter/widgets.dart';

import '../../device_preview.dart';
import 'tool_bar_style.dart';
import 'tool_bar_theme.dart';

class ToolBarButton extends StatefulWidget {
  final bool isRoundedLeft;
  final bool isRoundedRight;
  final IconData icon;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;

  /// Called when the user taps this button.
  final GestureTapCallback onTap;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode focusNode;

  const ToolBarButton({
    Key key,
    this.title,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    bool isRounded = false,
    bool isRoundedLeft = false,
    bool isRoundedRight = false,
    this.onTap,
    this.autofocus = false,
    this.focusNode,
  })  : isRoundedLeft = isRounded || isRoundedLeft,
        isRoundedRight = isRounded || isRoundedRight,
        assert(autofocus != null),
        super(key: key);

  @override
  _ToolBarButtonState createState() => _ToolBarButtonState();
}

class _ToolBarButtonState extends State<ToolBarButton> {
  bool isActive = false;
  bool isHover = false;
  bool isFocused = false;

  BoxDecoration decoration(DevicePreviewToolBarStyle style) {
    return BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(widget.isRoundedLeft ? 1000.0 : 2.0),
          topLeft: Radius.circular(widget.isRoundedLeft ? 1000.0 : 2.0),
          bottomRight: Radius.circular(widget.isRoundedRight ? 1000.0 : 2.0),
          topRight: Radius.circular(widget.isRoundedRight ? 1000.0 : 2.0),
        ),
        color: widget.onTap != null && (isActive || isHover)
            ? (widget.foregroundColor?.withOpacity(0.2) ??
                style.buttonHoverBackgroundColor)
            : (widget.backgroundColor ?? style.buttonBackgroundColor));
  }

  IconThemeData iconTheme(DevicePreviewToolBarStyle style) {
    return IconThemeData(
      size: 14,
      color: widget.foregroundColor ?? style.foregroundColor,
    );
  }

  TextStyle textStyle(DevicePreviewToolBarStyle style) => TextStyle(
        fontSize: 11.0,
        color: widget.foregroundColor ?? style.foregroundColor,
      );

  Widget _content() {
    if (widget.icon == null && widget.title != null) return Text(widget.title);
    if (widget.icon != null && widget.title == null) return Icon(widget.icon);
    return Row(
      children: <Widget>[
        Icon(
          widget.icon,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(widget.title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null;
    const duration = Duration(milliseconds: 80);
    final toolBarStyle = DevicePreviewToolBarTheme.of(context);

    var padding = EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 14.0,
    );

    // If direct child is an icon, we use same padding everywhere to
    // make the button a square.
    if (widget.title == null) {
      padding = EdgeInsets.all(padding.top);
    }

    return Semantics(
      container: true,
      button: true,
      enabled: !isDisabled,
      child: Focus(
        focusNode: widget.focusNode,
        canRequestFocus: !isDisabled,
        onFocusChange: (v) => setState(() => isFocused = true),
        autofocus: widget.autofocus,
        child: MouseRegion(
          onEnter: (_) => setState(() => isHover = true),
          onExit: (_) => setState(() => isHover = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => isActive = true),
            onTapUp: (_) => setState(() => isActive = false),
            onTapCancel: () => setState(() => isActive = false),
            onTap: widget.onTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedOpacity(
              duration: duration,
              opacity: isDisabled ? 0.6 : 1.0,
              child: AnimatedContainer(
                duration: duration,
                decoration: decoration(toolBarStyle),
                padding: padding,
                child: AnimatedDefaultTextStyle(
                  child: IconTheme(
                    data: iconTheme(toolBarStyle),
                    child: _content(),
                  ),
                  style: textStyle(toolBarStyle),
                  duration: duration,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

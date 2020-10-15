import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/widgets.dart';

class ToolBarButton extends StatefulWidget {
  final bool isRoundedTopLeft;
  final bool isRoundedTopRight;
  final bool isRoundedBottomLeft;
  final bool isRoundedBottomRight;
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
    bool isRoundedTop = false,
    bool isRoundedBottom = false,
    bool isRoundedBottomLeft = false,
    bool isRoundedBottomRight = false,
    bool isRoundedTopLeft = false,
    bool isRoundedTopRight = false,
    this.onTap,
    this.autofocus = false,
    this.focusNode,
  })  : isRoundedTopLeft =
            isRounded || isRoundedLeft || isRoundedTop || isRoundedTopLeft,
        isRoundedTopRight =
            isRounded || isRoundedRight || isRoundedTop || isRoundedTopRight,
        isRoundedBottomLeft = isRounded ||
            isRoundedBottom ||
            isRoundedLeft ||
            isRoundedBottomLeft,
        isRoundedBottomRight = isRounded ||
            isRoundedRight ||
            isRoundedBottom ||
            isRoundedBottomRight,
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
          bottomLeft: Radius.circular(widget.isRoundedBottomLeft ? 22.0 : 2.0),
          topLeft: Radius.circular(widget.isRoundedTopLeft ? 22.0 : 2.0),
          bottomRight:
              Radius.circular(widget.isRoundedBottomRight ? 22.0 : 2.0),
          topRight: Radius.circular(widget.isRoundedTopRight ? 22.0 : 2.0),
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
        fontSize: 11,
        color: widget.foregroundColor ?? style.foregroundColor,
      );

  Widget _content(BuildContext context, bool expanded) {
    if (widget.icon == null && widget.title != null) return Text(widget.title);
    if (widget.icon != null && widget.title == null) return Icon(widget.icon);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final title = Text(
      widget.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    return Row(
      children: <Widget>[
        Icon(
          widget.icon,
        ),
        SizedBox(
          width: toolBarStyle.spacing.regular.top,
        ),
        expanded
            ? Expanded(
                child: title,
              )
            : title,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null;
    const duration = Duration(milliseconds: 80);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    var padding = EdgeInsets.symmetric(
      vertical: toolBarStyle.spacing.regular.top,
      horizontal: toolBarStyle.spacing.big.top,
    );

    // If direct child is an icon, we use same padding everywhere to
    // make the button a square.
    if (widget.title == null) {
      padding = EdgeInsets.all(padding.top);
    }

    final isHorizontal =
        toolBarStyle.position == DevicePreviewToolBarPosition.top ||
            toolBarStyle.position == DevicePreviewToolBarPosition.bottom;

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
                    child: _content(context, !isHorizontal),
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

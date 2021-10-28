import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopoverScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  const PopoverScaffold({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconTheme(
      data: IconThemeData(
        color: theme.appBarTheme.foregroundColor,
        size: theme.appBarTheme.toolbarTextStyle!.fontSize! * 1.4,
      ),
      child: DefaultTextStyle(
        style: theme.appBarTheme.toolbarTextStyle!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: title,
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class PopoverBar extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final Widget? trailing;

  const PopoverBar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
      ),
      height: theme.appBarTheme.toolbarHeight,
      child: Row(
        children: <Widget>[
          if (leading != null) ...[
            leading!,
            const SizedBox(
              width: 6,
            ),
          ],
          if (leading == null && Navigator.of(context).canPop()) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          Expanded(
            child: title,
          ),
          if (trailing != null) ...[
            trailing!,
            const SizedBox(
              width: 6,
            ),
          ],
        ],
      ),
    );
  }
}

class PopoverPageRoute<T> extends PageRoute<T> {
  PopoverPageRoute({
    required RouteSettings settings,
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 0),
    this.reverseTransitionDuration = const Duration(milliseconds: 0),
  }) : super(
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
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class PopoverSearchField extends StatefulWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onTextChanged;

  const PopoverSearchField({
    Key? key,
    required this.hintText,
    required this.onTextChanged,
    this.text = '',
  }) : super(key: key);

  @override
  _PopoverSearchFieldState createState() => _PopoverSearchFieldState();
}

class _PopoverSearchFieldState extends State<PopoverSearchField> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.text,
    );
    _searchTECListener();
    super.initState();
  }

  void _searchTECListener() {
    _controller!.addListener(() {
      widget.onTextChanged(
        _controller!.text.replaceAll(' ', '').toLowerCase(),
      );
    });
  }

  @override
  void didUpdateWidget(covariant PopoverSearchField oldWidget) {
    if (widget.text != _controller!.text) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        _controller!.text = widget.text;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  void _clear() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _controller!.clear());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Container(
        color: theme.appBarTheme.backgroundColor,
        height: 48,
        child: TextField(
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontSize: 12,
          ),
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText, // 'Search by device name...',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            prefixIcon: const Icon(Icons.search),
            suffix: InkWell(
              child: const Icon(Icons.close),
              onTap: _clear,
            ),
          ),
        ),
      ),
    );
  }
}

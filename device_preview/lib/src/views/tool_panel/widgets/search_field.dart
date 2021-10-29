import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToolbarSearchField extends StatefulWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onTextChanged;

  const ToolbarSearchField({
    Key? key,
    required this.hintText,
    required this.onTextChanged,
    this.text = '',
  }) : super(key: key);

  @override
  _ToolbarSearchFieldState createState() => _ToolbarSearchFieldState();
}

class _ToolbarSearchFieldState extends State<ToolbarSearchField> {
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
  void didUpdateWidget(covariant ToolbarSearchField oldWidget) {
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
        color: theme.scaffoldBackgroundColor,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            border: InputBorder.none,
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

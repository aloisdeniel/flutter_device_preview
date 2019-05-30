import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Resizer extends StatefulWidget {
  final ValueChanged<Size> resized;
  final Size initialSize;
  final Size maxSize;
  final Size minSize;
  Resizer(
      {@required this.initialSize,
      @required this.maxSize,
      this.minSize = const Size(100, 100),
      @required this.resized});

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<Resizer> {
  Size _size;

  set size(Size value) {
    _size = Size(value.width.clamp(widget.minSize.width, widget.maxSize.width),
        value.height.clamp(widget.minSize.height, widget.maxSize.height));
    this.widget.resized(_size);
    this.setState(() {});
  }

  @override
  void initState() {
    _size = widget.initialSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      width: _size.width + 140,
      height: _size.height + 140,
      child: Listener(
          onPointerMove: (details) {
            this.size = Size(_size.width + details.delta.dx,
                _size.height - details.delta.dy);
          },
          behavior: HitTestBehavior.translucent,
          child: _Button(),
          ),
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFAAAAAA),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.transform, color: const Color(0xFF444444), size: 40),
    );
  }
}

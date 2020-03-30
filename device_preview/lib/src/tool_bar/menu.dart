import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DevicePreviewMenu extends StatefulWidget {
  final WidgetBuilder builder;

  const DevicePreviewMenu({
    @required this.builder,
  });

  @override
  _DevicePreviewMenuState createState() => _DevicePreviewMenuState();
}

class _DevicePreviewMenuState extends State<DevicePreviewMenu> {
  bool _isOpen;

  void open() {
    if (!_isOpen) setState(() => _isOpen = true);
  }

  void close() {
    if (_isOpen) setState(() => _isOpen = false);
  }

  @override
  void initState() {
    _isOpen = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
      layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              key: bottomChildKey,
              child: bottomChild,
            ),
            Positioned.fill(
              key: topChildKey,
              child: topChild,
            ),
          ],
        );
      },
      firstChild: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white60,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.settings),
            ),
            onTap: open,
          ),
        ),
      ),
      secondChild: IgnorePointer(
        ignoring: !_isOpen,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              key: Key('barrier'),
              child: GestureDetector(
                onTap: () {
                  close();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  color: _isOpen ? Colors.black45 : Colors.transparent,
                  child: SizedBox(),
                ),
              ),
            ),
            Positioned(
              key: Key('drawer'),
              top: 0,
              bottom: 0,
              left: 0,
              width: 320,
              child: widget.builder(context),
            ),
          ],
        ),
      ),
    );
  }
}

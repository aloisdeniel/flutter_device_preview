import 'dart:ui';

import 'package:device_preview/src/utilities/media_query_observer.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utilities/position.dart';

typedef PopoverContentBuilder = Widget Function(
    BuildContext context, GestureTapCallback onClose);

class Popover extends StatefulWidget {
  final Widget child;
  final String title;
  final IconData icon;
  final Size? size;
  final Rect? parentBounds;
  final PopoverContentBuilder builder;

  const Popover({
    Key? key,
    this.size,
    required this.parentBounds,
    required this.title,
    required this.icon,
    required this.child,
    required this.builder,
  }) : super(key: key);

  static void open(BuildContext context) {
    final state = context.findAncestorStateOfType<_PopoverState>();
    state!.open();
  }

  static void close(BuildContext context) {
    final state = context.findAncestorStateOfType<_PopoverState>();
    state!.close();
  }

  @override
  _PopoverState createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  final _key = GlobalKey();
  final List<OverlayEntry> _overlayEntries = [];
  bool _isOpen = false;

  void open() {
    if (!_isOpen) {
      final barrier = OverlayEntry(
        opaque: false,
        builder: (context) => _PopOverBarrier(
          () => close(),
        ),
      );

      final startPosition = Offset(
        _key.absolutePosition!.left - (widget.parentBounds?.left ?? 0),
        _key.absolutePosition!.top - (widget.parentBounds?.top ?? 0),
      );
      final popover = OverlayEntry(
        opaque: false,
        builder: (context) => MediaQueryObserver(
          child: _PopOverContainer(
            title: widget.title,
            icon: widget.icon,
            child: widget.builder(context, close),
            size: widget.size ?? Size(280, 420),
            startPosition:
                startPosition & (_key.absolutePosition?.size ?? Size.zero),
            parentBounds: widget.parentBounds,
          ),
        ),
      );

      _overlayEntries.add(barrier);
      _overlayEntries.add(popover);
      Overlay.of(context)!.insertAll(_overlayEntries);
      _isOpen = true;
    }
  }

  void close() {
    if (_isOpen) {
      for (var item in _overlayEntries) {
        item.remove();
      }
      _overlayEntries.clear();
      _isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      child: widget.child,
    );
  }
}

class _PopOverContainer extends StatefulWidget {
  final Rect startPosition;
  final Size size;
  final Widget child;
  final String title;
  final IconData icon;
  final Rect? parentBounds;

  _PopOverContainer({
    required this.title,
    required this.icon,
    required this.child,
    required this.startPosition,
    required this.size,
    required this.parentBounds,
  });

  @override
  __PopOverContainerState createState() => __PopOverContainerState();
}

class __PopOverContainerState extends State<_PopOverContainer>
    with WidgetsBindingObserver {
  bool _isStarted = false;
  Offset _translate = Offset.zero;

  @override
  void didChangeMetrics() {
    setState(() {});
  }

  @override
  void initState() {
    // Centered bottom
    _translate = Offset.zero;
    _isStarted = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _isStarted = true;
      });
    });
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = const Duration(milliseconds: 80);
    final previewTheme = DevicePreviewTheme.of(context);
    final toolBarStyle = previewTheme.toolBar;
    final media = MediaQuery.of(context);

    var bounds = widget.startPosition;
    final parentBounds = widget.parentBounds ?? (Offset.zero & media.size);
    final isHorizontal =
        toolBarStyle.position == DevicePreviewToolBarPosition.top ||
            toolBarStyle.position == DevicePreviewToolBarPosition.bottom;

    if (_isStarted) {
      if (widget.startPosition.top > parentBounds.height / 2) {
        final bottom = isHorizontal ? bounds.top : bounds.bottom;
        if (widget.startPosition.left > parentBounds.width / 2) {
          // Bottom-Right of the screen
          final right = isHorizontal ? bounds.right : bounds.left;
          bounds = Rect.fromLTRB(
            right - widget.size.width,
            bottom - widget.size.height,
            right,
            bottom,
          );
        } else {
          // Bottom-Left of the screen
          final left = isHorizontal ? bounds.left : bounds.right;
          bounds = Rect.fromLTRB(
            left,
            bottom - widget.size.height,
            left + widget.size.width,
            bottom,
          );
        }
      } else {
        final top = isHorizontal ? bounds.bottom : bounds.top;
        if (widget.startPosition.left > parentBounds.width / 2) {
          // Top-Right of the screen
          final right = isHorizontal ? bounds.right : bounds.left;
          bounds = Rect.fromLTRB(
            right - widget.size.width,
            top,
            right,
            top + widget.size.height,
          );
        } else {
          // Top-Left of the screen
          final left = isHorizontal ? bounds.left : bounds.right;
          bounds = Rect.fromLTRB(
            left,
            top,
            left + widget.size.width,
            top + widget.size.height,
          );
        }
      }
    } else {
      bounds = Offset(bounds.left, bounds.top) & widget.size;
    }

    if (bounds.bottom > parentBounds.height - media.padding.bottom) {
      bounds = Offset(bounds.left,
              parentBounds.height - media.padding.bottom - bounds.size.height) &
          bounds.size;
    }
    if (bounds.top < media.padding.top) {
      bounds = Offset(bounds.left, media.padding.top) & bounds.size;
    }

    final content = Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (u) {
              setState(() => _translate += u.delta);
            },
            child: _PopOverHeader(
              title: widget.title,
              icon: widget.icon,
            ),
          ),
          Expanded(
            child: Navigator(
              onGenerateInitialRoutes: (e, _) => [
                MaterialPageRoute(
                  builder: (context) => widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Positioned(
      left: bounds.left + _translate.dx,
      top: bounds.top - media.viewInsets.bottom + _translate.dy,
      width: bounds.width,
      height: bounds.height,
      child: AnimatedOpacity(
        duration: duration,
        opacity: _isStarted ? 1.0 : 0.0,
        child: MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          child: Theme(
            data: ThemeData.dark().copyWith(
              accentColor: previewTheme.toolBar.buttonHoverBackgroundColor,
            ),
            child: AnimatedContainer(
              duration: duration,
              curve: Curves.easeOut,
              transform: (_isStarted
                  ? (Matrix4.identity())
                  : (Matrix4.translationValues(0, 6, 0))),
              decoration: BoxDecoration(
                color: toolBarStyle.buttonBackgroundColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: kIsWeb
                    ? content
                    : BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                        ),
                        child: content,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopOverBarrier extends StatelessWidget {
  final GestureTapCallback onTap;

  _PopOverBarrier(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onTap,
        child: Container(color: const Color(0x06000000)),
      ),
    );
  }
}

class _PopOverHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  _PopOverHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Container(
      decoration: BoxDecoration(
        color: toolBarStyle.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      padding: toolBarStyle.spacing.regular,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 12,
            color: toolBarStyle.foregroundColor,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: TextStyle(
              color: toolBarStyle.foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

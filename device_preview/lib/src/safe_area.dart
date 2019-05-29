import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'device_preview.dart';

class DeviceSafeArea extends StatelessWidget {
  /// Creates a widget that avoids operating system interfaces.
  ///
  /// The [left], [top], [right], [bottom], and [minimum] arguments must not be
  /// null.
  const DeviceSafeArea({
    Key key,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    @required this.child,
  })  : assert(left != null),
        assert(top != null),
        assert(right != null),
        assert(bottom != null),
        super(key: key);

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// This minimum padding to apply.
  ///
  /// The greater of the minimum insets and the media padding will be applied.
  final EdgeInsets minimum;

  /// The widget below this widget in the tree.
  ///
  /// The padding on the [MediaQuery] for the [child] will be suitably adjusted
  /// to zero out any sides that were avoided by this widget.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = DevicePreview.mediaQuery(context).padding;
    return Padding(
      padding: EdgeInsets.only(
        left: math.max(left ? padding.left : 0.0, minimum.left),
        top: math.max(top ? padding.top : 0.0, minimum.top),
        right: math.max(right ? padding.right : 0.0, minimum.right),
        bottom: math.max(bottom ? padding.bottom : 0.0, minimum.bottom),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: left,
        removeTop: top,
        removeRight: right,
        removeBottom: bottom,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(FlagProperty('left', value: left, ifTrue: 'avoid left padding'));
    properties
        .add(FlagProperty('top', value: left, ifTrue: 'avoid top padding'));
    properties
        .add(FlagProperty('right', value: left, ifTrue: 'avoid right padding'));
    properties.add(
        FlagProperty('bottom', value: left, ifTrue: 'avoid bottom padding'));
  }
}

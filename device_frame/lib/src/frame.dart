import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'devices.dart';
import 'info/info.dart';
import 'info/parsing.dart';

/// Simulate a physical device and embedding a virtual
/// [screen] into it.
///
/// The [screen] media query's `padding`, `devicePixelRatio`, `size` are also
/// simulated from the device's info
///
/// The [screen] theme will also have the `platform` of the simulated device.
///
/// Using the [DeviceFrame.identifier] constructor will load an
/// svg file from assets first to get device frame visuals, but also
/// device info.
///
/// To preload the info, the [DeviceFrame.info] constructor can be
/// used instead.
///
/// See also:
///
/// * [Devices] to get all available devices.
///
class DeviceFrame extends StatefulWidget {
  /// The unique identifier of the simulated device.
  final DeviceIdentifier identifier;

  /// The screen that should be inserted into the simulated
  /// device.
  ///
  /// It is cropped with the device screen shape and its size
  /// is the [info]'s screensize.
  final Widget screen;

  /// All information related to the device.
  final DeviceInfo info;

  /// The current frame simulated orientation.
  ///
  /// It will also affect the media query.
  final Orientation orientation;

  /// Indicates whether the device frame is visible, else
  /// only the screen is displayed.
  final bool isFrameVisible;

  /// Load the device frame corresponding to given [identifier] and displays
  /// the given [screen] into the simulated device.
  ///
  /// The orientation of the device can be updated if the frame supports
  /// it (else it is ignored).
  ///
  /// If [isFrameVisible] is `true`, only the [screen] is displayed, but clipped with
  /// the device screen shape.
  DeviceFrame.identifier({
    Key key,
    @required this.identifier,
    @required this.screen,
    this.orientation = Orientation.portrait,
    this.isFrameVisible = true,
  })  : info = null,
        super(key: key);

  /// Displays the given [screen] into the given [info]
  /// simulated device.
  ///
  /// The orientation of the device can be updated if the frame supports
  /// it (else it is ignored).
  ///
  /// If [isFrameVisible] is `true`, only the [screen] is displayed, but clipped with
  /// the device screen shape.
  DeviceFrame.info({
    Key key,
    @required this.info,
    @required this.screen,
    this.orientation = Orientation.portrait,
    this.isFrameVisible = true,
  })  : identifier = null,
        super(key: key);

  @override
  _DeviceFrameState createState() => _DeviceFrameState();
}

class _DeviceFrameState extends State<DeviceFrame> {
  Future<DeviceInfo> svg;

  @override
  void initState() {
    svg = _update();
    super.initState();
  }

  @override
  void didUpdateWidget(DeviceFrame oldWidget) {
    if (oldWidget.info != widget.info ||
        oldWidget.identifier != widget.identifier) {
      setState(() {
        svg = _update();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<DeviceInfo> _update() async {
    if (widget.info != null) {
      return Future.value(widget.info);
    }

    return DefaultAssetBundle.of(context)
        .loadString(widget.identifier.assetKey)
        .then(
          (content) => parseFrameDocument(
            context,
            widget.identifier,
            content,
          ),
        );
  }

  bool isRotated(DeviceInfo info) {
    return info.canRotate && widget.orientation == Orientation.landscape;
  }

  MediaQueryData _mediaQuery(BuildContext context, DeviceInfo info) {
    final isRotated = this.isRotated(info);
    final padding = isRotated ? info.rotatedSafeAreas : info.safeAreas;
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.copyWith(
      size: info.screenSize,
      padding: padding,
      viewInsets: EdgeInsets.zero,
      viewPadding: padding,
      devicePixelRatio: info.pixelRatio,
    );
  }

  ThemeData _theme(BuildContext context) {
    return Theme.of(context).copyWith(
      platform: widget.identifier.platform,
    );
  }

  Widget _screen(BuildContext context, DeviceInfo info) {
    final isRotated = this.isRotated(info);
    final width = isRotated ? info.screenSize.height : info.screenSize.width;
    final height = isRotated ? info.screenSize.width : info.screenSize.height;

    return RotatedBox(
      quarterTurns: isRotated ? 1 : 0,
      child: SizedBox(
        width: width,
        height: height,
        child: MediaQuery(
          data: _mediaQuery(context, info),
          child: Theme(
            data: _theme(context),
            child: widget.screen,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DeviceInfo>(
      future: svg,
      builder: (context, value) {
        if (value.error != null)
          return Center(
            child: Text('Error : ${value.error}'),
          );
        if (value.data == null) return Container();
        final bounds = value.data.screenPath.getBounds();

        final stack = SizedBox(
          width: widget.isFrameVisible ? value.data.frameWidth : bounds.width,
          height:
              widget.isFrameVisible ? value.data.frameHeight : bounds.height,
          child: Stack(
            children: [
              if (widget.isFrameVisible)
                Positioned.fill(
                  key: Key('frame'),
                  child: SvgPicture.string(
                    value.data.svgFrame,
                    key: Key(widget.identifier.assetKey),
                  ),
                ),
              Positioned(
                key: Key('screen'),
                left: widget.isFrameVisible ? bounds.left : 0,
                top: widget.isFrameVisible ? bounds.top : 0,
                width: bounds.width,
                height: bounds.height,
                child: ClipPath(
                  child: FittedBox(
                    child: _screen(context, value.data),
                  ),
                  clipper: _ScreenClipper(
                    value.data.screenPath,
                  ),
                ),
              ),
            ],
          ),
        );

        final isRotated = this.isRotated(value.data);

        return FittedBox(
          child: RotatedBox(
            quarterTurns: isRotated ? -1 : 0,
            child: stack,
          ),
        );
      },
    );
  }
}

class _ScreenClipper extends CustomClipper<Path> {
  final Path path;

  const _ScreenClipper(this.path);

  @override
  Path getClip(Size size) {
    final bounds = path.getBounds();
    var transform = Matrix4.translationValues(-bounds.left, -bounds.top, 0);

    return path.transform(transform.storage);
  }

  @override
  bool shouldReclip(_ScreenClipper oldClipper) {
    return oldClipper.path != path;
  }
}

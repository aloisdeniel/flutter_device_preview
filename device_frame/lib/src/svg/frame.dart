import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'document.dart';

class SvgDeviceFrame extends StatefulWidget {
  final String deviceType;
  final String deviceName;
  final TargetPlatform platform;
  final Widget screen;
  final EdgeInsets viewInsets;
  final SvgFrameDocument document;
  final Orientation orientation;

  SvgDeviceFrame.asset({
    Key key,
    this.orientation = Orientation.portrait,
    this.viewInsets = EdgeInsets.zero,
    @required this.deviceType,
    @required this.deviceName,
    @required this.platform,
    @required this.screen,
  })  : document = null,
        super(key: key);

  SvgDeviceFrame.document({
    Key key,
    this.orientation = Orientation.portrait,
    this.viewInsets = EdgeInsets.zero,
    @required this.document,
    @required this.screen,
  })  : deviceType = null,
        deviceName = null,
        platform = null,
        super(key: key);

  @override
  _SvgDeviceFrameState createState() => _SvgDeviceFrameState();
}

class _SvgDeviceFrameState extends State<SvgDeviceFrame> {
  Future<SvgFrameDocument> svg;

  @override
  void initState() {
    svg = _update();
    super.initState();
  }

  @override
  void didUpdateWidget(SvgDeviceFrame oldWidget) {
    if (oldWidget.document != widget.document ||
        oldWidget.deviceName != widget.deviceName ||
        oldWidget.deviceType != widget.deviceType ||
        oldWidget.platform != widget.platform) {
      setState(() {
        svg = _update();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<SvgFrameDocument> _update() {
    if (widget.document != null) {
      return Future.value(widget.document);
    }

    final assetKey = frameDocumentAssetKey(
      widget.platform,
      widget.deviceType,
      widget.deviceName,
    );
    return DefaultAssetBundle.of(context).loadString(assetKey).then(
          (content) => parseFrameDocument(content),
        );
  }

  MediaQueryData _mediaQuery(BuildContext context, SvgFrameDocument document) {
    final padding = widget.orientation == Orientation.landscape
        ? document.lanscape
        : document.portrait;
    return MediaQuery.of(context).copyWith(
      size: document.screenSize,
      padding: padding,
      viewInsets: widget.viewInsets,
      viewPadding: padding + widget.viewInsets,
      devicePixelRatio: document.density,
    );
  }

  Widget _screen(BuildContext context, SvgFrameDocument doc) {
    if (widget.orientation == Orientation.portrait) {
      return SizedBox(
        width: doc.screenSize.width,
        height: doc.screenSize.height,
        child: MediaQuery(
          data: _mediaQuery(context, doc),
          child: widget.screen,
        ),
      );
    }
    final width = doc.screenSize.height;
    final height = doc.screenSize.width;

    return RotatedBox(
      quarterTurns: 1,
      child: SizedBox(
        width: width,
        height: height,
        child: MediaQuery(
          data: _mediaQuery(context, doc),
          child: widget.screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SvgFrameDocument>(
      future: svg,
      builder: (context, value) {
        if (value.error != null)
          return Center(
            child: Text('Error : ${value.error}'),
          );
        if (value.data == null) return Container();
        final bounds = value.data.screen.getBounds();

        final stack = SizedBox(
          width: value.data.width,
          height: value.data.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.string(
                  value.data.frame,
                ),
              ),
              Positioned(
                left: bounds.left,
                top: bounds.top,
                width: bounds.width,
                height: bounds.height,
                child: ClipPath(
                  child: FittedBox(
                    child: _screen(context, value.data),
                  ),
                  clipper: _ScreenClipper(
                    value.data.screen,
                  ),
                ),
              ),
            ],
          ),
        );

        if (widget.orientation == Orientation.landscape) {
          return FittedBox(
            child: RotatedBox(
              quarterTurns: -1,
              child: stack,
            ),
          );
        }

        return FittedBox(
          child: stack,
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

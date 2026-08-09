part of 'device.dart';

class GenericDesktopWindowFramePainter extends CustomPainter {
  const GenericDesktopWindowFramePainter({
    required this.platform,
    required this.windowPosition,
    this.outerBodyColor = defaultOuterBodyColor,
    this.innerBodyColor = defaultInnerBodyColor,
    this.outerBodyRadius = defaultOuterBodyRadius,
    this.innerBodyRadius = defaultInnerBodyRadius,
    this.innerBodyInsets = defaultInnerBodyInsets,
    this.screenInsets = defaultScreenInsets,
    this.screenRadius = defaultScreenRadius,
    this.footSize = defaultFootSize,
    this.footBarWidth = defaultFootBarWidth,
    this.footBaseHeight = defaultFootBaseHeight,
    this.windowRadius = defaultWindowRadius,
  });

  Size calculateFrameSize(Size screenSize) {
    return Size(
      screenSize.width + innerBodyInsets.horizontal + screenInsets.horizontal,
      screenSize.height + innerBodyInsets.vertical + screenInsets.vertical,
    );
  }

  Size get effectiveWindowSize {
    return Size(
      windowPosition.width,
      windowPosition.height - barHeight,
    );
  }

  double get barHeight {
    switch (platform) {
      case TargetPlatform.macOS:
        return 30;
      default:
        return 40;
    }
  }

  Offset get _windowLocation {
    return Offset(
      innerBodyInsets.left + screenInsets.left + windowPosition.left,
      innerBodyInsets.top + screenInsets.top + windowPosition.top,
    );
  }

  Path createScreenPath(Size screenSize) {
    final result = Path();
    result.addRRect(
      RRect.fromRectAndCorners(
        (_windowLocation + Offset(0, barHeight)) & effectiveWindowSize,
        bottomLeft: windowRadius,
        bottomRight: windowRadius,
      ),
    );
    return result;
  }

  final Rect windowPosition;
  final TargetPlatform platform;
  final Color outerBodyColor;
  final Radius outerBodyRadius;
  final Color innerBodyColor;
  final Radius innerBodyRadius;
  final Radius screenRadius;
  final Radius windowRadius;
  final EdgeInsets innerBodyInsets;
  final EdgeInsets screenInsets;
  final Size footSize;
  final double footBarWidth;
  final double footBaseHeight;

  static const Color defaultOuterBodyColor = Color(0xff3A4245);
  static const Radius defaultOuterBodyRadius = Radius.circular(30);
  static const Color defaultInnerBodyColor = Color(0xff121515);
  static const Radius defaultInnerBodyRadius = Radius.circular(20);
  static const Radius defaultScreenRadius = Radius.circular(10);
  static const Radius defaultWindowRadius = Radius.circular(6);
  static const Size defaultFootSize = Size(920, 280);
  static const double defaultFootBaseHeight = 40;
  static const double defaultFootBarWidth = 60;

  static const EdgeInsets defaultInnerBodyInsets = EdgeInsets.only(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
  );
  static const EdgeInsets defaultScreenInsets = EdgeInsets.only(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height - footSize.height,
    );

    final screenBounds = Rect.fromLTWH(
      innerBodyInsets.left + screenInsets.left,
      innerBodyInsets.top + screenInsets.top,
      bounds.width - innerBodyInsets.horizontal - screenInsets.horizontal,
      bounds.height - innerBodyInsets.vertical - screenInsets.vertical,
    );
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        screenBounds,
        screenRadius,
      ),
    );

    final windowPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          _windowLocation & effectiveWindowSize,
          windowRadius,
        ),
      );
    canvas.drawPath(
        windowPath,
        Paint()
          ..blendMode = BlendMode.multiply
          ..color = const Color(0xFF3F2548).withOpacity(0.6));

    canvas.drawWindowBar(
      platform: platform,
      bounds: _windowLocation &
          Size(
            windowPosition.width,
            barHeight,
          ),
      windowRadius: windowRadius,
    );
  }

  @override
  bool shouldRepaint(covariant GenericDesktopWindowFramePainter oldDelegate) {
    return false;
  }
}

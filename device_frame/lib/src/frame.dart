import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'devices.dart';
import 'info/info.dart';

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
class DeviceFrame extends StatelessWidget {
  /// The unique identifier of the simulated device.
  final DeviceIdentifier identifier;

  /// The screen that should be inserted into the simulated
  /// device.
  ///
  /// It is cropped with the device screen shape and its size
  /// is the [info]'s screensize.
  final Widget screen;

  /// All information related to the device.
  final DeviceInfo device;

  /// The current frame simulated orientation.
  ///
  /// It will also affect the media query.
  final Orientation orientation;

  /// Indicates whether the device frame is visible, else
  /// only the screen is displayed.
  final bool isFrameVisible;

  /// Displays the given [screen] into the given [info]
  /// simulated device.
  ///
  /// The orientation of the device can be updated if the frame supports
  /// it (else it is ignored).
  ///
  /// If [isFrameVisible] is `true`, only the [screen] is displayed, but clipped with
  /// the device screen shape.
  DeviceFrame({
    Key key,
    @required this.device,
    @required this.screen,
    this.orientation = Orientation.portrait,
    this.isFrameVisible = true,
  })  : identifier = device.identifier,
        super(key: key);

  static bool isRotated(DeviceInfo info, Orientation orientation) {
    return info != null &&
        info.canRotate &&
        orientation == Orientation.landscape;
  }

  static Future<void> precache(BuildContext context) async {
    for (var device in Devices.all) {
      await precachePicture(
        StringPicture(SvgPicture.svgStringDecoder, device.svgFrame),
        context,
      );
    }
  }

  static MediaQueryData mediaQuery(
      BuildContext context, DeviceInfo info, Orientation orientation) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = DeviceFrame.isRotated(info, orientation);
    final padding = isRotated
        ? info.rotatedSafeAreas
        : (info?.safeAreas ?? mediaQuery.padding);

    final screenSize = info != null ? info.screenSize : mediaQuery.size;
    final width = isRotated ? screenSize.height : screenSize.width;
    final height = isRotated ? screenSize.width : screenSize.height;

    return mediaQuery.copyWith(
      size: Size(width, height),
      padding: padding,
      viewInsets: EdgeInsets.zero,
      viewPadding: padding,
      devicePixelRatio: info?.pixelRatio ?? mediaQuery.devicePixelRatio,
    );
  }

  ThemeData _theme(BuildContext context) {
    final density = [
      DeviceType.desktop,
      DeviceType.laptop,
    ].contains(identifier.type)
        ? VisualDensity.compact
        : null;
    return Theme.of(context).copyWith(
      platform: identifier.platform,
      visualDensity: density,
    );
  }

  Widget _screen(BuildContext context, DeviceInfo info) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = DeviceFrame.isRotated(info, orientation);
    final screenSize = info != null ? info.screenSize : mediaQuery.size;
    final width = isRotated ? screenSize.height : screenSize.width;
    final height = isRotated ? screenSize.width : screenSize.height;

    return RotatedBox(
      quarterTurns: isRotated ? 1 : 0,
      child: SizedBox(
        width: width,
        height: height,
        child: MediaQuery(
          data: DeviceFrame.mediaQuery(context, info, orientation),
          child: Theme(
            data: _theme(context),
            child: screen,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final frameSize = device.frameSize;
    final bounds = device.screenPath.getBounds();
    final stack = SizedBox(
      width: isFrameVisible ? frameSize.width : bounds.width,
      height: isFrameVisible ? frameSize.height : bounds.height,
      child: Stack(
        children: [
          if (isFrameVisible)
            Positioned.fill(
              key: Key('frame'),
              child: SvgPicture.string(
                device.svgFrame,
                key: ValueKey(identifier),
              ),
            ),
          Positioned(
            key: Key('Screen'),
            left: isFrameVisible ? bounds.left : 0,
            top: isFrameVisible ? bounds.top : 0,
            width: bounds.width,
            height: bounds.height,
            child: ClipPath(
              child: FittedBox(
                child: _screen(context, device),
              ),
              clipper: _ScreenClipper(
                device.screenPath,
              ),
            ),
          ),
        ],
      ),
    );

    final isRotated = DeviceFrame.isRotated(device, orientation);

    return FittedBox(
      child: RotatedBox(
        quarterTurns: isRotated ? -1 : 0,
        child: stack,
      ),
    );
  }
}

class _ScreenClipper extends CustomClipper<Path> {
  final Path path;

  const _ScreenClipper(this.path);

  @override
  Path getClip(Size size) {
    final path = (this.path ?? (Path()..addRect(Offset.zero & size)));
    final bounds = path.getBounds();
    var transform = Matrix4.translationValues(-bounds.left, -bounds.top, 0);

    return path.transform(transform.storage);
  }

  @override
  bool shouldReclip(_ScreenClipper oldClipper) {
    return oldClipper.path != path;
  }
}

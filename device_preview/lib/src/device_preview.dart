import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'freeform/resizer.dart';
import 'device_frame_preview.dart';
import 'devices/devices.dart';
import 'menu.dart';
import 'screenshots/screenshot.dart';
import 'screenshots/upload_service.dart';

/// Simulates how a [child] would render on different
/// devices than the current one.
///
/// This previews also allows children to interact from the
/// [DevicePreviewState.of] methods. One of the main use cases are
/// the screenshots.
///
/// See also :
/// * [Devices] has a set of predefined common devices.
class DevicePreview extends StatefulWidget {
  /// If not [enabled], the [child] is used directly.
  final bool enabled;

  /// The previewed widget.
  ///
  /// It is common to give the root application widget.
  final Widget child;

  final BoxDecoration background;

  final ScreenshotUploader screenshotUploader;

  /// The available devices used for previewing.
  final List<Device> devices;

  /// Create a new [DevicePreview] of t
  DevicePreview(
      {Key key,
      @required this.child,
      this.devices,
      this.screenshotUploader = const FileioScreenshotUploader(),
      this.background = const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
      )),
      this.enabled = true})
      : assert(devices == null || devices.isNotEmpty),
        super(key: key);

  @override
  DevicePreviewState createState() => DevicePreviewState();

  ///
  static DevicePreviewState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<DevicePreviewState>());

  static Device device(BuildContext context) {
    final provider =
        context.inheritFromWidgetOfExactType(DeviceProvider) as DeviceProvider;
    return provider?.device;
  }

  static MediaQueryData mediaQuery(BuildContext context, {bool nullOk: false}) {
    final provider =
        context.inheritFromWidgetOfExactType(DeviceProvider) as DeviceProvider;
    return provider?.mediaQuery ?? MediaQuery.of(context, nullOk: nullOk);
  }

  static TargetPlatform platform(BuildContext context) {
    return device(context)?.platform ?? Theme.of(context).platform;
  }

  static Widget appBuilder(BuildContext context, Widget widget) {
    return MediaQuery(
        data: mediaQuery(context),
        child: Theme(
            data: Theme.of(context).copyWith(platform: platform(context)),
            child: widget));
  }
}

class DevicePreviewState extends State<DevicePreview> {
  Device _device;
  List<Device> _devices;
  GlobalKey _repaintKey = GlobalKey();
  StreamController<DeviceScreenshot> _onScreenshot;
  UniqueKey _appKey = UniqueKey();
  Orientation _orientation = Orientation.portrait;
  bool _isFrameVisible = true;
  static const Size _freeformMaxSize = const Size(1920, 1080);
  Size _freeformSize = _freeformMaxSize;

  MediaQueryData get mediaQuery {
    if (_device.type == DeviceType.freeform)
      return this._device.portrait.copyWith(size: this._freeformSize);

    switch (_orientation) {
      case Orientation.landscape:
        return this._device.landscape;
      default:
        return this._device.portrait;
    }
  }

  Orientation get orientation => _orientation;

  /// The curren active device.
  Device get device {
    if (_device.type == DeviceType.freeform) {
      final query = this.mediaQuery;
      return _device.copyWith(portrait: query, landscape: query);
    }

    return _device;
  }

  ScreenshotUploader get screenshotUploader => widget.screenshotUploader;

  List<Device> get availableDevices => _devices;

  bool get isFrameVisible => _isFrameVisible;

  Size get freeformSize => _freeformSize;

  set freeformSize(Size value) {
    this._freeformSize = value;
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  set isFrameVisible(bool value) {
    this._isFrameVisible = value;
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  set orientation(Orientation value) {
    this._orientation = value;
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  // Define the current active device.
  set device(Device device) {
    this._device = device;
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  /// Indicates whether the preview is currently enabled.
  bool get enabled => widget.enabled;

  /// Whenever the [screenshot] is called, a new value is pushed to
  /// this stream.
  Stream<DeviceScreenshot> get onScreenshot => _onScreenshot.stream;

  /// Takes a screenshot with the current configuration.
  Future<DeviceScreenshot> screenshot() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    final format = ui.ImageByteFormat.png;
    final image =
        await boundary.toImage(pixelRatio: mediaQuery.devicePixelRatio);
    final byteData = await image.toByteData(format: format);
    final bytes = byteData.buffer.asUint8List();
    final screenshot =
        DeviceScreenshot(device: device, bytes: bytes, format: format);
    _onScreenshot.add(screenshot);
    return screenshot;
  }

  void rotate() {
    this.orientation = Orientation
        .values[(this.orientation.index + 1) % Orientation.values.length];
  }

  void restart() {
    this._appKey = UniqueKey();
    this.setState(() {});
  }

  void toggleFrame() => isFrameVisible = !isFrameVisible;

  void _start() {
    _onScreenshot = StreamController<DeviceScreenshot>.broadcast();
    _devices = widget.devices ?? Devices.all;
    _device = _devices.first;
  }

  @override
  void initState() {
    this._start();
    super.initState();
  }

  @override
  void didUpdateWidget(DevicePreview oldWidget) {
    if (oldWidget.enabled != this.widget.enabled) {
      this.setState(() {});
    }

    if (oldWidget.devices != this.widget.devices) {
      _devices = widget.devices ?? _devices;
    }

    super.didUpdateWidget(oldWidget);
  }

  Offset _resizeStart;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final screen = Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        alignment: Alignment.center,
        child: ClipRect(
            child: MediaQuery(
                data: mediaQuery,
                child: DeviceProvider(
                    mediaQuery: mediaQuery,
                    key: _appKey,
                    device: _device,
                    child: widget.child))));

    Widget preview = _isFrameVisible
        ? DeviceFramePreview(
            device: device, orientation: this.orientation, child: screen)
        : screen;

    preview = RepaintBoundary(key: _repaintKey, child: preview);

    if (_device.type == DeviceType.freeform) {
      preview = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          preview,
          Container(
            alignment: Alignment.center,
            width: _freeformMaxSize.width,
            height: _freeformMaxSize.height,
            child: Resizer(
                initialSize: _freeformSize,
                maxSize: _freeformMaxSize,
                resized: (size) {
                  this.freeformSize = size;
                }),
          ),
        ],
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            drawer: DevicePreviewMenu(),
            body: DecoratedBox(
              decoration: widget.background,
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Positioned.fill(
                        child: FittedBox(fit: BoxFit.contain, child: preview)),
                    Positioned(
                        top: 0,
                        child: Builder(
                            builder: (context) => IconButton(
                                  icon: Icon(Icons.settings),
                                  tooltip: 'Settings',
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                )))
                  ],
                ),
              ),
            )));
  }
}

class _DeviceWithFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class DeviceProvider extends InheritedWidget {
  final Device device;
  final MediaQueryData mediaQuery;

  DeviceProvider(
      {Key key,
      @required this.mediaQuery,
      @required Widget child,
      @required this.device})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(DeviceProvider oldWidget) =>
      oldWidget.device != this.device || mediaQuery != oldWidget.mediaQuery;
}

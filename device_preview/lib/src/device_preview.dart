import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'device_frame.dart';
import 'device_frame_preview.dart';
import 'devices/devices.dart';
import 'menu.dart';
import 'screenshot.dart';

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

  /// Indicates that a device physical frame should be drawn.
  final bool isFrameVisible;

  /// The previewed widget.
  ///
  /// It is common to give the root application widget.
  final Widget child;

  final BoxDecoration background;

  /// The available devices used for previewing.
  final List<Device> devices;

  /// Create a new [DevicePreview] of t
  DevicePreview(
      {Key key,
      @required this.child,
      this.isFrameVisible = true,
      this.devices,
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
    return device(context)?.query ?? MediaQuery.of(context, nullOk: nullOk);
  }
}

class DevicePreviewState extends State<DevicePreview> {
  Device _device;
  List<Device> _devices;
  GlobalKey _repaintKey = GlobalKey();
  StreamController<DeviceScreenshot> _onScreenshot;

  /// The curren active device.
  Device get device => _device;

  List<Device> get availableDevices => _devices;

  // Define the current active device.
  set device(Device device) {
    if (widget.enabled) {
      this.setState(() {
        this._device = device;
      });
    } else {
      this._device = device;
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
        await boundary.toImage(pixelRatio: _device.query.devicePixelRatio);
    final byteData = await image.toByteData(format: format);
    final bytes = byteData.buffer.asUint8List();
    final screenshot =
        DeviceScreenshot(device: device, bytes: bytes, format: format);
    _onScreenshot.add(screenshot);
    return screenshot;
  }

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
    if (oldWidget.enabled != this.widget.enabled ||
        oldWidget.isFrameVisible != this.widget.isFrameVisible) {
      this.setState(() {});
    }

    if (oldWidget.devices != this.widget.devices) {
      _devices = widget.devices ?? _devices;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final screen = ClipRect(
        child: Container(
            width: _device.query.size.width,
            height: _device.query.size.height,
            alignment: Alignment.center,
            child: RepaintBoundary(
                key: _repaintKey,
                child: MediaQuery(
                    data: _device.query,
                    child: DeviceProvider(
                        device: _device, child: widget.child)))));

    final preview = this.widget.isFrameVisible
        ? DeviceFramePreview(frame: device.frame, child: screen)
        : screen;

    return MaterialApp(
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

class DeviceProvider extends InheritedWidget {
  final Device device;

  DeviceProvider({Key key, @required Widget child, @required this.device})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(DeviceProvider oldWidget) =>
      oldWidget.device != this.device;
}

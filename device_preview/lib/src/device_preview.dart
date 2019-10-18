import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'device_preview_data.dart';
import 'freeform/resizer.dart';
import 'devices/devices.dart';
import 'menu.dart';
import 'locales.dart';
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

  /// If not enabled, the settings drawer is't available.
  final bool areSettingsEnabled;

  /// Whether configuration should be saved to device preferences
  /// between sessions.
  final bool usePreferences;

  /// The previewed widget.
  ///
  /// It is common to give the root application widget.
  final WidgetBuilder builder;

  final BoxDecoration background;

  final ScreenshotUploader screenshotUploader;

  /// The available devices used for previewing.
  final List<Device> devices;

  /// The availables locale available locales.
  final List<NamedLocale> availablesLocales;

  /// Create a new [DevicePreview]
  DevicePreview(
      {Key key,
      @required this.builder,
      this.devices,
      this.usePreferences = true,
      this.areSettingsEnabled = true,
      this.availablesLocales = defaultAvailableLocales,
      this.screenshotUploader = const FileioScreenshotUploader(),
      this.background = const BoxDecoration(
          gradient: const LinearGradient(
        colors: [
          const Color(0xFFf5f7fa),
          const Color(0xFFc3cfe2),
        ],
      )),
      this.enabled = true})
      : assert(devices == null || devices.isNotEmpty),
        assert(usePreferences != null),
        assert(areSettingsEnabled != null),
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
  GlobalKey _repaintKey = GlobalKey();
  StreamController<DeviceScreenshot> _onScreenshot;
  UniqueKey _appKey = UniqueKey();
  Device get _device => availableDevices[
      math.min(_data.deviceIndex, availableDevices.length - 1)];

  DevicePreviewData _data;

  MediaQueryData get mediaQuery {
    MediaQueryData result;

    if (_device.type == DeviceType.freeform) {
      result = (this._device.portrait ?? this._device.landscape)
          .copyWith(size: this._data.freeformSize);
    } else if (!_device.canRotate) {
      result = this._device.portrait ?? this._device.landscape;
    } else {
      switch (_data.orientation) {
        case Orientation.landscape:
          result = this._device.landscape;
          break;
        default:
          result = this._device.portrait;
      }
    }

    result = result.copyWith(
      platformBrightness: _data.isDarkMode ? Brightness.dark : Brightness.light,
      textScaleFactor: _data.textScaleFactor,
      boldText: _data.boldText,
      disableAnimations: _data.disableAnimations,
      accessibleNavigation: _data.accessibleNavigation,
      invertColors: _data.invertColors,
    );

    return result;
  }

  Locale get locale => availablesLocales
      .firstWhere((x) => x.locale.toString() == _data.locale,
          orElse: () => availablesLocales.first)
      .locale;

  Orientation get orientation => _data.orientation;

  List<NamedLocale> get availablesLocales => widget.availablesLocales;

  bool get isDarkMode => _data.isDarkMode;

  set isDarkMode(bool value) {
    this._data = _data.copyWith(isDarkMode: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  bool get disableAnimations => _data.disableAnimations;

  set disableAnimations(bool value) {
    this._data = _data.copyWith(disableAnimations: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  bool get invertColors => _data.invertColors;

  set invertColors(bool value) {
    this._data = _data.copyWith(invertColors: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  bool get accessibleNavigation => _data.accessibleNavigation;

  set accessibleNavigation(bool value) {
    this._data = _data.copyWith(accessibleNavigation: value)
      ..save(!widget.usePreferences);

    if (widget.enabled) {
      this.setState(() {});
    }
  }

  double get textScaleFactor => _data.textScaleFactor;

  set textScaleFactor(double value) {
    this._data = _data.copyWith(textScaleFactor: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  bool get boldText => _data.boldText;

  set boldText(bool value) {
    this._data = _data.copyWith(boldText: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  /// The curren active device.
  Device get device {
    if (_device.type == DeviceType.freeform) {
      final query = this.mediaQuery;
      return _device.copyWith(landscape: query);
    }

    return _device;
  }

  ScreenshotUploader get screenshotUploader => widget.screenshotUploader;

  List<Device> get availableDevices => widget.devices ?? Devices.all;

  bool get isFrameVisible => _data.isFrameVisible;

  Size get freeformSize => _data.freeformSize;

  set locale(Locale value) {
    this._data = _data.copyWith(locale: value.toString())
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  set freeformSize(Size value) {
    this._data = _data.copyWith(freeformSize: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  set isFrameVisible(bool value) {
    this._data = _data.copyWith(isFrameVisible: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  set orientation(Orientation value) {
    this._data = _data.copyWith(orientation: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      this.setState(() {});
    }
  }

  // Define the current active device.
  set device(Device device) {
    this._data = _data.copyWith(deviceIndex: availableDevices.indexOf(device))
      ..save(!widget.usePreferences);
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
  }

  String get _defaultLocale => basicLocaleListResolution(
        WidgetsBinding.instance.window.locales,
        widget.availablesLocales.map((x) => x.locale),
      )?.toString();

  @override
  void initState() {
    this._data = DevicePreviewData(
      locale: _defaultLocale,
    );

    this._loadData();
    this._start();
    super.initState();
  }

  Future<void> _loadData() async {
    var data = await DevicePreviewData.load(!widget.usePreferences);
    if (data != null) {
      if (data.locale == null) {
        data = data.copyWith(locale: _defaultLocale);
      }
      this._data = data;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.setState(() {});
    });
  }

  @override
  void didUpdateWidget(DevicePreview oldWidget) {
    if (oldWidget.enabled != this.widget.enabled) {
      this.setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.builder(context);
    }

    final screen = Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      alignment: Alignment.center,
      child: ClipRect(
        child: MediaQuery(
          data: mediaQuery,
          child: Builder(
            builder: (context) => DeviceProvider(
              mediaQuery: mediaQuery,
              key: _appKey,
              device: _device,
              child: widget.builder(context),
            ),
          ),
        ),
      ),
    );

    final isRotated = this.orientation == Orientation.landscape;
    final screenSize = isRotated || device.portrait == null
        ? device.landscape.size
        : device.portrait.size;

    Widget preview = _data.isFrameVisible
        ? device.frameBuilder(
            context,
            screen,
            screenSize,
            isRotated,
          )
        : screen;

    preview = RepaintBoundary(
      key: _repaintKey,
      child: preview,
    );

    final bottomBar = Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: (_device.type == DeviceType.freeform)
          ? DeviceProvider(
              mediaQuery: mediaQuery,
              key: _appKey,
              device: _device,
              child: FreeformResizer())
          : SizedBox(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: widget.areSettingsEnabled ? DevicePreviewMenu() : null,
        body: DecoratedBox(
          decoration: widget.background,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned.fill(
                    child: Padding(
                  padding: (_device.type == DeviceType.freeform)
                      ? const EdgeInsets.only(bottom: 48.0)
                      : EdgeInsets.zero,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: preview,
                  ),
                )),
                bottomBar,
                Positioned(
                  top: 0,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.settings),
                      tooltip: 'Settings',
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

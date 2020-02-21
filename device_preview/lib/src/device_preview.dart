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
  ///
  /// Ignored if [data] is defined.
  final bool usePreferences;

  /// The configuration. If not precised, it is loaded from preferences.
  final DevicePreviewData data;

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
      this.data,
      bool usePreferences = true,
      this.areSettingsEnabled = true,
      this.availablesLocales = defaultAvailableLocales,
      this.screenshotUploader = const FileioScreenshotUploader(),
      this.background = const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFFf5f7fa),
          Color(0xFFc3cfe2),
        ],
      )),
      this.enabled = true})
      : assert(devices == null || devices.isNotEmpty),
        assert(usePreferences != null),
        assert(areSettingsEnabled != null),
        usePreferences = (data == null) && usePreferences,
        super(key: key);

  @override
  DevicePreviewState createState() => DevicePreviewState();

  static DevicePreviewState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<DevicePreviewState>());

  static Device device(BuildContext context) {
    final provider =
        context.inheritFromWidgetOfExactType(DeviceProvider) as DeviceProvider;
    return provider?.device;
  }

  static MediaQueryData mediaQuery(BuildContext context,
      {bool nullOk = false}) {
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
          child: widget),
    );
  }
}

class DevicePreviewState extends State<DevicePreview> {
  final _repaintKey = GlobalKey();
  StreamController<DeviceScreenshot> _onScreenshot;
  UniqueKey _appKey = UniqueKey();
  Device get _device => availableDevices[
      math.min(_data.deviceIndex, availableDevices.length - 1)];

  DevicePreviewData _data;

  MediaQueryData get mediaQuery {
    MediaQueryData result;

    if (_device.type == DeviceType.freeform) {
      result = (_device.portrait ?? _device.landscape)
          .copyWith(size: _data.freeformSize);
    } else if (!_device.canRotate) {
      result = _device.portrait ?? _device.landscape;
    } else {
      switch (_data.orientation) {
        case Orientation.landscape:
          result = _device.landscape;
          break;
        default:
          result = _device.portrait;
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
    _data = _data.copyWith(isDarkMode: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  bool get disableAnimations => _data.disableAnimations;

  set disableAnimations(bool value) {
    _data = _data.copyWith(disableAnimations: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  bool get invertColors => _data.invertColors;

  set invertColors(bool value) {
    _data = _data.copyWith(invertColors: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  bool get accessibleNavigation => _data.accessibleNavigation;

  set accessibleNavigation(bool value) {
    _data = _data.copyWith(accessibleNavigation: value)
      ..save(!widget.usePreferences);

    if (widget.enabled) {
      setState(() {});
    }
  }

  double get textScaleFactor => _data.textScaleFactor;

  set textScaleFactor(double value) {
    _data = _data.copyWith(textScaleFactor: value)
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  bool get boldText => _data.boldText;

  set boldText(bool value) {
    _data = _data.copyWith(boldText: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// The curren active device.
  Device get device {
    if (_device.type == DeviceType.freeform) {
      final query = mediaQuery;
      return _device.copyWith(landscape: query);
    }

    return _device;
  }

  ScreenshotUploader get screenshotUploader => widget.screenshotUploader;

  List<Device> get availableDevices => widget.devices ?? Devices.all;

  bool get isFrameVisible => _data.isFrameVisible;

  Size get freeformSize => _data.freeformSize;

  set locale(Locale value) {
    _data = _data.copyWith(locale: value.toString())
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  set freeformSize(Size value) {
    _data = _data.copyWith(freeformSize: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  set isFrameVisible(bool value) {
    _data = _data.copyWith(isFrameVisible: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  set orientation(Orientation value) {
    _data = _data.copyWith(orientation: value)..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  // Define the current active device.
  set device(Device device) {
    _data = _data.copyWith(deviceIndex: availableDevices.indexOf(device))
      ..save(!widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
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
    orientation =
        Orientation.values[(orientation.index + 1) % Orientation.values.length];
  }

  void restart() {
    _appKey = UniqueKey();
    setState(() {});
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
    _data = DevicePreviewData(
      locale: _defaultLocale,
    );

    _loadData();
    _start();
    super.initState();
  }

  Future<void> _loadData() async {
    DevicePreviewData data;

    if (widget.data != null) {
      data = widget.data;
    } else if (widget.usePreferences) {
      data = await DevicePreviewData.load();
    }

    if (data != null) {
      if (data.locale == null) {
        data = data.copyWith(locale: _defaultLocale);
      }
      _data = data;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(DevicePreview oldWidget) {
    if (oldWidget.enabled != widget.enabled) {
      setState(() {});
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

    final isRotated = orientation == Orientation.landscape;
    final screenSize = isRotated || device.portrait == null
        ? device.landscape.size
        : device.portrait.size;

    var preview = _data.isFrameVisible
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

    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
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
                    ],
                  ),
                ),
              ),
            ),
            if (widget.areSettingsEnabled)
              Positioned.fill(
                child: DevicePreviewMenu(),
              ),
          ],
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
      oldWidget.device != device || mediaQuery != oldWidget.mediaQuery;
}

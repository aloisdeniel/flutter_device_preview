import 'dart:async';

import 'package:device_preview/src/keyboard/virtual_keyboard.dart';
import 'package:device_preview/src/tool_bar/horizontal_toolbar.dart';
import 'package:device_preview/src/tool_bar/vertical_toolbar.dart';
import 'package:device_preview/src/utilities/media_query_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'device_preview_data.dart';
import 'device_preview_style.dart';
import 'devices/devices.dart';
import 'locales/locales.dart';
import 'locales/default_locales.dart';
import 'screenshots/screenshot.dart';
import 'screenshots/upload_service.dart';
import 'storage.dart';

/// Simulates how a [child] would render on different
/// devices than the current one.
///
/// This previews also allows children to interact from the
/// [DevicePreviewState.of] methods.
///
/// See also :
/// * [Devices] has a set of predefined common devices.
/// * [DevicePreviewStyle] to update the aspect.
class DevicePreview extends StatefulWidget {
  /// If not [enabled], the [child] is used directly.
  final bool enabled;

  /// Indicates whether the tool bar should be visible or not.
  final bool isToolBarVisible;

  /// Indicates whether the tool bar should be visible or not.
  @Deprecated('Replaced by `isToolBarVisible`')
  bool get areSettingsEnabled => isToolBarVisible;

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

  /// When the user takes a screenshot, this processor is invoked.
  ///
  /// Defaults to [FileioScreenshotUploader.upload].
  final ScreenshotProcessor onScreenshot;

  /// The available devices used for previewing.
  final List<Device> devices;

  /// Customizing the tool bar and background aspect.
  ///
  /// {@tool snippet}
  ///
  /// This sample shows how to apply a light theme for the toolbar and a custom background.
  ///
  /// ```dart
  /// DevicePreview(
  ///   style: DevicePreviewStyle(
  ///      background: BoxDecoration(color: const Color(0xFFFF0000)),
  ///      toolbar: DevicePreviewToolBarStyle.light(),
  ///   ),
  ///   builder: (context) => MyApp(),
  /// )
  /// ```
  /// {@end-tool}
  final DevicePreviewStyle style;

  /// The available locales.
  final List<NamedLocale> availablesLocales;

  /// Create a new [DevicePreview].
  DevicePreview(
      {Key key,
      @required this.builder,
      this.devices,
      this.data,
      bool usePreferences = true,
      this.style,
      bool areSettingsEnabled = true,
      bool isToolBarVisible = true,
      this.availablesLocales = defaultAvailableLocales,
      this.onScreenshot,
      this.enabled = true})
      : assert(devices == null || devices.isNotEmpty),
        assert(usePreferences != null),
        assert(areSettingsEnabled != null),
        isToolBarVisible = isToolBarVisible || areSettingsEnabled,
        usePreferences = (data == null) && usePreferences,
        super(key: key);

  @override
  DevicePreviewState createState() => DevicePreviewState();

  // The state from the closest [DevicePreview] instance that encloses the given
  /// context.
  static DevicePreviewState of(BuildContext context) =>
      context.findAncestorStateOfType<DevicePreviewState>();

  /// The currently selected [Device], if the preview is [enabled].
  static Device device(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();
    if (provider != null) {
      return provider.availableDevices[provider.data?.deviceIndex ?? 0];
    }

    return null;
  }

  /// The media query of the currently selected device.
  static MediaQueryData mediaQuery(
    BuildContext context, {
    bool nullOk = false,
  }) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();
    return provider?.mediaQuery ??
        MediaQuery.of(
          context,
          nullOk: nullOk,
        );
  }

  /// The current target platform for the currently selected device.
  static TargetPlatform platform(BuildContext context) {
    return device(context)?.platform ?? Theme.of(context).platform;
  }

  /// A global builder that should be inserted into [WidgetApp]'s builder
  /// to simulated the simulated device screen and platform properties.
  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    return MediaQuery(
      data: mediaQuery(context),
      child: Theme(
        data: Theme.of(context).copyWith(platform: platform(context)),
        child: widget,
      ),
    );
  }
}

class DevicePreviewState extends State<DevicePreview> {
  bool _isVirtualKeyboardVisible = false;

  /// The curren active device.
  Device get device {
    if (_device.type == DeviceType.freeform) {
      final query = mediaQuery;
      return _device.copyWith(landscape: query);
    }

    return _device;
  }

  /// The media query for the currently selected device, orientation and other
  /// selected simulated preferences.
  MediaQueryData get mediaQuery {
    MediaQueryData result;

    if (_device.type == DeviceType.freeform) {
      result = (_device.portrait ?? _device.landscape).copyWith(
        size: _data.freeformSize ?? Size(1080, 1920),
      );
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

    if (_isVirtualKeyboardVisible) {
      result = result.copyWith(
        viewInsets: EdgeInsets.only(
          bottom: VirtualKeyboard.minHeight + result.padding.bottom,
        ),
      );
    }

    return result;
  }

  DevicePreviewData get data => _data;

  /// Get the currently selected locale.
  Locale get locale => availablesLocales
      .firstWhere(
        (x) => x.locale.toString() == _data.locale,
        orElse: () => availablesLocales.first,
      )
      .locale;

  /// Get the currently selected simulated device orientation.
  Orientation get orientation => _data.orientation;

  /// Get the list of available locales.
  List<NamedLocale> get availablesLocales => widget.availablesLocales;

  /// Indicates whether the dark mode is enabled.
  bool get isDarkMode => _data.isDarkMode;

  /// Update the dark mode.
  set isDarkMode(bool value) {
    _data = _data.copyWith(isDarkMode: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// The current style.
  DevicePreviewStyle get style => _style;

  /// Indicates wheter animations are disabled.
  bool get disableAnimations => _data.disableAnimations;

  /// Indicates whether all colors should be inverted (for accessibility purpose).
  bool get invertColors => _data.invertColors;

  /// The current simulated navigation accessibilty preference.
  bool get accessibleNavigation => _data.accessibleNavigation;

  /// The current simulated text scale factor accessibilty preference.
  double get textScaleFactor => _data.textScaleFactor;

  /// Indicates whether the virtual keyboard is visible or not.
  bool get isVirtualKeyboardVisible => _isVirtualKeyboardVisible;

  /// Indicates whether the simulated bold text accessibilty preference is enabled.
  bool get boldText => _data.boldText;

  /// The processor used whenever the user take a new screenshot.
  ScreenshotProcessor get processScreenshot =>
      widget.onScreenshot ?? (const FileioScreenshotUploader().upload);

  List<Device> get availableDevices => widget.devices ?? Devices.all;

  /// Indicates whether the simulated physical device frame visibility.
  bool get isFrameVisible => _data.isFrameVisible ?? true;

  /// If in freeform mode, the currently selected simulated screen size.
  Size get freeformSize => _data.freeformSize ?? Size(1080, 1920);

  /// Set the [disableAnimations].
  set disableAnimations(bool value) {
    _data = _data.copyWith(disableAnimations: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Update the [style].
  set style(DevicePreviewStyle value) {
    _style = value;
    DevicePreviewStyleStorage.save(_style, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [invertColors].
  set invertColors(bool value) {
    _data = _data.copyWith(invertColors: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [accessibleNavigation].
  set accessibleNavigation(bool value) {
    _data = _data.copyWith(accessibleNavigation: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);

    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [textScaleFactor].
  set textScaleFactor(double value) {
    _data = _data.copyWith(textScaleFactor: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [locale].
  set locale(Locale value) {
    _data = _data.copyWith(locale: value.toString());
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [boldText].
  set boldText(bool value) {
    _data = _data.copyWith(boldText: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Show or hide the virtual keyboard.
  set isVirtualKeyboardVisible(bool value) {
    _isVirtualKeyboardVisible = value;
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [freeformSize].
  set freeformSize(Size value) {
    _data = _data.copyWith(freeformSize: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [isFrameVisible].
  set isFrameVisible(bool value) {
    _data = _data.copyWith(isFrameVisible: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  /// Set the [orientation].
  set orientation(Orientation value) {
    _data = _data.copyWith(orientation: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (widget.enabled) {
      setState(() {});
    }
  }

  // Define the current active device.
  set device(Device device) {
    _data = _data.copyWith(deviceIndex: availableDevices.indexOf(device));
    DevicePreviewStorage.save(_data, !widget.usePreferences);
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
    final image = await boundary.toImage(
      pixelRatio: mediaQuery.devicePixelRatio,
    );
    final byteData = await image.toByteData(
      format: format,
    );
    final bytes = byteData.buffer.asUint8List();
    final screenshot = DeviceScreenshot(
      device: device,
      bytes: bytes,
      format: format,
    );
    _onScreenshot.add(screenshot);
    return screenshot;
  }

  /// Change the simulated device orientation between portrait and landscape.
  void rotate() {
    orientation =
        Orientation.values[(orientation.index + 1) % Orientation.values.length];
  }

  /// Restart the application hosted by the simulated device.
  void restart() {
    _appKey = UniqueKey();
    setState(() {});
  }

  /// Change the simulated device frame visibility.
  void toggleFrame() => isFrameVisible = !isFrameVisible;

  @override
  void initState() {
    _data = DevicePreviewData(
      locale: _defaultLocale,
    );

    _loadData();
    _onScreenshot = StreamController<DeviceScreenshot>.broadcast();
    super.initState();
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
    return DevicePreviewTheme(
      style: style,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              return MediaQueryObserver(
                child: Builder(
                  builder: (context) {
                    final style = DevicePreviewTheme.of(context);
                    Widget screen = Container(
                      width: mediaQuery.size.width,
                      height: mediaQuery.size.height,
                      alignment: Alignment.center,
                      child: ClipRect(
                        child: MediaQuery(
                          data: mediaQuery,
                          child: Builder(
                            builder: (context) => DevicePreviewProvider(
                              mediaQuery: mediaQuery,
                              key: _appKey,
                              data: _data,
                              availableDevices: availableDevices,
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

                    screen = Stack(
                      children: <Widget>[
                        screen,
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedCrossFade(
                            firstChild: SizedBox(),
                            secondChild: VirtualKeyboard(
                              height: VirtualKeyboard.minHeight +
                                  mediaQuery.padding.bottom,
                            ),
                            crossFadeState: isVirtualKeyboardVisible
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ],
                    );

                    var preview = _data.isFrameVisible
                        ? device.frameBuilder(
                            context,
                            screen,
                            screenSize,
                            isRotated
                                ? DeviceOrientation.landscape
                                : DeviceOrientation.portrait,
                          )
                        : screen;

                    preview = RepaintBoundary(
                      key: _repaintKey,
                      child: preview,
                    );

                    final isToolBarHorizontal = style.toolBar.position ==
                            DevicePreviewToolBarPosition.bottom ||
                        style.toolBar.position ==
                            DevicePreviewToolBarPosition.top;

                    final isToolBarDirectionInverted = style.toolBar.position ==
                            DevicePreviewToolBarPosition.left ||
                        style.toolBar.position ==
                            DevicePreviewToolBarPosition.top;

                    return Builder(
                      builder: (context) {
                        return MediaQueryObserver(
                          child: Flex(
                            direction: isToolBarHorizontal
                                ? Axis.vertical
                                : Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              if (widget.isToolBarVisible &&
                                  isToolBarDirectionInverted)
                                isToolBarHorizontal
                                    ? DevicePreviewHorizontalToolBar(
                                        key: Key('HorizontalToolbar'),
                                      )
                                    : DevicePreviewVerticalToolBar(
                                        key: Key('VerticalToolbar'),
                                      ),
                              Expanded(
                                key: Key('Preview'),
                                child: DecoratedBox(
                                  decoration: style.background,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Builder(
                                      key: Key(DevicePreview.of(context)
                                          .device
                                          .name),
                                      builder: (context) => preview,
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.isToolBarVisible &&
                                  !isToolBarDirectionInverted)
                                isToolBarHorizontal
                                    ? DevicePreviewHorizontalToolBar(
                                        key: Key('HorizontalToolbar'),
                                      )
                                    : DevicePreviewVerticalToolBar(
                                        key: Key('VerticalToolbar'),
                                      ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// The repaint key used for rendering screenshots.
  final _repaintKey = GlobalKey();

  /// A stream that sends a new value each time the user takes
  /// a new screenshot.
  StreamController<DeviceScreenshot> _onScreenshot;

  /// The current application key (used for [restart]).
  UniqueKey _appKey = UniqueKey();

  /// The currently selected device from the [availableDevices].
  Device get _device => availableDevices[
      math.min(_data.deviceIndex, availableDevices.length - 1)];

  /// The current configuration.
  DevicePreviewData _data;

  /// The current style.
  DevicePreviewStyle _style;

  /// The default locale from the device.
  String get _defaultLocale => basicLocaleListResolution(
        WidgetsBinding.instance.window.locales,
        widget.availablesLocales.map((x) => x.locale),
      )?.toString();

  /// Load the configuration from the preferences (if no [data] provided by the user).
  Future<void> _loadData() async {
    var shouldSetState = false;
    DevicePreviewData data;
    try {
      if (widget.data != null) {
        data = widget.data;
      } else if (widget.usePreferences) {
        data = await DevicePreviewStorage.load();
      }

      if (data != null) {
        if (data.locale == null) {
          data = data.copyWith(locale: _defaultLocale);
        }
        _data = data;
        shouldSetState = true;
      }

      if (widget.style != null) {
        _style = widget.style;
      } else if (widget.usePreferences) {
        _style = await DevicePreviewStyleStorage.load();
      }

      if (shouldSetState) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }
}

class DevicePreviewProvider extends InheritedWidget {
  final DevicePreviewData data;
  final MediaQueryData mediaQuery;
  final List<Device> availableDevices;

  DevicePreviewProvider({
    Key key,
    @required this.availableDevices,
    @required this.mediaQuery,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DevicePreviewProvider oldWidget) =>
      oldWidget.data != data || mediaQuery != oldWidget.mediaQuery;
}

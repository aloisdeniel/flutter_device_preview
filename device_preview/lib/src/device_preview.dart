import 'dart:async';

import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/tool_bar/horizontal_toolbar.dart';
import 'package:device_preview/src/tool_bar/vertical_toolbar.dart';
import 'package:device_preview/src/utilities/media_query_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

import 'custom_device.dart';
import 'device_preview_data.dart';
import 'device_preview_style.dart';
import 'locales/locales.dart';
import 'locales/default_locales.dart';
import 'screenshots/screenshot.dart';
import 'screenshots/upload_service.dart';
import 'storage.dart';
import 'utilities/position.dart';

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
  final List<DeviceInfo> devices;

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
  final List<Locale> availableLocales;

  /// Create a new [DevicePreview].
  DevicePreview({
    Key key,
    @required this.builder,
    this.devices,
    this.data,
    bool usePreferences = true,
    this.style,
    bool areSettingsEnabled = true,
    bool isToolBarVisible = true,
    this.availableLocales,
    this.onScreenshot,
    this.enabled = true,
  })  : assert(devices == null || devices.isNotEmpty),
        assert(usePreferences != null),
        assert(areSettingsEnabled != null),
        isToolBarVisible = isToolBarVisible || areSettingsEnabled,
        usePreferences = (data == null) && usePreferences,
        super(key: key);

  static final List<DeviceInfo> defaultDevices = Devices.all;

  @override
  DevicePreviewState createState() => DevicePreviewState();

  // The state from the closest [DevicePreview] instance that encloses the given
  /// context.
  static DevicePreviewState of(BuildContext context) =>
      context.findAncestorStateOfType<DevicePreviewState>();

  /// The currently selected [Device], if the preview is [enabled].
  static DeviceInfo device(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();
    return provider?.deviceInfo;
  }

  /// The currently selected [orientation], if the preview is [enabled], else `portrait`.
  static Orientation orientation(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();
    if (provider != null) {
      return provider.data.orientation;
    }

    return Orientation.portrait;
  }

  /// The current target platform for the currently selected device.
  static TargetPlatform platform(BuildContext context) {
    return device(context)?.identifier?.platform ?? Theme.of(context).platform;
  }

  /// A global builder that should be inserted into [WidgetApp]'s builder
  /// to simulated the simulated device screen and platform properties.
  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();

    if (provider == null || !provider.data.isEnabled) return widget;

    return MediaQuery(
      data: _mediaQuery(context),
      child: Theme(
        data: Theme.of(context).copyWith(
          platform: provider?.deviceInfo?.identifier?.platform,
          visualDensity: [
            DeviceType.desktop,
            DeviceType.laptop,
          ].contains(provider?.deviceInfo?.identifier?.type)
              ? VisualDensity.compact
              : VisualDensity.comfortable,
          brightness:
              provider.data.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        child: widget,
      ),
    );
  }

  static MediaQueryData _mediaQuery(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();

    if (provider == null) return null;

    final device = provider?.deviceInfo;
    var mediaQuery = DeviceFrame.mediaQuery(
      context,
      device,
      provider.data.orientation,
    );

    if (provider.isVirtualKeyboardVisible) {
      mediaQuery = VirtualKeyboard.mediaQuery(mediaQuery);
    }

    return mediaQuery.copyWith(
      platformBrightness:
          provider.data.isDarkMode ? Brightness.dark : Brightness.light,
      textScaleFactor: provider.data.textScaleFactor,
      boldText: provider.data.boldText,
      disableAnimations: provider.data.disableAnimations,
      accessibleNavigation: provider.data.accessibleNavigation,
      invertColors: provider.data.invertColors,
    );
  }
}

class DevicePreviewState extends State<DevicePreview> {
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
  List<NamedLocale> get availablesLocales => widget.availableLocales == null
      ? defaultAvailableLocales
      : widget.availableLocales
          .map(
            (available) => defaultAvailableLocales.firstWhere(
              (all) => all.code == available.toString(),
              orElse: () => null,
            ),
          )
          .where((x) => x != null)
          .toList();

  /// Indicates whether the dark mode is enabled.
  bool get isDarkMode => _data.isDarkMode;

  /// Update the dark mode.
  set isDarkMode(bool value) {
    _data = _data.copyWith(isDarkMode: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Indicates whether the preview is currently enabled.
  bool get isEnabled => widget.enabled && _data.isEnabled;

  /// Whenever the [screenshot] is called, a new value is pushed to
  /// this stream.
  Stream<DeviceScreenshot> get onScreenshot => _onScreenshot.stream;

  /// The current style.
  DevicePreviewStyle get style => _style;

  /// Indicates wheter animations are disabled.
  bool get disableAnimations => _data.disableAnimations;

  /// Indicates whether all colors should be inverted (for accessibility purpose).
  bool get invertColors => _data.invertColors;

  /// The current simulated navigation accessibilty preference.
  bool get accessibleNavigation => _data.accessibleNavigation;

  /// All available devices.
  List<DeviceInfo> get availableDevices => _availableDevices;

  /// The current simulated text scale factor accessibilty preference.
  double get textScaleFactor => _data.textScaleFactor;

  /// Indicates whether the virtual keyboard is visible or not.
  bool get isVirtualKeyboardVisible => _isVirtualKeyboardVisible;

  /// Indicates whether the simulated bold text accessibilty preference is enabled.
  bool get boldText => _data.boldText;

  /// The processor used whenever the user take a new screenshot.
  ScreenshotProcessor get processScreenshot =>
      widget.onScreenshot ?? (const FileioScreenshotUploader().upload);

  /// Indicates whether the simulated physical device frame visibility.
  bool get isFrameVisible => _data.isFrameVisible ?? true;

  /// The currently selected device from the [availableDevices].
  DeviceInfo get deviceInfo {
    if (data?.deviceIdentifier == 'custom_device') {
      return CustomDeviceInfo(data?.customDevice);
    }
    return availableDevices.firstWhere(
      (x) => x.identifier.toString() == data?.deviceIdentifier,
      orElse: () => availableDevices.first,
    );
  }

  /// Indicate whether the current device is a custom one.
  bool get isCustomDevice {
    return deviceInfo?.identifier?.toString() ==
        CustomDeviceIdentifier.identifier;
  }

  /// Set the [disableAnimations].
  set disableAnimations(bool value) {
    _data = _data.copyWith(disableAnimations: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Update the [style].
  set style(DevicePreviewStyle value) {
    _style = value;
    DevicePreviewStyleStorage.save(_style, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [invertColors].
  set invertColors(bool value) {
    _data = _data.copyWith(invertColors: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [accessibleNavigation].
  set accessibleNavigation(bool value) {
    _data = _data.copyWith(accessibleNavigation: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);

    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [textScaleFactor].
  set textScaleFactor(double value) {
    _data = _data.copyWith(textScaleFactor: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [locale].
  set locale(Locale value) {
    _data = _data.copyWith(locale: value.toString());
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [boldText].
  set boldText(bool value) {
    _data = _data.copyWith(boldText: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Show or hide the virtual keyboard.
  set isVirtualKeyboardVisible(bool value) {
    _isVirtualKeyboardVisible = value;
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [isFrameVisible].
  set isFrameVisible(bool value) {
    _data = _data.copyWith(isFrameVisible: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [orientation].
  set orientation(Orientation value) {
    _data = _data.copyWith(orientation: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Set the [isEnabled].
  set isEnabled(bool value) {
    _data = _data.copyWith(isEnabled: value);
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    setState(() {});
  }

  // Define the current active device.
  set device(DeviceIdentifier device) {
    _data = _data.copyWith(
      deviceIdentifier: device?.toString(),
    );
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  // Update the current custom device.
  set customDevice(CustomDeviceInfoData data) {
    _data = _data.copyWith(
      customDevice: data,
    );
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  void enableCustomDevice() {
    _data = _data.copyWith(
      deviceIdentifier: CustomDeviceIdentifier.identifier,
    );
    DevicePreviewStorage.save(_data, !widget.usePreferences);
    if (isEnabled) {
      setState(() {});
    }
  }

  /// Takes a screenshot with the current configuration.
  Future<DeviceScreenshot> screenshot() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    final format = ui.ImageByteFormat.png;
    final device = deviceInfo;
    final image = await boundary.toImage(
      pixelRatio: device.pixelRatio,
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
    final index = (orientation.index + 1) % Orientation.values.length;
    orientation = Orientation.values[index];
  }

  /// Change the simulated device frame visibility.
  void toggleFrame() => isFrameVisible = !isFrameVisible;

  static final _defaultCustomDevice = CustomDeviceInfoData(
    id: 'custom_device',
    name: 'Custom',
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: EdgeInsets.only(top: 20),
    rotatedSafeAreas: EdgeInsets.only(top: 20),
    screenSize: Size(512, 1024),
    type: DeviceType.tablet,
  );

  @override
  void initState() {
    _data = DevicePreviewData(
      locale: _defaultLocale,
      customDevice: _defaultCustomDevice,
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

  Widget _buildPreview(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: 20 + mediaQuery.viewPadding.top,
        right: 20 + mediaQuery.viewPadding.right,
        left: 20 + mediaQuery.viewPadding.left,
        bottom: 20,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: RepaintBoundary(
          key: _repaintKey,
          child: DeviceFrame(
            device: deviceInfo,
            isFrameVisible: _data.isFrameVisible,
            orientation: _data.orientation,
            screen: VirtualKeyboard(
              isEnabled: _isVirtualKeyboardVisible,
              child: Theme(
                data: Theme.of(context).copyWith(
                  platform: deviceInfo?.identifier?.platform,
                  brightness: (data?.isDarkMode ?? false)
                      ? Brightness.dark
                      : Brightness.light,
                ),
                child: MediaQuery(
                  data: DevicePreview._mediaQuery(context),
                  child: Builder(
                    key: _appKey,
                    builder: widget.builder,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Builder(
        key: _appKey,
        builder: widget.builder,
      );
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _availableDevices == null
            ? _DevicePreviewLoader()
            : MediaQueryObserver(
                child: DevicePreviewProvider(
                  data: _data,
                  isVirtualKeyboardVisible: _isVirtualKeyboardVisible,
                  mediaQuery: DevicePreview._mediaQuery(context),
                  availableDevices: _availableDevices,
                  child: DecoratedBox(
                    decoration: style.background,
                    child: Builder(
                      builder: (context) => Stack(
                        children: <Widget>[
                          Positioned.fill(
                            left: style.toolBar.position ==
                                    DevicePreviewToolBarPosition.left
                                ? DevicePreviewVerticalToolBar.width(context) -
                                    12
                                : 0,
                            right: style.toolBar.position ==
                                    DevicePreviewToolBarPosition.right
                                ? DevicePreviewVerticalToolBar.width(context) -
                                    12
                                : 0,
                            top: style.toolBar.position ==
                                    DevicePreviewToolBarPosition.top
                                ? DevicePreviewHorizontalToolBar.height(
                                        context) -
                                    12
                                : 0,
                            bottom: style.toolBar.position ==
                                    DevicePreviewToolBarPosition.bottom
                                ? DevicePreviewHorizontalToolBar.height(
                                        context) -
                                    12
                                : 0,
                            key: Key('Preview'),
                            child: isEnabled
                                ? Builder(
                                    builder: _buildPreview,
                                  )
                                : Builder(
                                    key: _appKey,
                                    builder: widget.builder,
                                  ),
                          ),
                          Positioned.fill(
                            key: Key('Tools'),
                            child: DevicePreviewTheme(
                              style: style,
                              child: Localizations(
                                locale: locale,
                                delegates: [
                                  GlobalCupertinoLocalizations.delegate,
                                  GlobalMaterialLocalizations.delegate,
                                  GlobalWidgetsLocalizations.delegate,
                                ],
                                child: _ToolsOverlay(
                                  style: style,
                                  isToolBarVisible: widget.isToolBarVisible,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  /// The repaint key used for rendering screenshots.
  final _repaintKey = GlobalKey();

  bool _isVirtualKeyboardVisible = false;

  List<DeviceInfo> _availableDevices;

  /// A stream that sends a new value each time the user takes
  /// a new screenshot.
  StreamController<DeviceScreenshot> _onScreenshot;

  /// The current application key.
  final GlobalKey _appKey = GlobalKey();

  /// The current configuration.
  DevicePreviewData _data;

  /// The current style.
  DevicePreviewStyle _style;

  /// The default locale from the device.
  String get _defaultLocale => basicLocaleListResolution(
        WidgetsBinding.instance.window.locales,
        availablesLocales.map((x) => x.locale).toList(),
      )?.toString();

  /// Load the configuration from the preferences (if no [data] was provided by the user).
  Future<void> _loadData() async {
    DevicePreviewData data;

    try {
      await DeviceFrame.precache(context);
      _availableDevices = Devices.all;

      if (widget.data != null) {
        data = widget.data;
      } else if (widget.usePreferences) {
        data = await DevicePreviewStorage.load();
      }

      if (data != null) {
        if (data.locale == null) {
          data = data.copyWith(locale: _defaultLocale);
        }
        if (data.customDevice == null) {
          data = data.copyWith(
            customDevice: _defaultCustomDevice,
          );
        }
        _data = data;
      }

      if (widget.style != null) {
        _style = widget.style;
      } else if (widget.usePreferences) {
        _style = await DevicePreviewStyleStorage.load();
      }
    } catch (e) {
      print('Error while loading data: $e');
    } finally {
      _data ??= DevicePreviewData();
      _style ??= DevicePreviewStyle.dark();
      setState(() {});
    }
  }
}

class DevicePreviewProvider extends InheritedWidget {
  final DevicePreviewData data;
  final List<DeviceInfo> availableDevices;
  final MediaQueryData mediaQuery;
  final bool isVirtualKeyboardVisible;
  DeviceInfo get deviceInfo {
    if (data?.deviceIdentifier == CustomDeviceIdentifier.identifier) {
      return CustomDeviceInfo(data?.customDevice);
    }
    return availableDevices.firstWhere(
      (x) => x.identifier.toString() == data?.deviceIdentifier,
      orElse: () => availableDevices.first,
    );
  }

  static DevicePreviewProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DevicePreviewProvider>();

  DevicePreviewProvider({
    Key key,
    @required this.availableDevices,
    @required Widget child,
    @required this.mediaQuery,
    @required this.data,
    @required this.isVirtualKeyboardVisible,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(DevicePreviewProvider oldWidget) =>
      oldWidget.data != data ||
      oldWidget.mediaQuery != mediaQuery ||
      oldWidget.isVirtualKeyboardVisible != isVirtualKeyboardVisible;
}

class _DevicePreviewLoader extends StatefulWidget {
  const _DevicePreviewLoader({
    Key key,
  }) : super(key: key);

  @override
  __DevicePreviewLoaderState createState() => __DevicePreviewLoaderState();
}

class __DevicePreviewLoaderState extends State<_DevicePreviewLoader>
    with SingleTickerProviderStateMixin {
  static final _opacityTween = Tween<double>(begin: 1, end: 0);
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.perm_device_information,
              color: Colors.white,
              size: 48,
            ),
            SizedBox(height: 6),
            Text(
              'Device Preview',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                  ),
            ),
            SizedBox(height: 4),
            Text(
              'Loading',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white30,
                    fontSize: 9,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolsOverlay extends StatefulWidget {
  final bool isToolBarVisible;
  final DevicePreviewStyle style;
  const _ToolsOverlay({
    Key key,
    @required this.isToolBarVisible,
    @required this.style,
  }) : super(key: key);

  @override
  _ToolsOverlayState createState() => _ToolsOverlayState();
}

class _ToolsOverlayState extends State<_ToolsOverlay> {
  /// To get the global overlay position on screen.
  final GlobalKey _overlayKey = GlobalKey();

  @override
  void initState() {
    // Forcing rebuild to update absolute postion in `_overlayKey`
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => setState(() {}),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: _overlayKey,
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Stack(
              children: [
                if (widget.isToolBarVisible &&
                    widget.style.toolBar.position ==
                        DevicePreviewToolBarPosition.bottom)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: DevicePreviewHorizontalToolBar(
                      key: Key('HorizontalToolbar'),
                      overlayPosition: _overlayKey.absolutePosition,
                    ),
                  ),
                if (widget.isToolBarVisible &&
                    widget.style.toolBar.position ==
                        DevicePreviewToolBarPosition.top)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: DevicePreviewHorizontalToolBar(
                      key: Key('HorizontalToolbar'),
                      overlayPosition: _overlayKey.absolutePosition,
                    ),
                  ),
                if (widget.isToolBarVisible &&
                    widget.style.toolBar.position ==
                        DevicePreviewToolBarPosition.right)
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: DevicePreviewVerticalToolBar(
                      key: Key('VerticalToolbar'),
                      overlayPosition: _overlayKey.absolutePosition,
                    ),
                  ),
                if (widget.isToolBarVisible &&
                    widget.style.toolBar.position ==
                        DevicePreviewToolBarPosition.left)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: DevicePreviewVerticalToolBar(
                      key: Key('VerticalToolbar'),
                      overlayPosition: _overlayKey.absolutePosition,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/state/state.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/storage/storage.dart';
import 'package:device_preview/src/utilities/media_query_observer.dart';
import 'package:device_preview/src/views/tool_bar/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'locales/default_locales.dart';
import 'plugins/plugin.dart';
import 'utilities/position.dart';
import 'views/device_preview_style.dart';

/// Simulates how the result of [builder] would render on different
/// devices.
///
/// {@tool snippet}
///
/// This sample shows how to define an app with a plugin.
///
/// ```dart
/// DevicePreview(
///   builder: (context) => MyApp(),
///   plugins: [
///     const ScreenshotPlugin(),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also :
/// * [Devices] has a set of predefined common devices.
/// * [DevicePreviewStyle] to update the aspect.
class DevicePreview extends StatefulWidget {
  /// If not [enabled], the [child] is used directly.
  final bool enabled;

  /// Indicates whether the tool bar should be visible or not.
  final bool isToolbarVisible;

  /// The configuration. If not precised, it is loaded from preferences.
  final DevicePreviewData data;

  /// The previewed widget.
  ///
  /// It is common to give the root application widget.
  final WidgetBuilder builder;

  /// The available devices used for previewing.
  final List<DeviceInfo> devices;

  /// The list of plugins.
  final List<DevicePreviewPlugin> plugins;

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

  /// The storage used to persist preferences.
  ///
  /// By default, it saves preferences to the local device preferences.
  ///
  /// To disable settings persistence use `DevicePreviewStorage.none()`.
  final DevicePreviewStorage storage;

  /// Create a new [DevicePreview].
  DevicePreview({
    Key key,
    @required this.builder,
    this.devices,
    this.data,
    this.style,
    this.isToolbarVisible = true,
    this.availableLocales,
    this.plugins = const <DevicePreviewPlugin>[],
    DevicePreviewStorage storage,
    this.enabled = true,
  })  : assert(devices == null || devices.isNotEmpty),
        assert(isToolbarVisible != null),
        storage = storage ?? DevicePreviewStorage.preferences(),
        super(key: key);

  static final List<DeviceInfo> defaultDevices = Devices.all;

  @override
  _DevicePreviewState createState() => _DevicePreviewState();

  /// The current target platform for the currently selected device.
  static TargetPlatform platform(BuildContext context) {
    final platform = context.select(
      (DevicePreviewStore store) => store.deviceInfo.identifier.platform,
    );
    return platform ?? Theme.of(context).platform;
  }

  static bool _isEnabled(BuildContext context) {
    final state = context.findAncestorStateOfType<_DevicePreviewState>();
    return state != null && state.widget.enabled;
  }

  /// Currently defined locale.
  static Locale locale(BuildContext context) {
    if (!_isEnabled(context)) {
      return null;
    }

    final store = Provider.of<DevicePreviewStore>(context);
    return store.state.maybeMap(
      initialized: (state) {
        final splits = state.data.locale.split('_');
        final languageCode = splits[0];
        String scriptCode, countryCode;
        if (splits.length > 2) {
          scriptCode = splits[1];
          countryCode = splits[2];
        } else if (splits.length > 1) {
          countryCode = splits[1];
        }
        return Locale.fromSubtags(
          languageCode: languageCode,
          scriptCode: scriptCode,
          countryCode: countryCode,
        );
      },
      orElse: () => WidgetsBinding.instance.window.locale,
    );
  }

  /// The list of declared plugins.
  static List<DevicePreviewPlugin> pluginsOf(BuildContext context) {
    final state = context.findAncestorStateOfType<_DevicePreviewState>();
    return state.widget.plugins;
  }

  /// Make the toolbar visible to the user.
  ///
  /// If [enablePreview] is set to `true`, then the device preview is also enabled
  /// when appearing.
  static void showToolbar(
    BuildContext context, {
    bool enablePreview = true,
  }) {
    final store = Provider.of<DevicePreviewStore>(context);
    store.data = store.data.copyWith(
      isToolbarVisible: true,
      isEnabled: enablePreview,
    );
  }

  /// Hide the toolbar.
  ///
  /// If [disablePreview] is set to `false`, then the device preview stays active even
  /// if the toolbar is not visible anymore.
  static void hideToolbar(
    BuildContext context, {
    bool disablePreview = true,
  }) {
    final store = Provider.of<DevicePreviewStore>(context);
    store.data = store.data.copyWith(
      isToolbarVisible: false,
      isEnabled: !disablePreview,
    );
  }

  /// Select a device from its unique [deviceIdentifier].
  ///
  /// All the identifiers are available from [Devices].
  static void selectDevice(
    BuildContext context,
    DeviceIdentifier deviceIdentifier,
  ) {
    final store = Provider.of<DevicePreviewStore>(context,listen: false);
    store.selectDevice(deviceIdentifier);
  }

  /// All available locales in the tool.
  static List<Locale> allLocales(BuildContext context) {
    if (!_isEnabled(context)) {
      return defaultAvailableLocales.map((e) => Locale(e.code)).toList();
    }
    final store = Provider.of<DevicePreviewStore>(context);
    return store.state
        .maybeMap(
          initialized: (state) => state.locales,
          orElse: () => defaultAvailableLocales,
        )
        .map((e) => Locale(e.code))
        .toList();
  }

  /// Take a screenshot.
  static Future<DeviceScreenshot> screenshot(BuildContext context) {
    final state = context.findAncestorStateOfType<_DevicePreviewState>();
    final store = context.read<DevicePreviewStore>();
    return state.screenshot(store);
  }

  /// A global builder that should be inserted into [WidgetApp]'s builder
  /// to simulated the simulated device screen and platform properties.
  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    if (!_isEnabled(context)) {
      return widget;
    }
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.state.maybeMap(
        initialized: (state) => state.data.isEnabled,
        orElse: () => false,
      ),
    );

    if (!isEnabled) return widget;

    final identifier = context.select(
      (DevicePreviewStore store) => store.deviceInfo.identifier,
    );

    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

    return MediaQuery(
      data: _mediaQuery(context),
      child: Theme(
        data: Theme.of(context).copyWith(
          platform: identifier.platform,
          visualDensity: [
            DeviceType.desktop,
            DeviceType.laptop,
          ].contains(identifier.type)
              ? VisualDensity.compact
              : VisualDensity.comfortable,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        child: widget,
      ),
    );
  }

  static MediaQueryData _mediaQuery(BuildContext context) {
    final device = context.select(
      (DevicePreviewStore store) => store.deviceInfo,
    );

    final orientation = context.select(
      (DevicePreviewStore store) => store.data.orientation,
    );

    final isVirtualKeyboardVisible = context.select(
      (DevicePreviewStore store) => store.data.isVirtualKeyboardVisible,
    );

    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

    final textScaleFactor = context.select(
      (DevicePreviewStore store) => store.data.textScaleFactor,
    );

    final boldText = context.select(
      (DevicePreviewStore store) => store.data.boldText,
    );

    final disableAnimations = context.select(
      (DevicePreviewStore store) => store.data.disableAnimations,
    );

    final accessibleNavigation = context.select(
      (DevicePreviewStore store) => store.data.accessibleNavigation,
    );

    final invertColors = context.select(
      (DevicePreviewStore store) => store.data.invertColors,
    );

    var mediaQuery = DeviceFrame.mediaQuery(
      context,
      device,
      orientation,
    );

    if (isVirtualKeyboardVisible) {
      mediaQuery = VirtualKeyboard.mediaQuery(mediaQuery);
    }

    return mediaQuery.copyWith(
      platformBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      textScaleFactor: textScaleFactor,
      boldText: boldText,
      disableAnimations: disableAnimations,
      accessibleNavigation: accessibleNavigation,
      invertColors: invertColors,
    );
  }
}

class _DevicePreviewState extends State<DevicePreview> {
  /// Whenever the [screenshot] is called, a new value is pushed to
  /// this stream.
  Stream<DeviceScreenshot> get onScreenshot => _onScreenshot.stream;

  /// Takes a screenshot with the current configuration.
  Future<DeviceScreenshot> screenshot(DevicePreviewStore store) async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    final format = ui.ImageByteFormat.png;

    final image = await boundary.toImage(
      pixelRatio: store.deviceInfo.pixelRatio,
    );
    final byteData = await image.toByteData(
      format: format,
    );
    final bytes = byteData.buffer.asUint8List();
    final screenshot = DeviceScreenshot(
      device: store.deviceInfo,
      bytes: bytes,
      format: format,
    );
    _onScreenshot.add(screenshot);
    return screenshot;
  }

  @override
  void initState() {
    DeviceFrame.precache(context);
    _onScreenshot = StreamController<DeviceScreenshot>.broadcast();
    super.initState();
  }

  Widget _buildPreview(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final device = context.select(
      (DevicePreviewStore store) => store.deviceInfo,
    );
    final isFrameVisible = context.select(
      (DevicePreviewStore store) => store.data.isFrameVisible,
    );
    final orientation = context.select(
      (DevicePreviewStore store) => store.data.orientation,
    );
    final isVirtualKeyboardVisible = context.select(
      (DevicePreviewStore store) => store.data.isVirtualKeyboardVisible,
    );
    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

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
            device: device,
            isFrameVisible: isFrameVisible,
            orientation: orientation,
            screen: VirtualKeyboard(
              isEnabled: isVirtualKeyboardVisible,
              child: Theme(
                data: Theme.of(context).copyWith(
                  platform: device.identifier.platform,
                  brightness: isDarkMode ? Brightness.dark : Brightness.light,
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

    return ChangeNotifierProvider(
      create: (context) => DevicePreviewStore(
        devices: widget.devices,
        locales: widget.availableLocales,
        storage: widget.storage,
      ),
      builder: (context, child) {
        final isInitialized = context.select(
          (DevicePreviewStore store) => store.state.maybeMap(
            initialized: (_) => true,
            orElse: () => false,
          ),
        );

        if (!isInitialized) {
          return Builder(
            key: _appKey,
            builder: widget.builder,
          );
        }

        final isEnabled = context.select(
          (DevicePreviewStore store) => store.data.isEnabled,
        );

        final isToolbarVisible = widget.isToolbarVisible &&
            context.select(
              (DevicePreviewStore store) => store.data.isToolbarVisible,
            );

        final style = DevicePreviewTheme.of(context);

        return Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: MediaQueryObserver(
              //mediaQuery: DevicePreview._mediaQuery(context),
              child: DecoratedBox(
                decoration: style.background,
                child: Builder(
                  builder: (context) => Stack(
                    children: <Widget>[
                      Positioned.fill(
                        left: isToolbarVisible &&
                                style.toolBar.position ==
                                    DevicePreviewToolBarPosition.left
                            ? DevicePreviewToolBar.width(context) - 12
                            : 0,
                        right: isToolbarVisible &&
                                style.toolBar.position ==
                                    DevicePreviewToolBarPosition.right
                            ? DevicePreviewToolBar.width(context) - 12
                            : 0,
                        top: isToolbarVisible &&
                                style.toolBar.position ==
                                    DevicePreviewToolBarPosition.top
                            ? DevicePreviewToolBar.height(context) - 12
                            : 0,
                        bottom: isToolbarVisible &&
                                style.toolBar.position ==
                                    DevicePreviewToolBarPosition.bottom
                            ? DevicePreviewToolBar.height(context) - 12
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
                      if (isToolbarVisible)
                        Positioned.fill(
                          key: Key('Toolbar'),
                          child: DevicePreviewTheme(
                            style: style,
                            child: _ToolsOverlay(
                              style: style,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The repaint key used for rendering screenshots.
  final _repaintKey = GlobalKey();

  /// A stream that sends a new value each time the user takes
  /// a new screenshot.
  StreamController<DeviceScreenshot> _onScreenshot;

  /// The current application key.
  final GlobalKey _appKey = GlobalKey();
}

class _ToolsOverlay extends StatefulWidget {
  final DevicePreviewStyle style;
  const _ToolsOverlay({
    Key key,
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
    return Localizations(
      locale: Locale('en', 'US'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return Stack(
                children: [
                  if (widget.style.toolBar.position ==
                      DevicePreviewToolBarPosition.bottom)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: DevicePreviewToolBar(
                        key: Key('Bar'),
                        overlayPosition: _overlayKey.absolutePosition,
                      ),
                    ),
                  if (widget.style.toolBar.position ==
                      DevicePreviewToolBarPosition.top)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: DevicePreviewToolBar(
                        key: Key('Bar'),
                        overlayPosition: _overlayKey.absolutePosition,
                      ),
                    ),
                  if (widget.style.toolBar.position ==
                      DevicePreviewToolBarPosition.right)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: DevicePreviewToolBar(
                        key: Key('Bar'),
                        overlayPosition: _overlayKey.absolutePosition,
                      ),
                    ),
                  if (widget.style.toolBar.position ==
                      DevicePreviewToolBarPosition.left)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: DevicePreviewToolBar(
                        key: Key('Bar'),
                        overlayPosition: _overlayKey.absolutePosition,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A screenshot from a [device].
class DeviceScreenshot {
  /// The device from which the screenshot was taken from.
  final DeviceInfo device;

  /// The binary content of the resulting image file.
  final Uint8List bytes;

  /// The format in which image bytes should be returned when using.
  final ui.ImageByteFormat format;

  DeviceScreenshot({
    @required this.device,
    @required this.bytes,
    @required this.format,
  });
}

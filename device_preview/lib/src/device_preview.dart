import 'dart:async';

import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/state/state.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/utilities/media_query_observer.dart';
import 'package:device_preview/src/views/tool_bar/horizontal_toolbar.dart';
import 'package:device_preview/src/views/tool_bar/vertical_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'screenshots/screenshot.dart';
import 'screenshots/upload_service.dart';
import 'utilities/position.dart';
import 'views/device_preview_style.dart';

/// Simulates how a [child] would render on different
/// devices than the current one.
///
/// This previews also allows children to interact from the
/// [DevicePreviewStore.of] methods.
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
    @Deprecated('Replaced by `isToolBarVisible`')
    bool areSettingsEnabled,
    bool isToolBarVisible = true,
    this.availableLocales,
    this.onScreenshot,
    this.enabled = true,
  })  : assert(devices == null || devices.isNotEmpty),
        assert(usePreferences != null),
        assert(isToolBarVisible != null || areSettingsEnabled != null),
        isToolBarVisible = areSettingsEnabled ?? isToolbarVisible,
        usePreferences = (data == null) && usePreferences,
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

  /// Currently defined locale.
  static Locale locale(BuildContext context) {
    final state = Provider.of<DevicePreviewStore>(context);
    final splits = state.data.locale.split('_');
    return Locale(
      splits[0],
      splits.length > 1 ? splits[1] : null,
    );
  }

  /// All available locales in the tool.
  static List<Locale> allLocales(BuildContext context) {
    final store = Provider.of<DevicePreviewStore>(context);
    return store.locales.map((e) => Locale(e.code)).toList();
  }

  /// Take a screenshot.
  static Future<DeviceScreenshot> screenshot(BuildContext context) {
    final state = context.findAncestorStateOfType<_DevicePreviewState>();
    return state.screenshot();
  }

  /// Process a screenshot.
  static Future<String> processScreenshot(
      BuildContext context, DeviceScreenshot screenshot) {
    final state = context.findAncestorStateOfType<_DevicePreviewState>();
    return state.processScreenshot(screenshot);
  }

  /// A global builder that should be inserted into [WidgetApp]'s builder
  /// to simulated the simulated device screen and platform properties.
  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );

    if (isEnabled) return widget;

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

  /// The processor used whenever the user take a new screenshot.
  ScreenshotProcessor get processScreenshot =>
      widget.onScreenshot ?? (const FileioScreenshotUploader().upload);

  /// Takes a screenshot with the current configuration.
  Future<DeviceScreenshot> screenshot() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    final format = ui.ImageByteFormat.png;

    final device = context.select(
      (DevicePreviewStore store) => store.deviceInfo,
    );

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
        useStorage: widget.usePreferences,
      ),
      builder: (context, child) {
        final isInitialized = context.select(
          (DevicePreviewStore store) => store.state.maybeMap(
            initialized: (_) => true,
            orElse: () => false,
          ),
        );

        if (!isInitialized) {
          return _DevicePreviewLoader();
        }

        final isEnabled = context.select(
          (DevicePreviewStore store) => store.data.isEnabled,
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
                        left: style.toolBar.position ==
                                DevicePreviewToolBarPosition.left
                            ? DevicePreviewVerticalToolBar.width(context) - 12
                            : 0,
                        right: style.toolBar.position ==
                                DevicePreviewToolBarPosition.right
                            ? DevicePreviewVerticalToolBar.width(context) - 12
                            : 0,
                        top: style.toolBar.position ==
                                DevicePreviewToolBarPosition.top
                            ? DevicePreviewHorizontalToolBar.height(context) -
                                12
                            : 0,
                        bottom: style.toolBar.position ==
                                DevicePreviewToolBarPosition.bottom
                            ? DevicePreviewHorizontalToolBar.height(context) -
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
                          child: _ToolsOverlay(
                            style: style,
                            isToolBarVisible: widget.isToolBarVisible,
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
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
      ),
    );
  }
}

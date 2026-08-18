// Hand-written fakes for the wrapper unit tests.
//
// Both fakes implement the complete dart:ui interfaces explicitly so the
// wrapper tests double as a drift canary: a new SDK interface member breaks
// this file (and the wrappers) at compile time.
//
// ignore_for_file: deprecated_member_use

import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

/// A configurable [ui.Display].
class FakeDisplay implements ui.Display {
  FakeDisplay({
    this.id = 0,
    this.devicePixelRatio = 3.0,
    this.size = const ui.Size(2400, 1800),
    this.refreshRate = 60,
  });

  @override
  final int id;

  @override
  final double devicePixelRatio;

  @override
  final ui.Size size;

  @override
  final double refreshRate;
}

/// A configurable [ui.ViewPadding].
class StubViewPadding implements ui.ViewPadding {
  const StubViewPadding({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  @override
  final double left;

  @override
  final double top;

  @override
  final double right;

  @override
  final double bottom;
}

/// A configurable [ui.AccessibilityFeatures].
class StubAccessibilityFeatures implements ui.AccessibilityFeatures {
  StubAccessibilityFeatures({
    this.accessibleNavigation = false,
    this.invertColors = false,
    this.disableAnimations = false,
    this.boldText = false,
    this.reduceMotion = false,
    this.highContrast = false,
    this.onOffSwitchLabels = false,
    this.supportsAnnounce = true,
    this.autoPlayAnimatedImages = true,
    this.autoPlayVideos = true,
    this.deterministicCursor = false,
  });

  @override
  bool accessibleNavigation;

  @override
  bool invertColors;

  @override
  bool disableAnimations;

  @override
  bool boldText;

  @override
  bool reduceMotion;

  @override
  bool highContrast;

  @override
  bool onOffSwitchLabels;

  @override
  bool supportsAnnounce;

  @override
  bool autoPlayAnimatedImages;

  @override
  bool autoPlayVideos;

  @override
  bool deterministicCursor;
}

/// A fully configurable, call-recording [ui.FlutterView].
class FakeFlutterView implements ui.FlutterView {
  FakeFlutterView({
    this.viewId = 7,
    this.devicePixelRatio = 3.0,
    this.physicalSize = const ui.Size(2400, 1800),
    this.padding = const StubViewPadding(top: 120),
    this.viewPadding = const StubViewPadding(top: 120),
    this.viewInsets = const StubViewPadding(),
    this.systemGestureInsets = const StubViewPadding(),
    this.gestureSettings = const ui.GestureSettings(physicalTouchSlop: 24),
    this.displayFeatures = const <ui.DisplayFeature>[],
    this.displayCornerRadii = const ui.DisplayCornerRadii(
      topLeft: 10,
      topRight: 10,
      bottomRight: 10,
      bottomLeft: 10,
    ),
    ui.ViewConstraints? physicalConstraints,
    FakeDisplay? display,
  }) : physicalConstraints =
           physicalConstraints ?? ui.ViewConstraints.tight(physicalSize),
       display = display ?? FakeDisplay();

  /// The dispatcher this view claims to belong to. Assigned by
  /// [FakePlatformDispatcher]'s constructor.
  late ui.PlatformDispatcher dispatcher;

  final List<String> calls = <String>[];

  /// Arguments of the last [render] call.
  ui.Scene? lastRenderedScene;
  ui.Size? lastRenderedSize;

  /// Argument of the last [updateSemantics] call.
  ui.SemanticsUpdate? lastSemanticsUpdate;

  @override
  int viewId;

  @override
  ui.PlatformDispatcher get platformDispatcher => dispatcher;

  @override
  FakeDisplay display;

  @override
  double devicePixelRatio;

  @override
  ui.ViewConstraints physicalConstraints;

  @override
  ui.Size physicalSize;

  @override
  ui.ViewPadding viewInsets;

  @override
  ui.ViewPadding viewPadding;

  @override
  ui.ViewPadding systemGestureInsets;

  @override
  ui.ViewPadding padding;

  @override
  ui.GestureSettings gestureSettings;

  @override
  List<ui.DisplayFeature> displayFeatures;

  @override
  ui.DisplayCornerRadii? displayCornerRadii;

  @override
  void render(ui.Scene scene, {ui.Size? size}) {
    calls.add('render');
    lastRenderedScene = scene;
    lastRenderedSize = size;
  }

  @override
  void updateSemantics(ui.SemanticsUpdate update) {
    calls.add('updateSemantics');
    lastSemanticsUpdate = update;
  }
}

/// A fully configurable, call-recording [ui.PlatformDispatcher].
class FakePlatformDispatcher implements ui.PlatformDispatcher {
  FakePlatformDispatcher({
    FakeFlutterView? implicitView,
    List<FakeFlutterView>? otherViews,
  }) : implicitView = implicitView ?? FakeFlutterView(),
       otherViews = otherViews ?? <FakeFlutterView>[] {
    this.implicitView!.dispatcher = this;
    for (final FakeFlutterView view in this.otherViews) {
      view.dispatcher = this;
    }
  }

  final List<String> calls = <String>[];

  @override
  final FakeFlutterView? implicitView;

  final List<FakeFlutterView> otherViews;

  // ---------------------------------------------------------------------------
  // Configurable state.
  // ---------------------------------------------------------------------------

  List<ui.Locale> localesValue = const <ui.Locale>[ui.Locale('en', 'US')];
  ui.Brightness platformBrightnessValue = ui.Brightness.light;
  double textScaleFactorValue = 1.0;
  bool alwaysUse24HourFormatValue = false;
  StubAccessibilityFeatures accessibilityFeaturesValue =
      StubAccessibilityFeatures();
  ui.Locale? platformResolvedLocaleValue = const ui.Locale('en', 'US');
  List<ui.Locale>? lastSupportedLocales;
  String initialLifecycleStateValue = 'AppLifecycleState.resumed';
  double? lineHeightScaleFactorOverrideValue;
  double? letterSpacingOverrideValue;
  double? wordSpacingOverrideValue;
  double? paragraphSpacingOverrideValue;
  bool nativeSpellCheckServiceDefinedValue = false;
  bool supportsShowingSystemContextMenuValue = false;
  bool brieflyShowPasswordValue = true;
  String? systemFontFamilyValue = 'FakeFont';
  bool semanticsEnabledValue = false;
  String defaultRouteNameValue = '/';
  int? engineIdValue = 42;
  ByteData? persistentIsolateDataValue;

  /// The factor applied by the host's [scaleFontSize] (nonlinear stand-in).
  double hostFontScale = 1.5;

  // ---------------------------------------------------------------------------
  // Views.
  // ---------------------------------------------------------------------------

  @override
  Iterable<ui.Display> get displays => <ui.Display>[
    for (final FakeFlutterView view in views) view.display,
  ];

  @override
  Iterable<FakeFlutterView> get views => <FakeFlutterView>[
    ?implicitView,
    ...otherViews,
  ];

  @override
  FakeFlutterView? view({required int id}) {
    for (final FakeFlutterView view in views) {
      if (view.viewId == id) {
        return view;
      }
    }
    return null;
  }

  @override
  int? get engineId => engineIdValue;

  // ---------------------------------------------------------------------------
  // Simulatable getters.
  // ---------------------------------------------------------------------------

  @override
  ui.Locale get locale => locales.first;

  @override
  List<ui.Locale> get locales => localesValue;

  @override
  ui.Brightness get platformBrightness => platformBrightnessValue;

  @override
  double get textScaleFactor => textScaleFactorValue;

  @override
  double scaleFontSize(double unscaledFontSize) {
    calls.add('scaleFontSize');
    return unscaledFontSize * hostFontScale;
  }

  @override
  ui.AccessibilityFeatures get accessibilityFeatures =>
      accessibilityFeaturesValue;

  @override
  bool get alwaysUse24HourFormat => alwaysUse24HourFormatValue;

  @override
  ui.Locale? computePlatformResolvedLocale(List<ui.Locale> supportedLocales) {
    calls.add('computePlatformResolvedLocale');
    lastSupportedLocales = supportedLocales;
    return platformResolvedLocaleValue;
  }

  // ---------------------------------------------------------------------------
  // Callbacks — plain storage so tests can fire them.
  // ---------------------------------------------------------------------------

  @override
  ui.VoidCallback? onPlatformConfigurationChanged;

  @override
  ui.VoidCallback? onMetricsChanged;

  @override
  ui.ViewFocusChangeCallback? onViewFocusChange;

  @override
  ui.FrameCallback? onBeginFrame;

  @override
  ui.VoidCallback? onDrawFrame;

  @override
  ui.PointerDataPacketCallback? onPointerDataPacket;

  @override
  ui.KeyDataCallback? onKeyData;

  @override
  ui.HitTestCallback? onHitTest;

  @override
  ui.TimingsCallback? onReportTimings;

  @override
  ui.PlatformMessageCallback? onPlatformMessage;

  @override
  ui.VoidCallback? onAccessibilityFeaturesChanged;

  @override
  ui.VoidCallback? onLocaleChanged;

  @override
  ui.VoidCallback? onTextScaleFactorChanged;

  @override
  ui.VoidCallback? onPlatformBrightnessChanged;

  @override
  ui.VoidCallback? onSystemFontFamilyChanged;

  @override
  ui.VoidCallback? onSemanticsEnabledChanged;

  @override
  ui.SemanticsActionEventCallback? onSemanticsActionEvent;

  @override
  ui.VoidCallback? onFrameDataChanged;

  @override
  ui.ErrorCallback? onError;

  // ---------------------------------------------------------------------------
  // Delegation targets — recorded.
  // ---------------------------------------------------------------------------

  @override
  void requestViewFocusChange({
    required int viewId,
    required ui.ViewFocusState state,
    required ui.ViewFocusDirection direction,
  }) => calls.add('requestViewFocusChange');

  @override
  void sendPlatformMessage(
    String name,
    ByteData? data,
    ui.PlatformMessageResponseCallback? callback,
  ) => calls.add('sendPlatformMessage');

  @override
  void sendPortPlatformMessage(
    String name,
    ByteData? data,
    int identifier,
    SendPort port,
  ) => calls.add('sendPortPlatformMessage');

  @override
  void registerBackgroundIsolate(ui.RootIsolateToken token) =>
      calls.add('registerBackgroundIsolate');

  @override
  void setSemanticsTreeEnabled(bool enabled) =>
      calls.add('setSemanticsTreeEnabled');

  @override
  void setIsolateDebugName(String name) => calls.add('setIsolateDebugName');

  @override
  void requestDartPerformanceMode(ui.DartPerformanceMode mode) =>
      calls.add('requestDartPerformanceMode');

  @override
  ByteData? getPersistentIsolateData() {
    calls.add('getPersistentIsolateData');
    return persistentIsolateDataValue;
  }

  @override
  void scheduleFrame() => calls.add('scheduleFrame');

  @override
  void scheduleWarmUpFrame({
    required ui.VoidCallback beginFrame,
    required ui.VoidCallback drawFrame,
  }) => calls.add('scheduleWarmUpFrame');

  @override
  void updateSemantics(ui.SemanticsUpdate update) =>
      calls.add('updateSemantics');

  @override
  void setApplicationLocale(ui.Locale locale) =>
      calls.add('setApplicationLocale');

  // ---------------------------------------------------------------------------
  // Remaining state getters.
  // ---------------------------------------------------------------------------

  @override
  String get initialLifecycleState => initialLifecycleStateValue;

  @override
  double? get lineHeightScaleFactorOverride =>
      lineHeightScaleFactorOverrideValue;

  @override
  double? get letterSpacingOverride => letterSpacingOverrideValue;

  @override
  double? get wordSpacingOverride => wordSpacingOverrideValue;

  @override
  double? get paragraphSpacingOverride => paragraphSpacingOverrideValue;

  @override
  bool get nativeSpellCheckServiceDefined =>
      nativeSpellCheckServiceDefinedValue;

  @override
  bool get supportsShowingSystemContextMenu =>
      supportsShowingSystemContextMenuValue;

  @override
  bool get brieflyShowPassword => brieflyShowPasswordValue;

  @override
  String? get systemFontFamily => systemFontFamilyValue;

  @override
  bool get semanticsEnabled => semanticsEnabledValue;

  @override
  ui.FrameData get frameData => ui.PlatformDispatcher.instance.frameData;

  @override
  String get defaultRouteName => defaultRouteNameValue;
}

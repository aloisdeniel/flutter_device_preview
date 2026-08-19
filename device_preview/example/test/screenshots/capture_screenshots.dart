// Renders the "device lab" showcase under a handful of simulated devices and
// writes framed PNG screenshots — the images used by the pub.dev
// `screenshots:` block and the release announcements.
//
// Not a test (no `_test.dart` suffix, so `flutter test` skips it by default).
// Regenerate the images with:
//
//   cd device_preview/example
//   flutter test test/screenshots/capture_screenshots.dart
//
// Output goes to docs/announcements/images/ at the repository root, or to
// $DEVICE_PREVIEW_SHOTS_DIR when set.

// The capture pipeline is the package's own screenshot service module; using
// it from here keeps these images pixel-identical to what the DevTools
// "Screenshot" button downloads.
// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/service/screenshot.dart';
import 'package:device_preview_example/showcase.dart';
import 'package:device_preview_example/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _ScreenshotBinding extends AutomatedTestWidgetsFlutterBinding
    with DevicePreviewBindingMixin {
  static _ScreenshotBinding? _instance;

  /// The overlay style the simulated system bars are tinted from.
  ///
  /// Under `flutter_test` the binding's own style tracking lags the frame
  /// being captured (`MaterialApp` re-commits the framework's `.light` base
  /// style — opaque black navigation bar — on every build, and the tracked
  /// notifier catches up a frame late), so the composition pins the
  /// edge-to-edge style a real app declares instead.
  static final ValueNotifier<SystemUiOverlayStyle?> overlayStyle =
      ValueNotifier<SystemUiOverlayStyle?>(
        const SystemUiOverlayStyle(
          statusBarColor: Color(0x00000000),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0x00000000),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );

  static _ScreenshotBinding ensureInitialized() {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(enabled: true);
      _ScreenshotBinding();
    }
    return _instance!;
  }

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  @override
  Widget wrapWithDefaultView(Widget rootWidget) {
    final ui.FlutterView? wrapperView = previewImplicitView;
    final DevicePreviewController? controller = devicePreview;
    if (wrapperView != null) {
      return View(
        view: wrapperView,
        child: controller == null
            ? rootWidget
            : DevicePreviewFrame(
                simulation: controller.simulationListenable,
                overlayStyle: overlayStyle,
                child: rootWidget,
              ),
      );
    }
    return super.wrapWithDefaultView(rootWidget);
  }
}

/// One screenshot: a preset, optional tweaks, and the output file name.
class _Scene {
  const _Scene(
    this.fileName,
    this.preset, {
    this.app = const TodoApp(),
    this.orientation,
    this.tweak,
    this.locales,
    this.interact,
  });

  final String fileName;
  final DevicePreset preset;
  final Widget app;
  final Orientation? orientation;
  final DeviceSimulation Function(DeviceSimulation s)? tweak;
  final List<Locale>? locales;

  /// Optional in-app interaction performed before the capture.
  final Future<void> Function(WidgetTester tester)? interact;
}

/// How long a scene is pumped before its capture.
const Duration _settle = Duration(milliseconds: 600);

final List<_Scene> _scenes = <_Scene>[
  const _Scene('iphone-17-pro-max', DevicePresets.iPhone17ProMax),
  const _Scene('iphone-se-3', DevicePresets.iPhoneSe3),
  _Scene(
    'pixel-10-pro-fold',
    DevicePresets.pixel10ProFold,
    // Fill the pane right of the crease with a task's subtasks.
    interact: (WidgetTester tester) async {
      await tester.tap(find.text('Prepare the release'));
      await tester.pumpAndSettle();
    },
  ),
  _Scene(
    'iphone-16-pro-dark-200-text',
    DevicePresets.iPhone16Pro,
    app: const ShowcaseApp(),
    tweak: (DeviceSimulation s) => s.copyWith(
      platformBrightness: Brightness.dark,
      textScaleFactor: 2.0,
    ),
  ),
  _Scene(
    'ipad-pro-13-landscape',
    DevicePresets.iPadPro13M5,
    orientation: Orientation.landscape,
    // Show the add-task sheet riding the bottom safe area.
    interact: (WidgetTester tester) async {
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Ship 3.0');
      await tester.pump(const Duration(milliseconds: 100));
    },
  ),
  // French rather than an RTL locale: the test font manager has no
  // per-family glyph fallback, so non-Latin scripts render as boxes here.
  // The live demo on the landing page shows the Arabic RTL flip instead.
  const _Scene(
    'galaxy-s25-french-locale',
    DevicePresets.galaxyS25,
    app: ShowcaseApp(),
    locales: <Locale>[Locale('fr', 'FR')],
  ),
];

Future<void> _loadRealFonts() async {
  final String? flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot == null) {
    fail('FLUTTER_ROOT is not set; run through `flutter test`.');
  }
  final Directory fonts = Directory(
    '$flutterRoot/bin/cache/artifacts/material_fonts',
  );

  Future<void> load(String family, List<String> files) async {
    final FontLoader loader = FontLoader(family);
    for (final String file in files) {
      final File f = File(
        file.startsWith('/') ? file : '${fonts.path}/$file',
      );
      if (!f.existsSync()) continue; // e.g. the macOS-only Arabic face
      loader.addFont(
        Future<ByteData>.value(f.readAsBytesSync().buffer.asByteData()),
      );
    }
    await loader.load();
  }

  await load('Roboto', <String>[
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
    'Roboto-Light.ttf',
    'Roboto-Black.ttf',
  ]);
  await load('MaterialIcons', <String>['MaterialIcons-Regular.otf']);
}

void main() {
  final _ScreenshotBinding binding = _ScreenshotBinding.ensureInitialized();

  final String outDir =
      Platform.environment['DEVICE_PREVIEW_SHOTS_DIR'] ??
      '../../docs/announcements/images';

  setUpAll(() async {
    await _loadRealFonts();
    Directory(outDir).createSync(recursive: true);
  });

  tearDown(() async {
    await binding.devicePreview?.reset();
  });

  for (final _Scene scene in _scenes) {
    testWidgets('captures ${scene.fileName}', (WidgetTester tester) async {
      final DevicePreviewController controller = binding.devicePreview!;
      if (scene.locales != null) {
        tester.platformDispatcher.localesTestValue = scene.locales!;
        addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      }
      await controller.applyPreset(scene.preset);
      // Dark theme everywhere: it photographs better against the device
      // bodies. Scene tweaks may still override it.
      await controller.update(
        (DeviceSimulation s) =>
            s.copyWith(platformBrightness: Brightness.dark),
      );
      if (scene.orientation != null) {
        await controller.setOrientation(scene.orientation!);
      }
      if (scene.tweak != null) {
        await controller.update(scene.tweak!);
      }

      await tester.pumpWidget(scene.app);
      await tester.pump(_settle);
      if (scene.interact != null) {
        await scene.interact!(tester);
        await tester.pump(_settle);
      }

      final DevicePreviewScreenshot handler = DevicePreviewScreenshot(
        findRenderView: () => binding.renderViews.single,
        findHostView: () => binding.platformDispatcher.implicitView,
        state: PreviewState()
          ..simulation = controller.simulation
          ..fit = controller.fitTransform,
      );

      final bool disabledShadows = debugDisableShadows;
      debugDisableShadows = false;
      try {
        final Map<String, Object?> result = (await tester.runAsync(
          () => handler.capture(const <String, String>{'pixelRatio': '2'}),
        ))!;
        expect(result['error'], isNull, reason: '$result');
        final List<int> bytes = base64Decode(
          result['bytesBase64']! as String,
        );
        await tester.runAsync(
          () => File(
            '$outDir/${scene.fileName}.png',
          ).writeAsBytes(bytes, flush: true),
        );
      } finally {
        debugDisableShadows = disabledShadows;
      }

      // Dispose the showcase (its clock runs a periodic timer).
      await tester.pumpWidget(const SizedBox());
    });
  }
}

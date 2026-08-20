// Renders the DevTools panel against a scripted gateway (the test fake,
// loaded with the real generated device catalog) and writes a PNG — the
// screenshot embedded in the website's DevTools section.
//
// Not a test (no `_test.dart` suffix, so `flutter test` skips it by default).
// Regenerate with:
//
//   cd device_preview_devtools_extension
//   flutter test test/screenshots/capture_panel.dart
//
// Output goes to docs/images/devtools-panel.png at the repository root, or to
// $DEVICE_PREVIEW_SHOTS_DIR/devtools-panel.png when set.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:devtools_app_shared/ui.dart';
import 'package:device_preview_devtools_extension/src/devices/device_catalog.g.dart';
import 'package:device_preview_devtools_extension/src/panel.dart';
import 'package:device_preview_devtools_extension/src/panel_controller.dart';
import 'package:device_preview_devtools_extension/src/platform/platform_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show FontLoader;
import 'package:flutter_test/flutter_test.dart';

import '../fake_gateway.dart';

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
      final File f = File('${fonts.path}/$file');
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
  ]);
  await load('MaterialIcons', <String>['MaterialIcons-Regular.otf']);
}

void main() {
  final String outDir =
      Platform.environment['DEVICE_PREVIEW_SHOTS_DIR'] ?? '../docs/images';

  setUpAll(() async {
    await _loadRealFonts();
    Directory(outDir).createSync(recursive: true);
  });

  testWidgets('captures the panel', (WidgetTester tester) async {
    // A DevTools-sidebar-ish viewport, cropped to a 1:2 aspect ratio so the
    // website embed stays compact; the panel scrolls, so the lower sections
    // are simply cut at the fold.
    tester.view.physicalSize = const ui.Size(460, 920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final FakeGateway gateway = FakeGateway(connected: true, available: true)
      ..presetsJson = List<Map<String, Object?>>.from(kDeviceSpecs);
    final PanelController controller = PanelController(
      gateway: gateway,
      storage: InMemoryStorage(),
      saveScreenshot: (_, __) {},
      readyEventTimeout: const Duration(milliseconds: 10),
      bannerDelay: const Duration(milliseconds: 10),
    );
    addTearDown(controller.dispose);
    addTearDown(gateway.dispose);

    await tester.pumpWidget(
      RepaintBoundary(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeFor(
            isDarkTheme: true,
            ideTheme: IdeTheme(),
            theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          ),
          home: Scaffold(body: DevicePreviewPanel(controller: controller)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Show the panel with a device applied, like a working session.
    final PresetView iphone = controller.presets.firstWhere(
      (PresetView p) => p.id == 'apple-iphone-17-pro',
    );
    await controller.selectPreset(iphone);
    await tester.pumpAndSettle();

    final RenderRepaintBoundary boundary = tester
        .renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);

    final bool disabledShadows = debugDisableShadows;
    debugDisableShadows = false;
    try {
      await tester.runAsync(() async {
        final ui.Image image = await boundary.toImage(pixelRatio: 2);
        final ByteData bytes =
            (await image.toByteData(format: ui.ImageByteFormat.png))!;
        await File(
          '$outDir/devtools-panel.png',
        ).writeAsBytes(bytes.buffer.asUint8List(), flush: true);
      });
    } finally {
      debugDisableShadows = disabledShadows;
    }
  });
}

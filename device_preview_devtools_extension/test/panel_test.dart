import 'package:device_preview_devtools_extension/src/panel.dart';
import 'package:device_preview_devtools_extension/src/panel_controller.dart';
import 'package:device_preview_devtools_extension/src/platform/platform_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_gateway.dart';

void main() {
  late FakeGateway gateway;
  late PanelController controller;

  Future<void> pumpPanel(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DevicePreviewPanel(controller: controller)),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() {
    gateway = FakeGateway(connected: true, available: true);
    gateway.presetsJson = [testPhonePresetJson, testTabletPresetJson];
    controller = PanelController(
      gateway: gateway,
      storage: InMemoryStorage(),
      saveScreenshot: (_, __) {},
      readyEventTimeout: const Duration(milliseconds: 10),
      bannerDelay: const Duration(milliseconds: 10),
    );
  });

  tearDown(() {
    controller.dispose();
    gateway.dispose();
  });

  group('empty states', () {
    testWidgets('disconnected', (tester) async {
      gateway.connectedNotifier.value = false;
      await pumpPanel(tester);
      expect(find.text('No app connected'), findsOneWidget);
    });

    testWidgets('no binding', (tester) async {
      gateway.availableNotifier.value = false;
      await pumpPanel(tester);
      expect(
        find.text('Device Preview is not active in this app'),
        findsOneWidget,
      );
      // Let the banner grace timer fire (and verify the banner was shown).
      await tester.pump(const Duration(milliseconds: 50));
      expect(gateway.banners, hasLength(1));
    });
  });

  group('device section', () {
    testWidgets('shows sections and the active device label', (tester) async {
      await controller.selectPreset(const PresetView(testPhonePresetJson));
      await pumpPanel(tester);
      expect(find.text('Device'), findsOneWidget);
      expect(find.text('Display'), findsOneWidget);
      expect(find.text('Locale'), findsOneWidget);
      expect(find.text('Accessibility'), findsOneWidget);
      expect(find.text('Platform'), findsOneWidget);
      // Toolbar label + picker button label.
      expect(find.text('Test Phone'), findsNWidgets(2));
    });

    testWidgets('preset picker searches, groups and selects', (tester) async {
      await pumpPanel(tester);
      await tester
          .tap(find.byKey(const Key('device_preview_preset_picker_button')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('device_preview_real_device_entry')),
        findsOneWidget,
      );
      // The built-in catalog fills the list, so narrow it down to the two
      // app-registered presets before asserting on grouping.
      await tester.enterText(
        find.byKey(const Key('device_preview_preset_search')),
        'test-',
      );
      await tester.pumpAndSettle();
      expect(find.text('Phones'), findsOneWidget);
      expect(find.text('Tablets'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'Test Phone'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('device_preview_preset_search')),
        'test tablet',
      );
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ListTile, 'Test Phone'), findsNothing);
      expect(find.widgetWithText(ListTile, 'Test Tablet'), findsOneWidget);

      await tester.tap(find.widgetWithText(ListTile, 'Test Tablet'));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['presetId'], 'test-tablet');
      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('preset picker shows and searches the release year',
        (tester) async {
      await pumpPanel(tester);
      await tester
          .tap(find.byKey(const Key('device_preview_preset_picker_button')));
      await tester.pumpAndSettle();

      // 2026 matches exactly one catalog device, and its subtitle carries the
      // year between the brand and the metrics.
      await tester.enterText(
        find.byKey(const Key('device_preview_preset_search')),
        '2026',
      );
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ListTile, 'iPhone 17e'), findsOneWidget);
      expect(
        find.text('Apple · 2026 · 390×844 · @3.0x · framed'),
        findsOneWidget,
      );

      // Within a brand the newest devices come first.
      await tester.enterText(
        find.byKey(const Key('device_preview_preset_search')),
        'iphone 1',
      );
      await tester.pumpAndSettle();
      final names = tester
          .widgetList<ListTile>(find.byType(ListTile))
          .map((tile) => tile.title)
          .whereType<Text>()
          .map((text) => text.data)
          .whereType<String>()
          .where((name) => name.startsWith('iPhone'))
          .toList();
      // 2026 first, then the two 2025 models, then the 2024 ones (the tail of
      // the list is below the fold and not built).
      expect(
        names.take(4),
        ['iPhone 17e', 'iPhone 17', 'iPhone 17 Pro', 'iPhone 16'],
      );
    });

    testWidgets('real device entry clears metrics but keeps overrides',
        (tester) async {
      await controller.selectPreset(const PresetView(testPhonePresetJson));
      await controller.setBrightness('dark');
      await pumpPanel(tester);
      await tester
          .tap(find.byKey(const Key('device_preview_preset_picker_button')));
      await tester.pumpAndSettle();
      await tester
          .tap(find.byKey(const Key('device_preview_real_device_entry')));
      await tester.pumpAndSettle();
      expect(gateway.simulation, {'platformBrightness': 'dark'});
    });

    testWidgets('system UI switch is disabled without simulated bars',
        (tester) async {
      await pumpPanel(tester);
      final disabled = tester.widget<Switch>(
        find.byKey(const Key('device_preview_system_ui_switch')),
      );
      expect(disabled.onChanged, isNull);
      expect(disabled.value, isTrue);

      await controller.selectPreset(const PresetView(testFramedPresetJson));
      await tester.pumpAndSettle();
      final enabled = tester.widget<Switch>(
        find.byKey(const Key('device_preview_system_ui_switch')),
      );
      expect(enabled.onChanged, isNotNull);

      await tester.tap(find.byKey(const Key('device_preview_system_ui_switch')));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['showSystemUi'], isFalse);
    });

    testWidgets('touch input tri-state sends auto/on/off', (tester) async {
      await pumpPanel(tester);
      final toggle = find.byKey(const Key('device_preview_touch_input_toggle'));
      expect(
        tester.widget<SegmentedButton<String>>(toggle).selected,
        <String>{'system'},
        reason: 'auto by default',
      );

      await tester.tap(find.descendant(of: toggle, matching: find.text('On')));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['touchInput'], isTrue);

      await tester.tap(find.descendant(of: toggle, matching: find.text('Off')));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['touchInput'], isFalse);

      await tester.tap(find.descendant(of: toggle, matching: find.text('Auto')));
      await tester.pumpAndSettle();
      expect(gateway.simulation, isNull, reason: 'nothing left to override');
    });

    testWidgets('orientation toggle is disabled without a simulated screen',
        (tester) async {
      await pumpPanel(tester);
      final toggle = tester.widget<SegmentedButton<String>>(
        find.byKey(const Key('device_preview_orientation_toggle')),
      );
      expect(toggle.onSelectionChanged, isNull);
    });

    testWidgets('orientation toggle rotates an active preset', (tester) async {
      await controller.selectPreset(const PresetView(testPhonePresetJson));
      await pumpPanel(tester);
      await tester.tap(find.byIcon(Icons.stay_current_landscape));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['orientation'], 'landscape');
      expect(
        gateway.simulation?['screenSize'],
        {'width': 800.0, 'height': 400.0},
      );
    });

    testWidgets('custom expander applies custom metrics', (tester) async {
      await pumpPanel(tester);
      await tester.tap(find.byKey(const Key('device_preview_custom_expander')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('device_preview_custom_width')),
        '500',
      );
      await tester.enterText(
        find.byKey(const Key('device_preview_custom_height')),
        '1000',
      );
      await tester.enterText(
        find.byKey(const Key('device_preview_custom_dpr')),
        '2.5',
      );
      await tester.ensureVisible(
        find.byKey(const Key('device_preview_custom_apply')),
      );
      await tester.tap(find.byKey(const Key('device_preview_custom_apply')));
      await tester.pumpAndSettle();
      expect(gateway.simulation?['screenSize'], {
        'width': 500.0,
        'height': 1000.0,
      });
      expect(gateway.simulation?['devicePixelRatio'], 2.5);
      expect(gateway.simulation?['presetId'], isNull);
    });
  });

  group('display section', () {
    testWidgets('brightness segmented control sends the override',
        (tester) async {
      await pumpPanel(tester);
      await tester.ensureVisible(
        find.byKey(const Key('device_preview_brightness_toggle')),
      );
      await tester.tap(find.byIcon(Icons.dark_mode_outlined));
      await tester.pumpAndSettle();
      expect(gateway.simulation, {'platformBrightness': 'dark'});

      // Back to system clears the override entirely.
      final systemSegment = find.descendant(
        of: find.byKey(const Key('device_preview_brightness_toggle')),
        matching: find.text('System'),
      );
      await tester.tap(systemSegment);
      await tester.pumpAndSettle();
      expect(gateway.simulation, isNull);
    });

    testWidgets('text scale system chip clears the override', (tester) async {
      await controller.setTextScaleFactor(2.0);
      await pumpPanel(tester);
      await tester.ensureVisible(
        find.byKey(const Key('device_preview_text_scale_system_chip')),
      );
      await tester.tap(
        find.byKey(const Key('device_preview_text_scale_system_chip')),
      );
      await tester.pumpAndSettle();
      expect(gateway.simulation, isNull);
    });

    testWidgets('24-hour tri-state sends on/off/system', (tester) async {
      await pumpPanel(tester);
      final toggle = find.byKey(const Key('device_preview_24h_toggle'));
      await tester.ensureVisible(toggle);
      await tester.tap(
        find.descendant(of: toggle, matching: find.text('On')),
      );
      await tester.pumpAndSettle();
      expect(gateway.simulation, {'alwaysUse24HourFormat': true});
      await tester.tap(
        find.descendant(of: toggle, matching: find.text('Off')),
      );
      await tester.pumpAndSettle();
      expect(gateway.simulation, {'alwaysUse24HourFormat': false});
      await tester.tap(
        find.descendant(of: toggle, matching: find.text('System')),
      );
      await tester.pumpAndSettle();
      expect(gateway.simulation, isNull);
    });
  });
}

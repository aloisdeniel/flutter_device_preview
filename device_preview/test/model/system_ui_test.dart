import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const String kClock =
    '<svg viewBox="0 0 30 14"><rect width="30" height="14" '
    'fill="currentColor"/></svg>';

const SystemUiSimulation kSystemUi = SystemUiSimulation(
  statusBar: SystemUiBar(leading: kClock, inset: 24),
  navigationBar: SystemUiBar(
    center: '<svg viewBox="0 0 140 5"/>',
    bottomInset: 8,
  ),
);

void main() {
  group('json', () {
    test('round-trips', () {
      expect(SystemUiSimulation.fromJson(kSystemUi.toJson()), kSystemUi);
      expect(
        SystemUiSimulation.fromJson(
          Map<String, Object?>.from(
            jsonDecode(jsonEncode(kSystemUi.toJson())) as Map,
          ),
        ),
        kSystemUi,
      );
    });

    test('everything is optional', () {
      final SystemUiSimulation empty = SystemUiSimulation.fromJson(
        const <String, Object?>{},
      );
      expect(empty.statusBar, isNull);
      expect(empty.navigationBar, isNull);
      expect(empty.isEmpty, isTrue);
      expect(empty.toJson(), isEmpty);
    });

    test('bars default to a 16 pixel inset and no bottom inset', () {
      final SystemUiBar bar = SystemUiBar.fromJson(const <String, Object?>{
        'leading': '<svg viewBox="0 0 1 1"/>',
      });
      expect(bar.inset, 16);
      expect(bar.bottomInset, isNull);
      expect(bar.isEmpty, isFalse);
    });

    test('artwork may be authored as an array of lines', () {
      final SystemUiBar bar = SystemUiBar.fromJson(const <String, Object?>{
        'center': <Object?>['<svg viewBox="0 0 1 1">', '</svg>'],
      });
      expect(bar.center, '<svg viewBox="0 0 1 1">\n</svg>');
    });

    test('a bar with no artwork is dropped from the encoded form', () {
      const SystemUiSimulation blank = SystemUiSimulation(
        statusBar: SystemUiBar(),
      );
      expect(blank.isEmpty, isTrue);
      expect(blank.toJson(), isEmpty);
    });

    test('malformed values throw', () {
      expect(
        () => SystemUiBar.fromJson(const <String, Object?>{'inset': 'wide'}),
        throwsFormatException,
      );
      expect(
        () => SystemUiSimulation.fromJson(const <String, Object?>{
          'statusBar': 'nope',
        }),
        throwsFormatException,
      );
    });
  });

  group('simulation integration', () {
    test('round-trips through the simulation JSON', () {
      const DeviceSimulation simulation = DeviceSimulation(
        screenSize: ui.Size(400, 800),
        systemUi: kSystemUi,
      );
      expect(
        DeviceSimulation.fromJson(simulation.toJson()).systemUi,
        kSystemUi,
      );
      expect(simulation.isEmpty, isFalse);
    });

    test('copyWith clears it when passed null explicitly', () {
      const DeviceSimulation simulation = DeviceSimulation(systemUi: kSystemUi);
      expect(simulation.copyWith().systemUi, kSystemUi);
      expect(simulation.copyWith(systemUi: null).systemUi, isNull);
    });

    test('participates in equality', () {
      expect(
        const DeviceSimulation(systemUi: kSystemUi),
        const DeviceSimulation(systemUi: kSystemUi),
      );
      expect(
        const DeviceSimulation(systemUi: kSystemUi),
        isNot(const DeviceSimulation()),
      );
    });

    test('presets resolve it into both orientations unchanged', () {
      const DevicePreset preset = DevicePreset(
        id: 'x',
        name: 'X',
        platform: TargetPlatform.iOS,
        portraitSize: ui.Size(400, 800),
        devicePixelRatio: 2,
        systemUi: kSystemUi,
      );
      expect(preset.resolve().systemUi, kSystemUi);
      expect(
        preset.resolve(orientation: Orientation.landscape).systemUi,
        kSystemUi,
      );
      expect(DevicePreset.fromJson(preset.toJson()), preset);
    });
  });

  group('SystemUiColors.resolve', () {
    SystemUiColors resolve({
      SystemUiOverlayStyle? style,
      Brightness platformBrightness = Brightness.light,
      TargetPlatform platform = TargetPlatform.android,
    }) => SystemUiColors.resolve(
      style: style,
      platformBrightness: platformBrightness,
      platform: platform,
    );

    const ui.Color light = ui.Color(0xFFFFFFFF);
    const ui.Color dark = ui.Color(0xFF16181C);
    const ui.Color transparent = ui.Color(0x00000000);

    test('statusBarIconBrightness wins: light means light icons', () {
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ).statusBarIcons,
        light,
      );
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
        ).statusBarIcons,
        dark,
      );
    });

    test('statusBarBrightness describes the background, so it inverts', () {
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
        ).statusBarIcons,
        light,
      );
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
        ).statusBarIcons,
        dark,
      );
    });

    test('icon brightness wins over the iOS background field', () {
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ).statusBarIcons,
        dark,
      );
    });

    test('without a style the icons contrast with the platform brightness', () {
      expect(resolve().statusBarIcons, dark);
      expect(
        resolve(platformBrightness: Brightness.dark).statusBarIcons,
        light,
      );
    });

    test('navigation icons follow the status bar unless set', () {
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ).navigationBarIcons,
        light,
      );
      expect(
        resolve(
          style: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ).navigationBarIcons,
        dark,
      );
    });

    test('background tints apply on Android', () {
      final SystemUiColors colors = resolve(
        style: const SystemUiOverlayStyle(
          statusBarColor: ui.Color(0xFF102030),
          systemNavigationBarColor: ui.Color(0xFF405060),
          systemNavigationBarDividerColor: ui.Color(0xFF708090),
        ),
      );
      expect(colors.statusBarBackground, const ui.Color(0xFF102030));
      expect(colors.navigationBarBackground, const ui.Color(0xFF405060));
      expect(colors.navigationBarDivider, const ui.Color(0xFF708090));
    });

    test('background tints are ignored where the platform cannot honor '
        'them', () {
      final SystemUiColors colors = resolve(
        platform: TargetPlatform.iOS,
        style: const SystemUiOverlayStyle(
          statusBarColor: ui.Color(0xFF102030),
          systemNavigationBarColor: ui.Color(0xFF405060),
          systemNavigationBarDividerColor: ui.Color(0xFF708090),
          statusBarBrightness: Brightness.dark,
        ),
      );
      expect(colors.statusBarBackground, transparent);
      expect(colors.navigationBarBackground, transparent);
      expect(colors.navigationBarDivider, transparent);
      // The icon color still resolves.
      expect(colors.statusBarIcons, light);
    });

    test('value semantics', () {
      expect(resolve(), resolve());
      expect(resolve().hashCode, resolve().hashCode);
      expect(resolve(), isNot(resolve(platformBrightness: Brightness.dark)));
    });
  });
}

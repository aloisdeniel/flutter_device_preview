import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/presets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DevicePresets catalog', () {
    test('contains the 26 documented presets with unique ids', () {
      expect(DevicePresets.all, hasLength(26));
      final ids = DevicePresets.all.map((p) => p.id).toSet();
      expect(ids, hasLength(26));
    });

    test('every device preset declares a release year', () {
      for (final preset in DevicePresets.all) {
        if (preset.kind == DeviceKind.desktop) continue;
        expect(preset.year, isNotNull, reason: preset.id);
        expect(preset.year, inInclusiveRange(2000, 2100), reason: preset.id);
      }
    });

    test('every foldable preset reports a flat fold spanning its screen', () {
      final foldables = DevicePresets.all
          .where((p) => p.kind == DeviceKind.foldable)
          .toList();
      expect(foldables.map((p) => p.id), <String>[
        'google-pixel-10-pro-fold',
        'samsung-galaxy-z-flip-8',
        'samsung-galaxy-z-fold-8',
        'samsung-galaxy-z-fold-8-ultra',
      ]);
      for (final preset in foldables) {
        expect(preset.displayFeatures, hasLength(1), reason: preset.id);
        final feature = preset.displayFeatures.single;
        expect(feature.type, ui.DisplayFeatureType.fold, reason: preset.id);
        expect(
          feature.state,
          ui.DisplayFeatureState.postureFlat,
          reason: preset.id,
        );
        // A crease has zero area and runs edge to edge through the center
        // of the panel, along one axis or the other.
        final bounds = feature.bounds;
        final size = preset.portraitSize;
        if (bounds.width == 0) {
          expect(bounds.left, size.width / 2, reason: preset.id);
          expect(bounds.top, 0, reason: preset.id);
          expect(bounds.bottom, size.height, reason: preset.id);
        } else {
          expect(bounds.height, 0, reason: preset.id);
          expect(bounds.top, size.height / 2, reason: preset.id);
          expect(bounds.left, 0, reason: preset.id);
          expect(bounds.right, size.width, reason: preset.id);
        }
      }
      // Only foldables carry display features.
      expect(
        DevicePresets.all
            .where((p) => p.kind != DeviceKind.foldable)
            .expand((p) => p.displayFeatures),
        isEmpty,
      );
    });

    test('byId finds every catalog entry', () {
      for (final preset in DevicePresets.all) {
        expect(DevicePresets.byId(preset.id), same(preset));
      }
    });

    test('byId returns null for unknown ids', () {
      expect(DevicePresets.byId('nokia-3310'), isNull);
    });

    test('key metrics match the researched catalog', () {
      expect(DevicePresets.iPhone16.portraitSize, const ui.Size(393, 852));
      expect(DevicePresets.iPhone16.devicePixelRatio, 3.0);
      expect(
        DevicePresets.iPhone16Plus.portraitSize,
        const ui.Size(430, 932),
      );
      expect(DevicePresets.iPhone16e.portraitSize, const ui.Size(390, 844));
      expect(
        DevicePresets.iPhone16e.portraitPadding,
        const EdgeInsets.only(top: 47, bottom: 34), // notch, not an island
      );
      expect(DevicePresets.iPhone16Pro.portraitSize, const ui.Size(402, 874));
      expect(DevicePresets.iPhone16Pro.devicePixelRatio, 3.0);
      expect(
        DevicePresets.iPhone16ProMax.portraitSize,
        const ui.Size(440, 956),
      );
      expect(DevicePresets.iPhone17.portraitSize, const ui.Size(402, 874));
      expect(DevicePresets.iPhone17Pro.portraitSize, const ui.Size(402, 874));
      expect(DevicePresets.iPhone17Pro.devicePixelRatio, 3.0);
      expect(DevicePresets.iPhone17e.portraitSize, const ui.Size(390, 844));
      expect(
        DevicePresets.iPhone17e.portraitPadding,
        const EdgeInsets.only(top: 47, bottom: 34), // notch, not an island
      );
      expect(DevicePresets.iPhoneAir.portraitSize, const ui.Size(420, 912));
      expect(DevicePresets.iPhoneAir.year, 2025);
      expect(DevicePresets.iPadPro13.portraitSize, const ui.Size(1032, 1376));
      expect(DevicePresets.iPadPro13.kind, DeviceKind.tablet);
      expect(DevicePresets.iPadPro11.portraitSize, const ui.Size(834, 1210));
      expect(DevicePresets.iPadAir13.portraitSize, const ui.Size(1024, 1366));
      expect(DevicePresets.iPadAir11.portraitSize, const ui.Size(820, 1180));
      expect(DevicePresets.iPadAir11.year, 2025);
      expect(DevicePresets.pixel9.portraitSize, const ui.Size(411.43, 923.43));
      expect(DevicePresets.pixel9.devicePixelRatio, 2.625);
      expect(DevicePresets.pixel10.portraitSize, const ui.Size(411.43, 923.43));
      expect(DevicePresets.pixel10.year, 2025);
      expect(DevicePresets.galaxyS24.portraitSize, const ui.Size(360, 780));
      expect(DevicePresets.galaxyS24.devicePixelRatio, 3.0);
      expect(DevicePresets.galaxyS25.portraitSize, const ui.Size(360, 780));
      expect(DevicePresets.galaxyS25.year, 2025);
      expect(
        DevicePresets.galaxyTabS10Plus.portraitSize,
        const ui.Size(876, 1400),
      );
      expect(DevicePresets.galaxyTabS10Plus.kind, DeviceKind.tablet);
      expect(
        DevicePresets.galaxyTabS11.portraitSize,
        const ui.Size(800, 1280),
      );
      expect(DevicePresets.galaxyTabS11.kind, DeviceKind.tablet);
      expect(
        DevicePresets.smallDesktopWindow.portraitSize,
        const ui.Size(1024, 640),
      );
      expect(DevicePresets.smallDesktopWindow.devicePixelRatio, 1.0);
      expect(
        DevicePresets.largeDesktopWindow.portraitSize,
        const ui.Size(1920, 1080),
      );
      expect(DevicePresets.largeDesktopWindow.devicePixelRatio, 2.0);
      expect(DevicePresets.largeDesktopWindow.kind, DeviceKind.desktop);
    });
  });

  group('DevicePreset.resolve portrait', () {
    test('produces a metrics-only simulation with presetId set', () {
      final sim = DevicePresets.iPhone16Pro.resolve();
      expect(sim.presetId, 'apple-iphone-16-pro');
      expect(sim.orientation, Orientation.portrait);
      expect(sim.screenSize, const ui.Size(402, 874));
      expect(sim.devicePixelRatio, 3.0);
      expect(sim.padding, const EdgeInsets.only(top: 62, bottom: 34));
      expect(sim.viewPadding, sim.padding); // defaults to padding
      expect(sim.systemGestureInsets, EdgeInsets.zero);
      expect(sim.displayFeatures, isNull);
      // Non-metric fields stay unset.
      expect(sim.locales, isNull);
      expect(sim.platformBrightness, isNull);
      expect(sim.textScaleFactor, isNull);
      expect(sim.accessibility, isNull);
      expect(sim.targetPlatform, isNull);
      expect(sim.simulatesMetrics, isTrue);
    });
  });

  group('DevicePreset.resolve landscape', () {
    test('swaps screen dimensions', () {
      final sim = DevicePresets.iPhone16Pro.resolve(
        orientation: Orientation.landscape,
      );
      expect(sim.orientation, Orientation.landscape);
      expect(sim.screenSize, const ui.Size(874, 402));
    });

    test('uses explicit landscape safe areas when provided', () {
      final sim = DevicePresets.iPhone16.resolve(
        orientation: Orientation.landscape,
      );
      expect(
        sim.padding,
        const EdgeInsets.only(left: 59, right: 59, bottom: 21),
      );
      expect(sim.viewPadding, sim.padding);
    });

    test('explicit zero landscape safe areas stay zero (status bar hidden '
        'in landscape)', () {
      const preset = DevicePreset(
        id: 'custom-home-button',
        name: 'Custom Home-Button Phone',
        platform: TargetPlatform.iOS,
        portraitSize: ui.Size(375, 667),
        devicePixelRatio: 2.0,
        portraitPadding: EdgeInsets.only(top: 20),
        landscapePadding: EdgeInsets.zero,
        landscapeViewPadding: EdgeInsets.zero,
      );
      final sim = preset.resolve(orientation: Orientation.landscape);
      expect(sim.screenSize, const ui.Size(667, 375));
      expect(sim.padding, EdgeInsets.zero);
      expect(sim.viewPadding, EdgeInsets.zero);
    });

    test('derives landscape by the rotation rule when no explicit value', () {
      const preset = DevicePreset(
        id: 'custom-notch',
        name: 'Custom Notch Phone',
        platform: TargetPlatform.android,
        portraitSize: ui.Size(400, 800),
        devicePixelRatio: 2.0,
        portraitPadding: EdgeInsets.only(top: 44, bottom: 34),
      );
      final sim = preset.resolve(orientation: Orientation.landscape);
      // Rotation rule: left = right = portrait.top, bottom kept, top = 0.
      expect(
        sim.padding,
        const EdgeInsets.only(left: 44, right: 44, bottom: 34),
      );
      expect(
        sim.viewPadding,
        const EdgeInsets.only(left: 44, right: 44, bottom: 34),
      );
      expect(sim.screenSize, const ui.Size(800, 400));
    });

    test('display features rotate with the screen (foldable preset)', () {
      const preset = DevicePreset(
        id: 'custom-fold',
        name: 'Custom Foldable',
        platform: TargetPlatform.android,
        portraitSize: ui.Size(800, 1104),
        devicePixelRatio: 2.0,
        kind: DeviceKind.foldable,
        displayFeatures: [
          // Vertical hinge splitting the portrait screen down the middle.
          SimulatedDisplayFeature(
            bounds: ui.Rect.fromLTRB(390, 0, 410, 1104),
            type: ui.DisplayFeatureType.hinge,
            state: ui.DisplayFeatureState.postureFlat,
          ),
        ],
      );

      final portrait = preset.resolve();
      expect(
        portrait.displayFeatures!.single.bounds,
        const ui.Rect.fromLTRB(390, 0, 410, 1104),
      );

      final landscape = preset.resolve(orientation: Orientation.landscape);
      expect(landscape.screenSize, const ui.Size(1104, 800));
      // (l, t, r, b) → (t, w − r, b, w − l) with w = 800: the hinge becomes
      // a horizontal band fully inside the 1104×800 landscape screen.
      expect(
        landscape.displayFeatures!.single.bounds,
        const ui.Rect.fromLTRB(0, 390, 1104, 410),
      );
      expect(landscape.displayFeatures!.single.type,
          ui.DisplayFeatureType.hinge);
      expect(landscape.displayFeatures!.single.state,
          ui.DisplayFeatureState.postureFlat);
    });

    test('rotatedToLandscape and rotatedToPortrait are exact inverses', () {
      const feature = SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(100, 200, 300, 900),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureHalfOpened,
      );
      // Portrait 800 wide → landscape 800 tall → back.
      final roundTripped =
          feature.rotatedToLandscape(800).rotatedToPortrait(800);
      expect(roundTripped, feature);
    });

    test('rotation rule applies to portraitViewPadding independently', () {
      const preset = DevicePreset(
        id: 'custom-vp',
        name: 'Custom ViewPadding Phone',
        platform: TargetPlatform.android,
        portraitSize: ui.Size(400, 800),
        devicePixelRatio: 2.0,
        portraitPadding: EdgeInsets.only(top: 20),
        portraitViewPadding: EdgeInsets.only(top: 30, bottom: 10),
      );
      final sim = preset.resolve(orientation: Orientation.landscape);
      expect(sim.padding, const EdgeInsets.only(left: 20, right: 20));
      expect(
        sim.viewPadding,
        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      );
    });
  });

  group('DevicePreset.rotateToLandscape', () {
    test('mirrors top to both sides and keeps the bottom', () {
      expect(
        DevicePreset.rotateToLandscape(
          const EdgeInsets.only(top: 47, bottom: 34),
        ),
        const EdgeInsets.only(left: 47, right: 47, bottom: 34),
      );
    });

    test('zero stays zero', () {
      expect(DevicePreset.rotateToLandscape(EdgeInsets.zero), EdgeInsets.zero);
    });
  });

  group('DevicePreset JSON', () {
    test('round-trips through actual JSON encoding', () {
      for (final preset in DevicePresets.all) {
        final decoded = DevicePreset.fromJson(
          jsonDecode(jsonEncode(preset.toJson())) as Map<String, Object?>,
        );
        expect(decoded, preset);
      }
    });

    test('fromJson ignores unknown keys and applies defaults', () {
      final preset = DevicePreset.fromJson(<String, Object?>{
        'id': 'x',
        'name': 'X',
        'platform': 'android',
        'portraitSize': {'width': 100, 'height': 200},
        'devicePixelRatio': 2,
        'futureKey': true,
      });
      expect(preset.portraitPadding, EdgeInsets.zero);
      expect(preset.kind, DeviceKind.phone);
      expect(preset.displayFeatures, isEmpty);
    });

    test('year survives the round trip and defaults to null', () {
      expect(DevicePresets.iPhone17Pro.toJson()['year'], 2025);
      expect(
        DevicePreset.fromJson(DevicePresets.iPhone17Pro.toJson()).year,
        2025,
      );
      expect(DevicePresets.smallDesktopWindow.toJson().containsKey('year'),
          isFalse);
    });

    test('fromJson throws on a non-integer year', () {
      expect(
        () => DevicePreset.fromJson(<String, Object?>{
          'id': 'x',
          'name': 'X',
          'platform': 'android',
          'portraitSize': {'width': 100, 'height': 200},
          'devicePixelRatio': 2,
          'year': '2025',
        }),
        throwsFormatException,
      );
    });

    test('fromJson throws on missing required keys', () {
      expect(
        () => DevicePreset.fromJson(<String, Object?>{'id': 'x'}),
        throwsFormatException,
      );
    });

    test('fromJson throws on unknown platform', () {
      expect(
        () => DevicePreset.fromJson(<String, Object?>{
          'id': 'x',
          'name': 'X',
          'platform': 'symbian',
          'portraitSize': {'width': 100, 'height': 200},
          'devicePixelRatio': 2,
        }),
        throwsFormatException,
      );
    });
  });
}

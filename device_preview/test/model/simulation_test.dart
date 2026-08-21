import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

DeviceSimulation buildFullSimulation() {
  return const DeviceSimulation(
    presetId: 'apple-iphone-16',
    orientation: Orientation.landscape,
    screenSize: ui.Size(667, 375),
    devicePixelRatio: 2.0,
    padding: EdgeInsets.fromLTRB(1, 2, 3, 4),
    viewPadding: EdgeInsets.fromLTRB(5, 6, 7, 8),
    systemGestureInsets: EdgeInsets.fromLTRB(9, 10, 11, 12),
    keyboardInset: 291.0,
    displayFeatures: [
      SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(0, 100, 400, 120),
        type: ui.DisplayFeatureType.hinge,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ],
    locales: [ui.Locale('fr', 'FR'), ui.Locale('en', 'US')],
    platformBrightness: ui.Brightness.dark,
    textScaleFactor: 1.3,
    accessibility: SimulatedAccessibilityFeatures(
      boldText: true,
      disableAnimations: false,
    ),
    alwaysUse24HourFormat: true,
    targetPlatform: TargetPlatform.iOS,
  );
}

void main() {
  group('DeviceSimulation JSON', () {
    test('toJson matches the documented shape', () {
      final json = buildFullSimulation().toJson();
      expect(json['presetId'], 'apple-iphone-16');
      expect(json['orientation'], 'landscape');
      expect(json['screenSize'], {'width': 667.0, 'height': 375.0});
      expect(json['devicePixelRatio'], 2.0);
      expect(json['padding'], {
        'left': 1.0,
        'top': 2.0,
        'right': 3.0,
        'bottom': 4.0,
      });
      expect(json['viewPadding'], {
        'left': 5.0,
        'top': 6.0,
        'right': 7.0,
        'bottom': 8.0,
      });
      expect(json['systemGestureInsets'], {
        'left': 9.0,
        'top': 10.0,
        'right': 11.0,
        'bottom': 12.0,
      });
      expect(json['keyboardInset'], 291.0);
      expect(json['displayFeatures'], [
        {
          'bounds': {
            'left': 0.0,
            'top': 100.0,
            'right': 400.0,
            'bottom': 120.0,
          },
          'type': 'hinge',
          'state': 'postureFlat',
        },
      ]);
      expect(json['locales'], ['fr-FR', 'en-US']);
      expect(json['platformBrightness'], 'dark');
      expect(json['textScaleFactor'], 1.3);
      expect(json['accessibility'], {
        'boldText': true,
        'disableAnimations': false,
      });
      expect(json['alwaysUse24HourFormat'], true);
      // targetPlatform serializes under the key "platform".
      expect(json['platform'], 'iOS');
      expect(json.containsKey('targetPlatform'), isFalse);
    });

    test('null fields are absent from toJson', () {
      final json = const DeviceSimulation().toJson();
      expect(json, <String, Object?>{'orientation': 'portrait'});
    });

    test('round-trips through actual JSON encoding', () {
      final simulation = buildFullSimulation();
      final decoded = DeviceSimulation.fromJson(
        jsonDecode(jsonEncode(simulation.toJson())) as Map<String, Object?>,
      );
      expect(decoded, simulation);
    });

    test('empty simulation round-trips', () {
      const simulation = DeviceSimulation();
      expect(DeviceSimulation.fromJson(simulation.toJson()), simulation);
    });

    test('fromJson ignores unknown keys', () {
      final decoded = DeviceSimulation.fromJson(<String, Object?>{
        'devicePixelRatio': 3,
        'someFutureKey': 'whatever',
        'anotherOne': {'nested': true},
      });
      expect(decoded.devicePixelRatio, 3.0);
      expect(decoded.screenSize, isNull);
    });

    test('fromJson accepts integer numbers for double fields', () {
      final decoded = DeviceSimulation.fromJson(<String, Object?>{
        'screenSize': {'width': 375, 'height': 667},
        'textScaleFactor': 2,
      });
      expect(decoded.screenSize, const ui.Size(375, 667));
      expect(decoded.textScaleFactor, 2.0);
    });

    group('fromJson throws FormatException on malformed values', () {
      final malformed = <String, Map<String, Object?>>{
        'screenSize not a map': {'screenSize': 'foo'},
        'screenSize missing height': {
          'screenSize': {'width': 100},
        },
        'devicePixelRatio not a number': {'devicePixelRatio': 'three'},
        'padding not a map': {'padding': 12},
        'orientation unknown': {'orientation': 'diagonal'},
        'platformBrightness unknown': {'platformBrightness': 'purple'},
        'platform unknown': {'platform': 'BeOS'},
        'locales not a list': {'locales': 'fr-FR'},
        'locale not a string': {
          'locales': [42],
        },
        'locale empty tag': {
          'locales': [''],
        },
        'accessibility flag not a bool': {
          'accessibility': {'boldText': 'yes'},
        },
        'alwaysUse24HourFormat not a bool': {'alwaysUse24HourFormat': 1},
        'displayFeatures bad type': {
          'displayFeatures': [
            {
              'bounds': {'left': 0, 'top': 0, 'right': 1, 'bottom': 1},
              'type': 'teleporter',
              'state': 'postureFlat',
            },
          ],
        },
      };

      malformed.forEach((description, json) {
        test(description, () {
          expect(() => DeviceSimulation.fromJson(json), throwsFormatException);
        });
      });
    });

    test('fromJson parses script subtags in locales', () {
      final decoded = DeviceSimulation.fromJson(<String, Object?>{
        'locales': ['zh-Hans-CN', 'en'],
      });
      expect(
        decoded.locales![0],
        const ui.Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hans',
          countryCode: 'CN',
        ),
      );
      expect(decoded.locales![1], const ui.Locale('en'));
    });
  });

  group('DeviceSimulation copyWith sentinel semantics', () {
    const base = DeviceSimulation(
      textScaleFactor: 1.5,
      platformBrightness: ui.Brightness.dark,
    );

    test('omitting a parameter keeps the current value', () {
      final copy = base.copyWith(devicePixelRatio: 3.0);
      expect(copy.textScaleFactor, 1.5);
      expect(copy.platformBrightness, ui.Brightness.dark);
      expect(copy.devicePixelRatio, 3.0);
    });

    test('passing a value sets it', () {
      final copy = base.copyWith(textScaleFactor: 2.0);
      expect(copy.textScaleFactor, 2.0);
    });

    test('int literals are accepted for the double fields', () {
      final copy = base.copyWith(
        textScaleFactor: 2,
        devicePixelRatio: 3,
        keyboardInset: 291,
      );
      expect(copy.textScaleFactor, 2.0);
      expect(copy.devicePixelRatio, 3.0);
      expect(copy.keyboardInset, 291.0);
    });

    test('passing null explicitly CLEARS the override', () {
      final copy = base.copyWith(textScaleFactor: null);
      expect(copy.textScaleFactor, isNull);
      expect(copy.platformBrightness, ui.Brightness.dark); // untouched
    });

    test('clearing every field yields an empty simulation', () {
      final cleared = buildFullSimulation().copyWith(
        presetId: null,
        screenSize: null,
        devicePixelRatio: null,
        padding: null,
        viewPadding: null,
        systemGestureInsets: null,
        keyboardInset: null,
        displayFeatures: null,
        locales: null,
        platformBrightness: null,
        textScaleFactor: null,
        accessibility: null,
        alwaysUse24HourFormat: null,
        targetPlatform: null,
      );
      expect(cleared.isEmpty, isTrue);
    });

    test('orientation is non-nullable and kept when omitted', () {
      final rotated = base.copyWith(orientation: Orientation.landscape);
      expect(rotated.orientation, Orientation.landscape);
      expect(rotated.copyWith().orientation, Orientation.landscape);
    });
  });

  group('DeviceSimulation flags', () {
    test('isEmpty is true only when all overridable fields are null', () {
      expect(const DeviceSimulation().isEmpty, isTrue);
      expect(
        const DeviceSimulation(orientation: Orientation.landscape).isEmpty,
        isTrue,
      );
      expect(const DeviceSimulation(textScaleFactor: 1.0).isEmpty, isFalse);
      expect(buildFullSimulation().isEmpty, isFalse);
    });

    test('simulatesMetrics tracks screenSize', () {
      expect(const DeviceSimulation().simulatesMetrics, isFalse);
      expect(
        const DeviceSimulation(devicePixelRatio: 2.0).simulatesMetrics,
        isFalse,
      );
      expect(
        const DeviceSimulation(screenSize: ui.Size(100, 100)).simulatesMetrics,
        isTrue,
      );
    });
  });

  group('DeviceSimulation equality', () {
    test('identical field values are equal with equal hashCodes', () {
      final a = buildFullSimulation();
      final b = buildFullSimulation();
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('list fields use deep equality', () {
      const a = DeviceSimulation(locales: [ui.Locale('en', 'US')]);
      final b = DeviceSimulation(locales: [const ui.Locale('en', 'US')]);
      expect(a, b);
    });

    test('differing fields are unequal', () {
      final a = buildFullSimulation();
      expect(a, isNot(a.copyWith(textScaleFactor: 9.9)));
      expect(a, isNot(a.copyWith(orientation: Orientation.portrait)));
      expect(a, isNot(a.copyWith(targetPlatform: TargetPlatform.android)));
    });

    test('toString lists non-null fields only', () {
      const s = DeviceSimulation(textScaleFactor: 1.5);
      expect(s.toString(), contains('textScaleFactor: 1.5'));
      expect(s.toString(), isNot(contains('padding')));
    });
  });

  group('SimulatedAccessibilityFeatures', () {
    test('JSON round trip, null flags absent', () {
      const features = SimulatedAccessibilityFeatures(
        boldText: true,
        highContrast: false,
      );
      final json = features.toJson();
      expect(json, {'boldText': true, 'highContrast': false});
      expect(SimulatedAccessibilityFeatures.fromJson(json), features);
    });

    test('fromJson ignores unknown keys', () {
      final features = SimulatedAccessibilityFeatures.fromJson({
        'boldText': true,
        'futureFlag': true,
      });
      expect(features, const SimulatedAccessibilityFeatures(boldText: true));
    });

    test('copyWith sentinel: set, clear, keep', () {
      const base = SimulatedAccessibilityFeatures(
        boldText: true,
        reduceMotion: false,
      );
      expect(base.copyWith(invertColors: true).boldText, isTrue);
      expect(base.copyWith(boldText: null).boldText, isNull);
      expect(base.copyWith(boldText: null).reduceMotion, isFalse);
      expect(base.copyWith(boldText: false).boldText, isFalse);
    });

    test('equality and hashCode', () {
      const a = SimulatedAccessibilityFeatures(disableAnimations: true);
      const b = SimulatedAccessibilityFeatures(disableAnimations: true);
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(const SimulatedAccessibilityFeatures()));
    });
  });

  group('SimulatedDisplayFeature', () {
    test('JSON round trip', () {
      const feature = SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(10, 20, 30, 40),
        type: ui.DisplayFeatureType.cutout,
        state: ui.DisplayFeatureState.unknown,
      );
      expect(feature.toJson(), {
        'bounds': {'left': 10.0, 'top': 20.0, 'right': 30.0, 'bottom': 40.0},
        'type': 'cutout',
        'state': 'unknown',
      });
      expect(SimulatedDisplayFeature.fromJson(feature.toJson()), feature);
    });

    test('fromJson throws on missing bounds', () {
      expect(
        () => SimulatedDisplayFeature.fromJson({
          'type': 'hinge',
          'state': 'postureFlat',
        }),
        throwsFormatException,
      );
    });
  });
}

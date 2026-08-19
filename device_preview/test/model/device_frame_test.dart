import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const String kBody =
    '<svg viewBox="0 0 120 220">'
    '<rect width="120" height="220" rx="12" fill="#101010"/>'
    '</svg>';

const DeviceFrame kFrame = DeviceFrame(
  size: ui.Size(120, 220),
  screenOffset: ui.Offset(10, 10),
  screenPath: 'M0,0 H100 V200 H0 Z',
  body: kBody,
);

void main() {
  group('json', () {
    test('round-trips', () {
      final Map<String, Object?> json = kFrame.toJson();
      expect(DeviceFrame.fromJson(json), kFrame);
      // And survives an encode/decode cycle over the wire.
      expect(
        DeviceFrame.fromJson(
          Map<String, Object?>.from(jsonDecode(jsonEncode(json)) as Map),
        ),
        kFrame,
      );
    });

    test('only the size is required', () {
      final DeviceFrame frame = DeviceFrame.fromJson(<String, Object?>{
        'size': <String, Object?>{'width': 10, 'height': 20},
      });
      expect(frame.size, const ui.Size(10, 20));
      expect(frame.screenOffset, ui.Offset.zero);
      expect(frame.screenPath, isEmpty);
      expect(frame.body, isEmpty);
      expect(frame.isEmpty, isTrue);
      // Empty artwork and a zero offset stay out of the encoded form.
      expect(frame.toJson().keys, <String>['size']);
    });

    test('the body may be authored as an array of lines', () {
      final DeviceFrame frame = DeviceFrame.fromJson(<String, Object?>{
        'size': <String, Object?>{'width': 10, 'height': 20},
        'body': <Object?>['<svg viewBox="0 0 10 20">', '</svg>'],
      });
      expect(frame.body, '<svg viewBox="0 0 10 20">\n</svg>');
    });

    test('malformed values throw', () {
      expect(
        () => DeviceFrame.fromJson(const <String, Object?>{}),
        throwsFormatException,
      );
      expect(
        () => DeviceFrame.fromJson(const <String, Object?>{
          'size': <String, Object?>{'width': 10, 'height': 20},
          'body': 42,
        }),
        throwsFormatException,
      );
    });
  });

  group('bodyBounds', () {
    test('portrait places the body at minus the screen offset', () {
      expect(
        kFrame.bodyBounds(const ui.Size(100, 200), Orientation.portrait),
        const ui.Rect.fromLTRB(-10, -10, 110, 210),
      );
    });

    test('landscape rotates the body a quarter turn', () {
      // Landscape screen is (200, 100); the portrait width is 100.
      final ui.Rect bounds = kFrame.bodyBounds(
        const ui.Size(200, 100),
        Orientation.landscape,
      );
      // Portrait (-10, -10, 110, 210) → (top, W-right, bottom, W-left).
      expect(bounds, const ui.Rect.fromLTRB(-10, -10, 210, 110));
    });

    test('the rotation matches the display feature rotation', () {
      const SimulatedDisplayFeature feature = SimulatedDisplayFeature(
        bounds: ui.Rect.fromLTRB(-10, -10, 110, 210),
        type: ui.DisplayFeatureType.hinge,
        state: ui.DisplayFeatureState.unknown,
      );
      expect(
        feature.rotatedToLandscape(100).bounds,
        kFrame.bodyBounds(const ui.Size(200, 100), Orientation.landscape),
      );
    });
  });

  group('DeviceSimulation.contentBounds', () {
    test('is the screen rectangle without a frame', () {
      const DeviceSimulation simulation = DeviceSimulation(
        screenSize: ui.Size(100, 200),
      );
      expect(simulation.contentBounds, const ui.Rect.fromLTRB(0, 0, 100, 200));
    });

    test('grows to the body when a frame is simulated', () {
      const DeviceSimulation simulation = DeviceSimulation(
        screenSize: ui.Size(100, 200),
        frame: kFrame,
      );
      expect(simulation.contentBounds, const ui.Rect.fromLTRB(-10, -10, 110, 210));
    });

    test('follows the orientation', () {
      const DeviceSimulation simulation = DeviceSimulation(
        orientation: Orientation.landscape,
        screenSize: ui.Size(200, 100),
        frame: kFrame,
      );
      expect(simulation.contentBounds, const ui.Rect.fromLTRB(-10, -10, 210, 110));
    });

    test('is empty while passing through', () {
      expect(const DeviceSimulation().contentBounds, ui.Rect.zero);
    });
  });

  group('simulation integration', () {
    test('the frame round-trips through the simulation JSON', () {
      const DeviceSimulation simulation = DeviceSimulation(
        screenSize: ui.Size(100, 200),
        frame: kFrame,
      );
      expect(
        DeviceSimulation.fromJson(simulation.toJson()).frame,
        kFrame,
      );
      expect(simulation.isEmpty, isFalse);
      expect(const DeviceSimulation(frame: kFrame).isEmpty, isFalse);
    });

    test('copyWith clears the frame when passed null explicitly', () {
      const DeviceSimulation simulation = DeviceSimulation(frame: kFrame);
      expect(simulation.copyWith().frame, kFrame);
      expect(simulation.copyWith(frame: null).frame, isNull);
    });

    test('frames participate in equality', () {
      expect(
        const DeviceSimulation(frame: kFrame),
        const DeviceSimulation(frame: kFrame),
      );
      expect(
        const DeviceSimulation(frame: kFrame),
        isNot(const DeviceSimulation()),
      );
      expect(
        const DeviceSimulation(frame: kFrame).hashCode,
        const DeviceSimulation(frame: kFrame).hashCode,
      );
    });
  });

  group('DevicePreset', () {
    const DevicePreset preset = DevicePreset(
      id: 'test-framed',
      name: 'Framed',
      brand: 'Test',
      platform: TargetPlatform.android,
      portraitSize: ui.Size(100, 200),
      devicePixelRatio: 2,
      frame: kFrame,
    );

    test('resolves the frame into both orientations unchanged', () {
      expect(preset.resolve().frame, kFrame);
      expect(
        preset.resolve(orientation: Orientation.landscape).frame,
        kFrame,
      );
    });

    test('brand and frame round-trip through JSON', () {
      final DevicePreset decoded = DevicePreset.fromJson(preset.toJson());
      expect(decoded, preset);
      expect(decoded.brand, 'Test');
      expect(decoded.frame, kFrame);
    });

    test('built-in presets carry a frame and a brand', () {
      for (final DevicePreset builtIn in DevicePresets.all) {
        expect(builtIn.frame, isNotNull, reason: builtIn.id);
        expect(builtIn.brand, isNotNull, reason: builtIn.id);
      }
    });
  });
}

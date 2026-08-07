import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
// Internal implementation detail, deliberately NOT exported from the barrel.
import 'package:device_preview/src/model/pointer_rewrite.dart';
import 'package:flutter_test/flutter_test.dart';

/// A fully populated datum with a distinct value in every field, so that any
/// dropped field shows up in the assertions below.
ui.PointerData buildDatum({ui.PointerDataRespondCallback? onRespond}) {
  return ui.PointerData(
    viewId: 7,
    embedderId: 11,
    timeStamp: const Duration(milliseconds: 1234),
    change: ui.PointerChange.move,
    kind: ui.PointerDeviceKind.stylus,
    signalKind: ui.PointerSignalKind.scroll,
    device: 3,
    pointerIdentifier: 99,
    physicalX: 300.0,
    physicalY: 480.0,
    physicalDeltaX: 12.0,
    physicalDeltaY: -8.0,
    buttons: 2,
    obscured: true,
    synthesized: true,
    pressure: 0.4,
    pressureMin: 0.1,
    pressureMax: 1.5,
    distance: 0.3,
    distanceMax: 2.5,
    size: 0.15,
    radiusMajor: 10.0,
    radiusMinor: 6.0,
    radiusMin: 1.0,
    radiusMax: 20.0,
    orientation: 0.7,
    tilt: 0.9,
    platformData: 21,
    scrollDeltaX: 4.0,
    scrollDeltaY: -6.0,
    panX: 30.0,
    panY: 40.0,
    panDeltaX: 3.0,
    panDeltaY: -4.0,
    scale: 1.2,
    rotation: 0.5,
    onRespond: onRespond,
  );
}

void main() {
  group('rewritePointerData', () {
    test('identity fast path returns the exact same object', () {
      final datum = buildDatum();
      final result = rewritePointerData(datum, FitTransform.identity, 2.0, 2.0);
      expect(identical(result, datum), isTrue);
    });

    test('identity fit with differing DPRs still rewrites', () {
      final datum = buildDatum();
      final result = rewritePointerData(datum, FitTransform.identity, 2.0, 3.0);
      expect(identical(result, datum), isFalse);
      // realLogical = 300/2 = 150 → sim = 150 → physical = 150 * 3 = 450.
      expect(result.physicalX, closeTo(450.0, 1e-9));
    });

    test('non-identity fit with equal DPRs still rewrites', () {
      final datum = buildDatum();
      const fit = FitTransform(scale: 0.5, offset: ui.Offset.zero);
      final result = rewritePointerData(datum, fit, 2.0, 2.0);
      expect(identical(result, datum), isFalse);
    });

    group('full rewrite', () {
      const realDpr = 2.0;
      const simDpr = 3.0;
      const fit = FitTransform(scale: 0.5, offset: ui.Offset(10, 20));
      const k = simDpr / (realDpr * 0.5); // simDpr / (realDpr × fit.scale) = 3

      late ui.PointerData datum;
      late ui.PointerData result;

      setUp(() {
        datum = buildDatum();
        result = rewritePointerData(datum, fit, realDpr, simDpr);
      });

      test('positions map real-physical -> simulated-physical', () {
        // realLogical = (300, 480) / 2 = (150, 240)
        // simLogical = ((150, 240) - (10, 20)) / 0.5 = (280, 440)
        // physical' = (280, 440) * 3 = (840, 1320)
        expect(result.physicalX, closeTo(840.0, 1e-9));
        expect(result.physicalY, closeTo(1320.0, 1e-9));
      });

      test('physicalDelta scales by k', () {
        expect(result.physicalDeltaX, closeTo(12.0 * k, 1e-9));
        expect(result.physicalDeltaY, closeTo(-8.0 * k, 1e-9));
      });

      test('radii scale by k', () {
        expect(result.radiusMajor, closeTo(10.0 * k, 1e-9));
        expect(result.radiusMinor, closeTo(6.0 * k, 1e-9));
        expect(result.radiusMin, closeTo(1.0 * k, 1e-9));
        expect(result.radiusMax, closeTo(20.0 * k, 1e-9));
      });

      test('pan and panDelta scale by k', () {
        expect(result.panX, closeTo(30.0 * k, 1e-9));
        expect(result.panY, closeTo(40.0 * k, 1e-9));
        expect(result.panDeltaX, closeTo(3.0 * k, 1e-9));
        expect(result.panDeltaY, closeTo(-4.0 * k, 1e-9));
      });

      test('scrollDelta scales by k', () {
        expect(result.scrollDeltaX, closeTo(4.0 * k, 1e-9));
        expect(result.scrollDeltaY, closeTo(-6.0 * k, 1e-9));
      });

      test('viewId is untouched', () {
        expect(result.viewId, 7);
      });

      test('all pass-through fields are copied faithfully', () {
        expect(result.embedderId, 11);
        expect(result.timeStamp, const Duration(milliseconds: 1234));
        expect(result.change, ui.PointerChange.move);
        expect(result.kind, ui.PointerDeviceKind.stylus);
        expect(result.signalKind, ui.PointerSignalKind.scroll);
        expect(result.device, 3);
        expect(result.pointerIdentifier, 99);
        expect(result.buttons, 2);
        expect(result.obscured, isTrue);
        expect(result.synthesized, isTrue);
        expect(result.pressure, 0.4);
        expect(result.pressureMin, 0.1);
        expect(result.pressureMax, 1.5);
        expect(result.distance, 0.3);
        expect(result.distanceMax, 2.5);
        expect(result.size, 0.15);
        expect(result.orientation, 0.7);
        expect(result.tilt, 0.9);
        expect(result.platformData, 21);
        expect(result.scale, 1.2);
        expect(result.rotation, 0.5);
      });
    });

    test('respond() on the rewritten datum forwards to the original', () {
      bool? received;
      final datum = buildDatum(
        onRespond: ({bool allowPlatformDefault = false}) {
          received = allowPlatformDefault;
        },
      );
      const fit = FitTransform(scale: 0.5, offset: ui.Offset.zero);
      final result = rewritePointerData(datum, fit, 2.0, 3.0);
      result.respond(allowPlatformDefault: true);
      expect(received, isTrue);
    });

    test('letterbox positions map to out-of-bounds simulated coordinates', () {
      // Simulated 100x100 screen centered in a 300x100 real screen at
      // scale 1 → letterbox 100px on each side.
      const fit = FitTransform(scale: 1.0, offset: ui.Offset(100, 0));
      final datum = ui.PointerData(physicalX: 50.0, physicalY: 50.0);
      final result = rewritePointerData(datum, fit, 1.0, 1.0);
      expect(result.physicalX, -50.0); // naturally misses hit testing
    });
  });
}

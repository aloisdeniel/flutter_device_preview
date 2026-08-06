import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/binding/preview_values.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  group('PreviewViewPadding', () {
    test('stores raw physical values', () {
      const PreviewViewPadding padding = PreviewViewPadding(
        left: 1,
        top: 2,
        right: 3,
        bottom: 4,
      );
      expect(padding.left, 1);
      expect(padding.top, 2);
      expect(padding.right, 3);
      expect(padding.bottom, 4);
    });

    test('fromEdgeInsets converts logical to physical', () {
      final PreviewViewPadding padding = PreviewViewPadding.fromEdgeInsets(
        const EdgeInsets.fromLTRB(1, 2, 3, 4),
        2.5,
      );
      expect(padding.left, 2.5);
      expect(padding.top, 5);
      expect(padding.right, 7.5);
      expect(padding.bottom, 10);
    });

    test('zero has zeros for every edge', () {
      expect(PreviewViewPadding.zero.left, 0);
      expect(PreviewViewPadding.zero.top, 0);
      expect(PreviewViewPadding.zero.right, 0);
      expect(PreviewViewPadding.zero.bottom, 0);
    });

    test('equality and hashCode', () {
      const PreviewViewPadding a = PreviewViewPadding(
        left: 1,
        top: 2,
        right: 3,
        bottom: 4,
      );
      const PreviewViewPadding b = PreviewViewPadding(
        left: 1,
        top: 2,
        right: 3,
        bottom: 4,
      );
      const PreviewViewPadding c = PreviewViewPadding(
        left: 9,
        top: 2,
        right: 3,
        bottom: 4,
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });
  });

  group('PreviewAccessibilityFeatures', () {
    test('null simulated delegates every flag to the host', () {
      final StubAccessibilityFeatures host = StubAccessibilityFeatures(
        accessibleNavigation: true,
        invertColors: true,
        disableAnimations: true,
        boldText: true,
        reduceMotion: true,
        highContrast: true,
        onOffSwitchLabels: true,
        supportsAnnounce: false,
        autoPlayAnimatedImages: false,
        autoPlayVideos: false,
        deterministicCursor: true,
      );
      final PreviewAccessibilityFeatures merged = PreviewAccessibilityFeatures(
        host: host,
      );
      expect(merged.accessibleNavigation, isTrue);
      expect(merged.invertColors, isTrue);
      expect(merged.disableAnimations, isTrue);
      expect(merged.boldText, isTrue);
      expect(merged.reduceMotion, isTrue);
      expect(merged.highContrast, isTrue);
      expect(merged.onOffSwitchLabels, isTrue);
      expect(merged.supportsAnnounce, isFalse);
      expect(merged.autoPlayAnimatedImages, isFalse);
      expect(merged.autoPlayVideos, isFalse);
      expect(merged.deterministicCursor, isTrue);
    });

    test('non-null flags win, null flags fall through live', () {
      final StubAccessibilityFeatures host = StubAccessibilityFeatures(
        boldText: false,
        invertColors: true,
        reduceMotion: false,
      );
      final PreviewAccessibilityFeatures merged = PreviewAccessibilityFeatures(
        host: host,
        simulated: const SimulatedAccessibilityFeatures(
          boldText: true, // force on
          invertColors: false, // force off
          // reduceMotion left null: live from host
        ),
      );
      expect(merged.boldText, isTrue);
      expect(merged.invertColors, isFalse);
      expect(merged.reduceMotion, isFalse);

      // Live merge: a host change for a null flag is visible immediately.
      host.reduceMotion = true;
      expect(merged.reduceMotion, isTrue);
      // ...but forced flags stay forced.
      host.boldText = false;
      expect(merged.boldText, isTrue);
    });

    test('engine-only flags always delegate to the host', () {
      final StubAccessibilityFeatures host = StubAccessibilityFeatures(
        supportsAnnounce: false,
        autoPlayAnimatedImages: false,
        autoPlayVideos: true,
        deterministicCursor: true,
      );
      final PreviewAccessibilityFeatures merged = PreviewAccessibilityFeatures(
        host: host,
        simulated: const SimulatedAccessibilityFeatures(boldText: true),
      );
      expect(merged.supportsAnnounce, isFalse);
      expect(merged.autoPlayAnimatedImages, isFalse);
      expect(merged.autoPlayVideos, isTrue);
      expect(merged.deterministicCursor, isTrue);
    });

    test('equality and hashCode', () {
      final StubAccessibilityFeatures host = StubAccessibilityFeatures();
      final PreviewAccessibilityFeatures a = PreviewAccessibilityFeatures(
        host: host,
        simulated: const SimulatedAccessibilityFeatures(boldText: true),
      );
      final PreviewAccessibilityFeatures b = PreviewAccessibilityFeatures(
        host: host,
        simulated: const SimulatedAccessibilityFeatures(boldText: true),
      );
      final PreviewAccessibilityFeatures c = PreviewAccessibilityFeatures(
        host: host,
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });
  });
}

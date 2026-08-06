import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/binding/preview_flutter_view.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/binding/preview_values.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  late PreviewState state;
  late FakeFlutterView host;
  late FakePlatformDispatcher hostDispatcher;
  late FakePlatformDispatcher wrapperDispatcherStandIn;
  late PreviewFlutterView view;

  setUp(() {
    state = PreviewState();
    hostDispatcher = FakePlatformDispatcher();
    host = hostDispatcher.implicitView!;
    // Stand-in for the wrapper dispatcher: the view must return exactly the
    // dispatcher instance it was constructed with.
    wrapperDispatcherStandIn = FakePlatformDispatcher();
    view = PreviewFlutterView(
      hostView: host,
      platformDispatcher: wrapperDispatcherStandIn,
      state: state,
    );
  });

  DeviceSimulation metricSimulation({
    ui.Size screenSize = const ui.Size(200, 400),
    double? devicePixelRatio = 2.0,
    EdgeInsets? padding,
    EdgeInsets? viewPadding,
    EdgeInsets? systemGestureInsets,
    List<SimulatedDisplayFeature>? displayFeatures,
  }) => DeviceSimulation(
    screenSize: screenSize,
    devicePixelRatio: devicePixelRatio,
    padding: padding,
    viewPadding: viewPadding,
    systemGestureInsets: systemGestureInsets,
    displayFeatures: displayFeatures,
  );

  group('pass-through (no simulation)', () {
    test('per-member checklist: every member delegates to the host', () {
      // Identity.
      expect(view.viewId, host.viewId);
      expect(view.platformDispatcher, same(wrapperDispatcherStandIn));
      expect(view.display, same(host.display));
      // Metrics.
      expect(view.devicePixelRatio, host.devicePixelRatio);
      expect(view.physicalSize, host.physicalSize);
      expect(view.physicalConstraints, same(host.physicalConstraints));
      expect(view.padding, same(host.padding));
      expect(view.viewPadding, same(host.viewPadding));
      expect(view.viewInsets, same(host.viewInsets));
      expect(view.systemGestureInsets, same(host.systemGestureInsets));
      expect(view.gestureSettings, same(host.gestureSettings));
      expect(view.displayFeatures, same(host.displayFeatures));
      expect(view.displayCornerRadii, same(host.displayCornerRadii));
    });

    test('render forwards scene and size unchanged', () {
      view.render(_FakeScene(), size: const ui.Size(10, 20));
      expect(host.calls, contains('render'));
      expect(host.lastRenderedSize, const ui.Size(10, 20));
      view.render(_FakeScene());
      expect(host.lastRenderedSize, isNull);
    });

    test('a lone devicePixelRatio override without screenSize is inert', () {
      state.simulation = const DeviceSimulation(devicePixelRatio: 2.0);
      expect(view.devicePixelRatio, host.devicePixelRatio);
      expect(view.physicalSize, host.physicalSize);
      expect(view.displayCornerRadii, same(host.displayCornerRadii));
    });
  });

  group('metric simulation', () {
    test('devicePixelRatio and physicalSize', () {
      state.simulation = metricSimulation();
      expect(view.devicePixelRatio, 2.0);
      expect(view.physicalSize, const ui.Size(400, 800));
    });

    test('devicePixelRatio falls back to the host ratio when null', () {
      state.simulation = metricSimulation(devicePixelRatio: null);
      expect(view.devicePixelRatio, host.devicePixelRatio);
      expect(
        view.physicalSize,
        ui.Size(200 * host.devicePixelRatio, 400 * host.devicePixelRatio),
      );
    });

    test('physicalConstraints are tight at the simulated physical size', () {
      state.simulation = metricSimulation();
      final ui.ViewConstraints constraints = view.physicalConstraints;
      expect(constraints.minWidth, 400);
      expect(constraints.maxWidth, 400);
      expect(constraints.minHeight, 800);
      expect(constraints.maxHeight, 800);
    });

    test('padding and viewPadding are config logical × simulated ratio', () {
      state.simulation = metricSimulation(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
      );
      expect(
        view.padding,
        const PreviewViewPadding(left: 0, top: 40, right: 0, bottom: 20),
      );
      // viewPadding defaults to padding.
      expect(
        view.viewPadding,
        const PreviewViewPadding(left: 0, top: 40, right: 0, bottom: 20),
      );
    });

    test('explicit viewPadding wins over padding', () {
      state.simulation = metricSimulation(
        padding: const EdgeInsets.only(top: 20),
        viewPadding: const EdgeInsets.only(top: 30),
      );
      expect(view.viewPadding.top, 60);
      expect(view.padding.top, 40);
    });

    test('padding defaults to zero while simulating', () {
      state.simulation = metricSimulation();
      expect(view.padding, PreviewViewPadding.zero);
      expect(view.viewPadding, PreviewViewPadding.zero);
    });

    test('systemGestureInsets are zero while simulating if null', () {
      state.simulation = metricSimulation();
      expect(view.systemGestureInsets, PreviewViewPadding.zero);
      state.simulation = metricSimulation(
        systemGestureInsets: const EdgeInsets.only(bottom: 8),
      );
      expect(view.systemGestureInsets.bottom, 16);
    });

    test('viewInsets map the real keyboard inset into simulated space', () {
      // hostInsetPhysical=300, realDPR=3, fit.scale=0.5, simDPR=2:
      // simInsetLogical = 300 / 3 / 0.5 = 200 → 200 × 2 = 400 physical.
      host.viewInsets = const StubViewPadding(bottom: 300);
      state.simulation = metricSimulation();
      state.fit = const FitTransform(scale: 0.5, offset: ui.Offset.zero);
      expect(view.viewInsets.bottom, 400);
      expect(view.viewInsets.top, 0);
    });

    test(
      'gestureSettings rescale slop: hostSlop / realDPR / scale × simDPR',
      () {
        state.simulation = metricSimulation();
        state.fit = const FitTransform(scale: 0.5, offset: ui.Offset.zero);
        // 24 / 3 / 0.5 × 2 = 32.
        expect(view.gestureSettings.physicalTouchSlop, 32);
        expect(view.gestureSettings.physicalDoubleTapSlop, isNull);
      },
    );

    test('gestureSettings keep null slops null', () {
      host.gestureSettings = const ui.GestureSettings();
      state.simulation = metricSimulation();
      expect(view.gestureSettings.physicalTouchSlop, isNull);
    });

    test('displayFeatures come from the simulation (logical px, unscaled)', () {
      state.simulation = metricSimulation();
      expect(view.displayFeatures, isEmpty);
      state.simulation = metricSimulation(
        displayFeatures: const <SimulatedDisplayFeature>[
          SimulatedDisplayFeature(
            bounds: ui.Rect.fromLTRB(90, 0, 110, 400),
            type: ui.DisplayFeatureType.hinge,
            state: ui.DisplayFeatureState.postureFlat,
          ),
        ],
      );
      final ui.DisplayFeature feature = view.displayFeatures.single;
      expect(feature.bounds, const ui.Rect.fromLTRB(90, 0, 110, 400));
      expect(feature.type, ui.DisplayFeatureType.hinge);
      expect(feature.state, ui.DisplayFeatureState.postureFlat);
    });

    test('displayCornerRadii is null while simulating', () {
      state.simulation = metricSimulation();
      expect(view.displayCornerRadii, isNull);
    });

    test('render forces the real physical size', () {
      state.simulation = metricSimulation();
      view.render(_FakeScene(), size: const ui.Size(400, 800));
      expect(host.lastRenderedSize, host.physicalSize);
    });

    test('viewId stays the real id', () {
      state.simulation = metricSimulation();
      expect(view.viewId, host.viewId);
    });
  });

  test('updateSemantics always delegates', () {
    final _FakeSemanticsUpdate update = _FakeSemanticsUpdate();
    view.updateSemantics(update);
    expect(host.calls, contains('updateSemantics'));
    expect(host.lastSemanticsUpdate, same(update));
  });
}

class _FakeScene implements ui.Scene {
  @override
  void dispose() {}

  @override
  Future<ui.Image> toImage(int width, int height) => throw UnimplementedError();

  @override
  ui.Image toImageSync(int width, int height) => throw UnimplementedError();
}

class _FakeSemanticsUpdate implements ui.SemanticsUpdate {
  @override
  void dispose() {}
}

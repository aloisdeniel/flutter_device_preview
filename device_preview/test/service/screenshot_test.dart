// Exercises DevicePreviewScreenshot.capture against the real render tree —
// the actual toImage/PNG pipeline, output dimensions in both branches
// (pass-through and simulated metrics), and the error envelopes. The
// simulated-branch formula asserted here is `content.size × simDPR` pixels,
// matching the module's documented contract.

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:device_preview/presets.dart';
import 'package:device_preview/src/binding/preview_state.dart';
import 'package:device_preview/src/service/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_binding.dart';

void main() {
  final TestDevicePreviewBinding binding =
      TestDevicePreviewBinding.ensureInitialized();

  tearDown(() async {
    await binding.devicePreview?.reset();
  });

  RenderView renderView() => binding.renderViews.single;

  DevicePreviewScreenshot handler(PreviewState state) =>
      DevicePreviewScreenshot(
        findRenderView: renderView,
        findHostView: () => binding.platformDispatcher.implicitView,
        state: state,
      );

  Future<Map<String, Object?>> capture(
    WidgetTester tester,
    PreviewState state, {
    Map<String, String> parameters = const <String, String>{},
  }) async {
    // toImage + PNG encoding need real async.
    return (await tester.runAsync(
      () => handler(state).capture(parameters),
    ))!;
  }

  testWidgets('captures the host view when no metric simulation is active', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ColoredBox(color: Color(0xFF2266AA)));
    final Map<String, Object?> result =
        await capture(tester, PreviewState());

    expect(result['error'], isNull);
    expect(result['format'], 'png');
    final ui.FlutterView hostView =
        binding.platformDispatcher.implicitView!;
    expect(result['width'], hostView.physicalSize.width.round());
    expect(result['height'], hostView.physicalSize.height.round());
    final List<int> bytes =
        base64Decode(result['bytesBase64']! as String);
    // PNG magic number: the payload really is an encoded image.
    expect(bytes.sublist(0, 4), <int>[0x89, 0x50, 0x4E, 0x47]);
  });

  testWidgets('a simulated capture covers contentBounds at the simulated '
      'device pixel ratio', (WidgetTester tester) async {
    // A metrics-only preset (the built-in ones now carry a frame, which
    // grows the captured contentBounds to the device body).
    const DevicePreset bare = DevicePreset(
      id: 'test-bare-iphone-16',
      name: 'Bare iPhone 16',
      platform: TargetPlatform.iOS,
      portraitSize: ui.Size(393, 852),
      devicePixelRatio: 3.0,
    );
    await binding.devicePreview!.applyPreset(bare);
    await tester.pumpWidget(const ColoredBox(color: Color(0xFF2266AA)));

    // Mirror the applied simulation in the handler's state, with the fit the
    // binding computed for the real window.
    final PreviewState state = PreviewState()
      ..simulation = binding.devicePreview!.simulation
      ..fit = binding.devicePreview!.fitTransform;
    final Map<String, Object?> result = await capture(tester, state);

    expect(result['error'], isNull);
    // 393×852 logical at DPR 3 → 1179×2556 pixels, regardless of
    // the host window's size or ratio. Within one pixel: the engine ceils
    // `bounds × pixelRatio`, so float error can add a pixel.
    expect(result['width'], closeTo(1179, 1));
    expect(result['height'], closeTo(2556, 1));
  });

  testWidgets('an unparsable pixelRatio returns the invalidParams envelope', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SizedBox.expand());
    final Map<String, Object?> result = await capture(
      tester,
      PreviewState(),
      parameters: <String, String>{'pixelRatio': 'huge'},
    );
    final Map<String, Object?> error =
        (result['error']! as Map<Object?, Object?>).cast<String, Object?>();
    expect(error['code'], 'invalidParams');
  });

  testWidgets('reports unavailable when no render view is mounted', (
    WidgetTester tester,
  ) async {
    final DevicePreviewScreenshot detached = DevicePreviewScreenshot(
      findRenderView: () => null,
      findHostView: () => binding.platformDispatcher.implicitView,
      state: PreviewState(),
    );
    final Map<String, Object?> result = (await tester.runAsync(
      () => detached.capture(const <String, String>{}),
    ))!;
    final Map<String, Object?> error =
        (result['error']! as Map<Object?, Object?>).cast<String, Object?>();
    expect(error['code'], 'unavailable');
  });
}

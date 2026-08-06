import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import '../binding/preview_state.dart';
import '../model/fit_transform.dart';
import '../model/simulation.dart';

/// Optional screenshot module for `ext.device_preview.screenshot`.
///
/// Renders the root layer (an [OffsetLayer]) to a PNG. While metric
/// simulation is active the capture covers exactly the simulated screen:
///
/// * bounds = `fit.offset × realDPR & simLogical × fit.scale × realDPR`
/// * pixelRatio = `simDPR / (fit.scale × realDPR)` → exactly
///   `simLogical × simDPR` pixels.
///
/// Entirely failure-isolated: any error returns a protocol error envelope
/// and can never affect the simulation core. Advertised via
/// `capabilities.screenshot`.
class DevicePreviewScreenshot {
  /// Creates the screenshot handler.
  DevicePreviewScreenshot({
    required this.findRenderView,
    required this.findHostView,
    required this.state,
  });

  /// Locates the RenderView to capture (the one backed by the implicit
  /// view), or null when none is mounted.
  final RenderView? Function() findRenderView;

  /// Locates the real (host) implicit view, or null when unavailable.
  final ui.FlutterView? Function() findHostView;

  /// The shared simulation state.
  final PreviewState state;

  Map<String, Object?> _error(String code, String message) => <String, Object?>{
    'error': <String, Object?>{'code': code, 'message': message},
  };

  /// Handles an `ext.device_preview.screenshot` request.
  ///
  /// Accepts an optional `pixelRatio` string parameter overriding the
  /// simulated (or real) device pixel ratio used for the output resolution.
  Future<Map<String, Object?>> capture(Map<String, String> parameters) async {
    try {
      final RenderView? renderView = findRenderView();
      final ui.FlutterView? hostView = findHostView();
      if (renderView == null || hostView == null) {
        return _error('unavailable', 'No render view is mounted.');
      }
      // Reading the root layer from outside the render tree is exactly what
      // this capability-flagged module is for; the risk is isolated here.
      // ignore: invalid_use_of_protected_member
      final Layer? layer = renderView.layer;
      if (layer is! OffsetLayer) {
        return _error(
          'unavailable',
          'The root layer is not an OffsetLayer '
              '(${layer.runtimeType}); cannot capture.',
        );
      }
      final double? requestedRatio = parameters.containsKey('pixelRatio')
          ? double.tryParse(parameters['pixelRatio']!)
          : null;
      if (parameters.containsKey('pixelRatio') && requestedRatio == null) {
        return _error(
          'invalidParams',
          'Invalid "pixelRatio": ${parameters['pixelRatio']}',
        );
      }

      final double realRatio = hostView.devicePixelRatio;
      final DeviceSimulation? simulation = state.simulation;
      final Rect bounds;
      final double pixelRatio;
      if (simulation != null && simulation.simulatesMetrics) {
        final FitTransform fit = state.fit;
        final ui.Size logical = simulation.screenSize!;
        final double outputRatio =
            requestedRatio ?? (simulation.devicePixelRatio ?? realRatio);
        bounds =
            (fit.offset * realRatio) &
            Size(
              logical.width * fit.scale * realRatio,
              logical.height * fit.scale * realRatio,
            );
        pixelRatio = outputRatio / (fit.scale * realRatio);
      } else {
        bounds = Offset.zero & hostView.physicalSize;
        pixelRatio = (requestedRatio ?? realRatio) / realRatio;
      }

      final ui.Image image = await layer.toImage(
        bounds,
        pixelRatio: pixelRatio,
      );
      try {
        final ByteData? bytes = await image.toByteData(
          format: ui.ImageByteFormat.png,
        );
        if (bytes == null) {
          return _error('encoding', 'PNG encoding returned no data.');
        }
        return <String, Object?>{
          'format': 'png',
          'width': image.width,
          'height': image.height,
          'bytesBase64': base64Encode(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
          ),
        };
      } finally {
        image.dispose();
      }
    } catch (error) {
      return _error('screenshotFailed', '$error');
    }
  }
}

import 'dart:ui' as ui;

import 'fit_transform.dart';

/// Rewrites a [ui.PointerData] received in real physical coordinates into the
/// simulated device's physical coordinate space.
///
/// The framework's pointer converter divides positions by the wrapper view's
/// (simulated) device pixel ratio, so producing simulated-physical values
/// here makes hit testing, recognizers, and hover tracking receive exactly
/// the right simulated-logical positions:
///
/// ```
/// realLogical    = (physicalX, physicalY) / realDpr
/// simLogical     = (realLogical − fit.offset) / fit.scale
/// physicalX'/Y'  = simLogical × simDpr
/// k              = simDpr / (realDpr × fit.scale)
/// physicalDelta', radii, pan, panDelta, scrollDelta: × k
/// ```
///
/// [ui.PointerData.viewId] is deliberately left untouched: the real implicit
/// view id is what keys the framework's view lookup tables.
///
/// Identity fast path: when [fit] is [FitTransform.identity] and the two
/// device pixel ratios are equal, the exact same [datum] object is returned
/// with zero allocation.
ui.PointerData rewritePointerData(
  ui.PointerData datum,
  FitTransform fit,
  double realDevicePixelRatio,
  double simulatedDevicePixelRatio,
) {
  if (fit == FitTransform.identity &&
      realDevicePixelRatio == simulatedDevicePixelRatio) {
    return datum;
  }

  final ui.Offset realLogical = ui.Offset(
    datum.physicalX / realDevicePixelRatio,
    datum.physicalY / realDevicePixelRatio,
  );
  final ui.Offset simulatedLogical = fit.toSimulatedLogical(realLogical);
  final double k =
      simulatedDevicePixelRatio / (realDevicePixelRatio * fit.scale);

  return ui.PointerData(
    viewId: datum.viewId,
    embedderId: datum.embedderId,
    timeStamp: datum.timeStamp,
    change: datum.change,
    kind: datum.kind,
    signalKind: datum.signalKind,
    device: datum.device,
    pointerIdentifier: datum.pointerIdentifier,
    physicalX: simulatedLogical.dx * simulatedDevicePixelRatio,
    physicalY: simulatedLogical.dy * simulatedDevicePixelRatio,
    physicalDeltaX: datum.physicalDeltaX * k,
    physicalDeltaY: datum.physicalDeltaY * k,
    buttons: datum.buttons,
    obscured: datum.obscured,
    synthesized: datum.synthesized,
    pressure: datum.pressure,
    pressureMin: datum.pressureMin,
    pressureMax: datum.pressureMax,
    distance: datum.distance,
    distanceMax: datum.distanceMax,
    size: datum.size,
    radiusMajor: datum.radiusMajor * k,
    radiusMinor: datum.radiusMinor * k,
    radiusMin: datum.radiusMin * k,
    radiusMax: datum.radiusMax * k,
    orientation: datum.orientation,
    tilt: datum.tilt,
    platformData: datum.platformData,
    scrollDeltaX: datum.scrollDeltaX * k,
    scrollDeltaY: datum.scrollDeltaY * k,
    panX: datum.panX * k,
    panY: datum.panY * k,
    panDeltaX: datum.panDeltaX * k,
    panDeltaY: datum.panDeltaY * k,
    scale: datum.scale,
    rotation: datum.rotation,
    onRespond: ({bool allowPlatformDefault = false}) =>
        datum.respond(allowPlatformDefault: allowPlatformDefault),
  );
}

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
/// Reports [datum] as coming from a [kind] pointer instead of the host's own.
///
/// This is what lets a mouse act as a finger: relabelled events take the
/// framework's touch paths — `ScrollBehavior.dragDevices` excludes the mouse
/// on desktop and the web, so dragging a list only scrolls once the pointer
/// claims to be a touch — and `_synthesiseDownButtons` gives them the primary
/// button a touch always carries.
///
/// Returns null for events the target kind could not produce, which the
/// caller drops: a touchscreen reports nothing while nothing touches it, so
/// hovers disappear rather than arriving as impossible hovering fingers.
///
/// Pointer *signals* (the scroll wheel, trackpad zoom) keep their real kind:
/// they have no touch equivalent, and rewriting them would only break
/// wheel scrolling. Data already of the requested kind is returned untouched.
///
/// Safe mid-stream: `PointerEventConverter` is stateless, so a pointer whose
/// kind changes between two events cannot desynchronize it.
ui.PointerData? retargetPointerKind(
  ui.PointerData datum,
  ui.PointerDeviceKind kind,
) {
  if (datum.kind == kind || datum.signalKind != null &&
      datum.signalKind != ui.PointerSignalKind.none) {
    return datum;
  }
  final bool hovers =
      kind == ui.PointerDeviceKind.mouse ||
      kind == ui.PointerDeviceKind.stylus ||
      kind == ui.PointerDeviceKind.invertedStylus ||
      kind == ui.PointerDeviceKind.trackpad;
  if (!hovers && datum.change == ui.PointerChange.hover) {
    return null;
  }
  return _copyWithKind(datum, kind);
}

ui.PointerData _copyWithKind(ui.PointerData datum, ui.PointerDeviceKind kind) {
  return ui.PointerData(
    viewId: datum.viewId,
    embedderId: datum.embedderId,
    timeStamp: datum.timeStamp,
    change: datum.change,
    kind: kind,
    signalKind: datum.signalKind,
    device: datum.device,
    pointerIdentifier: datum.pointerIdentifier,
    physicalX: datum.physicalX,
    physicalY: datum.physicalY,
    physicalDeltaX: datum.physicalDeltaX,
    physicalDeltaY: datum.physicalDeltaY,
    buttons: datum.buttons,
    obscured: datum.obscured,
    synthesized: datum.synthesized,
    pressure: datum.pressure,
    pressureMin: datum.pressureMin,
    pressureMax: datum.pressureMax,
    distance: datum.distance,
    distanceMax: datum.distanceMax,
    size: datum.size,
    radiusMajor: datum.radiusMajor,
    radiusMinor: datum.radiusMinor,
    radiusMin: datum.radiusMin,
    radiusMax: datum.radiusMax,
    orientation: datum.orientation,
    tilt: datum.tilt,
    platformData: datum.platformData,
    scrollDeltaX: datum.scrollDeltaX,
    scrollDeltaY: datum.scrollDeltaY,
    panX: datum.panX,
    panY: datum.panY,
    panDeltaX: datum.panDeltaX,
    panDeltaY: datum.panDeltaY,
    scale: datum.scale,
    rotation: datum.rotation,
    onRespond: ({bool allowPlatformDefault = false}) =>
        datum.respond(allowPlatformDefault: allowPlatformDefault),
  );
}

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

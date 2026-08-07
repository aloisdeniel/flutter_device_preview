import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import 'json_utils.dart';

/// The physical appearance of a simulated device: the shape its screen is cut
/// to, and the artwork of the body drawn behind that screen.
///
/// Everything is expressed in **portrait** logical pixels, in the coordinate
/// space of the simulated screen: the screen's top-left corner is the origin,
/// so the body starts at `-screenOffset`. Landscape is not a separate
/// description — the whole frame is rotated at paint time, exactly like
/// turning the real device around.
///
/// ```
///        ┌───────────────────┐  ← body, at (-screenOffset)
///        │  ┌─────────────┐  │
///        │  │   screen    │  │  ← origin (0, 0) at the screen's top-left
///        │  │             │  │
///        │  └─────────────┘  │
///        └───────────────────┘
/// ```
///
/// Both artwork fields are optional: a frame with only a [screenPath] rounds
/// the app's corners with no body, and a frame with only a [body] draws the
/// device around an unclipped rectangular screen.
@immutable
class DeviceFrame {
  /// Creates a device frame description.
  const DeviceFrame({
    required this.size,
    this.screenOffset = ui.Offset.zero,
    this.screenPath = '',
    this.body = '',
  });

  /// Decodes a frame from the JSON produced by [toJson].
  ///
  /// [body] also accepts an array of strings, joined with newlines, so that
  /// device spec files can keep their artwork readable.
  factory DeviceFrame.fromJson(Map<String, Object?> json) {
    return DeviceFrame(
      size: decodeSize(json['size'], 'size'),
      screenOffset: json['screenOffset'] == null
          ? ui.Offset.zero
          : decodeOffset(json['screenOffset'], 'screenOffset'),
      screenPath: json['screenPath'] == null
          ? ''
          : decodeString(json['screenPath'], 'screenPath'),
      body: json['body'] == null ? '' : decodeStringOrLines(json['body'], 'body'),
    );
  }

  /// The size of the body artwork, in portrait logical pixels.
  final ui.Size size;

  /// The offset of the screen's top-left corner inside the body.
  final ui.Offset screenOffset;

  /// SVG path data for the screen outline, in screen coordinates (the origin
  /// is the screen's top-left corner, portrait).
  ///
  /// Empty for a plain rectangular screen.
  final String screenPath;

  /// The body artwork: an SVG document whose view box covers [size].
  ///
  /// Drawn behind the app, so anything overlapping the screen area is hidden.
  /// Empty when the frame only rounds the screen corners.
  final String body;

  /// Whether this frame carries no artwork at all.
  bool get isEmpty => screenPath.isEmpty && body.isEmpty;

  /// The body rectangle in screen coordinates, for [orientation] of a screen
  /// of [screenSize] (already orientation-resolved).
  ///
  /// In landscape the frame is rotated a quarter turn, mapping a portrait
  /// point `(x, y)` to `(y, portraitWidth − x)` — the same rotation
  /// `SimulatedDisplayFeature.rotatedToLandscape` applies, so frame and
  /// display features stay physically consistent.
  ui.Rect bodyBounds(ui.Size screenSize, Orientation orientation) {
    final ui.Rect portrait = ui.Rect.fromLTWH(
      -screenOffset.dx,
      -screenOffset.dy,
      size.width,
      size.height,
    );
    if (orientation == Orientation.portrait) {
      return portrait;
    }
    // In landscape the screen is (portraitHeight, portraitWidth).
    final double portraitWidth = screenSize.height;
    return ui.Rect.fromLTRB(
      portrait.top,
      portraitWidth - portrait.right,
      portrait.bottom,
      portraitWidth - portrait.left,
    );
  }

  /// Encodes this frame as JSON. Empty artwork fields are absent.
  Map<String, Object?> toJson() => <String, Object?>{
    'size': encodeSize(size),
    if (screenOffset != ui.Offset.zero)
      'screenOffset': encodeOffset(screenOffset),
    if (screenPath.isNotEmpty) 'screenPath': screenPath,
    if (body.isNotEmpty) 'body': body,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DeviceFrame &&
        other.size == size &&
        other.screenOffset == screenOffset &&
        other.screenPath == screenPath &&
        other.body == body;
  }

  @override
  int get hashCode => Object.hash(size, screenOffset, screenPath, body);

  @override
  String toString() =>
      'DeviceFrame(size: $size, screenOffset: $screenOffset, '
      'screenPath: ${screenPath.length} chars, body: ${body.length} chars)';
}

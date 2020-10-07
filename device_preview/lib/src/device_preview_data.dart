import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'utilities/json_converters.dart';
import 'package:flutter/foundation.dart';

part 'device_preview_data.freezed.dart';
part 'device_preview_data.g.dart';

/// A [DevicePreview] configuration snapshot that can be
/// serialized to be persisted between sessions.
@freezed
abstract class DevicePreviewData with _$DevicePreviewData {
  /// Create a new [DevicePreviewData] configuration from all
  /// properties.
  const factory DevicePreviewData({
    /// Indicate whether the device simulation is enabled.
    @Default(true) bool isEnabled,

    /// The current orientation of the device
    @Default(Orientation.portrait) Orientation orientation,

    /// The currently selected device.
    @nullable String deviceIdentifier,

    /// The currently selected device locale.
    @Default('en-US') String locale,

    /// Indicate whether the frame is currently visible.
    @Default(true) bool isFrameVisible,

    /// Indicate whether the mode is currently dark.
    @Default(false) bool isDarkMode,

    /// Indicate whether texts are forced to bold.
    @Default(false) bool boldText,

    /// Indicate whether animations are disabled.
    @Default(false) bool disableAnimations,

    /// Indicate whether the highcontrast mode is activated.
    @Default(false) bool highContrast,

    /// Indicate whether the navigation is in accessible mode.
    @Default(false) bool accessibleNavigation,

    /// Indicate whether image colors are inverted.
    @Default(false) bool invertColors,

    /// The current text scaling factor.
    @Default(1.0) double textScaleFactor,

    /// The custom device configuration
    @nullable CustomDeviceInfoData customDevice,
  }) = _DevicePreviewData;

  factory DevicePreviewData.fromJson(Map<String, dynamic> json) =>
      _$DevicePreviewDataFromJson(json);
}

/// Info about a device and its frame.
@freezed
abstract class CustomDeviceInfoData with _$CustomDeviceInfoData {
  /// Create a new device info.
  const factory CustomDeviceInfoData({
    /// Identifier of the device.
    @required String id,

    /// The device type.
    @required DeviceType type,

    /// The device operating system.
    @required TargetPlatform platform,

    /// The display name of the device.
    @required String name,

    /// The safe areas when the device is in landscape orientation.
    @Default(null)
    @nullable
    @EdgeInsetsJsonConverter()
        EdgeInsets rotatedSafeAreas,

    /// The safe areas when the device is in portrait orientation.
    @required @EdgeInsetsJsonConverter() EdgeInsets safeAreas,

    /// The screen pixel density of the device.
    @required double pixelRatio,

    /// The size in points of the screen content.
    @required @SizeJsonConverter() Size screenSize,
  }) = _CustomDeviceInfoData;

  factory CustomDeviceInfoData.fromJson(Map<String, dynamic> json) =>
      _$CustomDeviceInfoDataFromJson(json);
}

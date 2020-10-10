import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../device_preview.dart';
import '../storage.dart';
import 'custom_device.dart';
import 'state.dart';

class DevicePreviewStore extends ChangeNotifier {
  DevicePreviewStore({
    List<Locale> locales,
    List<DeviceInfo> devices,
    this.useStorage = false,
  }) {
    initialize(
      locales: locales,
      devices: devices,
    );
  }

  final bool useStorage;

  DevicePreviewState _state = DevicePreviewState.notInitialized();

  DevicePreviewState get state => _state;

  set state(DevicePreviewState value) {
    _state = value;
    notifyListeners();
  }

  static final _defaultCustomDevice = CustomDeviceInfoData(
    id: CustomDeviceIdentifier.identifier,
    name: 'Custom',
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: EdgeInsets.only(top: 20),
    rotatedSafeAreas: EdgeInsets.only(top: 20),
    screenSize: Size(512, 1024),
    type: DeviceType.tablet,
  );

  /// Initializes the state by loading data from storage (if [useStorage])
  Future<void> initialize(
      {List<Locale> locales, List<DeviceInfo> devices}) async {
    await state.maybeWhen(
      notInitialized: () async {
        state = DevicePreviewState.initializing();

        final availaiableLocales = locales != null
            ? locales
                .map(
                  (available) => defaultAvailableLocales.firstWhere(
                    (all) => all.code == available.toString(),
                    orElse: () => null,
                  ),
                )
                .where((x) => x != null)
                .toList()
            : defaultAvailableLocales;
        final defaultLocale = basicLocaleListResolution(
          WidgetsBinding.instance.window.locales,
          availaiableLocales.map((x) => x.locale).toList(),
        )?.toString();

        var data = DevicePreviewData(
          locale: defaultLocale,
          customDevice: _defaultCustomDevice,
        );
        devices = devices ?? Devices.all;

        try {
          if (useStorage) {
            data = await DevicePreviewStorage.load();
          }
        } catch (e) {
          print('[device_preview] Error while restoring data: $e');
        }

        data ??= DevicePreviewData();

        if (data.locale == null) {
          data = data.copyWith(locale: defaultLocale);
        }
        if (data.customDevice == null) {
          data = data.copyWith(
            customDevice: _defaultCustomDevice,
          );
        }
        state = DevicePreviewState.initialized(
          locales: availaiableLocales,
          devices: devices,
          data: data,
        );
      },
      orElse: () => Future.value(),
    );
  }
}

/// A set of extension to triggers updates of the state.
extension DevicePreviewStateHelperExtensions on DevicePreviewStore {
  DevicePreviewData get data => state.maybeMap(
        initialized: (state) => state.data,
        orElse: () => throw Exception('Not initialized'),
      );

  set data(DevicePreviewData data) {
    state = state.maybeMap(
      initialized: (state) {
        final result = state.copyWith(data: data);
        DevicePreviewStorage.save(data, !useStorage);
        return result;
      },
      orElse: () => throw Exception('Not initialized'),
    );
  }

  List<NamedLocale> get locales => state.maybeMap(
        initialized: (state) => state.locales,
        orElse: () => throw Exception('Not initialized'),
      );

  List<DeviceInfo> get devices => state.maybeMap(
        initialized: (state) => state.devices,
        orElse: () => throw Exception('Not initialized'),
      );

  DevicePreviewSettingsData get settings =>
      data.settings ?? DevicePreviewSettingsData();

  set settings(DevicePreviewSettingsData value) {
    data = data.copyWith(settings: value);
  }

  /// The currently selected device from the [availableDevices].
  DeviceInfo get deviceInfo {
    if (data?.deviceIdentifier == CustomDeviceIdentifier.identifier) {
      return CustomDeviceInfo(data?.customDevice);
    }
    return state.maybeMap(
      initialized: (state) => state.devices.firstWhere(
        (x) => x.identifier.toString() == data?.deviceIdentifier,
        orElse: () => state.devices.first,
      ),
      orElse: () => throw Exception('Not initialized'),
    );
  }

  /// Get the currently selected locale.
  Locale get locale => state.maybeMap(
        initialized: (state) => state.locales
            .firstWhere(
              (x) => x.locale.toString() == data.locale,
              orElse: () => state.locales.first,
            )
            .locale,
        orElse: () => throw Exception('Not initialized'),
      );

  /// Activate the custom device mode.
  void enableCustomDevice() {
    data = data.copyWith(
      deviceIdentifier: CustomDeviceIdentifier.identifier,
    );
  }

  /// Hide or show the current device frame.
  void toggleFrame() {
    data = data.copyWith(
      isFrameVisible: !data.isFrameVisible,
    );
  }

  /// Hide or show the virtual keyboard.
  void toggleVirtualKeyboard() {
    data = data.copyWith(
      isVirtualKeyboardVisible: !data.isVirtualKeyboardVisible,
    );
  }

  /// Switch from light to dark mode.
  void toggleDarkMode() {
    data = data.copyWith(
      isDarkMode: !data.isDarkMode,
    );
  }

  /// Change the simulated device orientation between portrait and landscape.
  void rotate() {
    final index = (data.orientation.index + 1) % Orientation.values.length;
    data = data.copyWith(
      orientation: Orientation.values[index],
    );
  }

  /// Select the current device.
  void selectDevice(DeviceIdentifier id) {
    data = data.copyWith(
      deviceIdentifier: id.toString(),
    );
  }

  /// Indicate whether the current device is a custom one.
  bool get isCustomDevice =>
      deviceInfo?.identifier?.toString() == CustomDeviceIdentifier.identifier;

  /// Updates the custom device configuration.
  void updateCustomDevice(CustomDeviceInfoData data) =>
      this.data = this.data.copyWith(customDevice: data);
}

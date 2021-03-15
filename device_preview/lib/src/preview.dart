import 'dart:io';

import 'package:device_preview/src/locales.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menubar/menubar.dart';
import 'package:collection/collection.dart';
import 'package:window_size/window_size.dart';

import 'binding/binding.dart';
import 'binding/window.dart';
import 'devices/device.dart';
import 'devices/devices.dart';

class DevicePreview {
  static final DevicePreview _instance = DevicePreview._();
  DevicePreview._();
  factory DevicePreview() => _instance;
  Future<void> initialize() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      throw Exception('Device Preview is only compatible with desktop targets');
    }

    PreviewWidgetsFlutterBinding.ensureInitialized();
    await setApplicationMenu(
      [
        Submenu(
          label: 'Preview',
          children: [
            Submenu(
              label: 'Device',
              children: [
                MenuItem(
                  label: 'Orientation',
                  enabled: false,
                ),
                MenuItem(
                  label: 'Portrait',
                  onClicked: () => setOrientation(Orientation.portrait),
                ),
                MenuItem(
                  label: 'Landscape',
                  onClicked: () => setOrientation(Orientation.landscape),
                ),
                MenuDivider(),
                ...defaultDevices.map(
                  (category) => (category.devices.length == 1 &&
                          category.devices.first.length == 1 &&
                          category.devices.first.first.name == category.name)
                      ? MenuItem(
                          label: category.devices.first.first.name,
                          onClicked: () {
                            setDevice(category.devices.first.first);
                          },
                        )
                      : Submenu(
                          label: category.name,
                          children: [
                            ...category.devices
                                .map(
                                  (section) => [
                                    ...section.map(
                                      (device) => MenuItem(
                                        label: device.name,
                                        onClicked: () {
                                          setDevice(device);
                                        },
                                      ),
                                    ),
                                  ].asMap().entries.expand((entry) => [
                                        if (entry.key > 0) MenuDivider(),
                                        entry.value,
                                      ]),
                                )
                                .expand((x) => x)
                          ],
                        ),
                ),
              ],
            ),
            Submenu(
              label: 'Brightness',
              children: [
                MenuItem(
                  label: 'Light',
                  onClicked: () => setBrightness(Brightness.light),
                ),
                MenuItem(
                  label: 'Dark',
                  onClicked: () => setBrightness(Brightness.dark),
                ),
              ],
            ),
            _buildAccessibilityMenu(),
            _buildLocaleMenu(),
          ],
        ),
      ],
    );
  }

  Submenu _buildAccessibilityMenu() {
    return Submenu(
      label: 'Accessibility',
      children: [
        Submenu(
          label: 'Text scale factor',
          children: [
            MenuItem(
              label: '0.5',
              onClicked: () => setTextScaleFactor(0.5),
            ),
            MenuItem(
              label: '1.0',
              onClicked: () => setTextScaleFactor(1),
            ),
            MenuItem(
              label: '1.5',
              onClicked: () => setTextScaleFactor(1.5),
            ),
            MenuItem(
              label: '2.0',
              onClicked: () => setTextScaleFactor(2),
            ),
            MenuItem(
              label: '3.0',
              onClicked: () => setTextScaleFactor(3),
            ),
          ],
        ),
        Submenu(
          label: 'Bold text',
          children: [
            MenuItem(
              label: 'Enable',
              onClicked: () => setBoldText(true),
            ),
            MenuItem(
              label: 'Disable',
              onClicked: () => setBoldText(false),
            ),
          ],
        ),
        Submenu(
          label: 'Reduce motion',
          children: [
            MenuItem(
              label: 'Enable',
              onClicked: () => setReduceMotion(true),
            ),
            MenuItem(
              label: 'Disable',
              onClicked: () => setReduceMotion(false),
            ),
          ],
        ),
        Submenu(
          label: 'High contrast',
          children: [
            MenuItem(
              label: 'Enable',
              onClicked: () => setHighContrast(true),
            ),
            MenuItem(
              label: 'Disable',
              onClicked: () => setHighContrast(false),
            ),
          ],
        ),
      ],
    );
  }

  Submenu _buildLocaleMenu() {
    final byLanguage = groupBy<NamedLocale, String>(
        defaultAvailableLocales, (x) => x.locale.languageCode).entries;
    byLanguage.sorted((a, b) => a.key.compareTo(b.key));
    return Submenu(
      label: 'Locale',
      children: [
        MenuItem(
          label: 'Language',
          enabled: false,
        ),
        ...byLanguage.map(
          (x) => Submenu(
            label: x.key + ' - ' + x.value.first.name,
            children: [
              ...x.value.map(
                (language) => MenuItem(
                  label: language.code + ' - ' + language.name,
                  onClicked: () => setLocale(language.locale),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void setBrightness(Brightness? value) {
    PreviewWidgetsFlutterBinding.previewWindow.platformBrightness = value;
  }

  void setBoldText(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      boldText: value,
    );
  }

  void setHighContrast(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      highContrast: value,
    );
  }

  void setAccessibleNavigation(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
      PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
      accessibleNavigation: value,
    );
  }

  void setReduceMotion(bool? value) {
    PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures =
        PreviewAccessibilityFeatures.merge(
            PreviewWidgetsFlutterBinding.previewWindow.accessibilityFeatures,
            reduceMotion: value);
  }

  void setLocale(Locale? value) {
    PreviewWidgetsFlutterBinding.previewWindow.locale = value;
  }

  void setTextScaleFactor(double? value) {
    PreviewWidgetsFlutterBinding.previewWindow.textScaleFactor = value;
  }

  Orientation _orientation = Orientation.portrait;
  Device? _device;

  void setOrientation(Orientation orientation) {
    _orientation = orientation;
    _updatePadding();
    _updateSize();
  }

  Future<void> setDevice(Device device) async {
    _device = device;
    setWindowTitle(device.name);

    // Overriding platform
    debugDefaultTargetPlatformOverride = device.platform;

    _updatePadding();
    _updateSize();

    if (WidgetsBinding.instance != null) {
      await WidgetsBinding.instance!.reassembleApplication();
    }
  }

  void _updatePadding() {
    if (_device != null) {
      final padding = _device!.padding[_orientation]!;
      PreviewWidgetsFlutterBinding.previewWindow.padding = PreviewWindowPadding(
        bottom: padding.bottom,
        top: padding.top,
        right: padding.right,
        left: padding.left,
      );

      _updateSize();
    }
  }

  void _updateSize() {
    if (_device != null) {
      final size = _device!.physicalSize;
      if (size != null) {
        //final info = await getWindowInfo();
        //setWindowFrame(info.frame.topLeft & size);
        //setWindowMinSize(size);
        //setWindowMaxSize(size);
        final width =
            _orientation == Orientation.portrait ? size.width : size.height;
        final height =
            _orientation == Orientation.portrait ? size.height : size.width;

        PreviewWidgetsFlutterBinding.previewWindow.physicalSize = Size(
          width * PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio,
          height * PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio,
        );
      } else {
        //setWindowMinSize(Size.zero);
        //setWindowMaxSize(Size.infinite);
        PreviewWidgetsFlutterBinding.previewWindow.physicalSize = null;
      }
    } else {
      PreviewWidgetsFlutterBinding.previewWindow.physicalSize = null;
    }
  }
}

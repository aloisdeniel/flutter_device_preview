import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:menubar/menubar.dart';
import 'package:window_size/window_size.dart';

import 'devices.dart';
import 'binding.dart';

class DevicePreview {
  static final DevicePreview _instance = DevicePreview._();
  DevicePreview._();
  factory DevicePreview() => _instance;
  Future<void> initialize() async {
    PreviewWidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Device Preview');
    await setApplicationMenu(
      [
        Submenu(
          label: 'Devices',
          children: [
            ...defaultDevices.map(
              (category) => Submenu(
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
      ],
    );
  }

  Future<void> setDevice(Device device) async {
    // Overriding platform
    debugDefaultTargetPlatformOverride = device.platform;

    // View padding
    PreviewWidgetsFlutterBinding.previewWindow.padding = PreviewWindowPadding(
      bottom: device.padding.bottom,
      top: device.padding.top,
      right: device.padding.right,
      left: device.padding.left,
    );

    // Window size
    final info = await getWindowInfo();
    final size = device.physicalSize;
    if (size != null) {
      setWindowFrame(info.frame.topLeft & size);
      setWindowMinSize(size);
      setWindowMaxSize(size);
      PreviewWidgetsFlutterBinding.previewWindow.physicalSize = Size(
        size.width *
            PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio,
        size.height *
            PreviewWidgetsFlutterBinding.previewWindow.devicePixelRatio,
      );
    } else {
      setWindowMinSize(Size.zero);
      setWindowMaxSize(Size.infinite);
      PreviewWidgetsFlutterBinding.previewWindow.physicalSize = null;
    }
  }
}

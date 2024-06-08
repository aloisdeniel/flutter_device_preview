import 'package:device_frame/src/info/info.dart';

import 'package:flutter/widgets.dart';

/// A set of iOS devices.
class WindowsDevices {
  const WindowsDevices();

  DeviceInfo get window => _window;
  static final _window = DeviceInfo.genericDesktopWindow(
    platform: TargetPlatform.windows,
    name: 'Window',
    id: 'window',
    screenSize: const Size(1920, 1080),
    windowPosition: Rect.fromCenter(
      center: const Offset(
        1920 * 0.5,
        1080 * 0.5,
      ),
      width: 1920,
      height: 1080,
    ),
  );

  DeviceInfo get wideMonitor => _wideMonitor;
  static final _wideMonitor = DeviceInfo.genericDesktopMonitor(
    platform: TargetPlatform.windows,
    name: 'Large',
    id: 'large',
    screenSize: const Size(1920, 1080),
    windowPosition: Rect.fromCenter(
      center: const Offset(
        1920 * 0.5,
        1080 * 0.5,
      ),
      width: 1620,
      height: 780,
    ),
  );

  DeviceInfo get laptop => _laptop;
  static final _laptop = DeviceInfo.genericLaptop(
    platform: TargetPlatform.windows,
    name: 'Laptop',
    id: 'laptop',
    screenSize: const Size(1920, 1080),
    windowPosition: Rect.fromCenter(
      center: const Offset(
        1920 * 0.5,
        1080 * 0.5,
      ),
      width: 1620,
      height: 780,
    ),
  );

  /// All available devices.
  List<DeviceInfo> get all => [
        window,
        wideMonitor,
        laptop,
      ];
}

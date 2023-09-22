import 'dart:async';

import 'package:devtools_device_preview/devtools_device_preview.dart';
import 'package:devtools_device_preview/src/configuration/configuration.dart';
import 'package:devtools_device_preview/src/configuration/preference.dart';
import 'package:devtools_device_preview/src/services/service.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

import 'menu.platform.dart';

/// This adds a platform menu.
class MacOsPreviewMenu extends PlatformPreviewMenu {
  MacOsPreviewMenu(this.service) {
    _subscription = service.updates.listen(_buildMenu);
    service.get().then(_buildMenu);
  }

  late final StreamSubscription<PreviewConfiguration> _subscription;
  final PreviewService service;

  void _buildMenu(PreviewConfiguration configuration) {
    WidgetsBinding.instance.platformMenuDelegate.setMenus(
      <MenuItem>[
        const PlatformMenu(
          label: '',
          menus: <MenuItem>[],
        ),
        PlatformMenu(
          label: 'Device Preview',
          menus: <MenuItem>[
            PlatformMenuItem(
              label: configuration.isEnabled ? 'Disable' : 'Enable',
              onSelected: () => service.update(
                configuration.copyWith(
                  isEnabled: !configuration.isEnabled,
                ),
              ),
            ),
            DeviceMenu(
              value: configuration.device,
              onChange: (value) => service.update(
                configuration.copyWith(device: value),
              ),
            ),
            AccessibilityMenu(
              value: configuration.accessibility,
              onChange: (value) => service.update(
                configuration.copyWith(accessibility: value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
  }
}

class DeviceMenu extends PlatformMenu {
  DeviceMenu({
    required PreviewDeviceConfiguration value,
    required ValueChanged<PreviewDeviceConfiguration> onChange,
  }) : super(
          label: 'Device',
          menus: (() {
            final deviceByPlatform =
                groupBy(Devices.all, (d) => d.identifier.platform);
            return <MenuItem>[
              PlatformMenu(
                label: 'Brighntess',
                menus: <MenuItem>[
                  PlatformMenuItem(
                    label: 'System',
                    onSelected: () => onChange(
                      value.copyWith(
                          brightness:
                              const PreviewPreference<Brightness>.system()),
                    ),
                  ),
                  PlatformMenuItem(
                    label: 'Light',
                    onSelected: () => onChange(
                      value.copyWith(
                          brightness: const PreviewPreference.overriden(
                              Brightness.light)),
                    ),
                  ),
                  PlatformMenuItem(
                    label: 'Dark',
                    onSelected: () => onChange(
                      value.copyWith(
                          brightness: const PreviewPreference.overriden(
                              Brightness.dark)),
                    ),
                  ),
                ],
              ),
              PlatformMenu(
                label: 'Frame',
                menus: <MenuItem>[
                  PlatformMenuItem(
                    label: 'None',
                    onSelected: () => onChange(
                      value.copyWith(
                        device: const PreviewPreference<DeviceInfo>.system(),
                      ),
                    ),
                  ),
                  ...deviceByPlatform.entries.map(
                    (platform) => PlatformMenu(
                      label: platform.key.name,
                      menus: <MenuItem>[
                        ...platform.value.map(
                          (device) => PlatformMenuItem(
                            label: device.name,
                            onSelected: () => onChange(
                              value.copyWith(
                                  device:
                                      PreviewPreference<DeviceInfo>.overriden(
                                          device)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ];
          }()),
        );
}

class AccessibilityMenu extends PlatformMenu {
  AccessibilityMenu({
    required PreviewAccessibilityConfiguration value,
    required ValueChanged<PreviewAccessibilityConfiguration> onChange,
  }) : super(
          label: 'Accessibility',
          menus: [
            BoolPreferenceMenu(
              label: 'Bold text',
              value: value.boldText,
              onChange: (v) => onChange(
                value.copyWith(boldText: v),
              ),
            ),
            BoolPreferenceMenu(
              label: 'Accessible navigation',
              value: value.accessibleNavigation,
              onChange: (v) => onChange(
                value.copyWith(accessibleNavigation: v),
              ),
            ),
          ],
        );
}

class BoolPreferenceMenu extends PlatformMenu {
  BoolPreferenceMenu({
    required super.label,
    required PreviewPreference<bool> value,
    required ValueChanged<PreviewPreference<bool>> onChange,
  }) : super(
          menus: <MenuItem>[
            PlatformMenuItem(
              label: 'System',
              onSelected: () =>
                  onChange(const PreviewPreference<bool>.system()),
            ),
            PlatformMenuItem(
              label: 'Disable',
              onSelected: () =>
                  onChange(const PreviewPreference<bool>.overriden(false)),
            ),
            PlatformMenuItem(
              label: 'Enable',
              onSelected: () =>
                  onChange(const PreviewPreference<bool>.overriden(true)),
            ),
          ],
        );
}

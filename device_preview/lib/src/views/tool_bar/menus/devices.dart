import 'package:device_preview/src/state/custom_device.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:device_preview/src/views/tool_bar/button.dart';
import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/views/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/views/tool_bar/menus/style.dart';
import 'package:device_preview/src/views/widgets/popover.dart';
import 'package:device_preview/src/views/widgets/target_platform_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../utilities/spacing.dart';
import '../format.dart';

class DevicesPopOver extends StatefulWidget {
  const DevicesPopOver({
    Key? key,
  }) : super(key: key);

  @override
  _DevicesPopOverState createState() => _DevicesPopOverState();
}

class _DevicesPopOverState extends State<DevicesPopOver> {
  List<TargetPlatform>? selected;
  bool? _isCustomDevice;
  String _searchedText = '';

  @override
  Widget build(BuildContext context) {
    final all = context.select(
      (DevicePreviewStore store) =>
          store.devices.map((e) => e.identifier.platform).toSet().toList(),
    );

    final platform = context.select(
      (DevicePreviewStore store) => store.deviceInfo.identifier.platform,
    );

    var isCustomDevice = context.select(
      (DevicePreviewStore store) => store.isCustomDevice,
    );
    isCustomDevice = _isCustomDevice ?? isCustomDevice;

    final selected = this.selected ?? [platform];

    final devices = context.select(
      (DevicePreviewStore store) => store.devices
          .where(
            (x) =>
                selected.contains(x.identifier.platform) &&
                x.name.replaceAll(' ', '').toLowerCase().contains(
                      _searchedText,
                    ),
          )
          .toList()
        ..sort((x, y) {
          final result = x.screenSize.width.compareTo(y.screenSize.width);
          return result == 0
              ? x.screenSize.height.compareTo(y.screenSize.height)
              : result;
        }),
    );

    final theme = DevicePreviewTheme.of(context);

    return GestureDetector(
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode()); //remove search focus
      },
      child: Column(
        children: <Widget>[
          PlatformSelector(
            all: all,
            selected: isCustomDevice ? [] : selected,
            onChanged: (v) {
              setState(() {
                _searchedText = '';
                _isCustomDevice = false;
                this.selected = v;
              });
            },
            onCustomDeviceEnabled: () {
              setState(() => _isCustomDevice = true);
            },
          ),
          PopoverSearchField(
            hintText: 'Search by device name',
            text: _searchedText,
            onTextChanged: (value) => setState(() => _searchedText = value),
          ),
          Expanded(
            child: isCustomDevice
                ? const CustomDevicePanel()
                : ListView(
                    padding: theme.toolBar.spacing.regular,
                    children: devices
                        .map(
                          (e) => DeviceTile(
                            e,
                            () {
                              final state = context.read<DevicePreviewStore>();
                              state.selectDevice(e.identifier);
                            },
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class PlatformSelector extends StatelessWidget {
  final List<TargetPlatform> all;
  final List<TargetPlatform> selected;
  final ValueChanged<List<TargetPlatform>> onChanged;
  final VoidCallback onCustomDeviceEnabled;

  const PlatformSelector({
    Key? key,
    required this.all,
    required this.selected,
    required this.onChanged,
    required this.onCustomDeviceEnabled,
  }) : super(key: key);

  List<TargetPlatform> _orderPlatforms() {
    int getIndex(TargetPlatform d) {
      final index = <TargetPlatform>[
        TargetPlatform.iOS,
        TargetPlatform.android,
        TargetPlatform.macOS,
        TargetPlatform.windows,
        TargetPlatform.linux,
      ].indexOf(d);
      return index == -1 ? 1000 : index;
    }

    return all.toList()..sort((x, y) => getIndex(x).compareTo(getIndex(y)));
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final theme = Theme.of(context);
    final isCustomSelected = context.select(
      (DevicePreviewStore store) =>
          store.deviceInfo.identifier.toString() ==
          CustomDeviceIdentifier.identifier,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      color: toolBarStyle.backgroundColor,
      child: SizedBox(
        height: 36,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ..._orderPlatforms().map<Widget>(
              (x) {
                final isSelected = selected.contains(x);
                return ToolBarButton(
                  backgroundColor: toolBarStyle.foregroundColor
                      .withOpacity(isSelected ? 0.4 : 0.1),
                  foregroundColor: toolBarStyle.foregroundColor
                      .withOpacity(isSelected ? 1.0 : 0.8),
                  child: TargetPlatformIcon(platform: x),
                  onTap: () {
                    onChanged([x]);
                  },
                );
              },
            ).spaced(horizontal: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: theme.textTheme.button!.color!.withOpacity(0.4),
                borderRadius: BorderRadius.circular(3),
              ),
              width: 2,
              height: 2,
            ),
            ToolBarButton(
              backgroundColor: toolBarStyle.foregroundColor
                  .withOpacity(isCustomSelected ? 0.4 : 0.1),
              foregroundColor: toolBarStyle.foregroundColor
                  .withOpacity(isCustomSelected ? 1.0 : 0.8),
              icon: Icons.phonelink_setup_outlined,
              onTap: () {
                if (!isCustomSelected) {
                  final state = context.read<DevicePreviewStore>();
                  state.enableCustomDevice();
                }
                onCustomDeviceEnabled();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDevicePanel extends StatelessWidget {
  const CustomDevicePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customDevice = context.select(
      (DevicePreviewStore store) => store.data.customDevice,
    );

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const WrapOptionsTile(
          title: 'Target platform',
          options: <Widget>[
            PlatformSelectBox(
              platform: TargetPlatform.android,
            ),
            PlatformSelectBox(
              platform: TargetPlatform.iOS,
            ),
            PlatformSelectBox(
              platform: TargetPlatform.macOS,
            ),
            PlatformSelectBox(
              platform: TargetPlatform.windows,
            ),
            PlatformSelectBox(
              platform: TargetPlatform.linux,
            ),
          ],
        ),
        const WrapOptionsTile(
          title: 'Device type',
          options: <Widget>[
            DeviceTypeSelectBox(
              type: DeviceType.phone,
            ),
            DeviceTypeSelectBox(
              type: DeviceType.tablet,
            ),
            DeviceTypeSelectBox(
              type: DeviceType.laptop,
            ),
            DeviceTypeSelectBox(
              type: DeviceType.desktop,
            ),
          ],
        ),
        const SectionHeader(
          title: 'Screen size',
        ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Width',
            value: customDevice.screenSize.width,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  screenSize: Size(v, customDevice.screenSize.height),
                ),
              );
            },
            min: 128,
            max: 2688,
            divisions: 20,
          ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Height',
            value: customDevice.screenSize.height,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  screenSize: Size(
                    customDevice.screenSize.width,
                    v,
                  ),
                ),
              );
            },
            min: 128,
            max: 2688,
            divisions: 20,
          ),
        const SectionHeader(
          title: 'Safe areas',
        ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Left',
            value: customDevice.safeAreas.left,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  safeAreas: customDevice.safeAreas.copyWith(left: v),
                ),
              );
            },
            min: 0,
            max: 128,
            divisions: 8,
          ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Top',
            value: customDevice.safeAreas.top,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  safeAreas: customDevice.safeAreas.copyWith(top: v),
                ),
              );
            },
            min: 0,
            max: 128,
            divisions: 8,
          ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Right',
            value: customDevice.safeAreas.right,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  safeAreas: customDevice.safeAreas.copyWith(right: v),
                ),
              );
            },
            min: 0,
            max: 128,
            divisions: 8,
          ),
        if (customDevice != null)
          SliderRowTile(
            title: 'Bottom',
            value: customDevice.safeAreas.bottom,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(
                  safeAreas: customDevice.safeAreas.copyWith(bottom: v),
                ),
              );
            },
            min: 0,
            max: 128,
            divisions: 8,
          ),
        if (customDevice != null)
          SliderTile(
            title: 'Screen density',
            value: customDevice.pixelRatio,
            onValueChanged: (v) {
              final store = context.read<DevicePreviewStore>();
              store.updateCustomDevice(
                customDevice.copyWith(pixelRatio: v),
              );
            },
            min: 1,
            max: 4,
            divisions: 3,
          )
      ],
    );
  }
}

class DeviceTile extends StatelessWidget {
  final DeviceInfo device;
  final GestureTapCallback onTap;

  const DeviceTile(
    this.device,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIdentifier = context.select(
      (DevicePreviewStore store) => store.deviceInfo.identifier,
    );

    final isSelected = selectedIdentifier == device.identifier;
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    return GestureDetector(
      onTap: !isSelected ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: isSelected
            ? toolBarStyle.foregroundColor.withOpacity(0.18)
            : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: toolBarStyle.spacing.big.top,
            vertical: toolBarStyle.spacing.regular.top,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 12,
                child: Icon(
                  device.identifier.typeIcon(),
                  size: 12,
                  color: toolBarStyle.foregroundColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      device.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: toolBarStyle.foregroundColor,
                      ),
                    ),
                    Text(
                      device.identifier.typeLabel(),
                      style: TextStyle(
                        fontSize: 11,
                        color: toolBarStyle.foregroundColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceTypeSelectBox extends StatelessWidget {
  final DeviceType type;
  const DeviceTypeSelectBox({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customDevice = context.select(
      (DevicePreviewStore store) => store.data.customDevice,
    );
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return SelectBox(
      isSelected: customDevice!.type == type,
      onTap: () {
        final store = context.read<DevicePreviewStore>();
        store.updateCustomDevice(
          customDevice.copyWith(
            type: type,
          ),
        );
      },
      child: Icon(
        type.typeIcon(),
        color: toolBarStyle.foregroundColor,
        size: 11,
      ),
    );
  }
}

class PlatformSelectBox extends StatelessWidget {
  final TargetPlatform platform;
  const PlatformSelectBox({
    Key? key,
    required this.platform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customDevice = context.select(
      (DevicePreviewStore store) => store.data.customDevice,
    );
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final isSelected = customDevice!.platform == platform;
    return SelectBox(
      isSelected: isSelected,
      onTap: () {
        final store = context.read<DevicePreviewStore>();
        store.updateCustomDevice(
          customDevice.copyWith(
            platform: platform,
          ),
        );
      },
      child: SizedBox(
        width: 11,
        height: 11,
        child: TargetPlatformIcon(
          platform: platform,
          color: toolBarStyle.foregroundColor,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 20,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: toolBarStyle.foregroundColor,
        ),
      ),
    );
  }
}

class SliderRowTile extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onValueChanged;

  const SliderRowTile({
    Key? key,
    required this.title,
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          final range = (max - min);
          onValueChanged(
            value == max ? min : (value + (range / divisions)),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 9,
                      color: toolBarStyle.foregroundColor.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PopoverSlider(
                    divisions: divisions, // 11,
                    value: value,
                    onChanged: onValueChanged,
                    min: min, //0.25,
                    max: max, // 3.0,
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: toolBarStyle.foregroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

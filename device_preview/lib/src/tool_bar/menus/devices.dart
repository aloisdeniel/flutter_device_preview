import 'dart:math' as math;

import 'package:device_preview/src/custom_device.dart';
import 'package:device_preview/src/tool_bar/button.dart';
import 'package:device_frame/device_frame.dart';
import 'package:device_preview/src/tool_bar/menus/accessibility.dart';
import 'package:device_preview/src/tool_bar/menus/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../device_preview.dart';
import '../../utilities/spacing.dart';
import '../format.dart';

class DevicesPopOver extends StatefulWidget {
  @override
  _DevicesPopOverState createState() => _DevicesPopOverState();
}

class _DevicesPopOverState extends State<DevicesPopOver> {
  List<TargetPlatform> selected;

  final TextEditingController _searchTEC = TextEditingController();
  String _searchedText = '';
  bool _isCustomDevice;

  @override
  void initState() {
    _searchTECListener();
    super.initState();
  }

  void _searchTECListener() {
    _searchTEC.addListener(() {
      setState(() {
        _searchedText = _searchTEC.text.replaceAll(' ', '').toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final all = preview.availableDevices
        .map((e) => e.identifier.platform)
        .toSet()
        .toList();
    final selected = this.selected ??
        [preview.deviceInfo?.identifier?.platform ?? all.first];

    final isCustomDevice = _isCustomDevice ?? preview.isCustomDevice;
    return GestureDetector(
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode()); //remove search focus
      },
      child: Column(
        children: <Widget>[
          PlatformSelector(
            all: all,
            selected: selected,
            onChanged: (v) {
              setState(() {
                _clearSearchTEC();
                _isCustomDevice = false;
                this.selected = v;
              });
            },
            onCustomDeviceEnabled: () {
              setState(() => _isCustomDevice = true);
            },
          ),
          DeviceSearchField(
            _searchTEC,
            onClear: _clearSearchTEC,
          ),
          Expanded(
            child: isCustomDevice
                ? CustomDevicePanel()
                : ListView(
                    padding: EdgeInsets.all(10),
                    children: preview.availableDevices
                        .where((x) =>
                            selected.contains(x.identifier.platform) &&
                            x.name
                                .replaceAll(' ', '')
                                .toLowerCase()
                                .contains(_searchedText))
                        .map((e) =>
                            DeviceTile(e, () => preview.device = e.identifier))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  void _clearSearchTEC() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _searchTEC.clear());
  }
}

class PlatformSelector extends StatelessWidget {
  final List<TargetPlatform> all;
  final List<TargetPlatform> selected;
  final ValueChanged<List<TargetPlatform>> onChanged;
  final VoidCallback onCustomDeviceEnabled;

  const PlatformSelector({
    @required this.all,
    @required this.selected,
    @required this.onChanged,
    @required this.onCustomDeviceEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final theme = Theme.of(context);

    final preview = DevicePreview.of(context);
    final isCustomSelected = preview.deviceInfo?.identifier?.assetKey ==
        CustomDeviceIdentifier.identifier;
    return Container(
      padding: const EdgeInsets.all(10),
      color: toolBarStyle.backgroundColor,
      child: Row(
        children: [
          ...all.map<Widget>(
            (x) {
              final isSelected = selected.contains(x);
              return ToolBarButton(
                backgroundColor: isSelected ? theme.accentColor : null,
                foregroundColor:
                    isSelected ? theme.accentTextTheme.button.color : null,
                icon: x.platformIcon(),
                onTap: () {
                  onChanged([x]);
                },
              );
            },
          ).spaced(horizontal: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: theme.accentTextTheme.button.color.withOpacity(0.4),
              borderRadius: BorderRadius.circular(3),
            ),
            width: 2,
            height: 2,
          ),
          ToolBarButton(
            backgroundColor: isCustomSelected ? theme.accentColor : null,
            foregroundColor:
                isCustomSelected ? theme.accentTextTheme.button.color : null,
            icon: Icons.phonelink_setup_outlined,
            onTap: () {
              if (!isCustomSelected) {
                preview.enableCustomDevice();
              }
              onCustomDeviceEnabled();
            },
          ),
        ],
      ),
    );
  }
}

class CustomDevicePanel extends StatelessWidget {
  const CustomDevicePanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final customDevice = preview.data.customDevice;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        WrapOptionsTile(
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
        WrapOptionsTile(
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
        SectionHeader(
          title: 'Screen size',
        ),
        SliderRowTile(
          title: 'Width',
          value: customDevice.screenSize.width,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              screenSize: Size(v, customDevice.screenSize.height),
            );
          },
          min: 128,
          max: 2688,
          divisions: 10,
        ),
        SliderRowTile(
          title: 'Height',
          value: customDevice.screenSize.height,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              screenSize: Size(
                customDevice.screenSize.width,
                v,
              ),
            );
          },
          min: 128,
          max: 2688,
          divisions: 10,
        ),
        SectionHeader(
          title: 'Safe areas',
        ),
        SliderRowTile(
          title: 'Left',
          value: customDevice.safeAreas.left,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              safeAreas: customDevice.safeAreas.copyWith(left: v),
            );
          },
          min: 0,
          max: 128,
          divisions: 8,
        ),
        SliderRowTile(
          title: 'Top',
          value: customDevice.safeAreas.top,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              safeAreas: customDevice.safeAreas.copyWith(top: v),
            );
          },
          min: 0,
          max: 128,
          divisions: 8,
        ),
        SliderRowTile(
          title: 'Right',
          value: customDevice.safeAreas.right,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              safeAreas: customDevice.safeAreas.copyWith(right: v),
            );
          },
          min: 0,
          max: 128,
          divisions: 8,
        ),
        SliderRowTile(
          title: 'Bottom',
          value: customDevice.safeAreas.bottom,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(
              safeAreas: customDevice.safeAreas.copyWith(bottom: v),
            );
          },
          min: 0,
          max: 128,
          divisions: 8,
        ),
        SliderTile(
          title: 'Screen density',
          value: customDevice.pixelRatio,
          onValueChanged: (v) {
            preview.customDevice = customDevice.copyWith(pixelRatio: v);
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
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final isSelected = preview.deviceInfo.name == device.name;
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;

    return GestureDetector(
      onTap: !isSelected ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 12,
                child: Icon(
                  device.identifier.typeIcon(),
                  size: 12,
                  color: toolBarStyle.foregroundColor,
                ),
              ),
              SizedBox(width: 12),
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

class DeviceSearchField extends StatelessWidget {
  final TextEditingController searchTEC;
  final VoidCallback onClear;
  const DeviceSearchField(this.searchTEC, {Key key, @required this.onClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Container(
      child: Material(
        child: Container(
          color: toolBarStyle.backgroundColor,
          height: 48,
          padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
          child: TextField(
            style: TextStyle(
              color: toolBarStyle.foregroundColor,
              fontSize: 12,
            ),
            controller: searchTEC,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: toolBarStyle.foregroundColor.withOpacity(0.5),
                fontSize: 12,
              ),
              hintText: 'Search by device name...',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              filled: true,
              fillColor: toolBarStyle.foregroundColor.withOpacity(0.12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              prefixIcon: Icon(
                FontAwesomeIcons.search,
                color: toolBarStyle.foregroundColor.withOpacity(0.5),
                size: 12,
              ),
              suffix: InkWell(
                child: Icon(
                  FontAwesomeIcons.times,
                  size: 12,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: onClear,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeviceTypeSelectBox extends StatelessWidget {
  final DeviceType type;
  const DeviceTypeSelectBox({
    Key key,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return SelectBox(
      isSelected: preview.data.customDevice.type == type,
      onTap: () => preview.customDevice = preview.data.customDevice.copyWith(
        type: type,
      ),
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
    Key key,
    @required this.platform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return SelectBox(
      isSelected: preview.data.customDevice.platform == platform,
      onTap: () => preview.customDevice = preview.data.customDevice.copyWith(
        platform: platform,
      ),
      child: Icon(
        platform.platformIcon(),
        color: toolBarStyle.foregroundColor,
        size: 11,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    @required this.title,
  });

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
    @required this.title,
    @required this.min,
    @required this.max,
    @required this.divisions,
    @required this.value,
    @required this.onValueChanged,
  });

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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 9,
                    color: toolBarStyle.foregroundColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    divisions: divisions, // 11,
                    value: value,
                    onChanged: onValueChanged,
                    min: min, //0.25,
                    max: max, // 3.0,
                  ),
                ),
                Text(
                  value?.toString() ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    color: toolBarStyle.foregroundColor,
                    fontWeight: FontWeight.bold,
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

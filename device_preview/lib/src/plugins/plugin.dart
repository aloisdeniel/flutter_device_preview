import 'package:device_preview/src/state/store.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DevicePreviewPlugin {
  final String identifier;
  final String name;
  final IconData icon;
  final Size windowSize;
  final DevicePreviewPluginWidgetBuilder builder;

  const DevicePreviewPlugin({
    @required this.identifier,
    @required this.name,
    @required this.icon,
    this.windowSize,
    this.builder,
  })  : assert(name != null),
        assert(identifier != null),
        assert(icon != null);

  Widget build(BuildContext context) {
    final data = context.select<DevicePreviewStore, Map<String, dynamic>>(
      (state) {
        final plugins = state.data.pluginData;
        return plugins.containsKey(identifier) ? plugins[identifier] : {};
      },
    );
    return buildData(context, data, (data) {
      final store = context.read<DevicePreviewStore>();
      store.data = store.data.copyWith(pluginData: {
        ...store.data.pluginData,
        identifier: data,
      });
    });
  }

  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    DevicePreviewPluginDataUpdater updateData,
  ) {
    assert(builder != null);
    return builder(context, data, updateData);
  }
}

typedef DevicePreviewPluginWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> data,
  DevicePreviewPluginDataUpdater updateData,
);

typedef DevicePreviewPluginDataUpdater = void Function(
  Map<String, dynamic> data,
);

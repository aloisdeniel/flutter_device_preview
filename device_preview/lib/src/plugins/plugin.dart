import 'package:device_preview/src/state/store.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// A plugin definition for device preview.
///
/// It allows to add a dedicate button in the tool bar (with the [icon] and [name]). When the
/// user taps the icon, a window of [windowSize] is opened and its content is built with the
/// [builder].
///
/// The plugin can have preferences data that is saved with the other preferences with
/// the configured [DevicePreviewStorage].
///
/// The windows can contain an inner navigation since it has a [Navigator].
///
/// To define a custom plugin, instead of instantiating a [DevicePreviewPlugin], the class can
/// be inherited and the [buildData] overriden.
///
/// See also :
///
/// * [FileExplorerPlugin] for a file explorer plugin example implementation.
/// * [FileExplorerPlugin] for a file explorer plugin example implementation.
class DevicePreviewPlugin {
  /// Create a new plugin definition.
  const DevicePreviewPlugin({
    required this.identifier,
    required this.name,
    required this.icon,
    this.windowSize = const Size(280, 300),
    this.builder,
  });

  /// The unique identifier of the plugin.
  final String identifier;

  /// The name of the plugin that is displayed in the button and the window name.
  final String name;

  /// The icon of the plugin that is displayed in the button and the window name.
  final IconData icon;

  /// The size of the window that is opened when the user taps on the plugin button
  /// from the toolbar.
  final Size windowSize;

  /// The window content builder.
  final DevicePreviewPluginWidgetBuilder? builder;

  /// Build the window content by observing the plugin's data in storage and
  /// calling [buildData].
  Widget build(BuildContext context) {
    final data = context.select<DevicePreviewStore, Map<String, dynamic>>(
      (state) {
        final plugins = state.data.pluginData;
        return plugins.containsKey(identifier) ? plugins[identifier] ?? {} : {};
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

  /// Build the window content with the given plugin's [data] and the [updateData]
  /// method that saves new data and triggers a new build.
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    DevicePreviewPluginDataUpdater updateData,
  ) {
    assert(builder != null);
    return builder!(context, data, updateData);
  }
}

/// Build the window content with the given plugin's [data] and the [updateData]
/// method that saves new data and triggers a new build.
typedef DevicePreviewPluginWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> data,
  DevicePreviewPluginDataUpdater updateData,
);

/// Update a plugin [data] by saving it to the storage.
typedef DevicePreviewPluginDataUpdater = void Function(
  Map<String, dynamic> data,
);

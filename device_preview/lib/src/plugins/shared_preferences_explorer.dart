import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/views/widgets/popover.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'plugin.dart';

/// A plugin for device preview that allows to explore the local shared preferences
/// of the application.
///
/// An instance should be provided the the [plugins] constructor property of
/// a [DevicePreview].
class SharedPreferencesExplorerPlugin extends DevicePreviewPlugin {
  const SharedPreferencesExplorerPlugin()
      : super(
          identifier: 'shared_preferences_explorer',
          name: 'Shared preferences',
          icon: Icons.storage_rounded,
          windowSize: const Size(320, 480),
        );

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    updateData,
  ) {
    const selectedKey = 'selected_key';
    return Material(
      color: Colors.transparent,
      child: _AllPreferencesView(
        selected: data.containsKey(selectedKey) ? data[selectedKey] : null,
        onKeySelected: (path) => updateData(
          {
            ...data,
            selectedKey: path,
          },
        ),
      ),
    );
  }
}

class _AllPreferencesView extends StatefulWidget {
  final String? selected;
  final ValueChanged<String?> onKeySelected;
  const _AllPreferencesView({
    Key? key,
    required this.selected,
    required this.onKeySelected,
  }) : super(key: key);

  @override
  _AllPreferencesViewState createState() => _AllPreferencesViewState();
}

class _AllPreferencesViewState extends State<_AllPreferencesView> {
  SharedPreferences? preferences;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _update();
    });
    super.initState();
  }

  Future<void> _update() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {});

    if (widget.selected != null) {
      final name = preferences!.getString(widget.selected!);
      if (name != null) {
        await Navigator.push(
          context,
          PopoverPageRoute(
            settings: const RouteSettings(),
            builder: (context) => _PreferencesDetailBody(
              preferenceKey: widget.selected!,
              content: name,
            ),
          ),
        );
      }
      widget.onKeySelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (preferences == null) {
      return const SizedBox();
    }
    final keys = preferences!.getKeys().toList()
      ..sort((x, y) => x.compareTo(y));

    if (keys.isEmpty) {
      return const _Empty();
    }

    return _PreferencesListBody(
      onKeySelected: (key) async {
        widget.onKeySelected(key);
        final name = preferences!.getString(widget.selected!);
        if (name != null) {
          await Navigator.push(
            context,
            PopoverPageRoute(
              settings: const RouteSettings(),
              builder: (context) => _PreferencesDetailBody(
                preferenceKey: key,
                content: name,
              ),
            ),
          );
        }
        widget.onKeySelected(null);
      },
      preferenceKeys:
          keys.map((k) => MapEntry(k, preferences!.get(k).toString())).toList(),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No shared preference'),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final String preferenceKey;
  final String value;
  final VoidCallback onTap;
  const _PreferenceTile({
    Key? key,
    required this.value,
    required this.preferenceKey,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopoverTile(
      onTap: onTap,
      leading: const Icon(Icons.note),
      title: Text(
        preferenceKey,
        maxLines: 1,
      ),
      subtitle: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _PreferencesListBody extends StatelessWidget {
  final List<MapEntry<String, String>> preferenceKeys;
  final ValueChanged<String> onKeySelected;
  const _PreferencesListBody({
    Key? key,
    required this.onKeySelected,
    required this.preferenceKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopoverScaffold(
      title: const PopoverBar(
        title: Text('Keys'),
      ),
      body: ListView(
        children: [
          ...preferenceKeys.map(
            (x) => _PreferenceTile(
              key: Key(x.key),
              value: x.value,
              preferenceKey: x.key,
              onTap: () => onKeySelected(x.key),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferencesDetailBody extends StatelessWidget {
  final String preferenceKey;
  final String content;
  const _PreferencesDetailBody({
    Key? key,
    required this.preferenceKey,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = DevicePreviewTheme.of(context);
    return PopoverScaffold(
      title: PopoverBar(
        title: Text(preferenceKey),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Text(content),
        ),
      ),
    );
  }
}

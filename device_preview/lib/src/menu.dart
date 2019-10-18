import 'package:device_preview/src/locales.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../device_preview.dart';

class DevicePreviewMenu extends StatelessWidget {
  Iterable<Widget> buildItems(
      BuildContext context, NavigatorState rootNavigator) sync* {
    final preview = DevicePreview.of(context);

    yield _SectionHeader("State");
    yield _Action(
        icon: Icons.refresh,
        title: "Restart application",
        onTap: () {
          preview.restart();
          rootNavigator.pop();
        });
    yield _Action(
        icon: Icons.screen_rotation,
        title: "Rotate",
        onTap: () {
          preview.rotate();
          rootNavigator.pop();
        });
    yield _Action(
        icon: Icons.photo_camera,
        title: "Take a screenshot",
        onTap: () async {
          try {
            final screenshot = await preview.screenshot();
            final link = await preview.screenshotUploader.upload(screenshot);
            print("[DevicePreview] Screenshot : $link");
          } catch (e) {
            print("[DevicePreview] Error while uploading screenshot : $e");
          }
          rootNavigator.pop();
        });

    yield _Action(
        icon: Icons.devices,
        title: "${preview.isFrameVisible ? "Hide" : "Show"} device frame",
        onTap: () {
          preview.toggleFrame();
          rootNavigator.pop();
        });

    yield _SectionHeader("Preferences");

    yield _SwitchAction(
        icon: preview.isDarkMode ? Icons.brightness_low : Icons.brightness_high,
        title: "Dark mode",
        initialValue: preview.isDarkMode,
        onChanged: (v) {
          preview.isDarkMode = v;
        });

    yield _SwitchAction(
        icon: Icons.movie_filter,
        title: "Disable animations",
        initialValue: preview.disableAnimations,
        onChanged: (v) {
          preview.disableAnimations = v;
        });

    yield _SwitchAction(
        icon: Icons.invert_colors,
        title: "Invert colors",
        initialValue: preview.invertColors,
        onChanged: (v) {
          preview.invertColors = v;
        });

    yield _SwitchAction(
        icon: Icons.accessibility_new,
        title: "Accessible navigation",
        initialValue: preview.accessibleNavigation,
        onChanged: (v) {
          preview.accessibleNavigation = v;
        });

    yield _SwitchAction(
        icon: Icons.format_bold,
        title: "Bold text",
        initialValue: preview.boldText,
        onChanged: (v) {
          preview.boldText = v;
        });

    yield _SliderAction(
      icon: Icons.text_fields,
      title: "Text scale factor",
      initialValue: preview.textScaleFactor,
      minValue: 0.5,
      maxValue: 3.0,
      onChanged: (v) {
        preview.textScaleFactor = v;
      },
    );

    yield _SectionHeader("Localization");

    yield _PickAction<NamedLocale>(
        icon: Icons.language,
        title: "Locale",
        values: preview.availablesLocales,
        initialValue: preview.availablesLocales
            .firstWhere((x) => x.locale == preview.locale),
        onChanged: (v) {
          preview.locale = v.locale;
        });

    yield _SectionHeader("Device");

    final iosDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.iOS)
        .toList();

    final androidDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.android)
        .toList();

    if (iosDevices.isNotEmpty) {
      yield _GroupHeader("iOS");
      for (var device in iosDevices) {
        yield _DeviceItem(device, () {
          preview.device = device;
          rootNavigator.pop();
        });
      }
    }

    if (androidDevices.isNotEmpty) {
      yield _GroupHeader("Android");
      for (var device in androidDevices) {
        yield _DeviceItem(device, () {
          preview.device = device;
          rootNavigator.pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final rootNavigator = Navigator.of(context);
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        color: Colors.white,
        width: 320,
        child: Material(
          child: Navigator(
            onGenerateRoute: (s) => MaterialPageRoute(
              settings: RouteSettings(isInitialRoute: true),
              builder: (context) => ListView(
                children: buildItems(context, rootNavigator).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final GestureTapCallback onTap;

  final String title;

  final IconData icon;

  _Action({
    @required this.onTap,
    this.icon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
              ),
              const SizedBox(width: 12.0),
            ],
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderAction extends StatelessWidget {
  final ValueChanged<double> onChanged;

  final double initialValue;

  final double maxValue;

  final double minValue;

  final String title;

  final IconData icon;

  _SliderAction({
    @required this.initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.icon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14),
          const SizedBox(width: 12.0),
          Text(title),
          Expanded(
            child: Slider(
              activeColor: theme.accentColor,
              inactiveColor: theme.accentColor.withOpacity(0.2),
              value: initialValue,
              max: maxValue,
              min: minValue,
              onChanged: this.onChanged,
            ),
          ),
          SizedBox(
              width: 36,
              child: Text(
                this.initialValue.toStringAsFixed(1),
              )),
        ],
      ),
    );
  }
}

class _SwitchAction extends StatelessWidget {
  final ValueChanged<bool> onChanged;

  final bool initialValue;

  final String title;

  final IconData icon;

  _SwitchAction({
    @required this.initialValue,
    @required this.onChanged,
    @required this.icon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(title),
          ),
          Switch(
            value: initialValue,
            onChanged: this.onChanged,
          ),
        ],
      ),
    );
  }
}

class _PickPage<T> extends StatefulWidget {
  final T initialValue;
  final List<T> values;
  final String title;
  final IconData icon;

  _PickPage({
    @required this.initialValue,
    @required this.values,
    @required this.icon,
    @required this.title,
  });

  @override
  State<StatefulWidget> createState() {
    return _PickPageState<T>();
  }
}

class _PickPageState<T> extends State<_PickPage<T>> {
  PickPageDelegate<T> _searchDelegate;

  @override
  void initState() {
    _searchDelegate = PickPageDelegate<T>(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(this.widget.icon),
            SizedBox(
              width: 32,
            ),
            Text(this.widget.title),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final selected = await showSearch<T>(
                context: context,
                delegate: _searchDelegate,
              );

              if (selected != null) {
                Navigator.of(context).pop(selected);
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: this
            .widget
            .values
            .map(
              (x) => _Action(
                title: x.toString(),
                onTap: () {
                  Navigator.of(context).pop(x);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class PickPageDelegate<T> extends SearchDelegate<T> {
  final _PickPage<T> widget;

  PickPageDelegate(this.widget);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        this.close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }

  List<T> _filteredValues() {
    return widget.values
        .where((x) => x
            .toString()
            .toLowerCase()
            .trim()
            .contains(this.query.toLowerCase().trim()))
        .toList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: this
          ._filteredValues()
          .map(
            (x) => _Action(
              title: x.toString(),
              onTap: () {
                this.close(context, x);
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: this
          ._filteredValues()
          .map(
            (x) => _Action(
              title: x.toString(),
              onTap: () {
                this.close(context, x);
              },
            ),
          )
          .toList(),
    );
  }
}

class _PickAction<T> extends StatelessWidget {
  final ValueChanged<T> onChanged;

  final T initialValue;

  final List<T> values;

  final String title;

  final IconData icon;

  _PickAction({
    @required this.initialValue,
    @required this.onChanged,
    @required this.values,
    @required this.icon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => _PickPage<T>(
              title: this.title,
              icon: this.icon,
              initialValue: this.initialValue,
              values: this.values,
            ),
          ),
        );
        if (result != null) {
          this.onChanged(result);
        }
      },
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 14),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(title),
            ),
            Text(
              initialValue?.toString(),
              style: TextStyle(
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final String title;

  _GroupHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 12.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 10.0, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 12.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 8.0),
          Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1,
          ),
        ],
      ),
    );
  }
}

class _DeviceItem extends StatelessWidget {
  final Device device;
  final GestureTapCallback onTap;

  _DeviceItem(this.device, this.onTap);

  IconData _icon() {
    switch (device.type) {
      case DeviceType.tablet:
        return Icons.tablet_android;
        break;
      case DeviceType.watch:
        return Icons.watch;
        break;
      case DeviceType.desktop:
        return Icons.desktop_mac;
        break;
      case DeviceType.tv:
        return Icons.tv;
        break;
      case DeviceType.freeform:
        return Icons.photo_size_select_small;
        break;
      default:
        return Icons.phone_android;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final isSelected = preview.device == device;
    final foreground = Theme.of(context)
        .primaryTextTheme
        .display1
        .color
        .withOpacity(isSelected ? 1 : 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      child: InkWell(
        onTap: !isSelected ? this.onTap : null,
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(width: 12.0, child: Icon(_icon(), size: 14)),
              SizedBox(width: 12.0),
              Expanded(
                  child:
                      Text(device.name, style: TextStyle(color: foreground))),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:device_preview/src/locales.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../device_preview.dart';

class DevicePreviewMenu extends StatefulWidget {
  @override
  _DevicePreviewMenuState createState() => _DevicePreviewMenuState();
}

class _DevicePreviewMenuState extends State<DevicePreviewMenu> {
  bool _isOpen = false;

  void open() {
    if (!_isOpen) setState(() => _isOpen = true);
  }

  void close() {
    if (_isOpen) setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
      layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              key: bottomChildKey,
              child: bottomChild,
            ),
            Positioned.fill(
              key: topChildKey,
              child: topChild,
            ),
          ],
        );
      },
      firstChild: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white60,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.settings),
          ),
          onTap: open,
        ),
      ),
      secondChild: IgnorePointer(
        ignoring: !_isOpen,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              key: Key('barrier'),
              child: GestureDetector(
                onTap: () {
                  close();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  color: _isOpen ? Colors.black45 : Colors.transparent,
                  child: SizedBox(),
                ),
              ),
            ),
            Positioned(
              key: Key('drawer'),
              top: 0,
              bottom: 0,
              left: 0,
              width: 320,
              child: DevicePreviewDrawer(),
            ),
          ],
        ),
      ),
    );
  }
}

class DevicePreviewDrawer extends StatelessWidget {
  Iterable<Widget> buildItems(BuildContext context) sync* {
    final preview = DevicePreview.of(context);
    final root = context.findAncestorStateOfType<_DevicePreviewMenuState>();
    yield _SectionHeader('State');
    yield _Action(
        icon: Icons.refresh,
        title: 'Restart application',
        onTap: () {
          preview.restart();
          root.close();
        });
    yield _Action(
        icon: Icons.screen_rotation,
        title: 'Rotate',
        onTap: () {
          preview.rotate();
          root.close();
        });
    yield _Action(
        icon: Icons.photo_camera,
        title: 'Take a screenshot',
        onTap: () async {
          try {
            final screenshot = await preview.screenshot();
            final link = await preview.screenshotUploader.upload(screenshot);
            print('[DevicePreview] Screenshot : $link');
          } catch (e) {
            print('[DevicePreview] Error while uploading screenshot : $e');
          }
          root.close();
        });

    yield _Action(
        icon: Icons.devices,
        title: '${preview.isFrameVisible ? "Hide" : "Show"} device frame',
        onTap: () {
          preview.toggleFrame();
          root.close();
        });

    yield _SectionHeader('Preferences');

    yield _SwitchAction(
        icon: preview.isDarkMode ? Icons.brightness_low : Icons.brightness_high,
        title: 'Dark mode',
        initialValue: preview.isDarkMode,
        onChanged: (v) {
          preview.isDarkMode = v;
        });

    yield _SwitchAction(
        icon: Icons.movie_filter,
        title: 'Disable animations',
        initialValue: preview.disableAnimations,
        onChanged: (v) {
          preview.disableAnimations = v;
        });

    yield _SwitchAction(
        icon: Icons.invert_colors,
        title: 'Invert colors',
        initialValue: preview.invertColors,
        onChanged: (v) {
          preview.invertColors = v;
        });

    yield _SwitchAction(
        icon: Icons.accessibility_new,
        title: 'Accessible navigation',
        initialValue: preview.accessibleNavigation,
        onChanged: (v) {
          preview.accessibleNavigation = v;
        });

    yield _SwitchAction(
        icon: Icons.format_bold,
        title: 'Bold text',
        initialValue: preview.boldText,
        onChanged: (v) {
          preview.boldText = v;
        });

    yield _SliderAction(
      icon: Icons.text_fields,
      title: 'Text scale factor',
      initialValue: preview.textScaleFactor,
      minValue: 0.5,
      maxValue: 3.0,
      onChanged: (v) {
        preview.textScaleFactor = v;
      },
    );

    yield _SectionHeader('Localization');

    yield _PickAction<NamedLocale>(
        icon: Icons.language,
        title: 'Locale',
        values: preview.availablesLocales,
        initialValue: preview.availablesLocales
            .firstWhere((x) => x.locale == preview.locale),
        onChanged: (v) {
          preview.locale = v.locale;
        });

    yield _SectionHeader('Device');

    final iosDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.iOS)
        .toList();

    final androidDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.android)
        .toList();

    if (iosDevices.isNotEmpty) {
      yield _GroupHeader('iOS');
      for (var device in iosDevices) {
        yield _DeviceItem(device, () {
          preview.device = device;
          root.close();
        });
      }
    }

    if (androidDevices.isNotEmpty) {
      yield _GroupHeader('Android');
      for (var device in androidDevices) {
        yield _DeviceItem(device, () {
          preview.device = device;
          root.close();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        color: Colors.white,
        width: 320,
        child: MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: Material(
            child: ListView(
              children: buildItems(context).toList(),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
              ),
              const SizedBox(width: 12),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14),
          const SizedBox(width: 12),
          Text(title),
          Expanded(
            child: Slider(
              activeColor: theme.accentColor,
              inactiveColor: theme.accentColor.withOpacity(0.2),
              value: initialValue,
              max: maxValue,
              min: minValue,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
              width: 36,
              child: Text(
                initialValue.toStringAsFixed(1),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title),
          ),
          Switch(
            value: initialValue,
            onChanged: onChanged,
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
            Icon(widget.icon),
            SizedBox(
              width: 32,
            ),
            Text(widget.title),
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
        children: widget.values
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
        close(context, null);
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
            .contains(query.toLowerCase().trim()))
        .toList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: _filteredValues()
          .map(
            (x) => _Action(
              title: x.toString(),
              onTap: () {
                close(context, x);
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: _filteredValues()
          .map(
            (x) => _Action(
              title: x.toString(),
              onTap: () {
                close(context, x);
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
              title: title,
              icon: icon,
              initialValue: initialValue,
              values: values,
            ),
          ),
        );
        if (result != null) {
          onChanged(result);
        }
      },
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 14),
            const SizedBox(width: 12),
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
      padding: const EdgeInsets.only(top: 24, left: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 10, color: Colors.grey)),
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
      padding: const EdgeInsets.only(top: 32, left: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 8),
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
        .headline4
        .color
        .withOpacity(isSelected ? 1 : 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      child: InkWell(
        onTap: !isSelected ? onTap : null,
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: 12,
                child: Icon(
                  _icon(),
                  size: 14,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  device.name,
                  style: TextStyle(color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LocalesPopOver extends StatefulWidget {
  @override
  _LocalesPopOverState createState() => _LocalesPopOverState();
}

class _LocalesPopOverState extends State<LocalesPopOver> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    final locales = context.select(
      (DevicePreviewStore store) => store.locales,
    );
    return Column(
      children: <Widget>[
        LocaleTools(
          filter: filter,
          onFilterChanged: (v) => setState(() => filter = v),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: locales
                .where((x) {
                  final filter = this.filter.trim().toLowerCase();
                  return filter.isEmpty ||
                      x.name.toLowerCase().contains(filter) ||
                      x.code.toLowerCase().contains(filter);
                })
                .map((x) => LocaleTile(x))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class LocaleTools extends StatefulWidget {
  final String filter;
  final ValueChanged<String> onFilterChanged;

  const LocaleTools({
    @required this.filter,
    @required this.onFilterChanged,
  });

  @override
  _LocaleToolsState createState() => _LocaleToolsState();
}

class _LocaleToolsState extends State<LocaleTools> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.filter);
    super.initState();
  }

  @override
  void didUpdateWidget(LocaleTools oldWidget) {
    if (controller.text != widget.filter) {
      controller.text = widget.filter;
      setState(() => {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return Material(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: toolBarStyle.backgroundColor,
        child: SizedBox(
          height: 34,
          child: TextField(
            style: TextStyle(
              fontSize: 11,
              color: toolBarStyle.foregroundColor,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: toolBarStyle.foregroundColor.withOpacity(0.12),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: toolBarStyle.foregroundColor.withOpacity(0.12),
              ),
            ),
            controller: controller,
            onChanged: widget.onFilterChanged,
          ),
        ),
      ),
    );
  }
}

class LocaleTile extends StatelessWidget {
  final NamedLocale locale;

  const LocaleTile(this.locale);

  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.select(
      (DevicePreviewStore store) => store.data.locale,
    );
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    final isSelected = selectedLocale == locale.code;
    return GestureDetector(
      onTap: !isSelected
          ? () {
              final store = context.read<DevicePreviewStore>();
              store.data = store.data.copyWith(locale: locale.code);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                locale.name,
                style: TextStyle(
                    fontSize: 12, color: toolBarStyle.foregroundColor),
              ),
              Text(
                locale.code,
                style: TextStyle(
                  fontSize: 11,
                  color: toolBarStyle.foregroundColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:device_preview/src/views/device_preview_style.dart';
import 'package:device_preview/src/views/widgets/popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LocalesPopOver extends StatefulWidget {
  const LocalesPopOver({Key? key}) : super(key: key);

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
    final theme = DevicePreviewTheme.of(context);
    return Column(
      children: <Widget>[
        PopoverSearchField(
          hintText: 'Search by locale name or code',
          text: filter,
          onTextChanged: (value) => setState(() => filter = value),
        ),
        Expanded(
          child: ListView(
            padding: theme.toolBar.spacing.regular,
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

class LocaleTile extends StatelessWidget {
  final NamedLocale locale;

  const LocaleTile(
    this.locale, {
    Key? key,
  }) : super(key: key);

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
        color: isSelected
            ? toolBarStyle.foregroundColor.withOpacity(0.18)
            : Colors.transparent,
        child: Padding(
          padding: toolBarStyle.spacing.regular,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                locale.name,
                style: TextStyle(
                  fontSize: 12,
                  color: toolBarStyle.foregroundColor,
                ),
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

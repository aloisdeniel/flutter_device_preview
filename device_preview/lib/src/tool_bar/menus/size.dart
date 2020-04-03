import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../device_preview_style.dart';

class SizePopOver extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const SizePopOver({
    @required this.value,
    @required this.onChanged,
  });

  static final List<double> allValues =
      List.generate(22, (index) => (index + 1) * 128.0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: allValues
          .map<Widget>(
            (x) => SizeTile(
              value: x,
              onChanged: onChanged,
              isSelected: value == x,
            ),
          )
          .toList(),
    );
  }
}

class SizeTile extends StatelessWidget {
  final double value;
  final bool isSelected;
  final ValueChanged<double> onChanged;

  const SizeTile({
    @required this.value,
    @required this.isSelected,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final toolBarStyle = DevicePreviewTheme.of(context).toolBar;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: toolBarStyle.foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

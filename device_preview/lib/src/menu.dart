import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../device_preview.dart';

class DevicePreviewMenu extends StatelessWidget {
  Iterable<Widget> buildItems(BuildContext context) sync* {
    final preview = DevicePreview.of(context);
    final iosDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.iOS)
        .toList();

    final androidDevices = preview.availableDevices
        .where((x) => x.platform == TargetPlatform.android)
        .toList();

    yield _Action(
        icon: Icons.refresh,
        title: "Restart application",
        onTap: () {
          preview.restart();
        });

    if (iosDevices.isNotEmpty) {
      yield _SectionHeader("iOS");
      for (var device in iosDevices) {
        yield _DeviceItem(device);
      }
    }

    if (androidDevices.isNotEmpty) {
      yield _SectionHeader("Android");
      for (var device in androidDevices) {
        yield _DeviceItem(device);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        color: Colors.white,
        width: 300,
        child:
            Material(child: ListView(children: buildItems(context).toList())),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final GestureTapCallback onTap;

  final String title;

  final IconData icon;

  _Action({@required this.onTap, @required this.icon, @required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 14),
            SizedBox(width: 12.0),
            Expanded(child: Text(title)),
          ],
        ),
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
      padding: const EdgeInsets.only(top: 32.0, left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8.0),
          Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1,
          )
        ],
      ),
    );
  }
}

class _DeviceItem extends StatelessWidget {
  final Device device;

  _DeviceItem(this.device);

  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final isSelected = preview.device == device;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      child: InkWell(
        onTap: !isSelected
            ? () {
                preview.device = device;
                Navigator.pop(context);
              }
            : null,
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                  width: 12.0,
                  child:
                      (isSelected ? Icon(Icons.check, size: 14) : SizedBox())),
              SizedBox(width: 12.0),
              Expanded(child: Text(device.name)),
            ],
          ),
        ),
      ),
    );
  }
}

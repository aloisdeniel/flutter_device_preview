import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'plugin.dart';

class FileExplorerPlugin extends DevicePreviewPlugin {
  const FileExplorerPlugin()
      : super(
          identifier: 'file_explorer',
          name: 'File explorer',
          icon: Icons.folder,
          windowSize: const Size(320, 500),
        );

  @override
  Widget buildData(
      BuildContext context, Map<String, dynamic> data, updateData) {
    const selectedKey = 'selected_path';
    return _DirectoryView(
      selected: data.containsKey(selectedKey) ? data[selectedKey] : null,
      onItemSelected: (path) => updateData(
        {
          ...data,
          selectedKey: path,
        },
      ),
    );
  }
}

class _DirectoryView extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onItemSelected;
  const _DirectoryView({
    Key key,
    @required this.selected,
    @required this.onItemSelected,
  }) : super(key: key);

  @override
  _DirectoryViewState createState() => _DirectoryViewState();
}

class _DirectoryViewState extends State<_DirectoryView> {
  FileSystemEntity entity;
  List<FileSystemEntity> children;
  FileStat stat;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
    });
    super.initState();
  }

  Future<void> _update() async {
    final selected =
        widget.selected ?? (await getApplicationDocumentsDirectory()).path;
    final type = await FileSystemEntity.type(selected);
    if (type == FileSystemEntityType.file) {
      final file = File(selected);
      final stat = await file.stat();
      setState(() {
        entity = file;
        this.stat = stat;
      });
    } else if (type == FileSystemEntityType.directory) {
      final directory = Directory(selected);
      final children = await directory.list().toList();
      setState(() {
        entity = directory;
        this.children = children;
      });
    }
  }

  @override
  void didUpdateWidget(covariant _DirectoryView oldWidget) {
    if (widget.selected != oldWidget.selected) {
      _update();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (entity == null) {
      return SizedBox();
    }
    if (entity is Directory) {
      return ListView(
        children: [
          ...children.map(
            (x) => x is File
                ? _FileTile(
                    key: Key(x.path),
                    file: File(x.path),
                  )
                : _DirectoryTile(
                    key: Key(x.path),
                    file: Directory(x.path),
                  ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Text(path.basename(entity.path)),
        Text(stat.size.toString()),
      ],
    );
  }
}

class _FileTile extends StatelessWidget {
  final File file;
  const _FileTile({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.file_copy),
      title: Text(
        path.basename(file.path),
      ),
    );
  }
}

class _DirectoryTile extends StatelessWidget {
  final Directory file;
  const _DirectoryTile({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.folder),
      title: Text(
        path.basename(file.path),
      ),
    );
  }
}

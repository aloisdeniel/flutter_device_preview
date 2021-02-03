import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/views/widgets/popover.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:pedantic/pedantic.dart';

import 'plugin.dart';

/// A plugin for device preview that allows to explore the local file system
/// of the application.
///
/// An instance should be provided the the [plugins] constructor property of
/// a [DevicePreview].
class FileExplorerPlugin extends DevicePreviewPlugin {
  /// Create the file explorer plugin.
  const FileExplorerPlugin()
      : super(
          identifier: 'file_explorer',
          name: 'File explorer',
          icon: Icons.folder,
          windowSize: const Size(320, 480),
        );

  @override
  Widget buildData(
      BuildContext context, Map<String, dynamic> data, updateData) {
    const selectedKey = 'selected_path';
    return Material(
      color: Colors.transparent,
      child: _Root(
        selected: data.containsKey(selectedKey) ? data[selectedKey] : null,
        onPathSelected: (path) => updateData(
          {
            ...data,
            selectedKey: path,
          },
        ),
      ),
    );
  }
}

class _Root extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onPathSelected;
  const _Root({
    Key key,
    @required this.onPathSelected,
    @required this.selected,
  }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<_Root> {
  List<FileSystemEntity> directories = [];
  FileSystemEntityType type;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
    });
    super.initState();
  }

  Future<void> _update() async {
    directories.clear();
    try {
      directories.add(await getApplicationDocumentsDirectory());
      // ignore: empty_catches
    } catch (e) {}
    try {
      directories.add(await getApplicationSupportDirectory());
      // ignore: empty_catches
    } catch (e) {}
    try {
      directories.add(await getTemporaryDirectory());
      // ignore: empty_catches
    } catch (e) {}
    try {
      directories.add(await getLibraryDirectory());
      // ignore: empty_catches
    } catch (e) {}
    try {
      directories.add(await getDownloadsDirectory());
      // ignore: empty_catches
    } catch (e) {}
    setState(() {});

    if (widget.selected != null) {
      var selected = widget.selected;
      var baseDir = directories.firstWhere(
        (x) => selected.startsWith(x.path),
        orElse: () => null,
      );

      if (baseDir != null) {
        selected = selected.replaceFirst(baseDir.path, '');
        final navigator = Navigator.of(
          context,
        );
        unawaited(
          navigator
              .push(
                PopoverPageRoute(
                  builder: (context) => _DirectoryView(
                    directory: baseDir,
                    onPathSelected: widget.onPathSelected,
                  ),
                ),
              )
              .then(
                (value) => widget.onPathSelected(null),
              ),
        );

        // Then navigate to subdirectory
        final splits = path
            .split(selected)
            .where((x) => x.isNotEmpty && x != '/' && x != '\\')
            .toList();
        var current = baseDir.path;
        for (var item in splits) {
          final previousCurrent = current;
          current = path.join(current, item);
          final type = await FileSystemEntity.type(current);
          unawaited(
            navigator
                .push(
                  PopoverPageRoute(
                    builder: (context) => type == FileSystemEntityType.directory
                        ? _DirectoryView(
                            directory: Directory(current),
                            onPathSelected: widget.onPathSelected,
                          )
                        : _FileView(
                            file: File(current),
                          ),
                  ),
                )
                .then(
                  (value) => widget.onPathSelected(previousCurrent),
                ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopoverScaffold(
      title: PopoverBar(
        title: Text('Application directories'),
      ),
      body: _FileList(
        children: directories,
        onPathSelected: widget.onPathSelected,
      ),
    );
  }
}

class _DirectoryView extends StatefulWidget {
  final Directory directory;
  final ValueChanged<String> onPathSelected;
  const _DirectoryView({
    Key key,
    @required this.directory,
    @required this.onPathSelected,
  }) : super(key: key);

  @override
  _DirectoryViewState createState() => _DirectoryViewState();
}

class _DirectoryViewState extends State<_DirectoryView> {
  List<FileSystemEntity> children;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
    });
    super.initState();
  }

  Future<void> _update() async {
    final children = await widget.directory.list().toList();
    setState(() {
      this.children = children;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopoverScaffold(
      title: PopoverBar(
        title: Text(path.basename(widget.directory.path)),
      ),
      body: (children == null)
          ? SizedBox()
          : ((children.isEmpty)
              ? _Empty()
              : _FileList(
                  children: children,
                  onPathSelected: widget.onPathSelected,
                )),
    );
  }
}

class _FileList extends StatelessWidget {
  final List<FileSystemEntity> children;
  final ValueChanged<String> onPathSelected;
  const _FileList({
    Key key,
    @required this.children,
    @required this.onPathSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...children
            .where(
              (x) => x is File || x is Directory,
            )
            .map((child) => child is Directory
                ? _DirectoryTile(
                    directory: child,
                    onTap: () async {
                      onPathSelected(child.path);
                      await Navigator.push(
                        context,
                        PopoverPageRoute(
                          builder: (context) => _DirectoryView(
                            directory: child,
                            onPathSelected: onPathSelected,
                          ),
                        ),
                      );
                    },
                  )
                : _FileTile(
                    file: child,
                    onTap: () async {
                      onPathSelected(child.path);
                      await Navigator.push(
                        context,
                        PopoverPageRoute(
                          builder: (context) => _FileView(
                            file: child,
                          ),
                        ),
                      );
                    },
                  )),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No file '),
    );
  }
}

class _DirectoryTile extends StatelessWidget {
  final Directory directory;
  final VoidCallback onTap;
  const _DirectoryTile({
    Key key,
    @required this.directory,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopoverTile(
      onTap: onTap,
      leading: Icon(Icons.folder),
      title: Text(
        path.basename(directory.path),
        maxLines: 1,
      ),
    );
  }
}

class _FileTile extends StatelessWidget {
  final File file;
  final VoidCallback onTap;
  const _FileTile({
    Key key,
    @required this.file,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopoverTile(
      onTap: onTap,
      leading: Icon(Icons.file_copy),
      title: Text(
        path.basename(file.path),
        maxLines: 1,
      ),
    );
  }
}

class _FileView extends StatefulWidget {
  final File file;
  const _FileView({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  _FileViewState createState() => _FileViewState();
}

class _FileViewState extends State<_FileView> {
  String content;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
    });
    super.initState();
  }

  Future<void> _update() async {
    final ext = path.extension(widget.file.path).toLowerCase();

    switch (ext) {
      case '.txt':
      case '.json':
        content = await widget.file.readAsString();
        break;
      default:
        final stat = await widget.file.stat();
        content = 'size: ${stat.size} bytes';
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = DevicePreviewTheme.of(context);
    return PopoverScaffold(
      title: PopoverBar(
        title: Text(path.basename(widget.file.path)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: theme.toolBar.spacing.regular,
          child: Text(content ?? ''),
        ),
      ),
    );
  }
}

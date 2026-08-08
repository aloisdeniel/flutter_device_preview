// Todo — the third demo app embedded in the landing page (`docs/index.html`):
// a small but structurally realistic app, exercising the surfaces a
// simulation interacts with the most:
//
//  * a scrollable main list under an app bar and above the safe areas,
//  * a bottom modal sheet (the add flow) that rides the keyboard's
//    `viewInsets` and the bottom safe area,
//  * page navigation (task → its subtasks),
//  * confirmation dialogs (delete, from each item's menu button), and
//  * snack bars confirming every mutation.
//
// Like the other demos, it is an ordinary Flutter app: the only
// device_preview-specific lines are in [main]. Build the web bundle with
// `tool/build_demo.sh` at the root of the repository.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'src/demo_bridge.dart';
import 'src/demo_theme.dart';

void main() {
  // `true` rather than the default: the demo is a *release* web build, where
  // simulation would otherwise be off.
  DevicePreview.enable(enabled: true, padding: const EdgeInsets.all(16));
  connectDemoPanel(DevicePreview.maybeController);
  runApp(const TodoApp());
}

/// A task: a title, a done flag and — for top-level tasks — subtasks.
class TodoItem {
  /// Creates a task.
  TodoItem(this.title, {this.done = false, List<TodoItem>? subtasks})
    : subtasks = subtasks ?? <TodoItem>[];

  /// The user-entered title.
  final String title;

  /// Whether the task is checked off.
  bool done;

  /// The task's subtasks (unused on subtasks themselves).
  final List<TodoItem> subtasks;
}

/// Root widget of the todo demo.
class TodoApp extends StatelessWidget {
  /// Creates the todo demo app.
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'device_preview todo',
      debugShowCheckedModeBanner: false,
      // ThemeMode.system follows the simulated platform brightness.
      theme: demoTheme(demoLightScheme),
      darkTheme: demoTheme(demoDarkScheme),
      home: TodoListPage(items: _seed()),
    );
  }

  /// Starter content, so the demo never opens on an empty screen.
  static List<TodoItem> _seed() => <TodoItem>[
    TodoItem(
      'Prepare the release',
      subtasks: <TodoItem>[
        TodoItem('Update the changelog', done: true),
        TodoItem('Run the test suite'),
        TodoItem('Tag the version'),
      ],
    ),
    TodoItem(
      'Try device_preview',
      done: true,
      subtasks: <TodoItem>[
        TodoItem('Pick a device in the panel', done: true),
        TodoItem('Rotate it', done: true),
        TodoItem('Push the text scale to 2.0'),
      ],
    ),
    TodoItem('Water the plants'),
  ];
}

/// Shows the bottom sheet asking for a title; returns it, or null when
/// dismissed.
///
/// `isScrollControlled` + the `viewInsets` padding keep the field above the
/// software keyboard — under a simulated device the keyboard inset is mapped
/// into simulated space, so this is a good place to watch it work.
Future<String?> _promptForTitle(BuildContext context, {required String hint}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (BuildContext context) => _TitleSheet(hint: hint),
  );
}

/// The content of the add sheet; owns the text controller so it outlives the
/// sheet's exit animation.
class _TitleSheet extends StatefulWidget {
  const _TitleSheet({required this.hint});

  final String hint;

  @override
  State<_TitleSheet> createState() => _TitleSheetState();
}

class _TitleSheetState extends State<_TitleSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final String title = _controller.text.trim();
    Navigator.of(context).pop(title.isEmpty ? null : title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: widget.hint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

/// Asks for confirmation before deleting [title]; resolves to true on
/// confirm.
Future<bool> _confirmDelete(BuildContext context, String title) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Delete task?'),
      content: Text('"$title" and everything in it will be removed.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// The action toast shown after every mutation.
void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
    );
}

/// The main list of tasks.
class TodoListPage extends StatefulWidget {
  /// Creates the main list over [items].
  const TodoListPage({super.key, required this.items});

  /// The mutable task list backing the page.
  final List<TodoItem> items;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Future<void> _add() async {
    final String? title = await _promptForTitle(context, hint: 'New task');
    if (title == null || !mounted) {
      return;
    }
    setState(() => widget.items.add(TodoItem(title)));
    _toast(context, 'Added "$title"');
  }

  Future<void> _delete(TodoItem item) async {
    if (!await _confirmDelete(context, item.title) || !mounted) {
      return;
    }
    setState(() => widget.items.remove(item));
    _toast(context, 'Deleted "${item.title}"');
  }

  Future<void> _open(TodoItem item) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => TaskPage(task: item)),
    );
    // Subtask counts may have changed while the detail page was up.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        padding: EdgeInsets.only(
          bottom: 88 + MediaQuery.paddingOf(context).bottom,
        ),
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final TodoItem item = widget.items[index];
          final int total = item.subtasks.length;
          final int done = item.subtasks.where((TodoItem s) => s.done).length;
          return _TodoTile(
            item: item,
            subtitle: total == 0 ? null : '$done of $total subtasks done',
            onToggle: (bool? value) =>
                setState(() => item.done = value ?? false),
            onTap: () => _open(item),
            onDelete: () => _delete(item),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// A task's page: its subtasks, with the same add / delete / toast flows.
class TaskPage extends StatefulWidget {
  /// Creates the page for [task].
  const TaskPage({super.key, required this.task});

  /// The task whose subtasks are shown.
  final TodoItem task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<void> _add() async {
    final String? title = await _promptForTitle(context, hint: 'New subtask');
    if (title == null || !mounted) {
      return;
    }
    setState(() => widget.task.subtasks.add(TodoItem(title)));
    _toast(context, 'Added "$title"');
  }

  Future<void> _delete(TodoItem subtask) async {
    if (!await _confirmDelete(context, subtask.title) || !mounted) {
      return;
    }
    setState(() => widget.task.subtasks.remove(subtask));
    _toast(context, 'Deleted "${subtask.title}"');
  }

  @override
  Widget build(BuildContext context) {
    final List<TodoItem> subtasks = widget.task.subtasks;
    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title)),
      body: subtasks.isEmpty
          ? Center(
              child: Text(
                'No subtasks yet.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                bottom: 88 + MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: subtasks.length,
              itemBuilder: (BuildContext context, int index) {
                final TodoItem subtask = subtasks[index];
                return _TodoTile(
                  item: subtask,
                  onToggle: (bool? value) =>
                      setState(() => subtask.done = value ?? false),
                  onDelete: () => _delete(subtask),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add subtask',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// One task row: checkbox, title, optional subtitle, and the item menu.
class _TodoTile extends StatelessWidget {
  const _TodoTile({
    required this.item,
    this.subtitle,
    required this.onToggle,
    this.onTap,
    required this.onDelete,
  });

  final TodoItem item;
  final String? subtitle;
  final ValueChanged<bool?> onToggle;
  final VoidCallback? onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Checkbox(value: item.done, onChanged: onToggle),
      title: Text(
        item.title,
        style: item.done
            ? TextStyle(
                color: colors.onSurfaceVariant,
                decoration: TextDecoration.lineThrough,
              )
            : null,
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      onTap: onTap ?? () => onToggle(!item.done),
      trailing: MenuAnchor(
        menuChildren: <Widget>[
          MenuItemButton(
            leadingIcon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
            child: const Text('Delete'),
          ),
        ],
        builder:
            (BuildContext context, MenuController menu, Widget? child) =>
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Task menu',
                  onPressed: () => menu.isOpen ? menu.close() : menu.open(),
                ),
      ),
    );
  }
}

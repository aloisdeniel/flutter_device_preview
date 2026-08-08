// Smoke coverage for the todo demo (`lib/todo.dart`): adding a task through
// the bottom sheet, navigating into a task, adding a subtask, and deleting
// through the item menu's confirmation dialog — each confirmed by a toast.

import 'package:device_preview_example/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adds a task through the bottom sheet and toasts it', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();

    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.text('Added "Buy milk"'), findsOneWidget); // the SnackBar
  });

  testWidgets('opens a task and adds a subtask inside it', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.text('Prepare the release'));
    await tester.pumpAndSettle();
    // On the task page now: its subtasks are visible.
    expect(find.text('Run the test suite'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Write release notes');
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();
    expect(find.text('Write release notes'), findsOneWidget);

    // Back on the list, the subtask count includes the new one.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('1 of 4 subtasks done'), findsOneWidget);
  });

  testWidgets('deletes a task from its menu after confirming', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TodoApp());
    expect(find.text('Water the plants'), findsOneWidget);

    await tester.tap(find.byTooltip('Task menu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // The confirmation dialog names the task; cancel keeps it.
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Water the plants'), findsOneWidget);

    // Confirming removes it and toasts.
    await tester.tap(find.byTooltip('Task menu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Water the plants'), findsNothing);
    expect(find.text('Deleted "Water the plants"'), findsOneWidget);
  });
}

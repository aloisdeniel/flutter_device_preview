// Smoke coverage for the todo demo (`lib/todo.dart`): adding a task through
// the bottom sheet, navigating into a task, adding a subtask, and deleting
// through the item menu's confirmation dialog — each confirmed by a toast.
// On a screen split by a vertical fold, selection fills the pane right of
// the crease instead of pushing a route.

import 'dart:ui' as ui;

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

  testWidgets('a vertical fold shows subtasks beside the list, not pushed', (
    WidgetTester tester,
  ) async {
    // The Pixel 10 Pro Fold, unfolded: 852x883 logical, zero-width fold at
    // mid-width — exactly what its preset simulates.
    tester.view.devicePixelRatio = 2.4375;
    tester.view.physicalSize = const Size(852, 883) * 2.4375;
    tester.view.displayFeatures = const <ui.DisplayFeature>[
      ui.DisplayFeature(
        bounds: Rect.fromLTRB(426, 0, 426, 883),
        type: ui.DisplayFeatureType.fold,
        state: ui.DisplayFeatureState.postureFlat,
      ),
    ];
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const TodoApp());

    // Before a selection: the placeholder pane.
    expect(find.text('Select a task to see its subtasks.'), findsOneWidget);

    await tester.tap(find.text('Prepare the release'));
    await tester.pumpAndSettle();

    // The subtasks appear while the list stays on screen — no route pushed,
    // so there is no back button anywhere.
    expect(find.text('Run the test suite'), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    // Mutations in the pane refresh the list's counts live: "Prepare the
    // release" joins "Try device_preview" at 2 of 3.
    expect(find.text('1 of 3 subtasks done'), findsOneWidget);
    await tester.tap(find.text('Run the test suite'));
    await tester.pumpAndSettle();
    expect(find.text('1 of 3 subtasks done'), findsNothing);
    expect(find.text('2 of 3 subtasks done'), findsNWidgets(2));

    // Everything left of the fold belongs to the list pane (the selected
    // task's title also titles the detail pane's app bar), everything right
    // of it to the detail pane.
    expect(
      tester
          .getBottomRight(find.widgetWithText(ListTile, 'Prepare the release'))
          .dx,
      lessThanOrEqualTo(426),
    );
    expect(
      tester.getTopLeft(find.text('Run the test suite')).dx,
      greaterThan(426),
    );

    // Selecting another task swaps the pane.
    await tester.tap(find.text('Try device_preview'));
    await tester.pumpAndSettle();
    expect(find.text('Rotate it'), findsOneWidget);
    expect(find.text('Run the test suite'), findsNothing);
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

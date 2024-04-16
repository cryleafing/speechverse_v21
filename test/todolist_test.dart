import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speechverse_v2/screens/to_do_list.dart';

void main() {
  testWidgets('To-Do List page test', (WidgetTester tester) async {
    // Mock database helper and provide it to the widget

    await tester.pumpWidget(const MaterialApp(home: TodoList()));

    // Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.pumpAndSettle();

    // Tap the 'Add Task' button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
    await tester
        .pumpAndSettle(); // Wait for any async tasks to complete and UI to build

    // Verify that the task appears
    expect(find.text('New Task'), findsOneWidget);
  });
}

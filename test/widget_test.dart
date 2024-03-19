// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'counter_widget.dart';

void main() {
  testWidgets('Counter Widget Test', (WidgetTester tester) async {
    // Build the widget under test
    await tester.pumpWidget(const MaterialApp(
      home: CounterWidget(),
    ));

    // Verify the initial state of the counter
    expect(find.text('0'), findsOneWidget);

    // Tap the increment button
    await tester.tap(find.byKey(const Key('increment_button')));
    await tester.pump(); // Rebuild the widget after the button tap

    // Verify that the counter is incremented
    expect(find.text('1'), findsOneWidget);
  });
}

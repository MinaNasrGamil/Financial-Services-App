import 'package:finance_app/view/screens/contact_us_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ContactUs form validation', (tester) async {
    // Wrap in MaterialApp to provide Scaffold
    await tester.pumpWidget(
      MaterialApp(home: ContactUsScreen()),
    );

    // Ensure the submit button is visible
    final submitFinder = find.text('Submit');
    await tester.ensureVisible(submitFinder);

    // Tap button and pump to trigger validation
    await tester.tap(submitFinder);
    await tester.pump();

    // Expect three validation errors under the fields
    expect(find.text('This field is required'), findsNWidgets(3));
  });
}

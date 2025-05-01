import 'package:finance_app/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeScreen shows 4 menu buttons', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Our Products'), findsOneWidget);
    expect(find.text('Submit Complaint'), findsOneWidget);
    expect(find.text('About Company'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hungryhive/main.dart';

void main() {
  testWidgets('Phone Login Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const HungryHive());

    // Check main texts
    expect(find.text('WELCOME'), findsOneWidget);
    expect(find.text('Continue with Number'), findsOneWidget);

    // Check phone icon
    expect(find.byIcon(Icons.phone), findsOneWidget);

    // Ensure unwanted elements are NOT present
    expect(find.text('Continue with Google'), findsNothing);
    expect(find.text('Create an Account'), findsNothing);
  });
}
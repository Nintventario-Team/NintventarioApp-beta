import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/sale_spots.dart';

void main() {
  /// Test to verify the presence of greeting text
  testWidgets('Verify greeting text', (WidgetTester tester) async {
    // Build the SaleSptosPage widget
    await tester.pumpWidget(const MaterialApp(home: SaleSptosPage()));

    // Verify if the greeting text is displayed correctly
    expect(find.text('Hola! \nAndrés Cornejo'), findsOneWidget);
  });

  /// Test to verify the instruction text
  testWidgets('Verify instruction text', (WidgetTester tester) async {
    // Build the SaleSptosPage widget
    await tester.pumpWidget(const MaterialApp(home: SaleSptosPage()));

    // Verify if the instruction text is displayed correctly
    expect(find.text('Seleccione un local comercial para empezar:'), findsOneWidget);
  });


  /// Test to verify the BottomAppBar elements
  testWidgets('Verify BottomAppBar elements', (WidgetTester tester) async {
    // Build the SaleSptosPage widget
    await tester.pumpWidget(const MaterialApp(home: SaleSptosPage()));

    // Verify if the BottomAppBar is present
    expect(find.byType(BottomAppBar), findsOneWidget);

    // Verify if the CircleAvatar is present
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}

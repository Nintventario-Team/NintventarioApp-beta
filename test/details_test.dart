import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/details.dart';
import 'package:nintventario/widgets/date_selector_widget.dart';

void main() {
  group('InventoryDetails Widget Tests', () {
    // Mocks or test values for globals
    const String testInventoryId = 'INV12345';
    const String testEmployeeName = 'John Doe';
    const String testGlobalDate = '2024-08-10';

    setUp(() {
      // Set up any necessary global variables or mock dependencies.
      globalEmployeeName = testEmployeeName;
      globalDate = testGlobalDate;
      inventoryId = testInventoryId;
    });

    testWidgets('InventoryDetails displays correctly', (WidgetTester tester) async {
      // Build the InventoryDetails widget.
      await tester.pumpWidget(const MaterialApp(home: InventoryDetails()));

      // Verify the AppBar title is correct.
      expect(find.text('Detalles del Inventario'), findsOneWidget);

      // Verify the Inventory ID is displayed correctly.
      expect(find.text(testInventoryId), findsOneWidget);

      // Verify the Employee name TextField has the correct initial value.
      expect(find.widgetWithText(TextField, testEmployeeName), findsOneWidget);

      // Verify the Duration TextField has the correct initial value.
      expect(find.widgetWithText(TextField, '0'), findsOneWidget);

      // Verify the DateSelectorWidget is present.
      expect(find.byType(DateSelectorWidget), findsOneWidget);

      // Verify the "Guardar borrador" button is present.
      expect(find.text('Guardar borrador'), findsOneWidget);
    });

    testWidgets('InventoryDetails allows saving a draft', (WidgetTester tester) async {
      // Build the InventoryDetails widget.
      await tester.pumpWidget(const MaterialApp(home: InventoryDetails()));

      // Enter some text into the Employee name TextField.
      await tester.enterText(find.byType(TextField).first, 'Jane Smith');

      // Enter some text into the Duration TextField.
      await tester.enterText(find.byType(TextField).last, '5');

      // Tap the "Guardar borrador" button.
      await tester.tap(find.text('Guardar borrador'));
      await tester.pump(); // Pump once to process the tap.
      await tester.pumpAndSettle(); // Ensure all animations and async operations are completed.

      // Verify the SnackBar is shown with the correct message.
      expect(find.text('Guardar borrador'), findsOneWidget);
    });
  });
}

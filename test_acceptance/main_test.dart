import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'package:nintventario/screens/home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Test SaleSptosPage, Home, and Inventory Creation Navigation with Filter Selection and Stock Update',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SaleSptosPage(),
      ),
    );

    // Wait for the SaleSptosPage to load
    await tester.pumpAndSettle();

    // Verify that the SaleSptosPage is displayed
    expect(find.byType(SaleSptosPage), findsOneWidget);

    // Verify that the text "Hola! \nAndrés Cornejo" is displayed
    expect(find.text('Hola! \nAndrés Cornejo'), findsOneWidget);

    // Verify that the GridView is displayed
    expect(find.byType(GridView), findsOneWidget);

    // Simulate the tap on the "Ceibos" sale spot
    await tester.tap(find.text('Ceibos'));
    await tester.pumpAndSettle();

    // Verify that the navigation to the Home screen has occurred
    expect(find.byType(Home), findsOneWidget);

    // Simulate the tap on the "Crear Inventario" button
    await tester.tap(find.text('Crear Inventario'));
    await tester.pumpAndSettle();

    // Verify that the navigation to the Inventory creation screen has occurred
    expect(find.text('Lista de productos'), findsOneWidget);

    // Select the "Todos" filter
    await tester.tap(find.text('Select Filter'), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find
        .text('Todos')
        .last); // .last to ensure the dropdown menu item is selected
    await tester.pumpAndSettle();

    // Verify that the "Todos" filter has been selected
    expect(find.text('Todos'), findsOneWidget);

    // Simulate the tap on the product "(Ps5)Fifa 23"
    await tester.tap(find.text('(Ps5)Fifa 23'));
    await tester.pumpAndSettle();

    // Verify that the product details screen is displayed
    expect(find.text('Detalles del producto'), findsOneWidget);

    // Change the current stock to 2
    await tester.enterText(find.byType(TextField).last, '2');
    await tester.pumpAndSettle();

    // Hide the keyboard by tapping outside the TextField
    await tester.tap(find.byType(
        Scaffold)); // Taps anywhere on the screen outside of the TextField
    await tester.pumpAndSettle();

    // Simulate the tap on the "Confirmar" button
    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();

    // Verify that the screen has returned to the product list
    expect(find.text('Lista de productos'), findsOneWidget);

    // Verify that the product has the updated stock
    // Here you could verify that the list is updated, if necessary
    Future<dynamic>.delayed(const Duration(seconds: 60));
    // Tap on "Detalles" to open the inventory details
    await tester.tap(find.text('Detalles'));
    await tester.pumpAndSettle();

    // Verify that the Inventory Details screen is displayed
    expect(find.text('Detalles del Inventario'), findsOneWidget);

    // Change the inventory manager name
    await tester.enterText(find.byType(TextField).first, 'Juan Pérez');
    await tester.pumpAndSettle();

// Simulate pressing the 'Done' or 'Return' key on the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    Future<dynamic>.delayed(const Duration(seconds: 120));

    // Verify that the name has been updated
    expect(find.text('Juan Pérez'), findsOneWidget);

    // Simulate the tap on the "Guardar borrador" button
    await tester.tap(find.text('Guardar borrador'));
    await tester.pumpAndSettle();

    // Verify that the confirmation message is displayed
    expect(find.text('¡Borrador guardado exitosamente!'), findsOneWidget);

    // You can add more assertions here to verify the correct behavior after saving the draft
  });
}

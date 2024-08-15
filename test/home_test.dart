import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';

void main() {
  /// Test to verify the AppBar title
  testWidgets('Verify AppBar title', (WidgetTester tester) async {
    // Build the Home widget
    await tester.pumpWidget(const Home());

    // Verify if the AppBar title is "HOME"
    expect(find.text('Crear Inventario'), findsOneWidget);

  });

  /// Test to verify the menu items
  testWidgets('Verify menu items', (WidgetTester tester) async {
    // Build the Home widget
    await tester.pumpWidget(const Home());

    // Verify if the "Crear Inventario" menu item is present
    expect(find.widgetWithText(MenuItem, 'Crear Inventario'), findsOneWidget);
    
    // Verify if the "Historial" menu item is present
    expect(find.widgetWithText(MenuItem, 'Historial'), findsOneWidget);
    
    // Verify if the "Ajustes" menu item is present
    expect(find.widgetWithText(MenuItem, 'Ajustes'), findsOneWidget);
    
    // Verify if the "Salir" menu item is present
    expect(find.widgetWithText(MenuItem, 'Salir'), findsOneWidget);
  });

}

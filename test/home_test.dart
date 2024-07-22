import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';

void main() {
  /// Test to verify the AppBar title
  testWidgets('Verify AppBar title', (WidgetTester tester) async {
    // Build the Home widget
    await tester.pumpWidget(const Home());

    // Verify if the AppBar title is "HOME"
    expect(find.text('HOME'), findsOneWidget);

    // Verify the font size of the AppBar title
    final Text titleText = tester.widget(find.text('HOME'));
    expect(titleText.style?.fontSize, fontTitleSizeVar);
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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/widgets/tab_widget.dart';

void main() {
  group('Integration Tests', () {
    testWidgets('Home screen navigation test', (WidgetTester tester) async {
      // Renderizar la pantalla inicial
      await tester.pumpWidget(const Home());

      // Verificar si los textos "HOME" y "Bienvenido a ..." están presentes
      expect(find.text('HOME'), findsOneWidget);
      expect(find.text('Bienvenido a'), findsOneWidget);

      // Simular tap en el botón "Crear Inventario"
      await tester.tap(find.text('Crear Inventario'));
      await tester.pumpAndSettle();  // Esperar a que la animación de navegación termine

      // Verificar que estamos en la pantalla de inventario
      expect(find.text('Productos'), findsOneWidget);
      expect(find.text('Detalles'), findsOneWidget);
      expect(find.text('Reporte'), findsOneWidget);
    });

    testWidgets('Product list filter test', (WidgetTester tester) async {
      // Renderizar la pantalla de inventario
      await tester.pumpWidget(const CustomTabBar());

      // Simular tap en el tab de Productos
      await tester.tap(find.text('Productos'));
      await tester.pumpAndSettle();

      // Verificar que el filtro se aplica correctamente
      await tester.enterText(find.byType(TextField), 'Producto 1');
      await tester.pumpAndSettle();
      expect(find.text('Producto 1'), findsOneWidget);
    });
  });
}

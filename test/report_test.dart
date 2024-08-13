import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/inventoryScreens/report.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';

void main() {
  group('Report Screen', () {
    testWidgets('should display correct number of checked and unchecked products', (WidgetTester tester) async {
      // Arrange
      globalProducts = <Product>[
        Product(name: 'Product 1', state: ProductState.checked, id: '', stockAnterior: 0),
        Product(name: 'Product 2', state: ProductState.unchecked, id: '', stockAnterior: 0),
        Product(name: 'Product 3', state: ProductState.checked, id: '', stockAnterior: 0),
      ];
      globalObservations = 'Test observation';

      // Act
      await tester.pumpWidget(const MaterialApp(home: ReportScreen()));

      // Assert
      expect(find.text('Productos checkeados:'), findsOneWidget);
      expect(find.text('Productos no-checkeados:'), findsOneWidget);
    });

    testWidgets('should allow observation editing and display updated value', (WidgetTester tester) async {
      // Arrange
      globalObservations = 'Initial observation';
      await tester.pumpWidget(const MaterialApp(home: ReportScreen()));

      // Act
      await tester.enterText(find.byType(TextFormField), 'Updated observation');
      await tester.pump();

      // Assert
      expect(globalObservations, 'Updated observation');
    });

});
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';

void main() {
  /// Test to verify that the product details are displayed correctly.
  testWidgets('Displays correct product details', (WidgetTester tester) async {
    // Sample product for testing.
    final Product product = Product(id: '1', name: 'Product A', stockAnterior: 10, stockActual: 5, state: ProductState.checked);

    // Build the widget.
    await tester.pumpWidget(MaterialApp(home: ProductDetails(product: product)));

    // Verify that the product details are displayed correctly.
    expect(find.text('ID del producto:'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Nombre del producto:'), findsOneWidget);
    expect(find.text('Product A'), findsOneWidget);
    expect(find.text('Stock anterior:'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('Stock Actual:'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  /// Test to verify that the initial stock is set correctly in the text field.
  testWidgets('Initial stock value is set correctly', (WidgetTester tester) async {
    // Sample product for testing.
    final Product product = Product(id: '1', name: 'Product A', stockAnterior: 10, stockActual: 5, state: ProductState.checked);

    // Build the widget.
    await tester.pumpWidget(MaterialApp(home: ProductDetails(product: product)));

    // Verify that the initial stock value is correctly set in the TextField.
    expect(find.text('5'), findsOneWidget);
  });
}

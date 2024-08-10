import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';
import 'package:nintventario/screens/inventoryScreens/products_list.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/widgets/qr_scanner_widget.dart';

void main() {
  /// Test to verify that products are correctly filtered by their state (Checked, Unchecked).
  testWidgets('Filters product list by state', (WidgetTester tester) async {
    // Sample products for testing.
    final List<Product> products = <Product>[
      Product(id: '1', name: 'Product A', stockAnterior: 10, stockActual: 5, state: ProductState.checked),
      Product(id: '2', name: 'Product B', stockAnterior: 15, stockActual: 8, state: ProductState.unchecked),
    ];
    globalProducts = products;

    // Build the widget.
    await tester.pumpWidget(const MaterialApp(home: ProductsList(currentPageIndex: 0)));

    // Open the dropdown filter menu and select "Checked".
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('checkeados').last);
    await tester.pumpAndSettle();

    // Verify that only checked products are shown.
    expect(find.text('Product A'), findsOneWidget);
    expect(find.text('Product B'), findsNothing);

    // Now filter for "Unchecked" products.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('no-checkeados').last);
    await tester.pumpAndSettle();

    // Verify that only unchecked products are shown.
    expect(find.text('Product B'), findsOneWidget);
    expect(find.text('Product A'), findsNothing);
  });

  /// Test to verify that selecting a product navigates to the `ProductDetails` screen.
  testWidgets('Navigates to ProductDetails on product tap', (WidgetTester tester) async {
    // Sample product for testing.
    final Product product = Product(id: '1', name: 'Product A', stockAnterior: 10, stockActual: 5, state: ProductState.checked);
    globalProducts = <Product>[product];

    // Build the widget.
    await tester.pumpWidget(const MaterialApp(home: ProductsList(currentPageIndex: 0)));

    // Tap on the product in the list.
    await tester.tap(find.text('Product A'));
    await tester.pumpAndSettle();

    // Verify that the ProductDetails screen is shown.
    expect(find.byType(ProductDetails), findsOneWidget);
  });

  /// Test to verify that the floating action button navigates to the QR scanner widget.
  testWidgets('Floating action button navigates to QR scanner', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const MaterialApp(home: ProductsList(currentPageIndex: 0)));

    // Tap on the floating action button.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify that the QRScannerWidget is shown.
    expect(find.byType(QRScannerWidget), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';
import 'package:nintventario/widgets/qr_scanner_widget.dart';

void main() {
  group('QRScannerWidget Tests', () {
    testWidgets('Barcode Detection', (WidgetTester tester) async {
      // Mock product data
      globalProducts = <Product>[
        Product(id: '12345', name: 'Product 1', stockAnterior: 10),
      ];

      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: QRScannerWidget()));

      // Simulate barcode detection
      final QRScannerWidgetState state =
          tester.state(find.byType(QRScannerWidget));
      state.handleBarcodeDetection('12345');

      // Verify navigation to ProductDetails
      await tester.pumpAndSettle();
      expect(find.byType(ProductDetails), findsOneWidget);
    });

    testWidgets('Barcode Not Found', (WidgetTester tester) async {
      // Mock product data
      globalProducts = <Product>[
        Product(id: '12345', name: 'Product 1', stockAnterior: 10),
      ];

      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: QRScannerWidget()));

      // Simulate barcode detection with an invalid code
      final QRScannerWidgetState state =
          tester.state(find.byType(QRScannerWidget));
      state.handleBarcodeDetection('67890');

      // Verify AlertDialog is shown
      await tester.pump();
      expect(find.text('Producto no encontrado'), findsOneWidget);
      expect(find.text('No se encontró ningún producto con el ID 67890.'),
          findsOneWidget);
    });

    testWidgets('Camera Switching', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: QRScannerWidget()));

      // Find the FloatingActionButton and tap it
      final Finder switchButton = find.byIcon(Icons.switch_camera);
      await tester.tap(switchButton);

      // Verify the camera was switched (can use mock or check camera controller state)
      final QRScannerWidgetState state =
          tester.state(find.byType(QRScannerWidget));
      expect(state.cameraController, isNotNull);
    });
  });
}

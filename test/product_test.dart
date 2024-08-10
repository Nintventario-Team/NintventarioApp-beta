import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/classes/product.dart';

void main() {
  group('Product Class Tests', () {
    test('Product Initialization', () {
      // Initialize product
      final Product product = Product(
        id: '001',
        name: 'Test Product',
        stockAnterior: 100,
        stockActual: 50,
        state: ProductState.checked,
      );

      // Verify the values
      expect(product.id, '001');
      expect(product.name, 'Test Product');
      expect(product.stockAnterior, 100);
      expect(product.stockActual, 50);
      expect(product.state, ProductState.checked);
    });

    test('JSON Serialization', () {
      // Initialize product
      final Product product = Product(
        id: '001',
        name: 'Test Product',
        stockAnterior: 100,
        stockActual: 50,
        state: ProductState.unchecked,
      );

      // Convert to JSON
      final Map<String, dynamic> json = product.toJson();

      // Verify JSON map
      expect(json['codigo'], '001');
      expect(json['nombre'], 'Test Product');
      expect(json['stock_inicial'], 100);
      expect(json['stock_final'], 50);
      expect(json['state'], 'unchecked');
    });

    test('JSON Deserialization', () {
      // Mock JSON data
      final Map<String, Object> json = <String, Object>{
        'codigo': '001',
        'nombre': 'Test Product',
        'stock_inicial': 100,
        'stock_final': 50,
        'state': 'checked',
      };

      // Deserialize to Product
      final Product product = Product.fromJson(json);

      // Verify the product values
      expect(product.id, '001');
      expect(product.name, 'Test Product');
      expect(product.stockAnterior, 100);
      expect(product.stockActual, 50);
      expect(product.state, ProductState.checked);
    });
  });
}

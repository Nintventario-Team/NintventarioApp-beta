import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  final List<Map<String, dynamic>> products = const [
    {'id': 1, 'name': 'Producto A', 'stock': 100},
    {'id': 2, 'name': 'Producto B', 'stock': 200},
    {'id': 3, 'name': 'Producto C', 'stock': 150},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de productos')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Producto')),
            DataColumn(label: Text('Stock')),
          ],
          rows: products.map((product) {
            return DataRow(cells: [
              DataCell(Text(product['id'].toString())),
              DataCell(Text(product['name'])),
              DataCell(Text(product['stock'].toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}


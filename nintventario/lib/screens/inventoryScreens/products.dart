import 'package:flutter/material.dart';

double _fontTextSize = 18;
double _fontTitleSize = 22;
double _spaceColumn = 100;

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  final List<Map<String, dynamic>> products = const [
    {'id': 1, 'name': 'Producto A', 'stock': 100},
    {'id': 2, 'name': 'Producto B', 'stock': 200},
    {'id': 3, 'name': 'Producto C', 'stock': 150},
    {'id': 4, 'name': 'Producto C', 'stock': 150}
  ];

  void _onProductTap(Map<String, dynamic> product) {
    // la lógica que debe ejecutarse al hacer clic en un producto
    print('Producto seleccionado: ${product['name']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de productos')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32.0),
              child: DataTable(
                columnSpacing: _spaceColumn, // Espacio entre columnas
                //dataRowHeight: 60.0, // Altura de las filas
                columns: [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(color: Colors.blue, fontSize: _fontTitleSize), // Color y tamaño de los encabezados
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Producto',
                      style: TextStyle(color: Colors.blue, fontSize: _fontTitleSize), // Color y tamaño de los encabezados
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Stock',
                      style: TextStyle(color: Colors.blue, fontSize: _fontTitleSize), // Color y tamaño de los encabezados
                    ),
                  ),
                ],
                rows: products.map((product) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(product['id'].toString(), style: TextStyle(fontSize: _fontTextSize)),
                      ),
                      DataCell(
                        Text(product['name'], style: TextStyle(fontSize: _fontTextSize)),
                        onTap: () => _onProductTap(product),
                      ),
                      DataCell(
                        Text(product['stock'].toString(), style: TextStyle(fontSize: _fontTextSize)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: ProductsList()));

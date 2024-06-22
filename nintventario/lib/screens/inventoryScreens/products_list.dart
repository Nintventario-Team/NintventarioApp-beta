// products_list.dart
import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';
import 'package:nintventario/screens/home.dart'; // Asegúrate de importar el archivo donde declaraste globalProducts
import 'package:nintventario/widgets/qr_scanner_widget.dart'; // Importa el widget del escáner QR

class ProductsList extends StatefulWidget {
  final int currentPageIndex;

  const ProductsList({super.key, required this.currentPageIndex});

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State<ProductsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(globalProducts); // Cambio aquí
    _sortProducts();
  }

  void _onSearchChanged(String searchTerm) {
    setState(() {
      _filteredProducts = globalProducts.where((product) {
        // Cambio aquí
        final String term = searchTerm.toLowerCase();
        final String productName = product.name.toLowerCase();
        final String productId = product.id.toLowerCase();
        final String productState =
            product.state.toString().split('.').last.toLowerCase();

        return productName.contains(term) ||
            productId.contains(term) ||
            (term == 'checked' &&
                productState == 'checked') || // Filtrar por estado checked
            (term == 'unchecked' &&
                productState == 'unchecked'); // Filtrar por estado unchecked
      }).toList();
      _sortProducts();
    });
  }

  void _sortProducts() {
    _filteredProducts.sort((a, b) {
      if (a.state == ProductState.unchecked &&
          b.state != ProductState.unchecked) {
        return -1;
      } else if (a.state != ProductState.unchecked &&
          b.state == ProductState.unchecked) {
        return 1;
      }
      return 0;
    });
  }

  Color _getStateColor(ProductState state) {
    switch (state) {
      case ProductState.checked:
        return Colors.green;
      case ProductState.unchecked:
        return const Color.fromARGB(255, 255, 0, 13);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Column(
          children: [
            SearchBar(onChanged: _onSearchChanged),
            Expanded(
              child: ListView.separated(
                itemCount: _filteredProducts.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final Product product = _filteredProducts[index];
                  final String productName = product.name;
                  final String productId = product.id;
                  final String stockAnterior = product.stockAnterior.toString();
                  String stockActual = product.stockActual.toString();
                  String productState =
                      product.state.toString().split('.').last;

                  return ListTile(
                    title: Text(
                      productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getStateColor(product.state),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Código: $productId'),
                        Text('Stock Anterior: $stockAnterior'),
                        Text('Stock Actual: $stockActual'),
                        Text('Estado: $productState'),
                      ],
                    ),
                    onTap: () async {
                      final updatedProduct = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: product),
                        ),
                      );
                      if (updatedProduct != null) {
                        setState(() {
                          globalProducts[globalProducts.indexOf(product)] =
                              updatedProduct; // Cambio aquí
                          _onSearchChanged('');
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QRScanner(),
                ),
              );
            },
            backgroundColor: Colors.white,
            child: Image.asset(
              'src/images/qrIcon.jpg', // Ruta de la imagen
              width: 30,
              height: 30,
            ), // Fondo blanco para que la imagen se vea mejor
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          labelText: 'Buscar por código, nombre o estado',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';

/// A StatefulWidget that displays a list of products.
class ProductsList extends StatefulWidget {
  /// The current page index.
  final int currentPageIndex;

  /// Creates an instance of [ProductsList].
  const ProductsList({super.key, required this.currentPageIndex});

  @override
  ProductsListState createState() => ProductsListState();
}

/// State class for [ProductsList].
class ProductsListState extends State<ProductsList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  /// List of filtered products to be displayed.
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List<Product>.from(globalProducts);
    _sortProducts();
  }

  /// Filters the products based on the search term.
  void _onSearchChanged(String searchTerm) {
    setState(() {
      _filteredProducts = globalProducts.where((Product product) {
        final String term = searchTerm.toLowerCase();
        final String productName = product.name.toLowerCase();
        final String productId = product.id.toLowerCase();
        final String productState = product.state.toString().split('.').last.toLowerCase();

        return productName.contains(term) ||
            productId.contains(term) ||
            (term == 'checked' && productState == 'checked') || // Filter by checked state
            (term == 'unchecked' && productState == 'unchecked'); // Filter by unchecked state
      }).toList();
      _sortProducts();
    });
  }

  /// Sorts the products, giving priority to unchecked products.
  void _sortProducts() {
    _filteredProducts.sort((Product a, Product b) {
      if (a.state == ProductState.unchecked && b.state != ProductState.unchecked) {
        return -1;
      } else if (a.state != ProductState.unchecked && b.state == ProductState.unchecked) {
        return 1;
      }
      return 0;
    });
  }

  /// Returns the color associated with the product state.
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
    return Column(
      children: <Widget>[
        SearchBar(onChanged: _onSearchChanged),
        Expanded(
          child: ListView.separated(
            itemCount: _filteredProducts.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final Product product = _filteredProducts[index];
              final String productName = product.name;
              final String productId = product.id;
              final String stockAnterior = product.stockAnterior.toString();
              final String stockActual = product.stockActual.toString();
              final String productState = product.state.toString().split('.').last;

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
                  children: <Widget>[
                    Text('ID: $productId'),
                    Text('Anterior Stock: $stockAnterior'),
                    Text('Actual Stock: $stockActual'),
                    Text('Estado: $productState'),
                  ],
                ),
                onTap: () async {
                  final Product? updatedProduct = await Navigator.push<Product>(
                    context,
                    MaterialPageRoute<Product>(
                      builder: (BuildContext context) => ProductDetails(product: product),
                    ),
                  );
                  if (updatedProduct != null) {
                    setState(() {
                      globalProducts[globalProducts.indexOf(product)] = updatedProduct;
                      _onSearchChanged('');
                    });
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// A stateless widget that represents a search bar.
class SearchBar extends StatelessWidget {
  /// Callback function to handle search term changes.
  final ValueChanged<String> onChanged;

  /// Creates an instance of [SearchBar].
  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          labelText: 'Search by ID, name, or state',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

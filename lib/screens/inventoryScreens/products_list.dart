import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';
import 'package:nintventario/widgets/qr_scanner_widget.dart';

/// A StatefulWidget that displays a list of products.
class ProductsList extends StatefulWidget {
  /// The index of the current page.
  final int currentPageIndex;

  /// Creates an instance of [ProductsList].
  const ProductsList({super.key, required this.currentPageIndex});

  @override
  ProductsListState createState() => ProductsListState();
}

/// The state class for [ProductsList].
class ProductsListState extends State<ProductsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  /// List of products filtered based on the search term and selected filter.
  late List<Product> _filteredProducts;

  /// Currently selected filter (All, Checked, Unchecked).
  String? _selectedFilter;

  /// Current search term entered in the search bar.
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = List<Product>.from(globalProducts);
    _filterAndSortProducts();
  }

  /// Filters and sorts the products based on the selected filter and search term.
  void _filterAndSortProducts() {
    setState(() {
      _filteredProducts = globalProducts.where((Product product) {
        final bool matchesSearchTerm = _searchTerm.isEmpty ||
            product.name.toLowerCase().contains(_searchTerm) ||
            product.id.toLowerCase().contains(_searchTerm);

        if (_selectedFilter == null || _selectedFilter == 'Todos') {
          return matchesSearchTerm;
        } else if (_selectedFilter == 'checkeados') {
          return matchesSearchTerm && product.state == ProductState.checked;
        } else if (_selectedFilter == 'no-checkeados') {
          return matchesSearchTerm && product.state == ProductState.unchecked;
        }
        return false;
      }).toList();

      _filteredProducts.sort((Product a, Product b) {
        if (a.state == ProductState.unchecked &&
            b.state != ProductState.unchecked) {
          return -1;
        } else if (a.state != ProductState.unchecked &&
            b.state == ProductState.unchecked) {
          return 1;
        }
        return 0;
      });
    });
  }

  /// Handles changes in the search bar input.
  void _onSearchChanged(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm.toLowerCase();
      _filterAndSortProducts();
    });
  }

  /// Returns the color associated with the product's state.
  Color _getStateColor(ProductState state) {
    switch (state) {
      case ProductState.checked:
        return Colors.green;
      case ProductState.unchecked:
        return const Color.fromARGB(255, 255, 0, 13);
    }
  }

  /// Navigates to the QR scanner widget.
  void _showScannerWidget() {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const QRScannerWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de productos',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Title text color (black)
          ),
        ), // AppBar background color (light blue)
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Filtro:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedFilter,
                  hint: const Text('Select Filter'),
                  items: <String>['Todos', 'checkeados', 'no-checkeados']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue;
                      _searchTerm =
                          ''; // Clear the search term when the filter changes
                      _filterAndSortProducts();
                    });
                  },
                ),
              ],
            ),
          ),
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
                final String stockActual = product.stockActual.toString();
                final String productState =
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
                    children: <Widget>[
                      Text('ID: $productId'),
                      Text('Stock anterior: $stockAnterior'),
                      Text('Stock actual: $stockActual'),
                      Text('Estado: $productState'),
                    ],
                  ),
                  onTap: () async {
                    final Product? updatedProduct =
                        await Navigator.push<Product>(
                      context,
                      MaterialPageRoute<Product>(
                        builder: (BuildContext context) =>
                            ProductDetails(product: product),
                      ),
                    );
                    if (updatedProduct != null) {
                      setState(() {
                        globalProducts[globalProducts.indexOf(product)] =
                            updatedProduct;
                        _filterAndSortProducts();
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showScannerWidget,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}

/// A stateless widget representing a search bar.
class SearchBar extends StatelessWidget {
  /// Callback function to handle changes in the search term.
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
          labelText: 'Search by ID or name',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

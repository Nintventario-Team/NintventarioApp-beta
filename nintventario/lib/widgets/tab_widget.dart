import 'package:flutter/material.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/details.dart';
import 'package:nintventario/screens/inventoryScreens/report.dart';
import 'package:nintventario/screens/inventoryScreens/products_list.dart';
import 'package:nintventario/classes/product.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

const double _fontTitleSize = 40;

/// A custom tab bar widget for managing inventory-related screens.
class CustomTabBar extends StatelessWidget {
  /// The initial index of the tab to be selected.
  final int initialIndex;
  /// Creates an instance of [CustomTabBar].
  const CustomTabBar({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: InventoryTabBar(initialIndex: initialIndex),
    );
  }
}

/// The tab bar widget for inventory management.
class InventoryTabBar extends StatefulWidget {
  /// The initial index of the tab to be selected.
  final int initialIndex;
  /// Creates an instance of [InventoryTabBar].
  const InventoryTabBar({super.key, this.initialIndex = 0});

  @override
  InventoryTabBarState createState() => InventoryTabBarState();
}

/// The state for the `InventoryTabBar` widget.
class InventoryTabBarState extends State<InventoryTabBar> {
  late Future<List<Product>> _futureProducts;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _futureProducts = loadProducts();

    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  /// Loads the list of products from a JSON file.
  Future<List<Product>> loadProducts() async {
    try {
      final String response = await rootBundle.loadString('src/files/inventario.json');
      final List<dynamic> data = jsonDecode(response);
      globalProducts = data.map((dynamic product) {
        return Product(
          id: product['codigo'],
          name: product['nombre'],
          stockAnterior: product['stock'],
          state: ProductState.unchecked, // Default state is unchecked
        );
      }).toList();
      return globalProducts;
    } catch (e) {
      throw Exception('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _futureProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        } else if (snapshot.hasError) {
          return _buildError(snapshot.error.toString());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildNoProductsFound();
        } else {
          final List<Product> products = snapshot.data!;
          return _buildTabBar(products);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ninventario',
          style: TextStyle(fontSize: _fontTitleSize),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(String errorMessage) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ninventario',
          style: TextStyle(fontSize: _fontTitleSize),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
      ),
      body: Center(child: Text('Error: $errorMessage')),
    );
  }

  Widget _buildNoProductsFound() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ninventario',
          style: TextStyle(fontSize: _fontTitleSize),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
      ),
      body: const Center(child: Text('No products found')),
    );
  }

  Widget _buildTabBar(List<Product> products) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ninventario',
            style: TextStyle(fontSize: _fontTitleSize),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const Home(),
                ),
              );
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: <Widget>[
                  ProductsList(currentPageIndex: _currentPageIndex),
                  const InventoryDetails(),
                  const ReportScreen(),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              onTap: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.list), text: 'Products'),
                Tab(icon: Icon(Icons.info), text: 'Details'),
                Tab(icon: Icon(Icons.edit_document), text: 'Report'),
              ],
              labelStyle: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}


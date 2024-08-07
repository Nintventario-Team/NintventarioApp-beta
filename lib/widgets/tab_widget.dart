import 'package:flutter/material.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/details.dart';
import 'package:nintventario/screens/inventoryScreens/report.dart';
import 'package:nintventario/screens/inventoryScreens/products_list.dart';

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
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nintventario',
            style: TextStyle(fontSize: _fontTitleSize, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const Home(),
                ),
              );
            },
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
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
              labelColor: Colors.blue.shade900,
              unselectedLabelColor: Colors.blue.shade300,
              onTap: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.list), text: 'Productos'),
                Tab(icon: Icon(Icons.info), text: 'Detalles'),
                Tab(icon: Icon(Icons.edit_document), text: 'Reporte'),
              ],
              labelStyle: const TextStyle(fontSize: 12),
              indicatorColor: Colors.blue.shade900,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/inventoryScreens/details.dart';
import 'package:nintventario/screens/inventoryScreens/report.dart';
import '../screens/settings.dart';
import '../screens/inventoryScreens/products.dart';

double _fontTitleSize = 40;

class CustomTabBar extends StatelessWidget {
  final int initialIndex;

  const CustomTabBar({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: TabBar1(initialIndex: initialIndex),
    );
  }
}

class TabBar1 extends StatelessWidget {
  final int initialIndex;

  const TabBar1({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ninventario',
            style: TextStyle(fontSize: _fontTitleSize),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(      
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                )); 
            },
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ProductsList(),
                  InventoryDetails(),
                  InventoryReport(),
                  SettingsScreen(),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.list), text: "Productos"),
                Tab(icon: Icon(Icons.info), text: "Detalles"),
                Tab(icon: Icon(Icons.edit_document), text: "Reporte"),
                Tab(icon: Icon(Icons.settings), text: "Ajustes"),
              ],
              labelStyle: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

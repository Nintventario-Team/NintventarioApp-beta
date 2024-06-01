import 'package:flutter/material.dart';
import '../screens/history.dart';
import '../screens/settings.dart';
import '../screens/new_inventory.dart';
import '../screens/products.dart';
import '../screens/home.dart';

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
          title: const Text('Ninventario'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  NewInventaryScreen(),
                  ProductsScreen(),
                  HistoryScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.edit_document), text: "Nuevo"),
                Tab(icon: Icon(Icons.list), text: "Productos"),
                Tab(icon: Icon(Icons.history), text: "Historial"),
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

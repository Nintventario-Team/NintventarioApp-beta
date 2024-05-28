import 'package:flutter/material.dart';
import '../screens/history.dart';
import '/screens/settings.dart';
import '../screens/new_inventory.dart';
import '../screens/products.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true), home: const TabBar1());
  }
}

class TabBar1 extends StatelessWidget {
  const TabBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ninventario'),
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

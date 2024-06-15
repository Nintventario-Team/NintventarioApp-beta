// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/history.dart';
import 'package:nintventario/screens/settings.dart';
import 'package:nintventario/widgets/tab_widget.dart';
import 'dart:io';
import 'package:flutter/services.dart';


String _place = "";
List<Draft> globalDrafts = [];
List<Product> globalProducts = [];
String inventoryId = "99999";
String globalTime = "";
String globalDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String globalEmployeeName = "Kevin Daniel Mawyin Pilozo";

double _spaceSize = 20;
double _crossAxisSpacingVar = 20;
double _fontTitleSizeVar = 40;
double _fontTextSizeVar = 18;
double _iconSize = 40;

void main() {
  runApp(const Home());
}

class GlobalState extends ChangeNotifier {
  String _globalDate = DateTime.now().toString();

  String get globalDate => _globalDate;

  set globalDate(String newDate) {
    _globalDate = newDate;
    notifyListeners();
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("HOME", style: TextStyle(fontSize: _fontTitleSizeVar)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: _spaceSize),
            Text("Bienvenido a $_place"),
            SizedBox(height: _spaceSize),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: _crossAxisSpacingVar,
                crossAxisCount: 2,
                children: const [
                  NewInventoryWidget(),
                  HistorialWidget(),
                  SettingsWidget(),
                  ExitWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewInventoryWidget extends StatelessWidget {
  const NewInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("Crear Inventario presionado");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomTabBar(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_document, size: _iconSize),
            Text("Crear Inventario",
                style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

class HistorialWidget extends StatelessWidget {
  const HistorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("Historial presionado");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DraftsScreen(drafts: globalDrafts),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: _iconSize),
            Text("Historial", style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("Ajustes presionado");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: _iconSize),
            Text("Ajustes", style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

class ExitWidget extends StatelessWidget {
  const ExitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("Salir presionado");
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.exit_to_app, size: _iconSize),
            Text("Salir", style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

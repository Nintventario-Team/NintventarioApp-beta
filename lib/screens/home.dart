import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/history.dart';
import 'package:nintventario/screens/settings.dart';
import 'package:nintventario/widgets/tab_widget.dart';
import 'package:flutter/services.dart';

/// Global list of drafts.
List<Draft> globalDrafts = <Draft>[];

/// Global list of products.
List<Product> globalProducts = <Product>[];

/// Global inventory identifier.
String inventoryId = '99999';

/// Global time.
String globalTime = '';

/// Global date.
String globalDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

/// Global employee name.
String globalEmployeeName = 'Kevin Daniel Mawyin Pilozo';

/// Global space size.
double spaceSize = 20;

/// Global cross-axis spacing.
double crossAxisSpacingVar = 20;

/// Global font size for title.
double fontTitleSizeVar = 30;

/// Global font size for text.
double fontTextSizeVar = 16;

/// Global icon size.
double iconSize = 50;

/// Entry point of the application.
void main() {
  runApp(const Home());
}

/// Class to manage global state.
class GlobalState extends ChangeNotifier {
  String _globalDate = DateTime.now().toString();

  /// Gets the current global date.
  String get globalDate => _globalDate;

  /// Sets the current global date and notifies listeners.
  set globalDate(String newDate) {
    _globalDate = newDate;
    notifyListeners();
  }
}

/// Main widget of the application.
class Home extends StatelessWidget {
  /// Creates an instance of [Home].
  const Home({super.key});

  /// Method to navigate to the custom tab bar screen.
  void _navigateToCustomTabBar(BuildContext context) {
    if (kDebugMode) {
      print('Create Inventory pressed');
    }
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CustomTabBar(),
      ),
    );
  }

  /// Method to navigate to the drafts screen.
  void _navigateToDraftsScreen(BuildContext context) {
    if (kDebugMode) {
      print('History pressed');
    }
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DraftsScreen(drafts: globalDrafts),
      ),
    );
  }

  /// Method to navigate to the settings screen.
  void _navigateToSettingsScreen(BuildContext context) {
    if (kDebugMode) {
      print('Settings pressed');
    }
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SettingsScreen(),
      ),
    );
  }

  /// Method to exit the app.
  void _exitApp(BuildContext context) {
    if (kDebugMode) {
      print('Exit pressed');
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'HOME',
            style: TextStyle(
              fontSize: fontTitleSizeVar,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
        ),
        body: Container(
          color: Colors.blue.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bienvenido a Ceibos',
                style: TextStyle(
                  fontSize: fontTitleSizeVar,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: spaceSize),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: crossAxisSpacingVar,
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    MenuItem(
                      icon: Icons.edit_document,
                      label: 'Crear Inventario',
                      onTap: () => _navigateToCustomTabBar(context),
                      color: Colors.blue.shade100,
                    ),
                    MenuItem(
                      icon: Icons.history,
                      label: 'Historial',
                      onTap: () => _navigateToDraftsScreen(context),
                      color: Colors.blue.shade200,
                    ),
                    MenuItem(
                      icon: Icons.settings,
                      label: 'Ajustes',
                      onTap: () => _navigateToSettingsScreen(context),
                      color: Colors.blue.shade300,
                    ),
                    MenuItem(
                      icon: Icons.exit_to_app,
                      label: 'Salir',
                      onTap: () => _exitApp(context),
                      color: Colors.blue.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for the menu items.
class MenuItem extends StatelessWidget {
  /// Icon for the menu item.
  final IconData icon;

  /// Label for the menu item.
  final String label;

  /// Callback for the tap event.
  final VoidCallback onTap;

  /// Background color for the menu item.
  final Color color;

  /// Creates an instance of [MenuItem].
  const MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: iconSize, color: Colors.black54),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontTextSizeVar,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

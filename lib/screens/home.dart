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

/// Global variable representing the place.
String _place = '';

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
double fontTitleSizeVar = 40;

/// Global font size for text.
double fontTextSizeVar = 18;

/// Global icon size.
double iconSize = 40;

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

  // Method to navigate to the custom tab bar screen
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

  // Method to navigate to the drafts screen
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

  // Method to navigate to the settings screen
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

  // Method to exit the app
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
          title: Text('HOME', style: TextStyle(fontSize: fontTitleSizeVar)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: spaceSize),
            Text('Bienvenido a $_place'),
            SizedBox(height: spaceSize),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: crossAxisSpacingVar,
                crossAxisCount: 2,
                children: <Widget>[
                  MenuItem(
                    icon: Icons.edit_document,
                    label: 'Crear Inventario',
                    onTap: () => _navigateToCustomTabBar(context),
                  ),
                  MenuItem(
                    icon: Icons.history,
                    label: 'Historial',
                    onTap: () => _navigateToDraftsScreen(context),
                  ),
                  MenuItem(
                    icon: Icons.settings,
                    label: 'Ajustes',
                    onTap: () => _navigateToSettingsScreen(context),
                  ),
                  MenuItem(
                    icon: Icons.exit_to_app,
                    label: 'Salir',
                    onTap: () => _exitApp(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget for the menu items.
class MenuItem extends StatelessWidget {
  /// icon for the rectangle.
  final IconData icon;
  /// label for the rectangle.
  final String label;
  /// signal for the action.
  final VoidCallback onTap;

  /// Creates an instance of [MenuItem].
  const MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: iconSize),
            Text(label, style: TextStyle(fontSize: fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

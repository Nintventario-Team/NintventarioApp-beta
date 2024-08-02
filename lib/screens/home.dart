import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/history.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'package:nintventario/screens/settings.dart';
import 'package:nintventario/widgets/tab_widget.dart';
import 'package:flutter/services.dart';

/// Global list of drafts.
List<Draft> globalDrafts = <Draft>[];

/// Global list of products.
List<Product> globalProducts = <Product>[];

/// Global inventory identifier.
String inventoryId = '';

/// Global time.
String globalTime = '';

/// Global date.
String globalDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

/// Global employee name.
String globalEmployeeName = '';

/// Global space size.
double spaceSize = 20;

/// Global cross-axis spacing.
double crossAxisSpacingVar = 20;

/// Global font size for title.
double fontTitleSizeVar = 30;

/// Global font size for text.
double fontTextSizeVar = 16;

/// Global icon size.
double iconSize = 40;

/// Current draft
Draft currentDraft = Draft();

///Observations
String globalObservations = 'Escriba aquí sus observaciones';

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
    currentDraft = Draft(); /// new draft default
    currentDraft.updateGlobalVariables();
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
        builder: (BuildContext context) => const DraftsScreen(),
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'HOME',
                  style: TextStyle(
                    fontSize: fontTitleSizeVar,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Bienvenido a $local',
                  style: TextStyle(
                    fontSize: fontTextSizeVar,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.blue.shade700,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          height: 180,
                          child: MenuItem(
                            icon: Icons.edit_document,
                            label: 'Crear Inventario',
                            onTap: () => _navigateToCustomTabBar(context),
                            color: Colors.blue.shade100,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 180,
                          child: MenuItem(
                            icon: Icons.history,
                            label: 'Historial',
                            onTap: () => _navigateToDraftsScreen(context),
                            color: Colors.blue.shade100,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 180,
                          child: MenuItem(
                            icon: Icons.settings,
                            label: 'Ajustes',
                            onTap: () => _navigateToSettingsScreen(context),
                            color: Colors.blue.shade100,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 180,
                          child: MenuItem(
                            icon: Icons.exit_to_app,
                            label: 'Salir',
                            onTap: () => _exitApp(context),
                            color: Colors.blue.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Últimas acciones',
                  style: TextStyle(
                    fontSize: fontTextSizeVar,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MenuItem(
                        imagePath: 'src/images/newestInv.png',
                        label: 'Último Inventario',
                        onTap: () {},
                        color: const Color.fromARGB(255, 249, 209, 144),
                        isLarge: true,
                      ),
                    ),
                    Expanded(
                      child: MenuItem(
                        imagePath: 'src/images/report.png',
                        label: 'Último Reporte',
                        onTap: () {},
                        color: const Color.fromARGB(255, 249, 144, 235),
                        isLarge: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for the menu items.
class MenuItem extends StatelessWidget {
  /// Icon for the menu item.
  final IconData? icon; // Optional icon
  
   /// ImagePath
  final String? imagePath;

  /// Label for the menu item.
  final String label;

  /// Callback for the tap event.
  final VoidCallback onTap;

  /// Background color for the menu item.
  final Color color;

  /// Flag to indicate if the menu item should be large.
  final bool isLarge;

  /// Creates an instance of [MenuItem].
  const MenuItem({
    this.imagePath,
    this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    this.isLarge = false,
    super.key,
  }) : assert(icon != null || imagePath != null,
            'Debe proporcionar un icono o una ruta de imagen.');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null) // Show image if provided
              Image.asset(
                imagePath!,
                width: isLarge ? 200 : 50,
                height: isLarge ? 250 : 50,
              )
            else if (icon != null) // Show icon if provided
              Icon(
                icon!,
                size: isLarge ? 50 : 30,
                color: Colors.black54,
              ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLarge ? 18 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/history.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'package:nintventario/screens/last_report.dart';
import 'package:nintventario/screens/last_inventory.dart';
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

/// Observations
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
    currentDraft = Draft();

    /// new draft default
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

  void _navigateToLastReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LastReport(),
      ),
    );
  }

  // Método para navegar a la página del último inventario
  void _navigateToLastInventory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LastInventory(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonSize = screenSize.width * 0.4;

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Background gradient to mimic the image design
              Container(
                height: screenSize.height * 0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    const Positioned(
                      top: 40,
                      right: 20,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('src/images/login.jpg'),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Bienvenido a $local',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Last Update 25 Feb 2023',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      MenuItem(
                        icon: Icons.edit_document,
                        label: 'Crear Inventario',
                        onTap: () => _navigateToCustomTabBar(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                      MenuItem(
                        icon: Icons.history,
                        label: 'Historial',
                        onTap: () => _navigateToDraftsScreen(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        label: 'Ajustes',
                        onTap: () => _navigateToSettingsScreen(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        label: 'Salir',
                        onTap: () => _exitApp(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                      MenuItem(
                        icon: Icons.last_page_rounded,
                        label: 'Último Inventario',
                        onTap: () => _navigateToLastReport(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                      MenuItem(
                        icon: Icons.last_page_rounded,
                        label: 'Último Reporte',
                        onTap: () => _navigateToLastInventory(context),
                        color: Colors.white,
                        buttonSize: buttonSize,
                      ),
                    ],
                  ),
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
  final IconData? icon; // Optional icon

  /// ImagePath
  final String? imagePath;

  /// Label for the menu item.
  final String label;

  /// Callback for the tap event.
  final VoidCallback onTap;

  /// Background color for the menu item.
  final Color color;

  /// Size of the button.
  final double buttonSize;

  /// Creates an instance of [MenuItem].
  const MenuItem({
    this.imagePath,
    this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    required this.buttonSize,
    super.key,
  }) : assert(icon != null || imagePath != null,
            'Debe proporcionar un icono o una ruta de imagen.');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15), // Rounded corners
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null) // Show image if provided
              Image.asset(
                imagePath!,
                width: 50,
                height: 50,
              )
            else if (icon != null) // Show icon if provided
              Icon(
                icon!,
                size: 40,
                color: Colors.blue,
              ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

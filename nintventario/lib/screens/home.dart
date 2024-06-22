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
double _spaceSize = 20;

/// Global cross-axis spacing.
double _crossAxisSpacingVar = 20;

/// Global font size for title.
double _fontTitleSizeVar = 40;

/// Global font size for text.
double _fontTextSizeVar = 18;

/// Global icon size.
double _iconSize = 40;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOME', style: TextStyle(fontSize: _fontTitleSizeVar)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: _spaceSize),
            Text('Welcome to $_place'),
            SizedBox(height: _spaceSize),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: _crossAxisSpacingVar,
                crossAxisCount: 2,
                children: const <Widget>[
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

/// Widget for creating a new inventory.
class NewInventoryWidget extends StatelessWidget {
  /// Creates an instance of [NewInventoryWidget].
  const NewInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (kDebugMode) {
            print('Create Inventory pressed');
          }
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const CustomTabBar(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.edit_document, size: _iconSize),
            Text('Create Inventory',
                style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

/// Widget for viewing the history.
class HistorialWidget extends StatelessWidget {
  /// Creates an instance of [HistorialWidget].
  const HistorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (kDebugMode) {
            print('History pressed');
          }
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => DraftsScreen(drafts: globalDrafts),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.history, size: _iconSize),
            Text('History', style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

/// Widget for settings.
class SettingsWidget extends StatelessWidget {
  /// Creates an instance of [SettingsWidget].
  const SettingsWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (kDebugMode) {
            print('Settings pressed');
          }
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const SettingsScreen(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.settings, size: _iconSize),
            Text('Settings', style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

/// Widget for exiting the application.
class ExitWidget extends StatelessWidget {
  /// Creates an instance of [ExitWidget].
  const ExitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (kDebugMode) {
            print('Exit pressed');
          }
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.exit_to_app, size: _iconSize),
            Text('Exit', style: TextStyle(fontSize: _fontTextSizeVar)),
          ],
        ),
      ),
    );
  }
}

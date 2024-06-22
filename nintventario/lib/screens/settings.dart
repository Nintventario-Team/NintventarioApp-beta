import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'about.dart';

double _spaceSize = 20;
double _fontOptionSize = 20;
double _fontTitleSize = 25;
double _hButton = 10;
double _vButton = 10;

/// Class for the settings screen.
class SettingsScreen extends StatefulWidget {
  /// Creates an instance of [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

/// State class for the settings screen.
class SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: _fontTitleSize),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notifications',
                style: TextStyle(fontSize: _fontOptionSize)),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                  if (kDebugMode) {
                    print(_notificationsEnabled);
                  }
                });
              },
            ),
          ),
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: Text(
              'Account Settings',
              style: TextStyle(fontSize: _fontOptionSize),
            ),
            onTap: () {
              // Navigate to the account settings screen
            },
          ),
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'About',
              style: TextStyle(fontSize: _fontOptionSize),
            ),
            onTap: () {
              // Navigate to the about screen
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) => AboutScreen()),
              );
            },
          ),
          const Spacer(),
          // Buttons to navigate to other screens
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the sale spots screen
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const SaleSptosPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 26, 107, 237),
                minimumSize: const Size(200, 40),
                padding: EdgeInsets.symmetric(
                    horizontal: _hButton, vertical: _vButton),
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text('Establishment'),
            ),
          ),
          SizedBox(height: _spaceSize),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 237, 26, 26),
                minimumSize: const Size(200, 40),
                padding: EdgeInsets.symmetric(
                    horizontal: _hButton, vertical: _vButton),
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text('Log Out'),
            ),
          ),
          SizedBox(height: _spaceSize),
        ],
      ),
    );
  }
}

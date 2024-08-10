import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'about.dart';
import 'account_info.dart';

double _spaceSize = 20;
double _fontOptionSize = 18;
double _fontTitleSize = 24;
double _hButton = 16;
double _vButton = 12;

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
          style: TextStyle(
            fontSize: _fontTitleSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a setting...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: _spaceSize),
              ListTile(
                leading: Icon(Icons.info, color: Colors.grey[700]),
                title: Text(
                  'Acerca de nostros',
                  style: TextStyle(
                      fontSize: _fontOptionSize, color: Colors.grey[800]),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => AboutScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.grey[700]),
                title: Text(
                  'Account',
                  style: TextStyle(
                      fontSize: _fontOptionSize, color: Colors.grey[800]),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
                onTap: () {
                  showAccountInfo(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.store, color: Colors.grey[700]),
                title: Text(
                  'Cambiar Establecimiento',
                  style: TextStyle(
                      fontSize: _fontOptionSize, color: Colors.grey[800]),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const SaleSptosPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.grey[700]),
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                      fontSize: _fontOptionSize, color: Colors.grey[800]),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const LoginApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

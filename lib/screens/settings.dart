import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'about.dart';

double _spaceSize = 20;
double _fontOptionSize = 18;
double _fontTitleSize = 22;
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
        title: RichText(
          text: TextSpan(
            text: 'Settings',
            style: TextStyle(
              fontSize: _fontTitleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White color for "Settings"
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' Settings', // Additional text
                style: TextStyle(
                  fontSize: _fontTitleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800], // Dark blue for additional text
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue[800], // Dark blue for AppBar
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // White color for the back arrow
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Container(
        color: Colors.blue[50], // Light blue background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: _spaceSize),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue[700]), // Blue icon
                title: Text('Notifications',
                    style: TextStyle(fontSize: _fontOptionSize, color: Colors.blue[800])),
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
                leading: Icon(Icons.manage_accounts, color: Colors.blue[700]), // Blue icon
                title: Text(
                  'Account Settings',
                  style: TextStyle(fontSize: _fontOptionSize, color: Colors.blue[800]),
                ),
                onTap: () {
                  // Navigate to the account settings screen
                },
              ),
              SizedBox(height: _spaceSize),
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue[700]), // Blue icon
                title: Text(
                  'About',
                  style: TextStyle(fontSize: _fontOptionSize, color: Colors.blue[800]),
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
                    foregroundColor: Colors.white, backgroundColor: Colors.blue[800], // Dark blue for button
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: _hButton, vertical: _vButton),
                    textStyle: const TextStyle(fontSize: 18), // White text color
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
                    foregroundColor: Colors.white, backgroundColor: Colors.red[700], // Dark red for button
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: _hButton, vertical: _vButton),
                    textStyle: const TextStyle(fontSize: 18), // White text color
                  ),
                  child: const Text('Log Out'),
                ),
              ),
              SizedBox(height: _spaceSize),
            ],
          ),
        ),
      ),
    );
  }
}

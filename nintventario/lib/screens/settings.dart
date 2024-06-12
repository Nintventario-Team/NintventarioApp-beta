import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';
import 'package:nintventario/screens/sale_spots.dart';
import 'about.dart';

double _spaceSize = 20;
double _fontOptionSize = 20;
double _fontTitleSize = 25;
double _hButton = 10;
double _vButton = 10;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
          style: TextStyle(fontSize: _fontTitleSize),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notificaciones',
                style: TextStyle(fontSize: _fontOptionSize)),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                  print(_notificationsEnabled);
                });
              },
            ),
          ),
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: Text(
              'Configurar cuenta',
              style: TextStyle(fontSize: _fontOptionSize),
            ),
            onTap: () {
              // Navegar a la pantalla de configuración de cuenta
            },
          ),
          SizedBox(height: _spaceSize),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'Acerca de',
              style: TextStyle(fontSize: _fontOptionSize),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
              // Navegar a la pantalla de acerca de
            },
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SaleSptosPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 107, 237),
                  minimumSize: const Size(200, 40),
                  padding: EdgeInsets.symmetric(
                      horizontal: _hButton, vertical: _vButton),
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: const Text('Establecimiento'),
            ),
          ),
          SizedBox(height: _spaceSize),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 26, 26),
                  minimumSize: const Size(200, 40),
                  padding: EdgeInsets.symmetric(
                      horizontal: _hButton, vertical: _vButton),
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: const Text('Cerrar Sesión'),
            ),
          ),
          SizedBox(height: _spaceSize),
        ],
      ),
    );
  }
}

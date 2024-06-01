import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';

double _spaceSize = 20;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes'),),
      body: Column(children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginApp()),
                );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 107, 237),
                  minimumSize: const Size(200, 50), 
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 25),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)
                ),
                  child: const Text('Establecimiento'),
          )
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
                  minimumSize: const Size(200, 50), 
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 25),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)
                ),
                  child: const Text('Cerrar Sesión'),
          )
        ),
      ]),
    );
  }
}

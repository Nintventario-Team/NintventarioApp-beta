import 'package:flutter/material.dart';
import 'sale_spots.dart';

/// Controller for the password input field.
final TextEditingController _passwordController = TextEditingController();

/// Main widget for the login screen.
class LoginApp extends StatelessWidget {
  /// Creates an instance of [LoginApp].
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('src/images/login.jpg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) => const SaleSptosPage()),
              );
            },
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
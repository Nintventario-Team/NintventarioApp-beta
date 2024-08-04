import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sale_spots.dart'; // Import your existing class

/// Controllers for input fields
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

/// Main widget for the login screen.
class LoginApp extends StatefulWidget {
  /// Constant constructor for the LoginApp class.
  const LoginApp({super.key});

  @override
  LoginAppState createState() => LoginAppState();
}

/// State of the login screen.
class LoginAppState extends State<LoginApp> {
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Function to handle login process.
  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final http.Response response = await http.post(
        Uri.parse('https://servernintventario.onrender.com/login'), // Use your local machine IP
        body: json.encode(
            <String, String>{'username': username, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final String token = data['Token'];

        // Store the token or handle the response as needed
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const SaleSptosPage(),
          ),
        );
      } else {
        // Handle error
        _showErrorDialog(context, 'Usuario o contraseña incorrectos');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _showErrorDialog(context, 'Un error ha ocurrido, inténtelo de nuevo.');
    }
  }

  /// Function to show an error dialog.
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// Function to handle bypassing the login.
  void _bypassLogin(BuildContext context) {
    // Action to execute when bypassing the login
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SaleSptosPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
      ), */
      body: Container(
        color: Colors.white, // Light blue background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Contenedor con efecto de difuminación
              Container(
                padding:
                    const EdgeInsets.all(4.0), // Espacio alrededor de la imagen
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1), // Fondo azul claro
                  borderRadius: BorderRadius.circular(
                      150), // Radio circular para la imagen
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blue
                          .withOpacity(0.5), // Sombra azul con opacidad
                      spreadRadius: 4,
                      blurRadius: 15,
                      offset: const Offset(0, 0), // Sin desplazamiento
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 150, // Tamaño de la imagen
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('src/images/login.jpg'),
                ),
              ),
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0), // Ajusta el valor según tus necesidades
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(
                        255, 21, 105, 200), // Dark blue color for the text
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[800], // Dark blue for button
                    minimumSize: const Size(double.infinity,
                        50), // Ensure button's height is 50 and width is dynamic
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 18), // Text size
                  ),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  _bypassLogin(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor:
                      Colors.blue[800], // Dark blue for button text
                ),
                child: const Text('Bypass Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

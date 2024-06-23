import 'package:flutter/material.dart';
import 'package:nintventario/screens/login_page.dart';

/// Entry point of the application.
///
/// This file defines the `main` function that starts the execution of the
/// Flutter application.
void main() => runApp(
      MaterialApp(
        // Prevents the debug banner from being displayed in the top right corner
        // of the application.
        debugShowCheckedModeBanner: false,
        // Defines the theme of the application.
        theme: ThemeData(
          // Configures the brightness of the application as light.
          brightness: Brightness.light,
          // Configures the primary color of the application as cyan.
          primaryColor: Colors.cyan,
        ),
        // Defines the home screen of the application as LoginPage.
        home: const Login(),
      ),
    );

/// The main widget representing the login screen.
///
/// This screen is the initial screen of the application, where users can
/// log in to access other functions of the application.
class Login extends StatelessWidget {
  /// Constant constructor of the Login class.
  ///
  /// [key] is an optional parameter used to uniquely identify the widget. In this
  /// case, [super.key] is used to initialize the `key` parameter of the base
  /// class `StatelessWidget` constructor.
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Defines the body of the screen as a login application widget.
      body: LoginApp(),
    );
  }
}

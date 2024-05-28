import 'package:flutter/material.dart';
import "package:nintventario/screens/login_page.dart";

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.cyan),
      home: Login(),
    ));

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginApp(),
    );
  }
}

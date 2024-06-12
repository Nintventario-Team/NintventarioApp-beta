import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha actual

class AboutScreen extends StatelessWidget {
  final String version = '1.0';
  final List<String> creators = [
    'Cornejo Andrés',
    'Mawyin Jorge',
    'Roldan Kevin',
    'Tomala Angel'
  ];
  final String currentDate = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ninventario $version',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Creado por:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              children: creators.map((creator) {
                return Text(
                  creator,
                  style: TextStyle(fontSize: 16),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Fecha de creación:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              currentDate,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutScreen(),
  ));
}

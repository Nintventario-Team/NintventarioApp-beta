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
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ninventario $version',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Creado por:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Column(
              children: creators.map((creator) {
                return Text(
                  creator,
                  style: const TextStyle(fontSize: 16),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Fecha de creación:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              currentDate,
              style: const TextStyle(fontSize: 16),
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

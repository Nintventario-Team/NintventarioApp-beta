import 'package:flutter/material.dart';
import '../screens/home.dart';

String _local = ''; // Variable global para almacenar la selección

class SaleSptosPage extends StatelessWidget {
  const SaleSptosPage({super.key});

  final List<Map<String, String>> _locations = const [
    {"image": "images/ceibos.jpg", "name": "Ceibos"},
    {"image": "images/machala.jpg", "name": "Machala"},
    {"image": "images/puntilla.jpg", "name": "Puntilla"},
    {"image": "images/terminal.jpg", "name": "Terminal"},
  ];

  void _selectLocation(BuildContext context, String location) {
    _local = location;
    print('Selected location: $_local');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Sptos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _locations.map((location) {
            return GestureDetector(
              onTap: () {
                _selectLocation(context, location['name']!); // Forzar a no nulo
              },
              child: Column(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      location['image']!,
                      width: 300,
                      height: 200,
                    ),
                  ),
                  Text(location['name']!),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

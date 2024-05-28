import 'package:flutter/material.dart';

String _local = ''; // Variable global para almacenar la selección

class SaleSptosPage extends StatefulWidget {
  @override
  _SaleSptosPageState createState() => _SaleSptosPageState();
}

class _SaleSptosPageState extends State<SaleSptosPage> {
  final List<Map<String, String>> _locations = [
    {"image": "images/ceibos.jpg", "name": "Ceibos"},
    {"image": "images/machala.jpg", "name": "Machala"},
    {"image": "images/puntilla.jpg", "name": "Puntilla"},
    {"image": "images/terminal.jpg", "name": "Terminal"},
  ];

  void _selectLocation(String location) {
    setState(() {
      _local = location;
    });
    print('Selected location: $_local');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Sptos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _locations.map((location) {
            return GestureDetector(
              onTap: () =>
                  _selectLocation(location['name']!), // Forzar a no nulo
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
                  SizedBox(
                      height: 20), // Añade un espaciado entre cada elemento
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

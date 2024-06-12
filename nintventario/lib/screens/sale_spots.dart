import 'package:flutter/material.dart';
import '../screens/home.dart';

String _local = ''; // Variable global para almacenar la selección

class SaleSptosPage extends StatelessWidget {
  const SaleSptosPage({Key? key});

  final List<Map<String, String>> _locations = const [
    {"image": "src/images/ceibos.jpg", "name": "Ceibos"},
    {"image": "src/images/machala.jpg", "name": "Machala"},
    {"image": "src/images/puntilla.jpg", "name": "Puntilla"},
    {"image": "src/images/terminal.jpg", "name": "Terminal"},
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _locations.map((location) {
            return GestureDetector(
              onTap: () {
                _selectLocation(context, location['name']!); // Forzar a no nulo
              },
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            location['image']!,
                            fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.4),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            child: Text(
                              location['name']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

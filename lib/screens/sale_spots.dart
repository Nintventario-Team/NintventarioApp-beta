import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';

/// Global Variable to save the local
String local = ''; 
//String _idLocal = '';

/// Main widget for the sale spots page.
class SaleSptosPage extends StatelessWidget {
  // List of sale spot locations.
  final List<Map<String, String>> _locations = const <Map<String, String>>[
    <String, String>{'image': 'src/images/ceibos.jpg', 'name': 'Ceibos'},
    <String, String>{'image': 'src/images/machala.jpg', 'name': 'Machala'},
    <String, String>{'image': 'src/images/puntilla.jpg', 'name': 'Puntilla'},
    <String, String>{'image': 'src/images/terminal.jpg', 'name': 'Terminal'},
  ];

  /// Creates an instance of [SaleSptosPage].
  const SaleSptosPage({super.key});

  /// Function to handle location selection.
  void _selectLocation(BuildContext context, String location) {
    local = location; // Update the global variable
    if (kDebugMode) {
      print('Selected location: $local');
    }
    // Navigate to the Home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const Home(),
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
          children: _locations.map((Map<String, String> location) {
            return GestureDetector(
              onTap: () {
                _selectLocation(context, location['name']!); // Handle location selection
              },
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          // Image representing the sale spot
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
                                  colors: <Color>[
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
                              style: const TextStyle(
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

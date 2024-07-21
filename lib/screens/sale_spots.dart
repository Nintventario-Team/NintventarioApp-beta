import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';

/// Global Variable to save the local
String local = ''; 

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
        title: const Text(
          'Sale Spots',
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
      ),
      body: Container(
        color: Colors.blue[50], // Light blue background
        child: SingleChildScrollView(
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
                    const SizedBox(height: 30), // Increased margin before the first image
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 200,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            // Image representing the sale spot
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                location['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
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
                                  fontSize: 22,
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
      ),
    );
  }
}

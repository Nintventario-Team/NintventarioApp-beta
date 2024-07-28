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
      body: Container(
        color: Colors.blue[50], // Light blue background
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 22),
              const Text(
                'Hola! \nAndrés Cornejo',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Seleccione un local comercial para empezar:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Color.fromARGB(165, 0, 0, 0), // Texto más transparente
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 locales por fila
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1, // Aspecto cuadrado
                  ),
                  itemCount: _locations.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, String> location = _locations[index];
                    return GestureDetector(
                      onTap: () {
                        _selectLocation(context,
                            location['name']!); // Handle location selection
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
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
                                      fontFamily: 'Oswald', // Font added here
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          BottomAppBar(
            color: const Color.fromARGB(
                204, 21, 101, 192), // Dark blue color for BottomAppBar
            shape:
                const CircularNotchedRectangle(), // Shape to make room for the circle
            notchMargin:
                8.0, // Margin between the circle and the bottom app bar
            child: Container(
              height: 90.0, // Height of the bottom app bar
            ),
          ),
          const Positioned(
            top:
                -30.0, // Adjust this value to control how much the image overlaps
            child: CircleAvatar(
              radius: 47, // Larger radius for the circle
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage('src/images/login.jpg'), // Main image from login
            ),
          ),
        ],
      ),
    );
  }
}

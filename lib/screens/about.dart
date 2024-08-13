import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the current date

/// Screen that displays information about the application.
class AboutScreen extends StatelessWidget {
  /// The version of the application.
  final String version = '1.0';

  /// List of the application's creators.
  final List<String> creators = <String>[
    'Cornejo Andrés',
    'Mawyin Jorge',
    'Roldan Kevin',
    'Tomala Angel'
  ];

  /// Formatted current date.
  final String currentDate = DateFormat.yMMMMd().format(DateTime.now());

  /// Constructor for the AboutScreen class.
  ///
  /// [key] is an optional parameter used to uniquely identify the widget.
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // White background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ninventario $version',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800], // Darker teal for title
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Created by:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            Colors.teal[700], // Medium teal for section title
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: creators.map((String creator) {
                        return Text(
                          creator,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0,
                                0), // Slightly lighter teal for creators
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Creation Date:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            Colors.teal[700], // Medium teal for section title
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(
                            255, 0, 0, 0), // Slightly lighter teal for date
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The entry point of the application.
void main() {
  runApp(MaterialApp(
    // Sets the home screen of the application to AboutScreen.
    home: AboutScreen(),
    theme: ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.teal, // Primary teal theme for the app
    ),
  ));
}

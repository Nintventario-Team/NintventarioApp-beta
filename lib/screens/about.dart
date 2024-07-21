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
        backgroundColor: Colors.blueAccent, // Darker blue for AppBar
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue[50], // Light blue background color
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
                        color: Colors.blue[800], // Darker blue for title
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Created by:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700], // Medium blue for section title
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
                            color: Colors.blue[600], // Slightly lighter blue for creators
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
                        color: Colors.blue[700], // Medium blue for section title
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[600], // Slightly lighter blue for date
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
      primarySwatch: Colors.blue, // Primary blue theme for the app
    ),
  ));
}

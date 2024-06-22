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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ninventario $version',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Created by:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Column(
              children: creators.map((String creator) {
                return Text(
                  creator,
                  style: const TextStyle(fontSize: 16),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Creation Date:',
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

/// The entry point of the application.
void main() {
  runApp(MaterialApp(
    // Sets the home screen of the application to AboutScreen.
    home: AboutScreen(),
  ));
}

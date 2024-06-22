import 'package:flutter/material.dart';
import 'package:nintventario/classes/draft.dart';

/// Screen that displays a list of saved drafts.
class DraftsScreen extends StatelessWidget {
  /// List of drafts.
  final List<Draft> drafts;

  /// Constructor for the DraftsScreen class.
  ///
  /// [drafts] is a list of drafts to be displayed on the screen.
  const DraftsScreen({super.key, required this.drafts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borradores Guardados'),
      ),
      body: ListView.builder(
        itemCount: drafts.length,
        itemBuilder: (BuildContext context, int index) {
          final Draft draft = drafts[index];
          return ListTile(
            title: Text('ID: ${draft.id}'),
            subtitle: Text('Employee: ${draft.employee}\nDuration: ${draft.duration} hours\nDate: ${draft.creationDate}'),
          );
        },
      ),
    );
  }
}

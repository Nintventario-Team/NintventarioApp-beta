import 'package:flutter/material.dart';
import 'package:nintventario/classes/draft.dart';

class DraftsScreen extends StatelessWidget {
  final List<Draft> drafts;

  const DraftsScreen({super.key, required this.drafts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borradores Guardados'),
      ),
      body: ListView.builder(
        itemCount: drafts.length,
        itemBuilder: (context, index) {
          final draft = drafts[index];
          return ListTile(
            title: Text('ID: ${draft.id}'),
            subtitle: Text('Encargado: ${draft.employee}\nDuración: ${draft.duration} horas\nFecha: ${draft.creationDate}'),
          );
        },
      ),
    );
  }
}

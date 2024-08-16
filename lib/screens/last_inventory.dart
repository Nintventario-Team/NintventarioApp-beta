
import 'package:flutter/material.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/widgets/tab_widget.dart';

/// Widget para la pantalla del último inventario.
class LastInventory extends StatefulWidget {
  /// Constructor constant of the LastInventory class.
  const LastInventory({super.key});

  @override
  LastInventoryState createState() => LastInventoryState();
}

/// State of the LastInventory widget.
class LastInventoryState extends State<LastInventory> {
  late Future<Draft?> _lastDraftFuture;

  @override
  void initState() {
    super.initState();
    _lastDraftFuture =
        _loadLastDraft(); // Cargar el último borrador al iniciar la pantalla
  }

  Future<Draft?> _loadLastDraft() async {
    final List<Draft> drafts = await Draft.loadDrafts();
    if (drafts.isEmpty) {
      return null; // Si no hay borradores, retornar null
    }

    // Ordenar los borradores para obtener el último
    drafts.sort((Draft a, Draft b) {
      final int dateComparison = b.creationDate
          .substring(0, 10)
          .compareTo(a.creationDate.substring(0, 10));
      if (dateComparison != 0) {
        return dateComparison;
      }
      return b.creationDate
          .substring(11)
          .compareTo(a.creationDate.substring(11));
    });

    return drafts.first; // Retornar el último borrador
  }

  void _onDraftSelected(Draft draft) {
    currentDraft =
        draft; // Establecer el borrador seleccionado como el borrador actual
    currentDraft.updateGlobalVariables();

    // Navegar a la página de detalles del inventario y pasar el borrador seleccionado
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CustomTabBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Último Inventario'),
      ),
      body: FutureBuilder<Draft?>(
        future: _lastDraftFuture,
        builder: (BuildContext context, AsyncSnapshot<Draft?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No hay inventarios disponibles.'));
          } else {
            final Draft draft = snapshot.data!;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'ID: ${draft.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Empleado: ${draft.employee}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'Duración: ${draft.duration} horas',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'Fecha: ${draft.creationDate.length > 10 ? draft.creationDate.substring(0, 10) : draft.creationDate}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Observaciones',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      draft.observations,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Estado: ${draft.state == DraftState.completed ? 'Completado' : 'No Completado'}',
                      style: TextStyle(
                        color: draft.state == DraftState.completed
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: () => _onDraftSelected(draft), // Navegar al hacer clic
              ),
            );
          }
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/widgets/tab_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pantalla que muestra una lista de borradores guardados y permite la selección.
class DraftsScreen extends StatefulWidget {
  /// Crea una instancia de [DraftsScreen].
  const DraftsScreen({super.key});

  @override
  DraftsScreenState createState() => DraftsScreenState();
}

/// Clase de estado para [DraftsScreen].
class DraftsScreenState extends State<DraftsScreen> {
  late Future<List<Draft>> _draftsFuture;
  String _filter = 'All'; // Estado actual del filtro
  String _sortOrder = 'Newest'; // Orden de clasificación actual

  @override
  void initState() {
    super.initState();
    _draftsFuture = Draft.loadDrafts(); // Cargar borradores cuando se inicializa la pantalla
  }

  void _onDraftSelected(Draft draft) {
    currentDraft = draft; // Establecer el borrador seleccionado como el borrador actual
    currentDraft.updateGlobalVariables();
    // Navegar a la página de detalles del inventario y pasar el borrador seleccionado
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CustomTabBar(),
      ),
    );
  }

  Future<void> _deleteDraft(Draft draft) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> draftsList = prefs.getStringList('drafts') ?? <String>[];

    // Eliminar borrador con el ID coincidente
    final int draftIndex = draftsList.indexWhere((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return draftJson['id'] == draft.id;
    });

    if (draftIndex != -1) {
      draftsList.removeAt(draftIndex);
      await prefs.setStringList('drafts', draftsList);
      setState(() {
        _draftsFuture = Draft.loadDrafts(); // Recargar borradores después de la eliminación
      });
    }
  }

  Future<void> _confirmDeleteDraft(Draft draft) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de Borrado'),
          content: Text('¿Estás seguro que quieres borrar el borrador? ID: ${draft.id}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Borrar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _deleteDraft(draft);
    }
  }

  Future<void> _toggleDraftStatus(Draft draft) async {
    final Draft updatedDraft = Draft(
      id: draft.id,
      employee: draft.employee,
      duration: draft.duration,
      creationDate: draft.creationDate,
      state: draft.state == DraftState.completed
          ? DraftState.notCompleted
          : DraftState.completed,
      products: draft.products,
      observations: draft.observations
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> draftsList = prefs.getStringList('drafts') ?? <String>[];

    // Actualizar borrador en la lista
    final int draftIndex = draftsList.indexWhere((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return draftJson['id'] == draft.id;
    });

    if (draftIndex != -1) {
      draftsList[draftIndex] = jsonEncode(updatedDraft.toJson());
      await prefs.setStringList('drafts', draftsList);
      setState(() {
        _draftsFuture = Draft.loadDrafts(); // Recargar borradores después de la actualización
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Borradores Guardados',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                if (value == 'Sort') {
                  _showSortDialog();
                } else {
                  _filter = value;
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('Todos'),
              ),
              const PopupMenuItem<String>(
                value: 'Completed',
                child: Text('Completados'),
              ),
              const PopupMenuItem<String>(
                value: 'NotCompleted',
                child: Text('No Completados'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'Sort',
                child: Text('Ordenar'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Draft>>(
        future: _draftsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Draft>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay borradores disponibles.'));
          } else {
            List<Draft> drafts = snapshot.data!;
            if (_filter == 'Completed') {
              drafts = drafts.where((Draft draft) => draft.state == DraftState.completed).toList();
            } else if (_filter == 'NotCompleted') {
              drafts = drafts.where((Draft draft) => draft.state == DraftState.notCompleted).toList();
            }

            if (_sortOrder == 'Newest') {
              drafts.sort((Draft a, Draft b) {
                final int dateComparison = b.creationDate.substring(0, 10).compareTo(a.creationDate.substring(0, 10));
                if (dateComparison != 0) {
                  return dateComparison;
                }
                final int timeComparison = b.creationDate.substring(11).compareTo(a.creationDate.substring(11));
                return timeComparison;
              });
            } else if (_sortOrder == 'Oldest') {
              drafts.sort((Draft a, Draft b) {
                final int dateComparison = a.creationDate.substring(0, 10).compareTo(b.creationDate.substring(0, 10));
                if (dateComparison != 0) {
                  return dateComparison;
                }
                final int timeComparison = a.creationDate.substring(11).compareTo(b.creationDate.substring(11));
                return timeComparison;
              });
            }

            return ListView.builder(
              itemCount: drafts.length,
              itemBuilder: (BuildContext context, int index) {
                final Draft draft = drafts[index];
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _toggleDraftStatus(draft),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: FaIcon(
                              draft.state == DraftState.completed
                                  ? FontAwesomeIcons.squareCheck
                                  : FontAwesomeIcons.square,
                              color: draft.state == DraftState.completed
                                  ? Colors.green
                                  : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20), // Espaciado adicional entre los íconos
                        GestureDetector(
                          onTap: () => _confirmDeleteDraft(draft),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const FaIcon(
                              FontAwesomeIcons.trash,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _onDraftSelected(draft),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showSortDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ordenar Borradores'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('Más Recientes'),
                value: 'Newest',
                groupValue: _sortOrder,
                onChanged: (String? value) {
                  setState(() {
                    _sortOrder = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Más Antiguos'),
                value: 'Oldest',
                groupValue: _sortOrder,
                onChanged: (String? value) {
                  setState(() {
                    _sortOrder = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

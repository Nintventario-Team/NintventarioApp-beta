import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/widgets/tab_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Screen that displays a list of saved drafts and allows selection.
class DraftsScreen extends StatefulWidget {
  /// Creates an instance of [DraftsScreen].
  const DraftsScreen({super.key});

  @override
  DraftsScreenState createState() => DraftsScreenState();
}

/// State class for [DraftsScreen].
class DraftsScreenState extends State<DraftsScreen> {
  late Future<List<Draft>> _draftsFuture;
  String _filter = 'Todos'; // Current filter state
  String _sortOrder = 'Recientes'; // Current sort order

  @override
  void initState() {
    super.initState();
    _draftsFuture = Draft.loadDrafts(); // Load drafts when the screen initializes
  }

  /// Handles draft selection and navigates to the inventory detail page.
  void _onDraftSelected(Draft draft) {
    currentDraft = draft; // Set the selected draft as the current draft
    currentDraft.updateGlobalVariables();
    // Navigate to the inventory details page and pass the selected draft
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CustomTabBar(),
      ),
    );
  }

  /// Deletes a draft from the saved drafts.
  Future<void> _deleteDraft(Draft draft) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> draftsList = prefs.getStringList('drafts') ?? <String>[];

    // Find and remove the draft with the matching ID
    final int draftIndex = draftsList.indexWhere((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return draftJson['id'] == draft.id;
    });

    if (draftIndex != -1) {
      draftsList.removeAt(draftIndex);
      await prefs.setStringList('drafts', draftsList);
      setState(() {
        _draftsFuture = Draft.loadDrafts(); // Reload drafts after deletion
      });
    }
  }

  /// Confirms with the user before deleting a draft.
  Future<void> _confirmDeleteDraft(Draft draft) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Confirmar borrado?'),
          content: Text('¿Estás seguro de que quieres borrar el borrador con ID: ${draft.id}?'),
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

  /// Toggles the completion status of a draft.
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

    // Update the draft in the list
    final int draftIndex = draftsList.indexWhere((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return draftJson['id'] == draft.id;
    });

    if (draftIndex != -1) {
      draftsList[draftIndex] = jsonEncode(updatedDraft.toJson());
      await prefs.setStringList('drafts', draftsList);
      setState(() {
        _draftsFuture = Draft.loadDrafts(); // Reload drafts after the update
      });
    }
  }

  /// Formats the creation date to ensure it is safe to use with substring.
  String _formatCreationDate(String creationDate) {
    if (creationDate.length >= 10) {
      return creationDate.substring(0, 10); // Get the date (YYYY-MM-DD)
    } else {
      return creationDate; // Return original value if too short
    }
  }

  /// Formats the creation time to ensure it is safe to use with substring.
  String _formatCreationTime(String creationDate) {
    if (creationDate.length > 11) {
      return creationDate.substring(11); // Get the time (HH:MM:SS)
    } else {
      return ''; // Return an empty string if too short
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Borrador Guardados',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                if (value == 'Ordenar') {
                  _showSortDialog();
                } else {
                  _filter = value;
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Todos',
                child: Text('Todos'),
              ),
              const PopupMenuItem<String>(
                value: 'Completados',
                child: Text('Completados'),
              ),
              const PopupMenuItem<String>(
                value: 'No Completados',
                child: Text('No Completados'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'Ordenar',
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
            if (_filter == 'Completados') {
              drafts = drafts.where((Draft draft) => draft.state == DraftState.completed).toList();
            } else if (_filter == 'No Completados') {
              drafts = drafts.where((Draft draft) => draft.state == DraftState.notCompleted).toList();
            }

            if (_sortOrder == 'Recientes') {
              drafts.sort((Draft a, Draft b) {
                final int dateComparison = _formatCreationDate(b.creationDate).compareTo(_formatCreationDate(a.creationDate));
                if (dateComparison != 0) {
                  return dateComparison;
                }
                final int timeComparison = _formatCreationTime(b.creationDate).compareTo(_formatCreationTime(a.creationDate));
                return timeComparison;
              });
            } else if (_sortOrder == 'Antiguos') {
              drafts.sort((Draft a, Draft b) {
                final int dateComparison = _formatCreationDate(a.creationDate).compareTo(_formatCreationDate(b.creationDate));
                if (dateComparison != 0) {
                  return dateComparison;
                }
                final int timeComparison = _formatCreationTime(a.creationDate).compareTo(_formatCreationTime(b.creationDate));
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
                          'Encargado: ${draft.employee}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Duración: ${draft.duration} horas',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Fecha: ${_formatCreationDate(draft.creationDate)}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Observaciones:',
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
                        const SizedBox(width: 20), // Additional spacing between icons
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

  /// Displays a dialog to select the sort order for drafts.
  void _showSortDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ordenar borradores'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('Recientes'),
                value: 'Recientes',
                groupValue: _sortOrder,
                onChanged: (String? value) {
                  setState(() {
                    _sortOrder = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Antiguos'),
                value: 'Antiguos',
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

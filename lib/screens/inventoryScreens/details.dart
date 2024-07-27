import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';
import '../../widgets/date_selector_widget.dart';
import 'package:nintventario/screens/history.dart';

/// Font size for the title text.
const double _fontTitleSizeVar = 25;

/// Entry point of the application.
void main() {
  runApp(
    const MaterialApp(
      home: InventoryDetails(),
    ),
  );
}

/// A StatefulWidget that displays inventory details.
class InventoryDetails extends StatefulWidget {
  /// Creates an instance of [InventoryDetails].
  const InventoryDetails({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsWidgetState();
}

/// State class for [InventoryDetails].
class _DetailsWidgetState extends State<InventoryDetails> with AutomaticKeepAliveClientMixin {
  /// Controller for the employee name input field.
  final TextEditingController _employeeController = TextEditingController(text: globalEmployeeName);

  /// Controller for the duration input field.
  final TextEditingController _durationController = TextEditingController(text: '0');

  /// List of drafts.
  final List<Map<String, String>> drafts = <Map<String, String>>[];

  /// Saves a draft.
  void _saveDraft() {
    final Draft newDraft = Draft(
      id: inventoryId,
      employee: _employeeController.text,
      duration: _durationController.text,
      creationDate: globalDate,
      state: DraftState.notCompleted, // or DraftState.completed depending on the condition
      products: List<Product>.from(globalProducts), // Copy of globalProducts to avoid direct modification
    );

    globalDrafts.add(newDraft);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Borrador guardado!')));

    if (kDebugMode) {
      print(globalDrafts);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del inventario',
          style: TextStyle(
            fontSize: _fontTitleSizeVar
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.list,
              color: Color.fromARGB(255, 0, 0, 0), // Icon color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) => DraftsScreen(drafts: globalDrafts)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Inventory ID:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.blueGrey.shade50, // Background color for container
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                inventoryId,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Encargado del inventario:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _employeeController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Duración del inventario (días):',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                hintText: 'Ingresa el número de días',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Fecha de creación:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DateSelectorWidget(
              onDateSelected: (DateTime newDate) {
                setState(() {
                  globalDate = newDate.toString();
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveDraft,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Guardar borrador'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


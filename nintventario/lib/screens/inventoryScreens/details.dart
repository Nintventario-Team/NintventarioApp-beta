import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nintventario/screens/home.dart';
import '../../widgets/date_selector_widget.dart';
import 'package:nintventario/screens/history.dart';

double _fontTitleSizeVar = 25;

void main() {
  runApp(
    const MaterialApp(
      home: InventoryDetails(),
    ),
  );
}

class InventoryDetails extends StatefulWidget {
  const InventoryDetails({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<InventoryDetails> with AutomaticKeepAliveClientMixin {
  final TextEditingController _employeeController = TextEditingController(text: globalEmployeeName);
  final TextEditingController _durationController = TextEditingController(text: '0');

  List<Map<String, String>> drafts = [];

  void _saveDraft() {
    drafts.add({
      'id': inventoryId,
      'employee': _employeeController.text,
      'duration': _durationController.text,
      'creationDate': globalDate,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Borrador guardado!')));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalles del inventario",
          style: TextStyle(fontSize: _fontTitleSizeVar),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DraftsScreen(drafts: globalDrafts)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("ID del inventario:"),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(inventoryId),
            ),
            const SizedBox(height: 20),
            const Text("Encargado del Inventario: "),
            const SizedBox(height: 10),
            TextField(
              controller: _employeeController,
              decoration: InputDecoration(
                hintText: 'Ingrese su nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Duración del inventariado: "),
            const SizedBox(height: 10),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                hintText: 'Ingrese el número de horas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 20),
            const Text("Fecha de creación: "),
            const SizedBox(height: 10),
            DateSelectorWidget(
              onDateSelected: (newDate) {
                setState(() {
                  globalDate = newDate.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveDraft,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                ),
                child: const Text('GUARDAR BORRADOR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

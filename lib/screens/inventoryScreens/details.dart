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
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved!')));

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
          'Inventory Details',
          style: TextStyle(fontSize: _fontTitleSizeVar),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Inventory ID:'),
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
            const Text('Inventory Manager: '),
            const SizedBox(height: 10),
            TextField(
              controller: _employeeController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Inventory Duration: '),
            const SizedBox(height: 10),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                hintText: 'Enter the number of hours',
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
            const Text('Creation Date: '),
            const SizedBox(height: 10),
            DateSelectorWidget(
              onDateSelected: (DateTime newDate) {
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
                child: const Text('SAVE DRAFT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

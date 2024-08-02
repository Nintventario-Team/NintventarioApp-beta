import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';

/// A stateless widget that represents the report screen.
class ReportScreen extends StatelessWidget {
  /// Creates an instance of [ReportScreen].
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int checkedProductsCount = 0;
    int uncheckedProductsCount = 0;

    // Count checked and unchecked products
    for (Product product in globalProducts) {
      if (product.state == ProductState.checked) {
        checkedProductsCount++;
      } else {
        uncheckedProductsCount++;
      }
    }

    final TextEditingController observationsController =
        TextEditingController(text: globalObservations);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Reporte del inventario',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Title text color (black)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              _buildDetailField(
                  'Productos checkeados:', checkedProductsCount.toString()),
              const SizedBox(height: 20),
              _buildDetailField('Productos no-checkeados:',
                  uncheckedProductsCount.toString()),
              const SizedBox(height: 20),
              _buildDetailField('Fecha de creación:', globalDate.substring(0, 10)),
              const SizedBox(height: 20),
              const Text(
                'Observaciones:',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: observationsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escriba sus observaciones aquí...',
                ),
                maxLines: 3,
                onChanged: (String newValue) {
                  // Update the global observations variable with the text field value
                  globalObservations = newValue;

                  // Print to console for debugging
                  if (kDebugMode) {
                    print('Observations: $globalObservations');
                  }
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Print to console for debugging
                    if (kDebugMode) {
                      print(globalProducts[1].name);
                    }
                    saveAndUploadProductsAsJson(globalProducts);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    minimumSize: const Size(200, 50), // Minimum button size
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 20, color: Colors.white), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Generar Excel', // Text inside the button
                    style: TextStyle(color: Colors.white), // Explicitly set text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a [TextField] to display details with consistent styling.
  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Label style
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueGrey.shade50, // Background color for containers
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: TextEditingController(text: value),
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 6), // Further reduced height
                hintStyle: TextStyle(color: Colors.grey), // Hint text color
              ),
              style: const TextStyle(
                color: Colors.grey, // Text color
                fontSize: 14, // Slightly smaller font size
              ),
            ),
          ),
        ),
      ],
    );
  }
}

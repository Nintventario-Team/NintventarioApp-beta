import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';

/// Main widget for the report screen.
class ReportScreen extends StatelessWidget {
  /// Constant constructor for the ReportScreen class.
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int checkedProductsCount = 0;
    int uncheckedProductsCount = 0;

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
            color: Color.fromARGB(255, 0, 0, 0),
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
              _buildDetailField(
                  'Fecha de creación:', globalDate.substring(0, 10)),
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
                  globalObservations = newValue;
                  if (kDebugMode) {
                    print('Observations: $globalObservations');
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      if (kDebugMode) {
                        print(globalProducts[1].name);
                      }
                      saveAndUploadProductsAsJson(globalProducts);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Generar Excel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (kDebugMode) {
                        print(globalProducts[1].name);
                      }
                      saveAndUploadProductsAsPdf(globalProducts);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Generar PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueGrey.shade50,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: TextEditingController(text: value),
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';

/// Main widget for the report screen.
class ReportScreen extends StatefulWidget {
  /// Constant constructor for the ReportScreen class.
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

/// State class for the report screen.
class ReportScreenState extends State<ReportScreen> {
  bool _isGeneratingExcel = false;
  bool _isGeneratingPdf = false;

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
              _buildDetailField(
                  'Productos no checkeados:', uncheckedProductsCount.toString()),
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
                  hintText: 'Escribe tus observaciones aquí...',
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
              if (_isGeneratingExcel || _isGeneratingPdf) ...<Widget>[
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    _isGeneratingExcel
                        ? 'Generando Excel...'
                        : 'Generando PDF...',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isGeneratingExcel = true;
                      });
                      await _generateExcel();
                      setState(() {
                        _isGeneratingExcel = false;
                      });
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
                      setState(() {
                        _isGeneratingPdf = true;
                      });
                      await _generatePdf();
                      setState(() {
                        _isGeneratingPdf = false;
                      });
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

  /// Builds a detail field with a label and value.
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

  /// Simulates generating an Excel file and uploading it.
  Future<void> _generateExcel() async {
    if (kDebugMode) {
      print(globalProducts[1].name);
    }
    await saveAndUploadProductsAsJson(globalProducts);
    // Simulate a delay for the operation
    await Future<dynamic>.delayed(const Duration(seconds: 2));
  }

  /// Simulates generating a PDF file and uploading it.
  Future<void> _generatePdf() async {
    if (kDebugMode) {
      print(globalProducts[1].name);
    }
    await saveAndUploadProductsAsPdf(globalProducts);
    // Simulate a delay for the operation
    await Future<dynamic>.delayed(const Duration(seconds: 2));
  }
}

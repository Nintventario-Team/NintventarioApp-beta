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

    final TextEditingController observationsController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Reporte del Inventario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Productos checkeados:',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        checkedProductsCount.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Productos no checkeados:',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        uncheckedProductsCount.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Fecha de creación:',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        globalDate,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
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
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to finalize
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('FINALIZE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

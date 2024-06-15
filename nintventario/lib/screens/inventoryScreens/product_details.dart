import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _stockActualController = TextEditingController();
  late int _initialStockActual;

  @override
  void initState() {
    super.initState();
    _initialStockActual = widget.product.stockActual;
    _stockActualController.text = widget.product.stockActual.toString();
  }

  @override
  void dispose() {
    _stockActualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ID del Producto:", style: TextStyle(color: Colors.grey)), // Cambio de color del texto
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.id),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Nombre del Producto:", style: TextStyle(color: Colors.grey)), // Cambio de color del texto
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.name),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Stock Anterior:", style: TextStyle(color: Colors.grey)), // Cambio de color del texto
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.stockAnterior.toString()),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Stock Actual:"),
            const SizedBox(height: 8),
            TextField(
              controller: _stockActualController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el stock actual',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final int newStockActual = int.tryParse(_stockActualController.text) ?? widget.product.stockActual;
                  setState(() {
                    if (newStockActual != _initialStockActual) {
                      widget.product.state = ProductState.checked;
                    }
                    widget.product.stockActual = newStockActual;
                  });
                  Navigator.pop(context, widget.product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(200, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                child: const Text('CONFIRMAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

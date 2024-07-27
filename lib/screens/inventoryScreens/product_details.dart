import 'package:flutter/material.dart';
import 'package:nintventario/classes/product.dart';

/// A StatefulWidget that displays details of a [Product].
class ProductDetails extends StatefulWidget {
  /// The [Product] whose details are to be displayed.
  final Product product;

  /// Creates an instance of [ProductDetails].
  const ProductDetails({super.key, required this.product});

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

/// State class for [ProductDetails].
class ProductDetailsState extends State<ProductDetails> {
  /// Controller for the current stock input field.
  final TextEditingController _stockActualController = TextEditingController();

  /// Initial value of the current stock.
  late final int _initialStockActual;

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
        title: const Text(
          'Detalles del producto',
          style: TextStyle(color: Colors.white), // Title text color
        ),
        backgroundColor: Colors.blue, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildDetailField('ID del producto:', widget.product.id),
            _buildDetailField('Nombre del producto:', widget.product.name),
            _buildDetailField(
                'Stock anterior:', widget.product.stockAnterior.toString()),
            const SizedBox(height: 16),
            const Text(
              'Stock Actual:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold), // Label style
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _stockActualController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                hintText: 'Ingresa el stock actual',
                hintStyle: TextStyle(color: Colors.grey), // Hint text color
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final int? newStockActual =
                      int.tryParse(_stockActualController.text);
                  if (newStockActual != null && newStockActual >= 0) {
                    setState(() {
                      if (newStockActual != _initialStockActual || newStockActual == 0) {
                        widget.product.state = ProductState.checked;
                      }
                      widget.product.stockActual = newStockActual;
                    });
                    Navigator.pop(context, widget.product);
                  } else {
                    // Show an error message if the input is invalid.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ingresa un stock válido (>= 0).')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button background color
                  minimumSize: const Size(200, 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 20, color: Colors.white), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Confirmar', // Text inside the button
                  style: TextStyle(
                      color:
                          Colors.white), // Explicitly set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a [TextField] to display product details with consistent styling.
  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold), // Label style
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
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintStyle: TextStyle(color: Colors.grey), // Hint text color
              ),
              style: const TextStyle(
                  color: Colors.grey, fontSize: 16), // Text color
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

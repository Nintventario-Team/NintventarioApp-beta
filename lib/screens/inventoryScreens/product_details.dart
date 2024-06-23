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
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Product ID:', style: TextStyle(color: Colors.grey)), // Text color change
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.id),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Product Name:', style: TextStyle(color: Colors.grey)), // Text color change
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.name),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Previous Stock:', style: TextStyle(color: Colors.grey)), // Text color change
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: widget.product.stockAnterior.toString()),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Current Stock:'),
            const SizedBox(height: 8),
            TextField(
              controller: _stockActualController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter current stock',
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
                child: const Text('CONFIRM'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/inventoryScreens/product_details.dart';
import 'package:nintventario/screens/home.dart';

/// Main widget for the QR scanner screen.
final MobileScannerController controller = MobileScannerController();

/// Widget for the QR scanner screen.
class QRScannerWidget extends StatefulWidget {
  /// Constant constructor for the QRScannerWidget class.
  const QRScannerWidget({super.key});

  @override

  QRScannerWidgetState createState() => QRScannerWidgetState();
}

/// State of the QR scanner screen.
class QRScannerWidgetState extends State<QRScannerWidget> {
  /// Function to handle barcode detection.
  final MobileScannerController cameraController = MobileScannerController();

  void _handleBarcodeDetection(String code) {
    try {
      final Product product = globalProducts.firstWhere(
        (Product product) => product.id == code,
      );
      Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ProductDetails(product: product),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Producto no encontrado'),
            content: Text('No se encontró ningún producto con el ID $code.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        controller: cameraController,
        allowDuplicates: false,
        onDetect: (Barcode barcode, MobileScannerArguments? args) {
          final String? code = barcode.rawValue;
          if (code != null) {
            debugPrint('Barcode found! $code');
            _handleBarcodeDetection(code);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cameraController.switchCamera(),
        child: const Icon(Icons.switch_camera),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

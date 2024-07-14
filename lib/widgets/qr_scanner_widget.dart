import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final MobileScannerController controller = MobileScannerController();

class QRScannerWidget extends StatefulWidget {
  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        controller: cameraController,
        allowDuplicates: false,
        onDetect: (barcode, args) {
          final String? code = barcode.rawValue;
          if (code != null) {
            debugPrint('Barcode found! $code');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cameraController.switchCamera(),
        child: Icon(Icons.switch_camera),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

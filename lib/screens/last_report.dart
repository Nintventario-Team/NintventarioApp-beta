import 'package:flutter/material.dart';

/// Widget for the last report screen.
class LastReport extends StatelessWidget {
  /// Constant constructor for the LastReport class.
  const LastReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Último Reporte'),
      ),
      body: const Center(
        child: Text('Contenido del Último Reporte'),
      ),
    );
  }
}

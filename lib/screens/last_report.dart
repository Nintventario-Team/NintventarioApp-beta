import 'package:flutter/material.dart';

class LastReport extends StatelessWidget {
  const LastReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Último Reporte'),
      ),
      body: Center(
        child: const Text('Contenido del Último Reporte'),
      ),
    );
  }
}

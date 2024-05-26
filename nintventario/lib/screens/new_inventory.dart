import 'package:flutter/material.dart';

class NewInventaryScreen extends StatelessWidget {
  const NewInventaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      body: const Center(child: Text('Nuevo Inventario')),
    );
  }
}

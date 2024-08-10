import 'package:flutter/material.dart';

class LastInventory extends StatelessWidget {
  const LastInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Último Inventario'),
      ),
      body: Center(
        child: const Text('Contenido del Último Inventario'),
      ),
    );
  }
}

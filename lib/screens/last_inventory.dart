import 'package:flutter/material.dart';

/// Widget for the last inventory screen.
class LastInventory extends StatelessWidget {
  /// Constant constructor for the LastInventory class.
  const LastInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Último Inventario'),
      ),
      body: const Center(
        child: Text('Contenido del Último Inventario'),
      ),
    );
  }
}

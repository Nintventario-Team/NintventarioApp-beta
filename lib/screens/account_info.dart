import 'package:flutter/material.dart';
import 'login_page.dart';

/// Function to show the account information dialog.
void showAccountInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Información de la cuenta'),
        content: Text('El usuario actual es: ${LoginAppState.currentUsername}'),
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

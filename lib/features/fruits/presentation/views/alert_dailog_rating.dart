import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Gracias por tu comentario'),
        content: const Text('Tu comentario ha sido recibido con éxito. Apreciamos tu aportación.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Cerrar el diálogo
              context.push('/'); // Navegar después de cerrar el diálogo
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? findKeyByValue<T>(Map<String, T> map, T reference) {
  for (var entry in map.entries) {
    if (entry.value == reference) {
      return entry.key;
    }
  }
  return null; // Retourne null si aucune correspondance n'est trouvée
}

void showInfoInDialog(BuildContext context, String info) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Info !"),
      content: Text(info),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Enter OTP"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Done"),
          onPressed: onPressed,
        )
      ],
    ),
  );
}

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

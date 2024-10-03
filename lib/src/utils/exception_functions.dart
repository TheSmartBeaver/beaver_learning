import 'package:flutter/material.dart';

void dealWithExceptionError(BuildContext context, Object? exceptionDetails) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("ERROR"),
              content: Text(exceptionDetails.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ));
  }
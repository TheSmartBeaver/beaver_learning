import 'package:flutter/material.dart';

import 'form-styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final int maxLength;
  int maxLines;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.label,
      required this.maxLength,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        maxLength: 50,
        minLines: 1,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: myinputborder,
          enabledBorder: myinputborder,
          focusedBorder: myfocusborder,
        ));
  }
}

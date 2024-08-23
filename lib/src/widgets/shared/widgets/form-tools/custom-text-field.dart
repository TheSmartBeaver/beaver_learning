import 'package:flutter/material.dart';

import 'form-styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final int maxLength;
  int maxLines;
  void Function(String)? onChanged;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.label,
      required this.maxLength,
      this.maxLines = 1,
      this.onChanged});
  
  @override
  State<StatefulWidget> createState() {
    return CustomTextFieldState();
  }
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    //controller.text = initialValue ?? '';

    return TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLength: 50,
        minLines: 1,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(widget.icon),
          border: myinputborder,
          enabledBorder: myinputborder,
          focusedBorder: myfocusborder,
        ));
  }
}

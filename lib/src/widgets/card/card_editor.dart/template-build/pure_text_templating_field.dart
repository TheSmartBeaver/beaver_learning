import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PureTextTemplatingField extends StatefulWidget {

  TextEditingController controller = TextEditingController();
  final String fieldName;

  PureTextTemplatingField({super.key, required this.fieldName});

  @override
  State<StatefulWidget> createState() {
    return _PureTextTemplatingFieldState();
  }
}

class _PureTextTemplatingFieldState extends State<PureTextTemplatingField> {
  @override
  Widget build(BuildContext context) {
    return Container(child: CustomTextField(controller: widget.controller, icon: Icons.abc, label: widget.fieldName, maxLength: 999));
  }
}
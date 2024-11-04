import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PureTextTemplatingField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final String fieldName;
  final CardTemplatedBranchInteracter cardTemplatedBranchInteracter;

  PureTextTemplatingField(
      {super.key,
      required this.fieldName,
      required this.cardTemplatedBranchInteracter});

  @override
  State<StatefulWidget> createState() {
    return _PureTextTemplatingFieldState();
  }
}

class _PureTextTemplatingFieldState extends State<PureTextTemplatingField> {
  void onTextChangeListener(String text) {
    widget.cardTemplatedBranchInteracter
        .updatePureTextField(widget.fieldName, text);
    // widget.updateJsonTree(widget.fieldPath, text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column( children: [
        Text("Widget : (TTF ${widget.fieldName}) Hashcode : ${widget.cardTemplatedBranchInteracter.cardTemplatedBranch.hashCode}"),
        CustomTextField(
            controller: widget.controller
              ..text = widget.cardTemplatedBranchInteracter
                  .getPureTextFieldValue(widget.fieldName),
            icon: Icons.abc,
            label: widget.fieldName,
            maxLength: null,
            maxLines: 5,
            onChanged: onTextChangeListener)]));
  }
}

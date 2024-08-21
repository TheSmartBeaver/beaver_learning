import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/field_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TemplateFormBuilder extends StatefulWidget {
  final String fieldName;

  const TemplateFormBuilder({super.key, required this.fieldName});

  @override
  State<StatefulWidget> createState() {
    return _TemplateFormBuilderState();
  }
}

class _TemplateFormBuilderState extends State<TemplateFormBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          children: [
            FieldTypeSelector(fieldName: widget.fieldName)
          ],
        ));
  }
}

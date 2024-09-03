import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_templating_field.dart';
import 'package:flutter/material.dart';

class TemplateFormBuilder extends StatefulWidget {
  final CardTemplatedBranch? cardTemplatedBranchToUpdate;
  final Function(List<PathPiece> fieldPath, dynamic value) updateJsonTree;

  const TemplateFormBuilder({super.key, required this.updateJsonTree, required this.cardTemplatedBranchToUpdate});

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
            TemplateTemplatingField(
                fieldPathPiece: PathPiece(AppConstante.rectoFieldName),
                updateJsonTree: widget.updateJsonTree,
                isListOfTemplates: false,
                cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(widget.cardTemplatedBranchToUpdate!.jsonObjectFields[AppConstante.rectoFieldName]!)),
            TemplateTemplatingField(
                fieldPathPiece: PathPiece(AppConstante.versoFieldName),
                updateJsonTree: widget.updateJsonTree,
                isListOfTemplates: false, 
                cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(widget.cardTemplatedBranchToUpdate!.jsonObjectFields[AppConstante.versoFieldName]!)),
          ],
        ));
  }
}

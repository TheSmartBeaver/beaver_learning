import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_templating_field.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';

class TemplateFormBuilder extends StatefulWidget {
  final CardTemplatedBranch? cardTemplatedBranchToUpdate;
  final Future<void> Function() updateCard;

  const TemplateFormBuilder(
      {super.key,
      required this.cardTemplatedBranchToUpdate,
      required this.updateCard});

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
        child: SingleChildScrollView(
            child: Column(
          children: [
            TemplateTemplatingField(
                fieldPathPiece: PathPiece(AppConstante.rectoFieldName),
                updateCard: widget.updateCard,
                isListOfTemplates: false,
                cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(updateCard: widget.updateCard,
                   cardTemplatedBranch:  widget.cardTemplatedBranchToUpdate!)),
            TemplateTemplatingField(
                fieldPathPiece: PathPiece(AppConstante.versoFieldName),
                updateCard: widget.updateCard,
                isListOfTemplates: false,
                cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(updateCard: widget.updateCard,
                    cardTemplatedBranch: widget.cardTemplatedBranchToUpdate!)),
          ],
        )));
  }
}

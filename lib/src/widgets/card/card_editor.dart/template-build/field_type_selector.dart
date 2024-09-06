import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/pure_text_templating_field.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_templating_field.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/widgets.dart';

class FieldTypeSelector extends StatefulWidget {
  @protected
  final CardTemplatedBranch?
      cardTemplatedBranchToUpdate; // On stocke ici le cardTemplatedBranchToUpdate de la template parente pour pouvoir le passer à l'enfant une fois qu'on connaîtra son type
  final PathPiece pathPiece;
  final Future<void> Function() updateCard;
  final isFieldsWithNoTypeHidden = false;

  List<DropDownItem<FieldType>> fieldTypeItems =
      FieldType.values.map<DropDownItem<FieldType>>(
    (FieldType cdt) {
      return DropDownItem<FieldType>(cdt.name, cdt);
    },
  ).toList();

  FieldTypeSelector(
      {super.key,
      required this.pathPiece,
      required this.updateCard,
      required this.cardTemplatedBranchToUpdate});

  @override
  State<StatefulWidget> createState() {
    return _FieldTypeSelectorState();
  }
}

class _FieldTypeSelectorState extends State<FieldTypeSelector> {
  FieldType? selectedFieldType;

  @override
  Widget build(BuildContext context) {
    Widget? fieldWidget;

    selectedFieldType = widget.cardTemplatedBranchToUpdate
        ?.getCardTemplatedBranchChildFieldType(widget.pathPiece);

    if (selectedFieldType == FieldType.JSON_OBJECT) {
      // PathPiece pathPieceFirst = widget.cardTemplatedBranchToUpdate!.getPath(
      //         path: [widget.pathPiece])!.first;
      fieldWidget = TemplateTemplatingField(
          fieldPathPiece: widget.pathPiece,
          isListOfTemplates: false,
          updateCard: widget.updateCard,
          cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(
              updateCard: widget.updateCard,
              cardTemplatedBranch: widget.cardTemplatedBranchToUpdate!));
    } else if (selectedFieldType == FieldType.JSON_OBJECT_ARRAY) {
      fieldWidget = TemplateTemplatingField(
          fieldPathPiece: widget.pathPiece,
          isListOfTemplates: true,
          updateCard: widget.updateCard,
          cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(
              updateCard: widget.updateCard,
              cardTemplatedBranch: widget.cardTemplatedBranchToUpdate!));
    } else if (selectedFieldType == FieldType.PURE_TEXT) {
      fieldWidget = PureTextTemplatingField(
          fieldName: widget.pathPiece.pathPieceName,
          cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(
              updateCard: widget.updateCard,
              cardTemplatedBranch: widget.cardTemplatedBranchToUpdate!));
    } else if (!widget.isFieldsWithNoTypeHidden) {
      fieldWidget = Column(children: [
        Text(widget.pathPiece.pathPieceName),
        CustomDropdownMenu<FieldType>(
          items: widget.fieldTypeItems,
          label: widget.pathPiece.pathPieceName,
          onSelected: (DropDownItem<FieldType>? item) {
            setState(() {
              selectedFieldType = item?.value;
              widget.cardTemplatedBranchToUpdate
                  ?.changeTypeOfField(widget.pathPiece, selectedFieldType);
            });
          },
        )
      ]);
    } else {
      fieldWidget = null;
    }

    return Container(
        padding: const EdgeInsets.all(4),
        child: Column(children: [
          Text(
              "Widget : (TTF ${widget.pathPiece.pathPieceName}) Hashcode : ${widget.cardTemplatedBranchToUpdate.hashCode}"),
          if (fieldWidget != null) fieldWidget
        ]));
  }
}

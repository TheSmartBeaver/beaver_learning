import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/pure_text_templating_field.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_templating_field.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/widgets.dart';

class FieldTypeSelector extends StatefulWidget {
  @protected
  final CardTemplatedBranch?
      cardTemplatedBranchToUpdate; // On stocke ici le cardTemplatedBranchToUpdate de la template parente pour pouvoir le passer à l'enfant une fois qu'on connaîtra son type
  final String fieldName;
  final Function(List<PathPiece> fieldPath, dynamic value) updateJsonTree;

  List<DropDownItem<FieldType>> fieldTypeItems =
      FieldType.values.map<DropDownItem<FieldType>>(
    (FieldType cdt) {
      return DropDownItem<FieldType>(cdt.name, cdt);
    },
  ).toList();

  FieldTypeSelector(
      {super.key,
      required this.fieldName,
      required this.updateJsonTree,
      required this.cardTemplatedBranchToUpdate});

  @override
  State<StatefulWidget> createState() {
    return _FieldTypeSelectorState(
        cardTemplatedBranchToUpdate: cardTemplatedBranchToUpdate);
  }
}

class _FieldTypeSelectorState extends State<FieldTypeSelector> {
  FieldType? selectedFieldType;
  CardTemplatedBranch? cardTemplatedBranchToUpdate;

  _FieldTypeSelectorState({required this.cardTemplatedBranchToUpdate});

  @override
  Widget build(BuildContext context) {
    late Widget fieldWidget;

      if (selectedFieldType == FieldType.JSON_OBJECT) {
        fieldWidget = TemplateTemplatingField(
            fieldPathPiece: cardTemplatedBranchToUpdate!.getPath(cardTemplatedBranchToUpdate!)!.first,
            isListOfTemplates: false,
            updateJsonTree: widget.updateJsonTree,
            cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(cardTemplatedBranchToUpdate!));
      } else if (selectedFieldType == FieldType.JSON_OBJECT_ARRAY) {
        fieldWidget = TemplateTemplatingField(
            fieldPathPiece: cardTemplatedBranchToUpdate!.getPath(cardTemplatedBranchToUpdate!)!.first,
            isListOfTemplates: true,
            updateJsonTree: widget.updateJsonTree,
            cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(cardTemplatedBranchToUpdate!));
      } else if (selectedFieldType == FieldType.PURE_TEXT) {
        fieldWidget = PureTextTemplatingField(
            fieldName: widget.fieldName, updateJsonTree: widget.updateJsonTree);
      } else {
        fieldWidget = CustomDropdownMenu<FieldType>(
          items: widget.fieldTypeItems,
          label: widget.fieldName,
          onSelected: (DropDownItem<FieldType>? item) {
            setState(() {
              selectedFieldType = item?.value;
            });
          },
        );
      }

      return Container(
        padding: const EdgeInsets.all(4),
        child: Column(children: [Text(widget.fieldName), fieldWidget]));
    }

  }

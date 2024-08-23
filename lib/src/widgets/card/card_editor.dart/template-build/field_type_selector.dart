import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/pure_text_templating_field.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_templating_field.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/widgets.dart';

enum FieldType {
  PURE_TEXT,
  JSON_OBJECT,
  JSON_OBJECT_ARRAY,
  // FIELD_TYPE_SELECTOR,
}

class FieldTypeSelector extends StatefulWidget {
  final CardTemplatedBranch cardTemplatedBranchToUpdate;
  final String fieldName;
  final Function(List<PathPiece> fieldPath, dynamic value) updateJsonTree;
  late List<PathPiece> fieldPath;

  List<DropDownItem<FieldType>> fieldTypeItems =
      FieldType.values.map<DropDownItem<FieldType>>(
    (FieldType cdt) {
      return DropDownItem<FieldType>(cdt.name, cdt);
    },
  ).toList();

  FieldTypeSelector({super.key, required this.fieldName, required this.updateJsonTree, required List<PathPiece> fieldPathArg, required this.cardTemplatedBranchToUpdate}){
    fieldPath = fieldPathArg;
  }

  @override
  State<StatefulWidget> createState() {
    return _FieldTypeSelectorState();
  }
}

class _FieldTypeSelectorState extends State<FieldTypeSelector> {
  FieldType? selectedFieldType;

  @override
  Widget build(BuildContext context) {
    late Widget fieldWidget;

    if (selectedFieldType == FieldType.JSON_OBJECT) {
      fieldWidget = TemplateTemplatingField(
          fieldName: widget.fieldName, isListOfTemplates: false, updateJsonTree: widget.updateJsonTree, fieldPathArg: widget.fieldPath, cardTemplatedBranchToUpdate: widget.cardTemplatedBranchToUpdate);
    } else if (selectedFieldType == FieldType.JSON_OBJECT_ARRAY) {
      fieldWidget = TemplateTemplatingField(
          fieldName: widget.fieldName, isListOfTemplates: true, updateJsonTree: widget.updateJsonTree, fieldPathArg: widget.fieldPath, cardTemplatedBranchToUpdate: widget.cardTemplatedBranchToUpdate);
    } else if (selectedFieldType == FieldType.PURE_TEXT) {
      fieldWidget = PureTextTemplatingField(fieldName: widget.fieldName, updateJsonTree: widget.updateJsonTree, fieldPathArg: widget.fieldPath);
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

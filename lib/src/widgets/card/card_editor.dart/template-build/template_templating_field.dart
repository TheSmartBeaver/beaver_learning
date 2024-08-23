import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/field_type_selector.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_search_dialog.dart';
import 'package:flutter/material.dart';

class TemplateTemplatingField extends StatefulWidget {
  final CardTemplatedBranch cardTemplatedBranchToUpdate;
  TextEditingController controller = TextEditingController();
  final String fieldName;
  final double buttonHeight = 50;
  final bool isListOfTemplates;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());
  final Function(List<PathPiece> fieldPath, dynamic value) updateJsonTree;
  late List<PathPiece> fieldPath;

  TemplateTemplatingField(
      {super.key,
      required this.fieldName,
      required this.isListOfTemplates,
      required this.updateJsonTree,
      required List<PathPiece> fieldPathArg,
      required this.cardTemplatedBranchToUpdate}) {
    var copiedFieldPath = List<PathPiece>.from(fieldPathArg);
    copiedFieldPath.add(PathPiece(fieldName));
    fieldPath = copiedFieldPath;
  }

  @override
  State<StatefulWidget> createState() {
    return _TemplateTemplatingFieldState();
  }
}

List<String?> getEveryMarkersInHtmlTemplate(String htmlTemplate) {
  var matches = AppConstante.markerRegExp.allMatches(htmlTemplate);
  var markersList = matches.map((e) => e.group(0)).toList();
  return markersList;
}

class _TemplateTemplatingFieldState extends State<TemplateTemplatingField> {
  CardTemplateData? activeTemplate;

  Future<void> processTemplate(int templateId) async {
    var htmlTemplate = await widget.cardDao.getHtmlCardTemplate(templateId);

    setState(() {
      activeTemplate = htmlTemplate;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (activeTemplate != null) {
      List<String?> markersList =
          getEveryMarkersInHtmlTemplate(activeTemplate!.template);

      return Container(
          color: Colors.purpleAccent,
          alignment: Alignment.center,
          child: Column(children: [
            Text("Template: ${activeTemplate!.path}"),
            ...markersList.map((e) => FieldTypeSelector(
                fieldName: e ?? "",
                updateJsonTree: widget.updateJsonTree,
                fieldPathArg: widget.fieldPath,
                cardTemplatedBranchToUpdate:
                    widget.cardTemplatedBranchToUpdate))
          ]));
    } else {
      return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => TemplateSearchDialog(
                  processTemplateFunction: processTemplate),
            );
          },
          child: Container(
              height: widget.buttonHeight,
              color: widget.isListOfTemplates
                  ? Colors.lightBlue
                  : Colors.redAccent,
              alignment: Alignment.center,
              child: const Column(children: [Text("Select Template")])));
    }
  }
}

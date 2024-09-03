import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/section_functions.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/field_type_selector.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_search_dialog.dart';
import 'package:flutter/material.dart';

class TemplateTemplatingField extends StatefulWidget {
  late CardTemplatedBranch cardTemplatedBranchToUpdate;
  late bool isCardTemplatedBranchToUpdateNew;
  final CardTemplatedBranchInteracter cardTemplatedBranchInteracter;
  TextEditingController controller = TextEditingController();
  final PathPiece fieldPathPiece;
  final double buttonHeight = 50;
  final bool isListOfTemplates;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());
  final Function(List<PathPiece> fieldPath, dynamic value) updateJsonTree;

  TemplateTemplatingField(
      {super.key,
      required this.fieldPathPiece,
      required this.isListOfTemplates,
      required this.updateJsonTree,
      required this.cardTemplatedBranchInteracter}) {
    var result = cardTemplatedBranchInteracter.getCardTemplatedBranchChild(
        fieldPathPiece, isListOfTemplates);
    cardTemplatedBranchToUpdate = result.child;
    isCardTemplatedBranchToUpdateNew = result.isNew;
  }

  @override
  State<StatefulWidget> createState() {
    return _TemplateTemplatingFieldState();
  }
}

List<String?> getEveryMarkersInHtmlTemplate(String htmlTemplate) {
  var matches = AppConstante.markerRegExp.allMatches(htmlTemplate);
  var markersList =
      matches.map((e) => removeMarkerBrackets(e.group(0) ?? '')).toList();
  return markersList;
}

class _TemplateTemplatingFieldState extends State<TemplateTemplatingField> {
  CardTemplateData? activeTemplate;
  late Widget widgetReturned;

  buildListOfTemplates() {
    if (!widget.isCardTemplatedBranchToUpdateNew) {
        List<Widget> listOfTemplates = widget.cardTemplatedBranchToUpdate.jsonObjectsListFields[widget.fieldPathPiece.pathPieceName]!.asMap().entries.map((entry) => TemplateTemplatingField(
                  fieldPathPiece: PathPiece(widget.fieldPathPiece.pathPieceName, index: entry.key),
                  isListOfTemplates: false,
                  updateJsonTree: widget.updateJsonTree,
                  cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(entry.value))).toList();

        Widget addTemplateButton = GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => TemplateSearchDialog(
                    processTemplateFunction: processTemplate),
              );
            },
            child: Container(
                height: widget.buttonHeight,
                color: Colors.lightBlue,
                alignment: Alignment.center,
                child: const Text("Add Template")));
        
        widgetReturned = Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Column(children: [
              addTemplateButton,
              ...listOfTemplates,
            ]));
    } else {
      widgetReturned = const Text("CASE TO IMPLEMENT"); 
    }
  }

  buildSingleTemplate() {
    if(!widget.isCardTemplatedBranchToUpdateNew){
      List<String?> markersList =
          getEveryMarkersInHtmlTemplate(activeTemplate!.template);

      widgetReturned = Container(
          color: Colors.purpleAccent,
          alignment: Alignment.center,
          child: Column(children: [
            Text("Template: ${activeTemplate!.path}"),
            ...markersList.map((e) => FieldTypeSelector(
                fieldName: e ?? "",
                updateJsonTree: widget.updateJsonTree,
                cardTemplatedBranchToUpdate:
                    widget.cardTemplatedBranchToUpdate))
          ]));;
    } else {
    if (activeTemplate != null) {
      List<String?> markersList =
          getEveryMarkersInHtmlTemplate(activeTemplate!.template);

      widgetReturned = Container(
          color: Colors.purpleAccent,
          alignment: Alignment.center,
          child: Column(children: [
            Text("Template: ${activeTemplate!.path}"),
            ...markersList.map((e) => FieldTypeSelector(
                fieldName: e ?? "",
                updateJsonTree: widget.updateJsonTree,
                cardTemplatedBranchToUpdate:
                    widget.cardTemplatedBranchToUpdate))
          ]));
    } else {
      widgetReturned = GestureDetector(
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

  Future<void> processTemplate(int templateId) async {
    var htmlTemplate = await widget.cardDao.getHtmlCardTemplate(templateId);

    setState(() {
      activeTemplate = htmlTemplate;
    });
  }

  Future<CardTemplateData> processTemplateByPath(String templatePath) async {
    CardTemplateData htmlTemplate = await widget.cardDao.getHtmlCardTemplateByPath(templatePath);
    return htmlTemplate;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isListOfTemplates) {
      buildSingleTemplate();
    } else {
      buildListOfTemplates();
    }
    return buildSection(widget.fieldPathPiece.pathPieceName, [widgetReturned]);
  }
}

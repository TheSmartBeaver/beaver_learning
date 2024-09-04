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
  final Future<void> Function() updateCard;

  TemplateTemplatingField(
      {super.key,
      required this.fieldPathPiece,
      required this.isListOfTemplates,
      required this.updateCard,
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
  Widget widgetReturned = const CircularProgressIndicator();
  bool isInitialized = false;

  Future buildListOfTemplates() async {
    if (!widget.isCardTemplatedBranchToUpdateNew) {
      List<Widget> listOfTemplates = widget
          .cardTemplatedBranchToUpdate
          //.parentCardTemplatedBranch!
          .jsonObjectsListFields[widget.fieldPathPiece.pathPieceName]!
          .asMap()
          .entries
          .map((entry) => TemplateTemplatingField(
              fieldPathPiece: PathPiece(widget.fieldPathPiece.pathPieceName,
                  index: entry.key),
              isListOfTemplates: false,
              updateCard: widget.updateCard,
              cardTemplatedBranchInteracter: CardTemplatedBranchInteracter(
                  updateCard: widget.updateCard,
                  cardTemplatedBranch: entry.value)))
          .toList();

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

  Future buildSingleTemplate() async {
    Color bgColor = widget.cardTemplatedBranchToUpdate.getColor();

    if (!widget.isCardTemplatedBranchToUpdateNew) {
      activeTemplate = await processTemplateByPath(
          widget.cardTemplatedBranchToUpdate.templateName!);
      List<String?> markersList =
          getEveryMarkersInHtmlTemplate(activeTemplate!.template);

      widgetReturned = Container(
          color: bgColor,
          alignment: Alignment.center,
          child: Column(children: [
            Text("Template: ${activeTemplate!.path}"),
            ...markersList.map((e) => FieldTypeSelector(
                pathPiece: PathPiece(e ?? "UNKNOWN"),
                updateCard: widget.updateCard,
                cardTemplatedBranchToUpdate:
                    widget.cardTemplatedBranchToUpdate))
          ]));
      ;
    } else {
      if (activeTemplate != null) {
        List<String?> markersList =
            getEveryMarkersInHtmlTemplate(activeTemplate!.template);

        widgetReturned = Container(
            color: bgColor,
            alignment: Alignment.center,
            child: Column(children: [
              Text("Template: ${activeTemplate!.path}"),
              ...markersList.map((e) => FieldTypeSelector(
                  pathPiece: PathPiece(e ?? "UNKNOWN"),
                  updateCard: widget.updateCard,
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
    CardTemplateData htmlTemplate =
        await widget.cardDao.getHtmlCardTemplateByPath(templatePath);
    return htmlTemplate;
  }

  Future<void> init() async {
    if (!isInitialized) {
      if (widget.isListOfTemplates) {
        await buildListOfTemplates();
      } else {
        await buildSingleTemplate();
      }
      setState(() {
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    init();

    return buildSection(widget.fieldPathPiece.pathPieceName, [widgetReturned]);
  }
}

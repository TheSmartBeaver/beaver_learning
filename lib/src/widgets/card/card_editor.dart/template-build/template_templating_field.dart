import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/field_type_selector.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_search_dialog.dart';
import 'package:flutter/material.dart';

class TemplateTemplatingField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final String fieldName;
  final double buttonHeight = 50;
  final bool isListOfTemplates;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());

  TemplateTemplatingField(
      {super.key, required this.fieldName, required this.isListOfTemplates});

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
            ...markersList.map((e) => FieldTypeSelector(fieldName: e ?? ""))
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

import 'dart:collection';
import 'dart:convert';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';

class TemplatedRendererManager {
  final HTMLContent htmlContent;
  final List<FileContent> contentFiles;
  final List<Exception> errors = [];
  final HashMap<String, String> htmlTemplates = HashMap();

  TemplatedRendererManager(
      {required this.htmlContent, required this.contentFiles});

  Future<HTMLContentRectoVerso> renderTemplatedCard() async {
    try {
      TemplatedCardJsonFields rectoVersoJsonFields = _getRectoVersoJsonFields();

      CardTemplatedBranch rectoCardTemplatedBranch =
          _buildTree(AppConstante.rectoFieldName, rectoVersoJsonFields.recto);
      CardTemplatedBranch versoCardTemplatedBranch =
          _buildTree(AppConstante.versoFieldName, rectoVersoJsonFields.verso);
      await fillHtmlTemplateDictionary();

      String recto = buildJsonHtmlAssociation(rectoCardTemplatedBranch);
      String verso = buildJsonHtmlAssociation(versoCardTemplatedBranch);

      return HTMLContentRectoVerso(
          recto: recto, verso: verso, files: contentFiles);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<HTMLContentCourseSupport> renderTemplatedHtmlSupport() async {
    try {
      TemplatedCourseSupportJsonFields templatedCourseSupportJsonFields = _getTemplatedCourseSupportJsonFields();

      CardTemplatedBranch templatedCourseTemplatedBranch =
          _buildTree(AppConstante.htmlSupportFieldName, templatedCourseSupportJsonFields.support);
      await fillHtmlTemplateDictionary();

      String htmlSupport = buildJsonHtmlAssociation(templatedCourseTemplatedBranch);

      return HTMLContentCourseSupport(
          htmlSupport: htmlSupport, files: contentFiles);
    } catch (e) {
      throw e;
    }
  }

  TemplatedCardJsonFields _getRectoVersoJsonFields() {
    TemplatedCardJsonFields rectoVersoJsonFields = TemplatedCardJsonFields.fromJson(
        jsonDecode(htmlContent.cardTemplatedJson));
    if (rectoVersoJsonFields.verso.isEmpty) {
      //TODO : Rajouter le path de la card
      errors.add(Exception("Verso is empty"));
    }
    if (rectoVersoJsonFields.recto.isEmpty) {
      errors.add(Exception("Recto is empty"));
    }
    return rectoVersoJsonFields;
  }

  TemplatedCourseSupportJsonFields _getTemplatedCourseSupportJsonFields() {
    TemplatedCourseSupportJsonFields rectoVersoJsonFields = TemplatedCourseSupportJsonFields.fromJson(
        jsonDecode(htmlContent.cardTemplatedJson));
    if (rectoVersoJsonFields.support.isEmpty) {
      //TODO : Rajouter le path de la card
      errors.add(Exception("TemplatedCourseSupport is empty"));
    }
    return rectoVersoJsonFields;
  }

  CardTemplatedBranch _buildTree(String side, Map<String, dynamic> cardFace) {
    CardTemplatedBranch tree = buildBranch(cardFace, errors: errors, htmlTemplates: htmlTemplates);
    return tree;
  }

  // On remplit le dictionnaire des templates pour pouvoir les associer
  Future<void> fillHtmlTemplateDictionary() async {
    AppDatabase db = MyDatabaseInstance.getInstance();
    for (var key in htmlTemplates.keys) {
      //TODO: Il me manque le lien avec le SKU !!!!!!
      try {
        var htmlTemplatesssss = await (db.select(db.cardTemplate)
              ..where((tbl) => tbl.path.equals(key)))
            .get();

        var htmlTemplate = await (db.select(db.cardTemplate)
              ..where((tbl) => tbl.path.equals(key)))
            .get();
        htmlTemplates[key] = htmlTemplate.first.template;
      } catch (e) {
        rethrow;
        //errors.add(e);
      }
    }
  }

  String buildJsonHtmlAssociation(CardTemplatedBranch cardTemplatedBranch) {
    String association = htmlTemplates[cardTemplatedBranch.templateName] != null
        ? htmlTemplates[cardTemplatedBranch.templateName]!
        : "TEMPLATE_NOT_FOUND";

    Map<String, String> associationParts = {};

    void removeRemainingMarkersInAssociation() {
      association = association.replaceAll(AppConstante.markerRegExp, '');
    }

    // On construit les morceaux d'associations de type "json list"
    for (var key in cardTemplatedBranch.jsonObjectsListFields.keys) {
      String associationPart = "";
      for (var cardTemplatedBranchItem
          in cardTemplatedBranch.jsonObjectsListFields[key]!) {
        associationPart += buildJsonHtmlAssociation(cardTemplatedBranchItem);
      }
      associationParts[key] = associationPart;
    }

    // On construit les morceaux d'associations de type "json"
    for (var key in cardTemplatedBranch.jsonObjectFields.keys) {
      associationParts[key] =
          buildJsonHtmlAssociation(cardTemplatedBranch.jsonObjectFields[key]!);
    }

    // On construit les morceaux d'associations de type "pure text"
    for (var key in cardTemplatedBranch.pureTextFields.keys) {
      associationParts[key] = cardTemplatedBranch.pureTextFields[key]!;
    }

    // On assemble
    for (var key in associationParts.keys) {
      association = association.replaceAll("{{$key}}", associationParts[key]!);
    }

    // On retire les markers restants qui n'ont pas été remplacés
    removeRemainingMarkersInAssociation();

    return association;
  }
}

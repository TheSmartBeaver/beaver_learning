import 'dart:collection';
import 'dart:convert';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';

class TemplatedCardRendererManager {
  final HTMLContent htmlContent;
  final List<HTMLContentObjFiles> hTMLContentObjFiles;
  final List<Exception> errors = [];
  final HashMap<String, String> htmlTemplates = HashMap();

  TemplatedCardRendererManager(
      {required this.htmlContent, required this.hTMLContentObjFiles});

  Future<HTMLContentRectoVerso> render() async {
    try {
      RectoVersoJsonFields rectoVersoJsonFields = _getRectoVersoJsonFields();

      CardTemplatedBranch rectoCardTemplatedBranch =
          _buildTree(rectoVersoJsonFields.recto);
      CardTemplatedBranch versoCardTemplatedBranch =
          _buildTree(rectoVersoJsonFields.verso);
      await fillHtmlTemplateDictionary();

      String recto = buildJsonHtmlAssociation(rectoCardTemplatedBranch);
      String verso = buildJsonHtmlAssociation(versoCardTemplatedBranch);

      return HTMLContentRectoVerso(
          recto: recto, verso: verso, files: hTMLContentObjFiles);
    } catch (e) {
      throw e;
    }
  }

  RectoVersoJsonFields _getRectoVersoJsonFields() {
    RectoVersoJsonFields rectoVersoJsonFields = RectoVersoJsonFields.fromJson(
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

  CardTemplatedBranch _buildTree(Map<String, dynamic> cardFace) {
    CardTemplatedBranch tree = _buildBranch(cardFace);
    return tree;
  }

  CardTemplatedBranch _buildBranch(Map<String, dynamic> cardFace) {
    //var jsonDecoded = jsonDecode(cardFace);
    if (!cardFace.containsKey(AppConstante.templateNameKey)) {
      errors.add(Exception("No template_name key"));
      return CardTemplatedBranch("");
    } else {
      //On prépare à la future récupération des templates qui vont nous servir à construire les associations
      htmlTemplates[cardFace[AppConstante.templateNameKey]] = "";
    }

    CardTemplatedBranch cardTemplatedBranch =
        CardTemplatedBranch(cardFace[AppConstante.templateNameKey]);

    for (var key in cardFace.keys) {
      if (key != AppConstante.templateNameKey) {
        // On cherche à choisir entre les 3 types de champs possibles : texte / json / json list
        if (cardFace[key] is List) {
          try {
            List<CardTemplatedBranch> cardTemplatedBranchReturnedList = [];
            for (var cardTemplatedBranchItem in cardFace[key]) {
              CardTemplatedBranch cardTemplatedBranchReturned =
                  _buildBranch(cardTemplatedBranchItem);
              cardTemplatedBranchReturnedList.add(cardTemplatedBranchReturned);
            }
            cardTemplatedBranch.jsonObjectsListFields[key] =
                cardTemplatedBranchReturnedList;
          } on Exception catch (e) {
            errors.add(e);
          }
        } else if (cardFace[key] is Map<String, dynamic>) {
          cardTemplatedBranch.jsonObjectFields[key] =
              _buildBranch(cardFace[key]);
        } else if (cardFace[key] is String) {
          cardTemplatedBranch.pureTextFields[key] = cardFace[key];
        } else {
          errors.add(Exception("Unknown type"));
        }
      }
    }

    return cardTemplatedBranch;
  }

  // On remplit le dictionnaire des templates pour pouvoir les associer
  Future<void> fillHtmlTemplateDictionary() async {
    AppDatabase db = MyDatabaseInstance.getInstance();
    for (var key in htmlTemplates.keys) {
      //TODO: Il me manque le lien avec le SKU !!!!!!
      try {
        var htmlTemplate = await (db.select(db.cardTemplate)
              ..where((tbl) => tbl.path.equals(key)))
            .getSingle();
        htmlTemplates[key] = htmlTemplate.template;
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

    RegExp markerRegExp = RegExp(r'{{.*}}');
    void removeRemainingMarkersInAssociation() {
      association = association.replaceAll(markerRegExp, '');
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

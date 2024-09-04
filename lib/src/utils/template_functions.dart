import 'dart:collection';
import 'dart:convert';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';

String CardTemplatedBranchToJsonString(
    CardTemplatedBranch cardTemplatedBranch) {
  //TODO: ça va être chaud xDDDDDD

  Map<String, dynamic> json = {};

  json[AppConstante.templateFieldName] = cardTemplatedBranch.templateName;

  for (var key in cardTemplatedBranch.pureTextFields.keys) {
    json[key] = cardTemplatedBranch.pureTextFields[key];
  }

  for (var key in cardTemplatedBranch.jsonObjectFields.keys) {
    json[key] = jsonDecode(CardTemplatedBranchToJsonString(
        cardTemplatedBranch.jsonObjectFields[key]!));
  }

  for (var key in cardTemplatedBranch.jsonObjectsListFields.keys) {
    json[key] = [];
    if (cardTemplatedBranch.jsonObjectsListFields[key] != null) {
      for (var index = 0;
          index < cardTemplatedBranch.jsonObjectsListFields[key]!.length;
          index++) {
        json[key].add(jsonDecode(CardTemplatedBranchToJsonString(
            cardTemplatedBranch.jsonObjectsListFields[key]![index])));
      }
    }
  }

  var encodedJson = jsonEncode(json);

  return encodedJson;
}

String removeMarkerBrackets(String marker) {
  return marker.replaceAll(RegExp(r'[{}]'), '');
}

CardTemplatedBranch buildBranch(Map<String, dynamic> cardJsonBranch,
    {List<Exception>? errors,
    Map<String, String>? htmlTemplates }) {
  //var jsonDecoded = jsonDecode(cardFace);
  if (!cardJsonBranch.containsKey(AppConstante.templateNameKey)) {
    errors?.add(Exception("No template_name key"));
    //return CardTemplatedBranch(fieldName, "");
  } else {
    //On prépare à la future récupération des templates qui vont nous servir à construire les associations
    htmlTemplates?[cardJsonBranch[AppConstante.templateNameKey]] = "";
  }

  CardTemplatedBranch cardTemplatedBranch =
      CardTemplatedBranch(cardJsonBranch[AppConstante.templateNameKey]);

  for (var key in cardJsonBranch.keys) {
    if (key != AppConstante.templateNameKey) {
      // On cherche à choisir entre les 3 types de champs possibles : texte / json / json list
      if (cardJsonBranch[key] is List) {
        try {
          List<CardTemplatedBranch> cardTemplatedBranchReturnedList = [];
          for (Map<String, dynamic> cardTemplatedBranchItem in cardJsonBranch[key]) {
            CardTemplatedBranch cardTemplatedBranchReturned =
                buildBranch(cardTemplatedBranchItem, errors: errors, htmlTemplates: htmlTemplates);
                // on set la branche parente
                cardTemplatedBranchReturned.parentCardTemplatedBranch = cardTemplatedBranch;
            cardTemplatedBranchReturnedList.add(cardTemplatedBranchReturned);
          }
          cardTemplatedBranch.jsonObjectsListFields[key] =
              cardTemplatedBranchReturnedList;
        } on Exception catch (e) {
          errors?.add(e);
        }
      } else if (cardJsonBranch[key] is Map<String, dynamic>) {
        CardTemplatedBranch branchObject = buildBranch(cardJsonBranch[key], errors: errors, htmlTemplates: htmlTemplates);
        // on set la branche parente
                branchObject.parentCardTemplatedBranch = cardTemplatedBranch;
        cardTemplatedBranch.jsonObjectFields[key] = branchObject;
            
      } else if (cardJsonBranch[key] is String) {
        cardTemplatedBranch.pureTextFields[key] = cardJsonBranch[key];
      } else {
        errors?.add(Exception("Unknown type"));
      }
    }
  }

  return cardTemplatedBranch;
}

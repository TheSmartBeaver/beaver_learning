import 'dart:convert';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';

String CardTemplatedBranchToJsonString(CardTemplatedBranch cardTemplatedBranch) {
  //TODO: ça va être chaud xDDDDDD

  Map<String, dynamic> json = {};

  json[AppConstante.templateFieldName] = cardTemplatedBranch.templateName;

  for(var key in cardTemplatedBranch.pureTextFields.keys){
    json[key] = cardTemplatedBranch.pureTextFields[key];
  }

  for(var key in cardTemplatedBranch.jsonObjectFields.keys){
    json[key] = CardTemplatedBranchToJsonString(cardTemplatedBranch.jsonObjectFields[key]!);
  }

  for(var key in cardTemplatedBranch.jsonObjectsListFields.keys){
    json[key] = [];
    if(cardTemplatedBranch.jsonObjectsListFields[key] != null){
      for(var index = 0; index < cardTemplatedBranch.jsonObjectsListFields[key]!.length; index++){
      json[key].add(CardTemplatedBranchToJsonString(cardTemplatedBranch.jsonObjectsListFields[key]![index]));
    }
    }
  }

  return jsonEncode(json);
}

String removeMarkerBrackets(String marker){
  return marker.replaceAll(RegExp(r'[{}]'), '');
}
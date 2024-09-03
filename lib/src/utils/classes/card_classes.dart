import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'card_classes.g.dart';

class HTMLContentRectoVerso {
  final String recto;
  final String verso;
  final List<HTMLContentObjFiles> files;

  HTMLContentRectoVerso(
      {required this.files, required this.recto, required this.verso});
}

class HTMLContentObjFiles {
  final String name;
  final String format;
  final File file;

  HTMLContentObjFiles(this.name, this.format, this.file);
}

@JsonSerializable(explicitToJson: true)
class RectoVersoJsonFields {
  final Map<String, dynamic> recto;
  final Map<String, dynamic> verso;

  RectoVersoJsonFields({required this.recto, required this.verso});

  factory RectoVersoJsonFields.fromJson(Map<String, dynamic> json) =>
      _$RectoVersoJsonFieldsFromJson(json);
}

class CardTemplatedBranch {
  final String? templateName;
  CardTemplatedBranch? parentCardTemplatedBranch;
  Map<String, CardTemplatedBranch> jsonObjectFields = {};
  Map<String, List<CardTemplatedBranch>> jsonObjectsListFields = {};
  Map<String, String> pureTextFields = {};

  CardTemplatedBranch(this.templateName);

  FieldType getfieldType(){
    if(parentCardTemplatedBranch != null && parentCardTemplatedBranch!.jsonObjectsListFields.containsValue(this)){
      return FieldType.JSON_OBJECT_ARRAY;
    }
    return FieldType.JSON_OBJECT;
  }

  List<PathPiece>? getPath(CardTemplatedBranch starting, {List<PathPiece>? path}) {
    path ??= [];

    if(parentCardTemplatedBranch != null){
      path.add(PathPiece("OHOH - ${path.length.toString()}"));
      parentCardTemplatedBranch!.getPath(starting, path: path);
    }
    return path;
  }
}

class PathPiece {
  final String pathPieceName;
  int index;

  PathPiece(this.pathPieceName, {this.index = 0});
}

enum FieldType {
  PURE_TEXT,
  JSON_OBJECT,
  JSON_OBJECT_ARRAY,
  // FIELD_TYPE_SELECTOR,
}

class CardTemplatedBranchInteracterData {
  final CardTemplatedBranch child;
  final bool isNew;

  CardTemplatedBranchInteracterData({required this.child, required this.isNew});

}

class CardTemplatedBranchInteracter {
  final CardTemplatedBranch cardTemplatedBranch;

  CardTemplatedBranchInteracter(this.cardTemplatedBranch);

  void updatePureTextField(String fieldName, String value) {
    cardTemplatedBranch.pureTextFields[fieldName] = value;
  }

  void removePureTextField(String fieldName) {
    cardTemplatedBranch.pureTextFields.remove(fieldName);
  }

  void removeTemplateTemplatingField(String fieldName, bool isListOfTemplates) {
    if(isListOfTemplates){
      cardTemplatedBranch.jsonObjectsListFields.remove(fieldName);
    } else {
      cardTemplatedBranch.jsonObjectFields.remove(fieldName);
    }
  }

  CardTemplatedBranchInteracterData getCardTemplatedBranchChild(PathPiece fieldPathPiece, bool isListOfTemplates) {
    if(isListOfTemplates && cardTemplatedBranch.jsonObjectsListFields.containsKey(fieldPathPiece.pathPieceName)){
      return CardTemplatedBranchInteracterData(isNew: false ,child: cardTemplatedBranch.jsonObjectsListFields[fieldPathPiece.pathPieceName]![fieldPathPiece.index]);
    } else if(!isListOfTemplates && cardTemplatedBranch.jsonObjectFields.containsKey(fieldPathPiece.pathPieceName)){
      return CardTemplatedBranchInteracterData(isNew: false, child: cardTemplatedBranch.jsonObjectFields[fieldPathPiece.pathPieceName]!);
    } else {
      return CardTemplatedBranchInteracterData(isNew: true, child: CardTemplatedBranch(fieldPathPiece.pathPieceName));
    }
  } 
}
import 'dart:io';

import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/utils/classes/helper_classes.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'card_classes.g.dart';

class HTMLContentRectoVerso {
  final int id;
  final String recto;
  final String verso;
  final List<FileContent> files;

  HTMLContentRectoVerso(this.id, 
      {required this.files, required this.recto, required this.verso});
}

class HTMLContentWithFileContents {
  final HTMLContent htmlContent;
  final List<FileContent> files;

  HTMLContentWithFileContents({required this.files, required this.htmlContent});
}

class HTMLContentCourseSupport {
  final String htmlSupport;
  final List<FileContent> files;

  HTMLContentCourseSupport({required this.files, required this.htmlSupport});
}

class HTMLContentObjFiles {
  final String name;
  final String format;
  final File file;

  HTMLContentObjFiles(this.name, this.format, this.file);
}

@JsonSerializable(explicitToJson: true)
class TemplatedCardJsonFields {
  final Map<String, dynamic> recto;
  final Map<String, dynamic> verso;

  TemplatedCardJsonFields({required this.recto, required this.verso});

  factory TemplatedCardJsonFields.fromJson(Map<String, dynamic> json) =>
      _$TemplatedCardJsonFieldsFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TemplatedCourseSupportJsonFields {
  final Map<String, dynamic> support;

  TemplatedCourseSupportJsonFields({required this.support});

  factory TemplatedCourseSupportJsonFields.fromJson(
          Map<String, dynamic> json) =>
      _$TemplatedCourseSupportJsonFieldsFromJson(json);
}

class CardTemplatedBranch {
  String? templateName;
  CardTemplatedBranch? parentCardTemplatedBranch;
  Map<String, CardTemplatedBranch> jsonObjectFields = {};
  Map<String, List<CardTemplatedBranch>> jsonObjectsListFields = {};
  Map<String, String> pureTextFields = {};

  // WARNING : Ne pas utiliser le constructeur hors de la classe
  CardTemplatedBranch(this.templateName);

  FieldType? getCardTemplatedBranchChildFieldType(PathPiece fieldPathPiece) {
    if (jsonObjectsListFields.containsKey(fieldPathPiece.pathPieceName)) {
      return FieldType.JSON_OBJECT_ARRAY;
    } else if (jsonObjectFields.containsKey(fieldPathPiece.pathPieceName)) {
      return FieldType.JSON_OBJECT;
    } else if (pureTextFields.containsKey(fieldPathPiece.pathPieceName)) {
      return FieldType.PURE_TEXT;
    }
    return null;
  }

  void removeFieldWithMatchingPathPiece(PathPiece pathPiece) {
    if (pathPiece.index != null) {
      jsonObjectsListFields[pathPiece.pathPieceName]
          ?.removeAt(pathPiece.index!);
    } else {
      jsonObjectsListFields.remove(pathPiece.pathPieceName);
      jsonObjectFields.remove(pathPiece.pathPieceName);
      pureTextFields.remove(pathPiece.pathPieceName);
    }
  }

  void changeTypeOfField(PathPiece pathPiece, FieldType? fieldType) {
    if (fieldType != null) {
      removeFieldWithMatchingPathPiece(pathPiece);

      if (fieldType == FieldType.JSON_OBJECT) {
        CardTemplatedBranch child =
            CardTemplatedBranch.createChild(this, pathPiece);
        jsonObjectFields.putIfAbsent(pathPiece.pathPieceName, () => child);
      } else if (fieldType == FieldType.JSON_OBJECT_ARRAY) {
        jsonObjectsListFields.putIfAbsent(pathPiece.pathPieceName, () => []);
      } else if (fieldType == FieldType.PURE_TEXT) {
        pureTextFields.putIfAbsent(pathPiece.pathPieceName, () => "");
      }
    }
  }

  List<PathPiece>? getPath(
      {CardTemplatedBranch? starting, List<PathPiece>? path}) {
    path ??= [];
    starting ??= this;

    if (parentCardTemplatedBranch != null && starting != this) {
      //path.add(PathPiece("OHOH - ${path.length.toString()}"));

      if (jsonObjectFields.containsValue(starting)) {
        path.add(PathPiece(
            "(${findKeyByValue<CardTemplatedBranch>(parentCardTemplatedBranch!.jsonObjectFields, starting)}) "));
      } else {
        int counter = 0;
        for (var entry in jsonObjectsListFields.entries) {
          if (entry.value.contains(starting)) {
            path.add(PathPiece("(${entry.key}/$counter)"));
          }
          counter++;
        }
      }

      parentCardTemplatedBranch!.getPath(starting: this, path: path);
    }

    if (starting == this) {
      parentCardTemplatedBranch?.getPath(starting: this, path: path);
    }
    path.add(PathPiece("${path.length.toString()} "));
    return path;
  }

  List<Color> colorsArray = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];

  Color getColor() {
    int pathLength = getPath()?.length ?? 0;
    return colorsArray[pathLength % colorsArray.length].withOpacity(0.2);
  }

  static CardTemplatedBranch createChild(
      CardTemplatedBranch parentBranch, PathPiece pathPiece) {
    CardTemplatedBranch child = CardTemplatedBranch(null);
    child.parentCardTemplatedBranch = parentBranch;

    if (pathPiece.index == null) {
      parentBranch.jsonObjectFields
          .putIfAbsent(pathPiece.pathPieceName, () => child);
    } else {
      parentBranch.jsonObjectsListFields[pathPiece.pathPieceName]
          ?[pathPiece.index!] = child;
    }
    return child;
  }
}

class PathPiece {
  final String pathPieceName;
  int? index;

  PathPiece(this.pathPieceName, {this.index});
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
  final Future<void> Function() updateCard;

  CardTemplatedBranchInteracter(
      {required this.cardTemplatedBranch, required this.updateCard});

  void updatePureTextField(String fieldName, String value) {
    cardTemplatedBranch.pureTextFields[fieldName] = value;
    updateCard();
  }

  String getPureTextFieldValue(String fieldName) {
    return cardTemplatedBranch.pureTextFields[fieldName] ?? '';
  }

  void removePureTextField(String fieldName) {
    cardTemplatedBranch.pureTextFields.remove(fieldName);
  }

  void removeTemplateTemplatingField(String fieldName, bool isListOfTemplates) {
    if (isListOfTemplates) {
      cardTemplatedBranch.jsonObjectsListFields.remove(fieldName);
    } else {
      cardTemplatedBranch.jsonObjectFields.remove(fieldName);
    }
  }

  CardTemplatedBranchInteracterData getCardTemplatedBranchChild(
      PathPiece fieldPathPiece, bool isListOfTemplates) {
    /* CAREFUL
      - bien vérifier que le template_name ne soit pas null dans le cas où on est en création et non modif
      - isNew = true si on a pas de template_name pour jsonObjectsListFields ou jsonObjectFields
    */
    // Le field est de type jsonObject List
    if (isListOfTemplates &&
            cardTemplatedBranch.jsonObjectsListFields
                .containsKey(fieldPathPiece.pathPieceName)
        // && cardTemplatedBranch
        //     .jsonObjectsListFields[fieldPathPiece.pathPieceName]?[
        //         fieldPathPiece.index!]
        //     .templateName != null
        ) {
      return CardTemplatedBranchInteracterData(
          isNew: false, child: cardTemplatedBranch);
      // Le field est de type jsonObject
    } else if (!isListOfTemplates &&
            fieldPathPiece.index == null &&
            cardTemplatedBranch.jsonObjectFields
                .containsKey(fieldPathPiece.pathPieceName)
        // && cardTemplatedBranch
        //         .jsonObjectFields[fieldPathPiece.pathPieceName]?.templateName !=
        //     null
        ) {
      bool isNew = cardTemplatedBranch
              .jsonObjectFields[fieldPathPiece.pathPieceName]?.templateName ==
          null;
      return CardTemplatedBranchInteracterData(
          isNew: isNew,
          child: cardTemplatedBranch
              .jsonObjectFields[fieldPathPiece.pathPieceName]!);
      // Le field est de type jsonObject faisant partie d'une liste de jsonObject
    } else if (!isListOfTemplates &&
            cardTemplatedBranch.parentCardTemplatedBranch != null &&
            fieldPathPiece.index != null &&
            cardTemplatedBranch.parentCardTemplatedBranch!.jsonObjectsListFields
                .containsKey(fieldPathPiece.pathPieceName)
        // && cardTemplatedBranch
        //     .parentCardTemplatedBranch!
        //     .jsonObjectsListFields[fieldPathPiece.pathPieceName]
        //         ?[fieldPathPiece.index!]
        //     .templateName !=
        // null
        ) {
      bool isNew = cardTemplatedBranch
              .parentCardTemplatedBranch!
              .jsonObjectsListFields[fieldPathPiece.pathPieceName]
                  ?[fieldPathPiece.index!]
              .templateName ==
          null;
      return CardTemplatedBranchInteracterData(
          isNew: isNew,
          child: cardTemplatedBranch
                  .parentCardTemplatedBranch!.jsonObjectsListFields[
              fieldPathPiece.pathPieceName]![fieldPathPiece.index!]);
    }
    // else if(cardTemplatedBranch.parentCardTemplatedBranch == null){
    //   return CardTemplatedBranchInteracterData(
    //       isNew: true, child: cardTemplatedBranch);
    // }
    return CardTemplatedBranchInteracterData(
        isNew: true,
        child: CardTemplatedBranch.createChild(
            cardTemplatedBranch, fieldPathPiece));
  }
}

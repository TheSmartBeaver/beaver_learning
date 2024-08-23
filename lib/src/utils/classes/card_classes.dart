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
  final String? parentFieldName;
  final String? templateName;
  Map<String, CardTemplatedBranch> jsonObjectFields = {};
  Map<String, List<CardTemplatedBranch>> jsonObjectsListFields = {};
  Map<String, String> pureTextFields = {};

  CardTemplatedBranch(this.parentFieldName, this.templateName);
}

class PathPiece {
  final String pathPieceName;
  int index;

  PathPiece(this.pathPieceName, {this.index = 0});
}

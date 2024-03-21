import 'dart:typed_data';

import 'package:beaver_learning/src/utils/export_functions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_classes.g.dart';

//TODO: Inutile d'essayer de tout sérialiser à la volée
// Parcourir les objets à la place et créer des jsons par-ci, des dossiers par-là et des fichiers.

enum ExportType { group, card, rectoHtml, versoHtml, fileContent, unknown }

@JsonSerializable(explicitToJson: true)
class ExportDescriptor {
  final ExportType type;
  String? name;

  factory ExportDescriptor.fromJson(Map<String, dynamic> json) =>
      _$ExportDescriptorFromJson(json);

  ExportDescriptor(this.type, {this.name});

  Map<String, dynamic> toJson() => _$ExportDescriptorToJson(this);

}

//@JsonSerializable(explicitToJson: true)
class GroupExport {
  final String title;
  final List<GroupExport> childGroups;
  final List<CardExport> cards;

  // factory GroupExport.fromJson(Map<String, dynamic> json) =>
  //     _$GroupExportFromJson(json);

  // Map<String, dynamic> toJson() => _$GroupExportToJson(this);

  GroupExport(this.title, this.childGroups, this.cards);
}

//@JsonSerializable(explicitToJson: true)
class CardExport {
  final HTMLContentExport content;

  // factory CardExport.fromJson(Map<String, dynamic> json) =>
  //     _$CardExportFromJson(json);
  
  // Map<String, dynamic> toJson() => _$CardExportToJson(this);

  CardExport({required this.content});

}
//@JsonSerializable(explicitToJson: true)
class HTMLContentExport {
  String recto;
  String verso;
  List<FileContentExport> files;

  // factory HTMLContentExport.fromJson(Map<String, dynamic> json) =>
  //     _$HTMLContentExportFromJson(json);
  
  // Map<String, dynamic> toJson() => _$HTMLContentExportToJson(this);

  HTMLContentExport({required this.recto, required this.verso, required this.files});
}

//@JsonSerializable(explicitToJson: true)
class FileContentExport {
  final String name;
  final String format;
  final Uint8List content;

  // factory FileContentExport.fromJson(Map<String, dynamic> json) =>
  //     _$FileContentExportFromJson(json);

  // Map<String, dynamic> toJson() => _$FileContentExportToJson(this);

  FileContentExport(this.name, this.format, this.content);
}
import 'package:beaver_learning/src/utils/export_functions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_classes.g.dart';

//TODO: Inutile d'essayer de tout sérialiser à la volée
// Parcourir les objets à la place et créer des jsons par-ci, des dossiers par-là et des fichiers.


@JsonSerializable(explicitToJson: true)
class GroupExport {
  final String title;
  final List<GroupExport> childGroups;
  final List<CardExport> cards;

  factory GroupExport.fromJson(Map<String, dynamic> json) =>
      _$GroupExportFromJson(json);

  Map<String, dynamic> toJson() => _$GroupExportToJson(this);

  GroupExport(this.title, this.childGroups, this.cards);
}

@JsonSerializable(explicitToJson: true)
class CardExport {
  final HTMLContentExport recto;
  final HTMLContentExport verso;

  factory CardExport.fromJson(Map<String, dynamic> json) =>
      _$CardExportFromJson(json);
  
  Map<String, dynamic> toJson() => _$CardExportToJson(this);

  CardExport({required this.recto, required this.verso});

}
@JsonSerializable(explicitToJson: true)
class HTMLContentExport {
  final String content;
  final List<FileContentExport> files;

  factory HTMLContentExport.fromJson(Map<String, dynamic> json) =>
      _$HTMLContentExportFromJson(json);

  Map<String, dynamic> toJson() => _$HTMLContentExportToJson(this);

  HTMLContentExport(this.content, this.files);

}

@JsonSerializable(explicitToJson: true)
class FileContentExport {
  final String name;
  final String format;
  // final String content; // TODO: Comment faire pour créer fichier ???

  factory FileContentExport.fromJson(Map<String, dynamic> json) =>
      _$FileContentExportFromJson(json);

  FileContentExport(this.name, this.format);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupExport _$GroupExportFromJson(Map<String, dynamic> json) => GroupExport(
      json['title'] as String,
      (json['childGroups'] as List<dynamic>)
          .map((e) => GroupExport.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['cards'] as List<dynamic>)
          .map((e) => CardExport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupExportToJson(GroupExport instance) =>
    <String, dynamic>{
      'title': instance.title,
      'childGroups': instance.childGroups,
      'cards': instance.cards,
    };

CardExport _$CardExportFromJson(Map<String, dynamic> json) => CardExport(
      recto: HTMLContentExport.fromJson(json['recto'] as Map<String, dynamic>),
      verso: HTMLContentExport.fromJson(json['verso'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardExportToJson(CardExport instance) =>
    <String, dynamic>{
      'recto': instance.recto,
      'verso': instance.verso,
    };

HTMLContentExport _$HTMLContentExportFromJson(Map<String, dynamic> json) =>
    HTMLContentExport(
      json['content'] as String,
      (json['files'] as List<dynamic>)
          .map((e) => FileContentExport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HTMLContentExportToJson(HTMLContentExport instance) =>
    <String, dynamic>{
      'content': instance.content,
      'files': instance.files,
    };

FileContentExport _$FileContentExportFromJson(Map<String, dynamic> json) =>
    FileContentExport(
      json['name'] as String,
      json['format'] as String,
    );

Map<String, dynamic> _$FileContentExportToJson(FileContentExport instance) =>
    <String, dynamic>{
      'name': instance.name,
      'format': instance.format,
    };

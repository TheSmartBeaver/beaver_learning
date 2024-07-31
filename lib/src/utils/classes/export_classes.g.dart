// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExportDescriptor _$ExportDescriptorFromJson(Map<String, dynamic> json) =>
    ExportDescriptor(
      $enumDecode(_$ExportTypeEnumMap, json['type']),
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      learnAbouts: (json['learnAbouts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      prerequisites: (json['prerequisites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )..imgUrl = json['imgUrl'] as String?;

Map<String, dynamic> _$ExportDescriptorToJson(ExportDescriptor instance) =>
    <String, dynamic>{
      'type': _$ExportTypeEnumMap[instance.type]!,
      'sku': instance.sku,
      'name': instance.name,
      'learnAbouts': instance.learnAbouts,
      'prerequisites': instance.prerequisites,
      'imgUrl': instance.imgUrl,
    };

const _$ExportTypeEnumMap = {
  ExportType.group: 'group',
  ExportType.card: 'card',
  ExportType.cardTemplated: 'cardTemplated',
  ExportType.cardJsonTemplated: 'cardJsonTemplated',
  ExportType.cardHtmlTemplated: 'cardHtmlTemplated',
  ExportType.rectoHtml: 'rectoHtml',
  ExportType.versoHtml: 'versoHtml',
  ExportType.fileContent: 'fileContent',
  ExportType.unknown: 'unknown',
  ExportType.course: 'course',
  ExportType.topic: 'topic',
  ExportType.support: 'support',
};

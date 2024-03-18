// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExportDescriptor _$ExportDescriptorFromJson(Map<String, dynamic> json) =>
    ExportDescriptor(
      $enumDecode(_$ExportTypeEnumMap, json['type']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ExportDescriptorToJson(ExportDescriptor instance) =>
    <String, dynamic>{
      'type': _$ExportTypeEnumMap[instance.type]!,
      'name': instance.name,
    };

const _$ExportTypeEnumMap = {
  ExportType.group: 'group',
  ExportType.card: 'card',
  ExportType.htmlContent: 'htmlContent',
  ExportType.fileContent: 'fileContent',
};

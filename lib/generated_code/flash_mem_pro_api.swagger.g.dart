// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_mem_pro_api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssemblyCategorySyncDto _$AssemblyCategorySyncDtoFromJson(
        Map<String, dynamic> json) =>
    AssemblyCategorySyncDto(
      sku: json['SKU'] as String? ?? 'default',
      path: json['Path'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$AssemblyCategorySyncDtoToJson(
        AssemblyCategorySyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'Path': instance.path,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

AssemblyLinkedToAssembCategSyncDto _$AssemblyLinkedToAssembCategSyncDtoFromJson(
        Map<String, dynamic> json) =>
    AssemblyLinkedToAssembCategSyncDto(
      assemblyCategorySKU: json['AssemblyCategorySKU'] as String? ?? 'default',
      assemblySKU: json['AssemblySKU'] as String? ?? 'default',
    );

Map<String, dynamic> _$AssemblyLinkedToAssembCategSyncDtoToJson(
        AssemblyLinkedToAssembCategSyncDto instance) =>
    <String, dynamic>{
      'AssemblyCategorySKU': instance.assemblyCategorySKU,
      'AssemblySKU': instance.assemblySKU,
    };

AuthenticateDto _$AuthenticateDtoFromJson(Map<String, dynamic> json) =>
    AuthenticateDto(
      isRegistered: json['IsRegistered'] as bool?,
    );

Map<String, dynamic> _$AuthenticateDtoToJson(AuthenticateDto instance) =>
    <String, dynamic>{
      'IsRegistered': instance.isRegistered,
    };

AuthenticateEntryDto _$AuthenticateEntryDtoFromJson(
        Map<String, dynamic> json) =>
    AuthenticateEntryDto(
      authentUid: json['AuthentUid'] as String? ?? 'default',
    );

Map<String, dynamic> _$AuthenticateEntryDtoToJson(
        AuthenticateEntryDto instance) =>
    <String, dynamic>{
      'AuthentUid': instance.authentUid,
    };

CardSyncDto _$CardSyncDtoFromJson(Map<String, dynamic> json) => CardSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      groupSKU: json['GroupSKU'] as String? ?? 'default',
      isMine: json['isMine'] as bool?,
      htmlContentSKU: json['HtmlContentSKU'] as String? ?? 'default',
      tags: json['Tags'] as String? ?? 'default',
      nextRevisionDateMultiplicator:
          (json['NextRevisionDateMultiplicator'] as num?)?.toDouble(),
      nextRevisionDate: json['NextRevisionDate'] == null
          ? null
          : DateTime.parse(json['NextRevisionDate'] as String),
      path: json['Path'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$CardSyncDtoToJson(CardSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'GroupSKU': instance.groupSKU,
      'isMine': instance.isMine,
      'HtmlContentSKU': instance.htmlContentSKU,
      'Tags': instance.tags,
      'NextRevisionDateMultiplicator': instance.nextRevisionDateMultiplicator,
      'NextRevisionDate': instance.nextRevisionDate?.toIso8601String(),
      'Path': instance.path,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

CardTemplateSyncDto _$CardTemplateSyncDtoFromJson(Map<String, dynamic> json) =>
    CardTemplateSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      path: json['Path'] as String? ?? 'default',
      template: json['Template'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$CardTemplateSyncDtoToJson(
        CardTemplateSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'Path': instance.path,
      'Template': instance.template,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

CourseSyncDto _$CourseSyncDtoFromJson(Map<String, dynamic> json) =>
    CourseSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      isMine: json['isMine'] as bool?,
      imageUrl: json['ImageUrl'] as String? ?? 'default',
      title: json['Title'] as String? ?? 'default',
      description: json['Description'] as String? ?? 'default',
      rootTopicSKU: json['RootTopicSKU'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$CourseSyncDtoToJson(CourseSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'isMine': instance.isMine,
      'ImageUrl': instance.imageUrl,
      'Title': instance.title,
      'Description': instance.description,
      'RootTopicSKU': instance.rootTopicSKU,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

CreateEntityForSkuDto _$CreateEntityForSkuDtoFromJson(
        Map<String, dynamic> json) =>
    CreateEntityForSkuDto(
      frontId: json['FrontId'] as int? ?? 0,
      sku: json['SKU'] as String? ?? 'default',
    );

Map<String, dynamic> _$CreateEntityForSkuDtoToJson(
        CreateEntityForSkuDto instance) =>
    <String, dynamic>{
      'FrontId': instance.frontId,
      'SKU': instance.sku,
    };

ElementsToSyncDto _$ElementsToSyncDtoFromJson(Map<String, dynamic> json) =>
    ElementsToSyncDto(
      fileContents: (json['FileContents'] as List<dynamic>?)
              ?.map(
                  (e) => FileContentSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      htmlContents: (json['HtmlContents'] as List<dynamic>?)
              ?.map(
                  (e) => HtmlContentSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      fileContentLinkedToHtmlContents: (json['FileContentLinkedToHtmlContents']
                  as List<dynamic>?)
              ?.map(
                  (e) => FileContentSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      assemblyCategories: (json['AssemblyCategories'] as List<dynamic>?)
              ?.map((e) =>
                  AssemblyCategorySyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      assemblyLinkedToAssembCateg:
          (json['AssemblyLinkedToAssembCateg'] as List<dynamic>?)
                  ?.map((e) => AssemblyLinkedToAssembCategSyncDto.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
      groups: (json['Groups'] as List<dynamic>?)
              ?.map((e) => GroupSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cards: (json['Cards'] as List<dynamic>?)
              ?.map((e) => CardSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      courses: (json['Courses'] as List<dynamic>?)
              ?.map((e) => CourseSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      topics: (json['Topics'] as List<dynamic>?)
              ?.map((e) => TopicSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cardTemplates: (json['CardTemplates'] as List<dynamic>?)
              ?.map((e) =>
                  CardTemplateSyncDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ElementsToSyncDtoToJson(ElementsToSyncDto instance) =>
    <String, dynamic>{
      'FileContents': instance.fileContents?.map((e) => e.toJson()).toList(),
      'HtmlContents': instance.htmlContents?.map((e) => e.toJson()).toList(),
      'FileContentLinkedToHtmlContents': instance
          .fileContentLinkedToHtmlContents
          ?.map((e) => e.toJson())
          .toList(),
      'AssemblyCategories':
          instance.assemblyCategories?.map((e) => e.toJson()).toList(),
      'AssemblyLinkedToAssembCateg':
          instance.assemblyLinkedToAssembCateg?.map((e) => e.toJson()).toList(),
      'Groups': instance.groups?.map((e) => e.toJson()).toList(),
      'Cards': instance.cards?.map((e) => e.toJson()).toList(),
      'Courses': instance.courses?.map((e) => e.toJson()).toList(),
      'Topics': instance.topics?.map((e) => e.toJson()).toList(),
      'CardTemplates': instance.cardTemplates?.map((e) => e.toJson()).toList(),
    };

ElementsWithoutSkuDto _$ElementsWithoutSkuDtoFromJson(
        Map<String, dynamic> json) =>
    ElementsWithoutSkuDto(
      fileContents: (json['FileContents'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      htmlContents: (json['HtmlContents'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      fileContentLinkedToHtmlContents:
          (json['FileContentLinkedToHtmlContents'] as List<dynamic>?)
                  ?.map((e) =>
                      CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
      assemblyCategories: (json['AssemblyCategories'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      assemblyLinkedToAssembCateg:
          (json['AssemblyLinkedToAssembCateg'] as List<dynamic>?)
                  ?.map((e) =>
                      CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
      groups: (json['Groups'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cards: (json['Cards'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      courses: (json['Courses'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      topics: (json['Topics'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cardTemplates: (json['CardTemplates'] as List<dynamic>?)
              ?.map((e) =>
                  CreateEntityForSkuDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ElementsWithoutSkuDtoToJson(
        ElementsWithoutSkuDto instance) =>
    <String, dynamic>{
      'FileContents': instance.fileContents?.map((e) => e.toJson()).toList(),
      'HtmlContents': instance.htmlContents?.map((e) => e.toJson()).toList(),
      'FileContentLinkedToHtmlContents': instance
          .fileContentLinkedToHtmlContents
          ?.map((e) => e.toJson())
          .toList(),
      'AssemblyCategories':
          instance.assemblyCategories?.map((e) => e.toJson()).toList(),
      'AssemblyLinkedToAssembCateg':
          instance.assemblyLinkedToAssembCateg?.map((e) => e.toJson()).toList(),
      'Groups': instance.groups?.map((e) => e.toJson()).toList(),
      'Cards': instance.cards?.map((e) => e.toJson()).toList(),
      'Courses': instance.courses?.map((e) => e.toJson()).toList(),
      'Topics': instance.topics?.map((e) => e.toJson()).toList(),
      'CardTemplates': instance.cardTemplates?.map((e) => e.toJson()).toList(),
    };

FileContentSyncDto _$FileContentSyncDtoFromJson(Map<String, dynamic> json) =>
    FileContentSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      isMine: json['isMine'] as bool?,
      name: json['Name'] as String? ?? 'default',
      format: json['Format'] as String? ?? 'default',
      content: json['Content'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$FileContentSyncDtoToJson(FileContentSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'isMine': instance.isMine,
      'Name': instance.name,
      'Format': instance.format,
      'Content': instance.content,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

GroupSyncDto _$GroupSyncDtoFromJson(Map<String, dynamic> json) => GroupSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      isMine: json['isMine'] as bool?,
      title: json['Title'] as String? ?? 'default',
      path: json['Path'] as String? ?? 'default',
      tags: json['Tags'] as String? ?? 'default',
      parentSKU: json['ParentSKU'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$GroupSyncDtoToJson(GroupSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'isMine': instance.isMine,
      'Title': instance.title,
      'Path': instance.path,
      'Tags': instance.tags,
      'ParentSKU': instance.parentSKU,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

HtmlContentSyncDto _$HtmlContentSyncDtoFromJson(Map<String, dynamic> json) =>
    HtmlContentSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      isMine: json['isMine'] as bool?,
      path: json['Path'] as String? ?? 'default',
      recto: json['Recto'] as String? ?? 'default',
      verso: json['Verso'] as String? ?? 'default',
      isTemplated: json['IsTemplated'] as bool?,
      cardTemplatedJson: json['CardTemplatedJson'] as String? ?? 'default',
      isAssembly: json['IsAssembly'] as bool?,
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$HtmlContentSyncDtoToJson(HtmlContentSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'isMine': instance.isMine,
      'Path': instance.path,
      'Recto': instance.recto,
      'Verso': instance.verso,
      'IsTemplated': instance.isTemplated,
      'CardTemplatedJson': instance.cardTemplatedJson,
      'IsAssembly': instance.isAssembly,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

TopicSyncDto _$TopicSyncDtoFromJson(Map<String, dynamic> json) => TopicSyncDto(
      sku: json['SKU'] as String? ?? 'default',
      path: json['Path'] as String? ?? 'default',
      title: json['Title'] as String? ?? 'default',
      parentSKU: json['ParentSKU'] as String? ?? 'default',
      parentCourseSKU: json['ParentCourseSKU'] as String? ?? 'default',
      groupSKU: json['GroupSKU'] as String? ?? 'default',
      fileSKU: json['FileSKU'] as String? ?? 'default',
      htmlContentSKU: json['HtmlContentSKU'] as String? ?? 'default',
      lastUpdated: json['LastUpdated'] == null
          ? null
          : DateTime.parse(json['LastUpdated'] as String),
    );

Map<String, dynamic> _$TopicSyncDtoToJson(TopicSyncDto instance) =>
    <String, dynamic>{
      'SKU': instance.sku,
      'Path': instance.path,
      'Title': instance.title,
      'ParentSKU': instance.parentSKU,
      'ParentCourseSKU': instance.parentCourseSKU,
      'GroupSKU': instance.groupSKU,
      'FileSKU': instance.fileSKU,
      'HtmlContentSKU': instance.htmlContentSKU,
      'LastUpdated': instance.lastUpdated?.toIso8601String(),
    };

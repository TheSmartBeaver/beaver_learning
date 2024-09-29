// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;

part 'flash_mem_pro_api.swagger.chopper.dart';
part 'flash_mem_pro_api.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class FlashMemProApi extends ChopperService {
  static FlashMemProApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$FlashMemProApi(client);
    }

    final newClient = ChopperClient(
        services: [_$FlashMemProApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$FlashMemProApi(newClient);
  }

  ///
  Future<chopper.Response<AuthenticateDto>> apiAppUserAuthentificatePost(
      {required AuthenticateEntryDto? body}) {
    generatedMapping.putIfAbsent(
        AuthenticateDto, () => AuthenticateDto.fromJsonFactory);

    return _apiAppUserAuthentificatePost(body: body);
  }

  ///
  @Post(
    path: '/api/AppUser/authentificate',
    optionalBody: true,
  )
  Future<chopper.Response<AuthenticateDto>> _apiAppUserAuthentificatePost(
      {@Body() required AuthenticateEntryDto? body});

  ///
  Future<chopper.Response> apiExampleGetExamplePost() {
    return _apiExampleGetExamplePost();
  }

  ///
  @Post(
    path: '/api/Example/getExample',
    optionalBody: true,
  )
  Future<chopper.Response> _apiExampleGetExamplePost();

  ///
  Future<chopper.Response> apiPopulatePopulatePost() {
    return _apiPopulatePopulatePost();
  }

  ///
  @Post(
    path: '/api/Populate/populate',
    optionalBody: true,
  )
  Future<chopper.Response> _apiPopulatePopulatePost();

  ///
  Future<chopper.Response> apiPopulateDepopulatePost() {
    return _apiPopulateDepopulatePost();
  }

  ///
  @Post(
    path: '/api/Populate/depopulate',
    optionalBody: true,
  )
  Future<chopper.Response> _apiPopulateDepopulatePost();

  ///
  Future<chopper.Response> apiSynchronizeSynchronizePost() {
    return _apiSynchronizeSynchronizePost();
  }

  ///
  @Post(
    path: '/api/Synchronize/synchronize',
    optionalBody: true,
  )
  Future<chopper.Response> _apiSynchronizeSynchronizePost();

  ///
  Future<chopper.Response<DateTime>>
      apiSynchronizeGetLastServerSynchronizationDateGet() {
    return _apiSynchronizeGetLastServerSynchronizationDateGet();
  }

  ///
  @Get(path: '/api/Synchronize/getLastServerSynchronizationDate')
  Future<chopper.Response<DateTime>>
      _apiSynchronizeGetLastServerSynchronizationDateGet();

  ///
  ///@param newSynchronizationDate
  Future<chopper.Response> apiSynchronizeSetLastServerSynchronizationDateGet(
      {DateTime? newSynchronizationDate}) {
    return _apiSynchronizeSetLastServerSynchronizationDateGet(
        newSynchronizationDate: newSynchronizationDate);
  }

  ///
  ///@param newSynchronizationDate
  @Get(path: '/api/Synchronize/setLastServerSynchronizationDate')
  Future<chopper.Response> _apiSynchronizeSetLastServerSynchronizationDateGet(
      {@Query('newSynchronizationDate') DateTime? newSynchronizationDate});

  ///
  Future<chopper.Response> apiSynchronizeSyncTowardsServerPost() {
    return _apiSynchronizeSyncTowardsServerPost();
  }

  ///
  @Post(
    path: '/api/Synchronize/syncTowardsServer',
    optionalBody: true,
  )
  Future<chopper.Response> _apiSynchronizeSyncTowardsServerPost();

  ///
  Future<chopper.Response<ElementsWithoutSkuDto>>
      apiSynchronizeCreateElementsWithMissingSkuPost(
          {required ElementsWithoutSkuDto? body}) {
    generatedMapping.putIfAbsent(
        ElementsWithoutSkuDto, () => ElementsWithoutSkuDto.fromJsonFactory);

    return _apiSynchronizeCreateElementsWithMissingSkuPost(body: body);
  }

  ///
  @Post(
    path: '/api/Synchronize/createElementsWithMissingSku',
    optionalBody: true,
  )
  Future<chopper.Response<ElementsWithoutSkuDto>>
      _apiSynchronizeCreateElementsWithMissingSkuPost(
          {@Body() required ElementsWithoutSkuDto? body});

  ///
  Future<chopper.Response> apiSynchronizeSynchronizeElementsTowardsServerPost(
      {required ElementsToSyncDto? body}) {
    return _apiSynchronizeSynchronizeElementsTowardsServerPost(body: body);
  }

  ///
  @Post(
    path: '/api/Synchronize/synchronizeElementsTowardsServer',
    optionalBody: true,
  )
  Future<chopper.Response> _apiSynchronizeSynchronizeElementsTowardsServerPost(
      {@Body() required ElementsToSyncDto? body});

  ///
  ///@param lastMobileUpdate
  Future<chopper.Response<ElementsToSyncDto>>
      apiSynchronizeSynchronizeElementsTowardsMobilePost(
          {DateTime? lastMobileUpdate}) {
    generatedMapping.putIfAbsent(
        ElementsToSyncDto, () => ElementsToSyncDto.fromJsonFactory);

    return _apiSynchronizeSynchronizeElementsTowardsMobilePost(
        lastMobileUpdate: lastMobileUpdate);
  }

  ///
  ///@param lastMobileUpdate
  @Post(
    path: '/api/Synchronize/synchronizeElementsTowardsMobile',
    optionalBody: true,
  )
  Future<chopper.Response<ElementsToSyncDto>>
      _apiSynchronizeSynchronizeElementsTowardsMobilePost(
          {@Query('lastMobileUpdate') DateTime? lastMobileUpdate});
}

@JsonSerializable(explicitToJson: true)
class AssemblyCategorySyncDto {
  const AssemblyCategorySyncDto({
    this.sku,
    this.path,
    this.lastUpdated,
  });

  factory AssemblyCategorySyncDto.fromJson(Map<String, dynamic> json) =>
      _$AssemblyCategorySyncDtoFromJson(json);

  static const toJsonFactory = _$AssemblyCategorySyncDtoToJson;
  Map<String, dynamic> toJson() => _$AssemblyCategorySyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$AssemblyCategorySyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssemblyCategorySyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $AssemblyCategorySyncDtoExtension on AssemblyCategorySyncDto {
  AssemblyCategorySyncDto copyWith(
      {String? sku, String? path, DateTime? lastUpdated}) {
    return AssemblyCategorySyncDto(
        sku: sku ?? this.sku,
        path: path ?? this.path,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  AssemblyCategorySyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<String?>? path,
      Wrapped<DateTime?>? lastUpdated}) {
    return AssemblyCategorySyncDto(
        sku: (sku != null ? sku.value : this.sku),
        path: (path != null ? path.value : this.path),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthenticateDto {
  const AuthenticateDto({
    this.isRegistered,
  });

  factory AuthenticateDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateDtoFromJson(json);

  static const toJsonFactory = _$AuthenticateDtoToJson;
  Map<String, dynamic> toJson() => _$AuthenticateDtoToJson(this);

  @JsonKey(name: 'IsRegistered')
  final bool? isRegistered;
  static const fromJsonFactory = _$AuthenticateDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthenticateDto &&
            (identical(other.isRegistered, isRegistered) ||
                const DeepCollectionEquality()
                    .equals(other.isRegistered, isRegistered)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isRegistered) ^ runtimeType.hashCode;
}

extension $AuthenticateDtoExtension on AuthenticateDto {
  AuthenticateDto copyWith({bool? isRegistered}) {
    return AuthenticateDto(isRegistered: isRegistered ?? this.isRegistered);
  }

  AuthenticateDto copyWithWrapped({Wrapped<bool?>? isRegistered}) {
    return AuthenticateDto(
        isRegistered:
            (isRegistered != null ? isRegistered.value : this.isRegistered));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthenticateEntryDto {
  const AuthenticateEntryDto({
    this.authentUid,
  });

  factory AuthenticateEntryDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateEntryDtoFromJson(json);

  static const toJsonFactory = _$AuthenticateEntryDtoToJson;
  Map<String, dynamic> toJson() => _$AuthenticateEntryDtoToJson(this);

  @JsonKey(name: 'AuthentUid', defaultValue: 'default')
  final String? authentUid;
  static const fromJsonFactory = _$AuthenticateEntryDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthenticateEntryDto &&
            (identical(other.authentUid, authentUid) ||
                const DeepCollectionEquality()
                    .equals(other.authentUid, authentUid)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(authentUid) ^ runtimeType.hashCode;
}

extension $AuthenticateEntryDtoExtension on AuthenticateEntryDto {
  AuthenticateEntryDto copyWith({String? authentUid}) {
    return AuthenticateEntryDto(authentUid: authentUid ?? this.authentUid);
  }

  AuthenticateEntryDto copyWithWrapped({Wrapped<String?>? authentUid}) {
    return AuthenticateEntryDto(
        authentUid: (authentUid != null ? authentUid.value : this.authentUid));
  }
}

@JsonSerializable(explicitToJson: true)
class CardSyncDto {
  const CardSyncDto({
    this.sku,
    this.groupSKU,
    this.isMine,
    this.htmlContentSKU,
    this.mnemotechnicHint,
    this.tags,
    this.nextRevisionDateMultiplicator,
    this.nextRevisionDate,
    this.path,
    this.lastUpdated,
  });

  factory CardSyncDto.fromJson(Map<String, dynamic> json) =>
      _$CardSyncDtoFromJson(json);

  static const toJsonFactory = _$CardSyncDtoToJson;
  Map<String, dynamic> toJson() => _$CardSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'GroupSKU', defaultValue: 'default')
  final String? groupSKU;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'HtmlContentSKU', defaultValue: 'default')
  final String? htmlContentSKU;
  @JsonKey(name: 'MnemotechnicHint', defaultValue: 'default')
  final String? mnemotechnicHint;
  @JsonKey(name: 'Tags', defaultValue: 'default')
  final String? tags;
  @JsonKey(name: 'NextRevisionDateMultiplicator')
  final double? nextRevisionDateMultiplicator;
  @JsonKey(name: 'NextRevisionDate')
  final DateTime? nextRevisionDate;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$CardSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CardSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.groupSKU, groupSKU) ||
                const DeepCollectionEquality()
                    .equals(other.groupSKU, groupSKU)) &&
            (identical(other.isMine, isMine) ||
                const DeepCollectionEquality().equals(other.isMine, isMine)) &&
            (identical(other.htmlContentSKU, htmlContentSKU) ||
                const DeepCollectionEquality()
                    .equals(other.htmlContentSKU, htmlContentSKU)) &&
            (identical(other.mnemotechnicHint, mnemotechnicHint) ||
                const DeepCollectionEquality()
                    .equals(other.mnemotechnicHint, mnemotechnicHint)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.nextRevisionDateMultiplicator,
                    nextRevisionDateMultiplicator) ||
                const DeepCollectionEquality().equals(
                    other.nextRevisionDateMultiplicator,
                    nextRevisionDateMultiplicator)) &&
            (identical(other.nextRevisionDate, nextRevisionDate) ||
                const DeepCollectionEquality()
                    .equals(other.nextRevisionDate, nextRevisionDate)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(groupSKU) ^
      const DeepCollectionEquality().hash(isMine) ^
      const DeepCollectionEquality().hash(htmlContentSKU) ^
      const DeepCollectionEquality().hash(mnemotechnicHint) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(nextRevisionDateMultiplicator) ^
      const DeepCollectionEquality().hash(nextRevisionDate) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $CardSyncDtoExtension on CardSyncDto {
  CardSyncDto copyWith(
      {String? sku,
      String? groupSKU,
      bool? isMine,
      String? htmlContentSKU,
      String? mnemotechnicHint,
      String? tags,
      double? nextRevisionDateMultiplicator,
      DateTime? nextRevisionDate,
      String? path,
      DateTime? lastUpdated}) {
    return CardSyncDto(
        sku: sku ?? this.sku,
        groupSKU: groupSKU ?? this.groupSKU,
        isMine: isMine ?? this.isMine,
        htmlContentSKU: htmlContentSKU ?? this.htmlContentSKU,
        mnemotechnicHint: mnemotechnicHint ?? this.mnemotechnicHint,
        tags: tags ?? this.tags,
        nextRevisionDateMultiplicator:
            nextRevisionDateMultiplicator ?? this.nextRevisionDateMultiplicator,
        nextRevisionDate: nextRevisionDate ?? this.nextRevisionDate,
        path: path ?? this.path,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  CardSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<String?>? groupSKU,
      Wrapped<bool?>? isMine,
      Wrapped<String?>? htmlContentSKU,
      Wrapped<String?>? mnemotechnicHint,
      Wrapped<String?>? tags,
      Wrapped<double?>? nextRevisionDateMultiplicator,
      Wrapped<DateTime?>? nextRevisionDate,
      Wrapped<String?>? path,
      Wrapped<DateTime?>? lastUpdated}) {
    return CardSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        groupSKU: (groupSKU != null ? groupSKU.value : this.groupSKU),
        isMine: (isMine != null ? isMine.value : this.isMine),
        htmlContentSKU: (htmlContentSKU != null
            ? htmlContentSKU.value
            : this.htmlContentSKU),
        mnemotechnicHint: (mnemotechnicHint != null
            ? mnemotechnicHint.value
            : this.mnemotechnicHint),
        tags: (tags != null ? tags.value : this.tags),
        nextRevisionDateMultiplicator: (nextRevisionDateMultiplicator != null
            ? nextRevisionDateMultiplicator.value
            : this.nextRevisionDateMultiplicator),
        nextRevisionDate: (nextRevisionDate != null
            ? nextRevisionDate.value
            : this.nextRevisionDate),
        path: (path != null ? path.value : this.path),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class CardTemplateSyncDto {
  const CardTemplateSyncDto({
    this.sku,
    this.path,
    this.template,
    this.lastUpdated,
  });

  factory CardTemplateSyncDto.fromJson(Map<String, dynamic> json) =>
      _$CardTemplateSyncDtoFromJson(json);

  static const toJsonFactory = _$CardTemplateSyncDtoToJson;
  Map<String, dynamic> toJson() => _$CardTemplateSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'Template', defaultValue: 'default')
  final String? template;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$CardTemplateSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CardTemplateSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.template, template) ||
                const DeepCollectionEquality()
                    .equals(other.template, template)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(template) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $CardTemplateSyncDtoExtension on CardTemplateSyncDto {
  CardTemplateSyncDto copyWith(
      {String? sku, String? path, String? template, DateTime? lastUpdated}) {
    return CardTemplateSyncDto(
        sku: sku ?? this.sku,
        path: path ?? this.path,
        template: template ?? this.template,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  CardTemplateSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<String?>? path,
      Wrapped<String?>? template,
      Wrapped<DateTime?>? lastUpdated}) {
    return CardTemplateSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        path: (path != null ? path.value : this.path),
        template: (template != null ? template.value : this.template),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class CourseSyncDto {
  const CourseSyncDto({
    this.sku,
    this.isMine,
    this.imageUrl,
    this.title,
    this.description,
    this.lastUpdated,
  });

  factory CourseSyncDto.fromJson(Map<String, dynamic> json) =>
      _$CourseSyncDtoFromJson(json);

  static const toJsonFactory = _$CourseSyncDtoToJson;
  Map<String, dynamic> toJson() => _$CourseSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'ImageUrl', defaultValue: 'default')
  final String? imageUrl;
  @JsonKey(name: 'Title', defaultValue: 'default')
  final String? title;
  @JsonKey(name: 'Description', defaultValue: 'default')
  final String? description;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$CourseSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CourseSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.isMine, isMine) ||
                const DeepCollectionEquality().equals(other.isMine, isMine)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(isMine) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $CourseSyncDtoExtension on CourseSyncDto {
  CourseSyncDto copyWith(
      {String? sku,
      bool? isMine,
      String? imageUrl,
      String? title,
      String? description,
      DateTime? lastUpdated}) {
    return CourseSyncDto(
        sku: sku ?? this.sku,
        isMine: isMine ?? this.isMine,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  CourseSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<bool?>? isMine,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<DateTime?>? lastUpdated}) {
    return CourseSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        isMine: (isMine != null ? isMine.value : this.isMine),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateEntityForSkuDto {
  const CreateEntityForSkuDto({
    this.frontId,
    this.sku,
  });

  factory CreateEntityForSkuDto.fromJson(Map<String, dynamic> json) =>
      _$CreateEntityForSkuDtoFromJson(json);

  static const toJsonFactory = _$CreateEntityForSkuDtoToJson;
  Map<String, dynamic> toJson() => _$CreateEntityForSkuDtoToJson(this);

  @JsonKey(name: 'FrontId', defaultValue: 0)
  final int? frontId;
  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  static const fromJsonFactory = _$CreateEntityForSkuDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateEntityForSkuDto &&
            (identical(other.frontId, frontId) ||
                const DeepCollectionEquality()
                    .equals(other.frontId, frontId)) &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(frontId) ^
      const DeepCollectionEquality().hash(sku) ^
      runtimeType.hashCode;
}

extension $CreateEntityForSkuDtoExtension on CreateEntityForSkuDto {
  CreateEntityForSkuDto copyWith({int? frontId, String? sku}) {
    return CreateEntityForSkuDto(
        frontId: frontId ?? this.frontId, sku: sku ?? this.sku);
  }

  CreateEntityForSkuDto copyWithWrapped(
      {Wrapped<int?>? frontId, Wrapped<String?>? sku}) {
    return CreateEntityForSkuDto(
        frontId: (frontId != null ? frontId.value : this.frontId),
        sku: (sku != null ? sku.value : this.sku));
  }
}

@JsonSerializable(explicitToJson: true)
class ElementsToSyncDto {
  const ElementsToSyncDto({
    this.fileContents,
    this.htmlContents,
    this.fileContentLinkedToHtmlContents,
    this.assemblyCategories,
    this.assemblyLinkedToAssembCateg,
    this.groups,
    this.cards,
    this.courses,
    this.topics,
    this.cardTemplates,
  });

  factory ElementsToSyncDto.fromJson(Map<String, dynamic> json) =>
      _$ElementsToSyncDtoFromJson(json);

  static const toJsonFactory = _$ElementsToSyncDtoToJson;
  Map<String, dynamic> toJson() => _$ElementsToSyncDtoToJson(this);

  @JsonKey(name: 'FileContents', defaultValue: <FileContentSyncDto>[])
  final List<FileContentSyncDto>? fileContents;
  @JsonKey(name: 'HtmlContents', defaultValue: <HtmlContentSyncDto>[])
  final List<HtmlContentSyncDto>? htmlContents;
  @JsonKey(name: 'FileContentLinkedToHtmlContents')
  final Map<String, dynamic>? fileContentLinkedToHtmlContents;
  @JsonKey(
      name: 'AssemblyCategories', defaultValue: <AssemblyCategorySyncDto>[])
  final List<AssemblyCategorySyncDto>? assemblyCategories;
  @JsonKey(name: 'AssemblyLinkedToAssembCateg')
  final Map<String, dynamic>? assemblyLinkedToAssembCateg;
  @JsonKey(name: 'Groups', defaultValue: <GroupSyncDto>[])
  final List<GroupSyncDto>? groups;
  @JsonKey(name: 'Cards', defaultValue: <CardSyncDto>[])
  final List<CardSyncDto>? cards;
  @JsonKey(name: 'Courses', defaultValue: <CourseSyncDto>[])
  final List<CourseSyncDto>? courses;
  @JsonKey(name: 'Topics', defaultValue: <TopicSyncDto>[])
  final List<TopicSyncDto>? topics;
  @JsonKey(name: 'CardTemplates', defaultValue: <CardTemplateSyncDto>[])
  final List<CardTemplateSyncDto>? cardTemplates;
  static const fromJsonFactory = _$ElementsToSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ElementsToSyncDto &&
            (identical(other.fileContents, fileContents) ||
                const DeepCollectionEquality()
                    .equals(other.fileContents, fileContents)) &&
            (identical(other.htmlContents, htmlContents) ||
                const DeepCollectionEquality()
                    .equals(other.htmlContents, htmlContents)) &&
            (identical(other.fileContentLinkedToHtmlContents,
                    fileContentLinkedToHtmlContents) ||
                const DeepCollectionEquality().equals(
                    other.fileContentLinkedToHtmlContents,
                    fileContentLinkedToHtmlContents)) &&
            (identical(other.assemblyCategories, assemblyCategories) ||
                const DeepCollectionEquality()
                    .equals(other.assemblyCategories, assemblyCategories)) &&
            (identical(other.assemblyLinkedToAssembCateg,
                    assemblyLinkedToAssembCateg) ||
                const DeepCollectionEquality().equals(
                    other.assemblyLinkedToAssembCateg,
                    assemblyLinkedToAssembCateg)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)) &&
            (identical(other.cards, cards) ||
                const DeepCollectionEquality().equals(other.cards, cards)) &&
            (identical(other.courses, courses) ||
                const DeepCollectionEquality()
                    .equals(other.courses, courses)) &&
            (identical(other.topics, topics) ||
                const DeepCollectionEquality().equals(other.topics, topics)) &&
            (identical(other.cardTemplates, cardTemplates) ||
                const DeepCollectionEquality()
                    .equals(other.cardTemplates, cardTemplates)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileContents) ^
      const DeepCollectionEquality().hash(htmlContents) ^
      const DeepCollectionEquality().hash(fileContentLinkedToHtmlContents) ^
      const DeepCollectionEquality().hash(assemblyCategories) ^
      const DeepCollectionEquality().hash(assemblyLinkedToAssembCateg) ^
      const DeepCollectionEquality().hash(groups) ^
      const DeepCollectionEquality().hash(cards) ^
      const DeepCollectionEquality().hash(courses) ^
      const DeepCollectionEquality().hash(topics) ^
      const DeepCollectionEquality().hash(cardTemplates) ^
      runtimeType.hashCode;
}

extension $ElementsToSyncDtoExtension on ElementsToSyncDto {
  ElementsToSyncDto copyWith(
      {List<FileContentSyncDto>? fileContents,
      List<HtmlContentSyncDto>? htmlContents,
      Map<String, dynamic>? fileContentLinkedToHtmlContents,
      List<AssemblyCategorySyncDto>? assemblyCategories,
      Map<String, dynamic>? assemblyLinkedToAssembCateg,
      List<GroupSyncDto>? groups,
      List<CardSyncDto>? cards,
      List<CourseSyncDto>? courses,
      List<TopicSyncDto>? topics,
      List<CardTemplateSyncDto>? cardTemplates}) {
    return ElementsToSyncDto(
        fileContents: fileContents ?? this.fileContents,
        htmlContents: htmlContents ?? this.htmlContents,
        fileContentLinkedToHtmlContents: fileContentLinkedToHtmlContents ??
            this.fileContentLinkedToHtmlContents,
        assemblyCategories: assemblyCategories ?? this.assemblyCategories,
        assemblyLinkedToAssembCateg:
            assemblyLinkedToAssembCateg ?? this.assemblyLinkedToAssembCateg,
        groups: groups ?? this.groups,
        cards: cards ?? this.cards,
        courses: courses ?? this.courses,
        topics: topics ?? this.topics,
        cardTemplates: cardTemplates ?? this.cardTemplates);
  }

  ElementsToSyncDto copyWithWrapped(
      {Wrapped<List<FileContentSyncDto>?>? fileContents,
      Wrapped<List<HtmlContentSyncDto>?>? htmlContents,
      Wrapped<Map<String, dynamic>?>? fileContentLinkedToHtmlContents,
      Wrapped<List<AssemblyCategorySyncDto>?>? assemblyCategories,
      Wrapped<Map<String, dynamic>?>? assemblyLinkedToAssembCateg,
      Wrapped<List<GroupSyncDto>?>? groups,
      Wrapped<List<CardSyncDto>?>? cards,
      Wrapped<List<CourseSyncDto>?>? courses,
      Wrapped<List<TopicSyncDto>?>? topics,
      Wrapped<List<CardTemplateSyncDto>?>? cardTemplates}) {
    return ElementsToSyncDto(
        fileContents:
            (fileContents != null ? fileContents.value : this.fileContents),
        htmlContents:
            (htmlContents != null ? htmlContents.value : this.htmlContents),
        fileContentLinkedToHtmlContents:
            (fileContentLinkedToHtmlContents != null
                ? fileContentLinkedToHtmlContents.value
                : this.fileContentLinkedToHtmlContents),
        assemblyCategories: (assemblyCategories != null
            ? assemblyCategories.value
            : this.assemblyCategories),
        assemblyLinkedToAssembCateg: (assemblyLinkedToAssembCateg != null
            ? assemblyLinkedToAssembCateg.value
            : this.assemblyLinkedToAssembCateg),
        groups: (groups != null ? groups.value : this.groups),
        cards: (cards != null ? cards.value : this.cards),
        courses: (courses != null ? courses.value : this.courses),
        topics: (topics != null ? topics.value : this.topics),
        cardTemplates:
            (cardTemplates != null ? cardTemplates.value : this.cardTemplates));
  }
}

@JsonSerializable(explicitToJson: true)
class ElementsWithoutSkuDto {
  const ElementsWithoutSkuDto({
    this.fileContents,
    this.htmlContents,
    this.fileContentLinkedToHtmlContents,
    this.assemblyCategories,
    this.assemblyLinkedToAssembCateg,
    this.groups,
    this.cards,
    this.courses,
    this.topics,
    this.cardTemplates,
  });

  factory ElementsWithoutSkuDto.fromJson(Map<String, dynamic> json) =>
      _$ElementsWithoutSkuDtoFromJson(json);

  static const toJsonFactory = _$ElementsWithoutSkuDtoToJson;
  Map<String, dynamic> toJson() => _$ElementsWithoutSkuDtoToJson(this);

  @JsonKey(name: 'FileContents', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? fileContents;
  @JsonKey(name: 'HtmlContents', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? htmlContents;
  @JsonKey(
      name: 'FileContentLinkedToHtmlContents',
      defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? fileContentLinkedToHtmlContents;
  @JsonKey(name: 'AssemblyCategories', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? assemblyCategories;
  @JsonKey(
      name: 'AssemblyLinkedToAssembCateg',
      defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? assemblyLinkedToAssembCateg;
  @JsonKey(name: 'Groups', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? groups;
  @JsonKey(name: 'Cards', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? cards;
  @JsonKey(name: 'Courses', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? courses;
  @JsonKey(name: 'Topics', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? topics;
  @JsonKey(name: 'CardTemplates', defaultValue: <CreateEntityForSkuDto>[])
  final List<CreateEntityForSkuDto>? cardTemplates;
  static const fromJsonFactory = _$ElementsWithoutSkuDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ElementsWithoutSkuDto &&
            (identical(other.fileContents, fileContents) ||
                const DeepCollectionEquality()
                    .equals(other.fileContents, fileContents)) &&
            (identical(other.htmlContents, htmlContents) ||
                const DeepCollectionEquality()
                    .equals(other.htmlContents, htmlContents)) &&
            (identical(other.fileContentLinkedToHtmlContents,
                    fileContentLinkedToHtmlContents) ||
                const DeepCollectionEquality().equals(
                    other.fileContentLinkedToHtmlContents,
                    fileContentLinkedToHtmlContents)) &&
            (identical(other.assemblyCategories, assemblyCategories) ||
                const DeepCollectionEquality()
                    .equals(other.assemblyCategories, assemblyCategories)) &&
            (identical(other.assemblyLinkedToAssembCateg,
                    assemblyLinkedToAssembCateg) ||
                const DeepCollectionEquality().equals(
                    other.assemblyLinkedToAssembCateg,
                    assemblyLinkedToAssembCateg)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)) &&
            (identical(other.cards, cards) ||
                const DeepCollectionEquality().equals(other.cards, cards)) &&
            (identical(other.courses, courses) ||
                const DeepCollectionEquality()
                    .equals(other.courses, courses)) &&
            (identical(other.topics, topics) ||
                const DeepCollectionEquality().equals(other.topics, topics)) &&
            (identical(other.cardTemplates, cardTemplates) ||
                const DeepCollectionEquality()
                    .equals(other.cardTemplates, cardTemplates)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileContents) ^
      const DeepCollectionEquality().hash(htmlContents) ^
      const DeepCollectionEquality().hash(fileContentLinkedToHtmlContents) ^
      const DeepCollectionEquality().hash(assemblyCategories) ^
      const DeepCollectionEquality().hash(assemblyLinkedToAssembCateg) ^
      const DeepCollectionEquality().hash(groups) ^
      const DeepCollectionEquality().hash(cards) ^
      const DeepCollectionEquality().hash(courses) ^
      const DeepCollectionEquality().hash(topics) ^
      const DeepCollectionEquality().hash(cardTemplates) ^
      runtimeType.hashCode;
}

extension $ElementsWithoutSkuDtoExtension on ElementsWithoutSkuDto {
  ElementsWithoutSkuDto copyWith(
      {List<CreateEntityForSkuDto>? fileContents,
      List<CreateEntityForSkuDto>? htmlContents,
      List<CreateEntityForSkuDto>? fileContentLinkedToHtmlContents,
      List<CreateEntityForSkuDto>? assemblyCategories,
      List<CreateEntityForSkuDto>? assemblyLinkedToAssembCateg,
      List<CreateEntityForSkuDto>? groups,
      List<CreateEntityForSkuDto>? cards,
      List<CreateEntityForSkuDto>? courses,
      List<CreateEntityForSkuDto>? topics,
      List<CreateEntityForSkuDto>? cardTemplates}) {
    return ElementsWithoutSkuDto(
        fileContents: fileContents ?? this.fileContents,
        htmlContents: htmlContents ?? this.htmlContents,
        fileContentLinkedToHtmlContents: fileContentLinkedToHtmlContents ??
            this.fileContentLinkedToHtmlContents,
        assemblyCategories: assemblyCategories ?? this.assemblyCategories,
        assemblyLinkedToAssembCateg:
            assemblyLinkedToAssembCateg ?? this.assemblyLinkedToAssembCateg,
        groups: groups ?? this.groups,
        cards: cards ?? this.cards,
        courses: courses ?? this.courses,
        topics: topics ?? this.topics,
        cardTemplates: cardTemplates ?? this.cardTemplates);
  }

  ElementsWithoutSkuDto copyWithWrapped(
      {Wrapped<List<CreateEntityForSkuDto>?>? fileContents,
      Wrapped<List<CreateEntityForSkuDto>?>? htmlContents,
      Wrapped<List<CreateEntityForSkuDto>?>? fileContentLinkedToHtmlContents,
      Wrapped<List<CreateEntityForSkuDto>?>? assemblyCategories,
      Wrapped<List<CreateEntityForSkuDto>?>? assemblyLinkedToAssembCateg,
      Wrapped<List<CreateEntityForSkuDto>?>? groups,
      Wrapped<List<CreateEntityForSkuDto>?>? cards,
      Wrapped<List<CreateEntityForSkuDto>?>? courses,
      Wrapped<List<CreateEntityForSkuDto>?>? topics,
      Wrapped<List<CreateEntityForSkuDto>?>? cardTemplates}) {
    return ElementsWithoutSkuDto(
        fileContents:
            (fileContents != null ? fileContents.value : this.fileContents),
        htmlContents:
            (htmlContents != null ? htmlContents.value : this.htmlContents),
        fileContentLinkedToHtmlContents:
            (fileContentLinkedToHtmlContents != null
                ? fileContentLinkedToHtmlContents.value
                : this.fileContentLinkedToHtmlContents),
        assemblyCategories: (assemblyCategories != null
            ? assemblyCategories.value
            : this.assemblyCategories),
        assemblyLinkedToAssembCateg: (assemblyLinkedToAssembCateg != null
            ? assemblyLinkedToAssembCateg.value
            : this.assemblyLinkedToAssembCateg),
        groups: (groups != null ? groups.value : this.groups),
        cards: (cards != null ? cards.value : this.cards),
        courses: (courses != null ? courses.value : this.courses),
        topics: (topics != null ? topics.value : this.topics),
        cardTemplates:
            (cardTemplates != null ? cardTemplates.value : this.cardTemplates));
  }
}

@JsonSerializable(explicitToJson: true)
class FileContentSyncDto {
  const FileContentSyncDto({
    this.sku,
    this.isMine,
    this.name,
    this.format,
    this.content,
    this.lastUpdated,
  });

  factory FileContentSyncDto.fromJson(Map<String, dynamic> json) =>
      _$FileContentSyncDtoFromJson(json);

  static const toJsonFactory = _$FileContentSyncDtoToJson;
  Map<String, dynamic> toJson() => _$FileContentSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'Name', defaultValue: 'default')
  final String? name;
  @JsonKey(name: 'Format', defaultValue: 'default')
  final String? format;
  @JsonKey(name: 'Content', defaultValue: 'default')
  final String? content;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$FileContentSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FileContentSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.isMine, isMine) ||
                const DeepCollectionEquality().equals(other.isMine, isMine)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.format, format) ||
                const DeepCollectionEquality().equals(other.format, format)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(isMine) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(format) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $FileContentSyncDtoExtension on FileContentSyncDto {
  FileContentSyncDto copyWith(
      {String? sku,
      bool? isMine,
      String? name,
      String? format,
      String? content,
      DateTime? lastUpdated}) {
    return FileContentSyncDto(
        sku: sku ?? this.sku,
        isMine: isMine ?? this.isMine,
        name: name ?? this.name,
        format: format ?? this.format,
        content: content ?? this.content,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  FileContentSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<bool?>? isMine,
      Wrapped<String?>? name,
      Wrapped<String?>? format,
      Wrapped<String?>? content,
      Wrapped<DateTime?>? lastUpdated}) {
    return FileContentSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        isMine: (isMine != null ? isMine.value : this.isMine),
        name: (name != null ? name.value : this.name),
        format: (format != null ? format.value : this.format),
        content: (content != null ? content.value : this.content),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class GroupSyncDto {
  const GroupSyncDto({
    this.sku,
    this.isMine,
    this.title,
    this.path,
    this.tags,
    this.parentSKU,
    this.lastUpdated,
  });

  factory GroupSyncDto.fromJson(Map<String, dynamic> json) =>
      _$GroupSyncDtoFromJson(json);

  static const toJsonFactory = _$GroupSyncDtoToJson;
  Map<String, dynamic> toJson() => _$GroupSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'Title', defaultValue: 'default')
  final String? title;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'Tags', defaultValue: 'default')
  final String? tags;
  @JsonKey(name: 'ParentSKU', defaultValue: 'default')
  final String? parentSKU;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$GroupSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GroupSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.isMine, isMine) ||
                const DeepCollectionEquality().equals(other.isMine, isMine)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.parentSKU, parentSKU) ||
                const DeepCollectionEquality()
                    .equals(other.parentSKU, parentSKU)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(isMine) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(parentSKU) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $GroupSyncDtoExtension on GroupSyncDto {
  GroupSyncDto copyWith(
      {String? sku,
      bool? isMine,
      String? title,
      String? path,
      String? tags,
      String? parentSKU,
      DateTime? lastUpdated}) {
    return GroupSyncDto(
        sku: sku ?? this.sku,
        isMine: isMine ?? this.isMine,
        title: title ?? this.title,
        path: path ?? this.path,
        tags: tags ?? this.tags,
        parentSKU: parentSKU ?? this.parentSKU,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  GroupSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<bool?>? isMine,
      Wrapped<String?>? title,
      Wrapped<String?>? path,
      Wrapped<String?>? tags,
      Wrapped<String?>? parentSKU,
      Wrapped<DateTime?>? lastUpdated}) {
    return GroupSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        isMine: (isMine != null ? isMine.value : this.isMine),
        title: (title != null ? title.value : this.title),
        path: (path != null ? path.value : this.path),
        tags: (tags != null ? tags.value : this.tags),
        parentSKU: (parentSKU != null ? parentSKU.value : this.parentSKU),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class HtmlContentSyncDto {
  const HtmlContentSyncDto({
    this.sku,
    this.isMine,
    this.path,
    this.recto,
    this.verso,
    this.isTemplated,
    this.cardTemplatedJson,
    this.isAssembly,
    this.lastUpdated,
  });

  factory HtmlContentSyncDto.fromJson(Map<String, dynamic> json) =>
      _$HtmlContentSyncDtoFromJson(json);

  static const toJsonFactory = _$HtmlContentSyncDtoToJson;
  Map<String, dynamic> toJson() => _$HtmlContentSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'Recto', defaultValue: 'default')
  final String? recto;
  @JsonKey(name: 'Verso', defaultValue: 'default')
  final String? verso;
  @JsonKey(name: 'IsTemplated')
  final bool? isTemplated;
  @JsonKey(name: 'CardTemplatedJson', defaultValue: 'default')
  final String? cardTemplatedJson;
  @JsonKey(name: 'IsAssembly')
  final bool? isAssembly;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$HtmlContentSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HtmlContentSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.isMine, isMine) ||
                const DeepCollectionEquality().equals(other.isMine, isMine)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.recto, recto) ||
                const DeepCollectionEquality().equals(other.recto, recto)) &&
            (identical(other.verso, verso) ||
                const DeepCollectionEquality().equals(other.verso, verso)) &&
            (identical(other.isTemplated, isTemplated) ||
                const DeepCollectionEquality()
                    .equals(other.isTemplated, isTemplated)) &&
            (identical(other.cardTemplatedJson, cardTemplatedJson) ||
                const DeepCollectionEquality()
                    .equals(other.cardTemplatedJson, cardTemplatedJson)) &&
            (identical(other.isAssembly, isAssembly) ||
                const DeepCollectionEquality()
                    .equals(other.isAssembly, isAssembly)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(isMine) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(recto) ^
      const DeepCollectionEquality().hash(verso) ^
      const DeepCollectionEquality().hash(isTemplated) ^
      const DeepCollectionEquality().hash(cardTemplatedJson) ^
      const DeepCollectionEquality().hash(isAssembly) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $HtmlContentSyncDtoExtension on HtmlContentSyncDto {
  HtmlContentSyncDto copyWith(
      {String? sku,
      bool? isMine,
      String? path,
      String? recto,
      String? verso,
      bool? isTemplated,
      String? cardTemplatedJson,
      bool? isAssembly,
      DateTime? lastUpdated}) {
    return HtmlContentSyncDto(
        sku: sku ?? this.sku,
        isMine: isMine ?? this.isMine,
        path: path ?? this.path,
        recto: recto ?? this.recto,
        verso: verso ?? this.verso,
        isTemplated: isTemplated ?? this.isTemplated,
        cardTemplatedJson: cardTemplatedJson ?? this.cardTemplatedJson,
        isAssembly: isAssembly ?? this.isAssembly,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  HtmlContentSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<bool?>? isMine,
      Wrapped<String?>? path,
      Wrapped<String?>? recto,
      Wrapped<String?>? verso,
      Wrapped<bool?>? isTemplated,
      Wrapped<String?>? cardTemplatedJson,
      Wrapped<bool?>? isAssembly,
      Wrapped<DateTime?>? lastUpdated}) {
    return HtmlContentSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        isMine: (isMine != null ? isMine.value : this.isMine),
        path: (path != null ? path.value : this.path),
        recto: (recto != null ? recto.value : this.recto),
        verso: (verso != null ? verso.value : this.verso),
        isTemplated:
            (isTemplated != null ? isTemplated.value : this.isTemplated),
        cardTemplatedJson: (cardTemplatedJson != null
            ? cardTemplatedJson.value
            : this.cardTemplatedJson),
        isAssembly: (isAssembly != null ? isAssembly.value : this.isAssembly),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class TopicSyncDto {
  const TopicSyncDto({
    this.sku,
    this.path,
    this.title,
    this.parentSKU,
    this.parentCourseSKU,
    this.groupSKU,
    this.fileSKU,
    this.htmlContentSKU,
    this.lastUpdated,
  });

  factory TopicSyncDto.fromJson(Map<String, dynamic> json) =>
      _$TopicSyncDtoFromJson(json);

  static const toJsonFactory = _$TopicSyncDtoToJson;
  Map<String, dynamic> toJson() => _$TopicSyncDtoToJson(this);

  @JsonKey(name: 'SKU', defaultValue: 'default')
  final String? sku;
  @JsonKey(name: 'Path', defaultValue: 'default')
  final String? path;
  @JsonKey(name: 'Title', defaultValue: 'default')
  final String? title;
  @JsonKey(name: 'ParentSKU', defaultValue: 'default')
  final String? parentSKU;
  @JsonKey(name: 'ParentCourseSKU', defaultValue: 'default')
  final String? parentCourseSKU;
  @JsonKey(name: 'GroupSKU', defaultValue: 'default')
  final String? groupSKU;
  @JsonKey(name: 'FileSKU', defaultValue: 'default')
  final String? fileSKU;
  @JsonKey(name: 'HtmlContentSKU', defaultValue: 'default')
  final String? htmlContentSKU;
  @JsonKey(name: 'LastUpdated')
  final DateTime? lastUpdated;
  static const fromJsonFactory = _$TopicSyncDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TopicSyncDto &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.parentSKU, parentSKU) ||
                const DeepCollectionEquality()
                    .equals(other.parentSKU, parentSKU)) &&
            (identical(other.parentCourseSKU, parentCourseSKU) ||
                const DeepCollectionEquality()
                    .equals(other.parentCourseSKU, parentCourseSKU)) &&
            (identical(other.groupSKU, groupSKU) ||
                const DeepCollectionEquality()
                    .equals(other.groupSKU, groupSKU)) &&
            (identical(other.fileSKU, fileSKU) ||
                const DeepCollectionEquality()
                    .equals(other.fileSKU, fileSKU)) &&
            (identical(other.htmlContentSKU, htmlContentSKU) ||
                const DeepCollectionEquality()
                    .equals(other.htmlContentSKU, htmlContentSKU)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(parentSKU) ^
      const DeepCollectionEquality().hash(parentCourseSKU) ^
      const DeepCollectionEquality().hash(groupSKU) ^
      const DeepCollectionEquality().hash(fileSKU) ^
      const DeepCollectionEquality().hash(htmlContentSKU) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      runtimeType.hashCode;
}

extension $TopicSyncDtoExtension on TopicSyncDto {
  TopicSyncDto copyWith(
      {String? sku,
      String? path,
      String? title,
      String? parentSKU,
      String? parentCourseSKU,
      String? groupSKU,
      String? fileSKU,
      String? htmlContentSKU,
      DateTime? lastUpdated}) {
    return TopicSyncDto(
        sku: sku ?? this.sku,
        path: path ?? this.path,
        title: title ?? this.title,
        parentSKU: parentSKU ?? this.parentSKU,
        parentCourseSKU: parentCourseSKU ?? this.parentCourseSKU,
        groupSKU: groupSKU ?? this.groupSKU,
        fileSKU: fileSKU ?? this.fileSKU,
        htmlContentSKU: htmlContentSKU ?? this.htmlContentSKU,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  TopicSyncDto copyWithWrapped(
      {Wrapped<String?>? sku,
      Wrapped<String?>? path,
      Wrapped<String?>? title,
      Wrapped<String?>? parentSKU,
      Wrapped<String?>? parentCourseSKU,
      Wrapped<String?>? groupSKU,
      Wrapped<String?>? fileSKU,
      Wrapped<String?>? htmlContentSKU,
      Wrapped<DateTime?>? lastUpdated}) {
    return TopicSyncDto(
        sku: (sku != null ? sku.value : this.sku),
        path: (path != null ? path.value : this.path),
        title: (title != null ? title.value : this.title),
        parentSKU: (parentSKU != null ? parentSKU.value : this.parentSKU),
        parentCourseSKU: (parentCourseSKU != null
            ? parentCourseSKU.value
            : this.parentCourseSKU),
        groupSKU: (groupSKU != null ? groupSKU.value : this.groupSKU),
        fileSKU: (fileSKU != null ? fileSKU.value : this.fileSKU),
        htmlContentSKU: (htmlContentSKU != null
            ? htmlContentSKU.value
            : this.htmlContentSKU),
        lastUpdated:
            (lastUpdated != null ? lastUpdated.value : this.lastUpdated));
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

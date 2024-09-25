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
      apiSynchronizeGetLastSynchronizationDateGet() {
    return _apiSynchronizeGetLastSynchronizationDateGet();
  }

  ///
  @Get(path: '/api/Synchronize/getLastSynchronizationDate')
  Future<chopper.Response<DateTime>>
      _apiSynchronizeGetLastSynchronizationDateGet();
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

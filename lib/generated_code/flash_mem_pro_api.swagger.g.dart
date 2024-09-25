// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_mem_pro_api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

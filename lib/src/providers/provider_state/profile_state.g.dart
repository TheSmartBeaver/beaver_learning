// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) => ProfileState()
  ..uid = json['uid'] as String
  ..name = json['name'] as String
  ..birthday = DateTime.parse(json['birthday'] as String);

Map<String, dynamic> _$ProfileStateToJson(ProfileState instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'birthday': instance.birthday.toIso8601String(),
    };

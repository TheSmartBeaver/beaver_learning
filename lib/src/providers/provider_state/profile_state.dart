import 'package:json_annotation/json_annotation.dart';
part 'profile_state.g.dart';

@JsonSerializable()
class ProfileState {
  late String uid;
  late String name;
  late DateTime birthday;

  ProfileState();

  factory ProfileState.fromJson(Map<String, dynamic> json) =>
      _$ProfileStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStateToJson(this);
}

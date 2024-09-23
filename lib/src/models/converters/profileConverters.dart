// import 'package:vibescopy_mob_ui/generated_code/vibescopy_api.swagger.dart';
// import 'package:vibescopy_mob_ui/models/liking_potential_match.dart';
// import 'package:vibescopy_mob_ui/models/photo_content.dart';
// import 'package:vibescopy_mob_ui/models/profileContent.dart';
// import 'package:vibescopy_mob_ui/models/provider_state/profile_state.dart';
// import 'package:vibescopy_mob_ui/models/provider_state/register_state.dart';
// import 'package:vibescopy_mob_ui/widgets/shared/utils.dart';

// class ProfileConverter {
//   static CreateUserDto convertRegisterToCreateUserDto(RegisterState profile) {
//     Gender gender = Gender.homme;
//     switch (profile.gender) {
//       case "homme":
//         gender = Gender.homme;
//         break;
//       case "femme":
//         gender = Gender.femme;
//         break;
//       default:
//     }
//     return CreateUserDto(
//         authentUid: profile.authentUid,
//         birthDay: profile.birthday,
//         email: profile.email,
//         name: profile.name,
//         gender: gender,
//         phone: "+33695150667",
//         lovingGenders: profile.lovingGenders.toList(),
//         friendGenders: profile.friendGenders.toList(),
//         lookingRelationShips: profile.lookingRelationShips
//             .toList()); //TODO: Remplacer par les infos correctes
//   }

//   static ProfileState convertProfileDtoToProfileState(ProfileDto profileDto) {
//     var profile = ProfileState();
//     profile.uid = profileDto.authentUid; //TODO: Remplacer par uid
//     profile.photos = [];
//     profile.birthday = profileDto.profileProposition!.birthDay;
//     profile.name = profileDto.name;
//     return profile;
//   }

//   static ProfileContent convertProfileStateToProfileContent(
//       ProfileState profileDto) {
//     var profile = ProfileContent(
//         uid: profileDto.uid,
//         name: profileDto.name,
//         birthDay: profileDto.birthday,
//         photos: profileDto.photos);
//     return profile;
//   }

//   static Future<LikingPotentialMatch>
//       convertPotentialMatchDtoToLikingPotentialMatch(
//           PotentialMatchDto profileDto) async {
//     List<PhotoContent> photos =
//         await UtilsFunctions.getPhotosByUid(profileDto.authentUid);

//     var profile = LikingPotentialMatch(
//         profileDto.name,
//         UtilsFunctions.calculateAge(profileDto.birthDay),
//         profileDto.distance != null ? profileDto.distance!.round() : 0,
//         photos[0].PhotoUrl,
//         "UNKNOWN",
//         'UNKNOWN',
//         'UNKNOWN',
//         isVerified: true);

//     return profile;
//   }
// }

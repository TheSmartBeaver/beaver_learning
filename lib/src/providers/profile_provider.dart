import 'dart:convert';
import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/providers/provider_state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPrefs;

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) {
    final pref = sharedPrefs.getString(AppConstante.profileProviderStateKey);

    if (pref == null || pref.isEmpty) {
      return ProfileNotifier(ref, ProfileState());
    }

    return ProfileNotifier(ref, ProfileState.fromJson(jsonDecode(pref)));
  },
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ref;

  ProfileNotifier(this.ref, ProfileState state) : super(state);

  // Future<void> fetchProfileAfterAuthent(ProfileDto profileDto) async {
  //   state = ProfileConverter.convertProfileDtoToProfileState(profileDto);
  //   persistState();
  // }

  void persistState() {
    sharedPrefs.setString(
        AppConstante.profileProviderStateKey, jsonEncode(state.toJson()));
  }
}

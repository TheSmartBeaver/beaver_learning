import 'package:beaver_learning/api/flash_mem_pro_api.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/generated_code/flash_mem_pro_api.swagger.dart';
import 'package:beaver_learning/service-agent/appuser_service_agent.dart';
import 'package:beaver_learning/src/providers/firebase_auth_provider.dart';
import 'package:beaver_learning/src/providers/profile_provider.dart';
import 'package:beaver_learning/src/screens/courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:image_picker/image_picker.dart';

class LoginScreen extends ConsumerStatefulWidget {

  static const String routeName = '/LoginScreen';

  LoginScreen({super.key}) {
    //TODO: Faire appel à la BDD, si gugus existe, changeScreen
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  var testurl =
      'https://www.123-stickers.com/2295-large_default/winnie-l-ourson.jpg';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchAuthent(false);
    });
  }

  Future<void> fetchAuthent(bool isNewLogin) async {
    if (ref.read(authProvider.notifier).user?.uid != null) {
      var authEntryDto = AuthenticateEntryDto(
          authentUid: ref.read(authProvider.notifier).user!.uid);

      AuthenticateDto result =
          await AppUserServiceAgent(context).authenticate(authEntryDto);
      if (result?.isRegistered == true) {
        // final profile = (await fmpApi.vibescopyApiUserGetUserProfileFbIdPost(
        //         fbId: authEntryDto.authentUid))
        //     .body;

        //sharedPrefs.remove(AppConstante.profileProviderStateKey);

        // await ref
        //     .read(profileProvider.notifier)
        //     .fetchProfileAfterAuthent(profile!);
      } else if (isNewLogin) {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            //builder: (ctx) => Rules(),
            builder: (ctx) => const CoursesScreen(),
          ),
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchAuthent(false);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_background.png'),
                fit: BoxFit
                    .cover, // Adjust the image to cover the entire container
              ),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  //Navigator.pushNamed(context, PhoneScreen.routeName);
                },
                child: const Text('Phone Sign In'),
              ),
              FilledButton(
                onPressed: () {
                  //context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                  ref.read(authProvider.notifier).signInWithGoogle(context, () {
                    //widget.screenUtils.changeScreen(ScreenEnum.matchings);
                    Navigator.pushNamed(context, CoursesScreen.routeName);
                    //showSnackBar(context, "appel");
                    fetchAuthent(true);
                  });
                },
                child: const Text('Google Sign In'),
              ),
              FilledButton(
                onPressed: () {
                  //context.read<FirebaseAuthMethods>().signInWithFacebook(context);
                },
                child: const Text('Facebook Sign In'),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}

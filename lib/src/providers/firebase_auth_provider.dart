import 'package:beaver_learning/src/dao/user_app_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/helper_classes.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_demo/utils/showOTPDialog.dart';
//import 'package:firebase_auth_demo/utils/showSnackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods extends StateNotifier<Object> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuthMethods() : super({});

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User? get user => _auth.currentUser;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context, Function callback) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        try {
          await GoogleSignIn().disconnect();
        } on Exception catch (e) {
          //Si on est déjà déco, c'est ok
        }

        final GoogleSignInAccount? googleUser =
            await GoogleSignIn(scopes: ["profile", "email"]).signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        showSnackBar(context, googleUser?.email ?? "");

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          var toto = await FirebaseAuth.instance.currentUser!.getIdToken();
          //var toto = credential.idToken;

          // await vibeScopApi.vibescopyApiUserLoginPost(
          //     body: new AuthentificateEntryDto(idToken: toto));

          showSnackBar(context,
              userCredential.additionalUserInfo?.username ?? "Pas de username");

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          //TODO: mieux faire un appel en bdd ?
          if (userCredential.user != null) {
            await initAdditionalTreatment(context);
            if (userCredential.additionalUserInfo!.isNewUser) {}
          }

          callback();
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // FACEBOOK SIGN IN
  // Future<void> signInWithFacebook(BuildContext context) async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();

  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //     await _auth.signInWithCredential(facebookAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    if (kIsWeb) {
      // !!! Works only on web !!!
      ConfirmationResult result =
          await _auth.signInWithPhoneNumber(phoneNumber);

      // Diplay Dialog Box To accept OTP
      showOTPDialog(
        codeController: codeController,
        context: context,
        onPressed: () async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: result.verificationId,
            smsCode: codeController.text.trim(),
          );

          await _auth.signInWithCredential(credential);
          Navigator.of(context).pop(); // Remove the dialog box
        },
      );
    } else {
      // FOR ANDROID, IOS
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //  Automatic handling of the SMS code
        verificationCompleted: (PhoneAuthCredential credential) async {
          // !!! works only on android !!!
          await _auth.signInWithCredential(credential);
        },
        // Displays a message when verification fails
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        // Displays a dialog box when OTP is sent
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
            codeController: codeController,
            context: context,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );

              // !!! Works only on Android, iOS !!!
              await _auth.signInWithCredential(credential);
              Navigator.of(context).pop(); // Remove the dialog box
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }

  bool checkIfUserLogged() {
    return _auth.currentUser != null;
  }

  initAdditionalTreatment(BuildContext context) async {
    final database = MyDatabaseInstance.getInstance();
    bool isUserAlreadyRegistered = await UserAppDao(database)
        .isUserAlreadyRegistered(_auth.currentUser!.uid);
    if (!isUserAlreadyRegistered) {
      await UserAppDao(database).create(UserAppCompanion.insert(
          fbId: _auth.currentUser!.uid, sku: const Value("TO_FILL")));
    }
  }
}

final authProvider = StateNotifierProvider<FirebaseAuthMethods, Object>((ref) {
  return FirebaseAuthMethods();
});

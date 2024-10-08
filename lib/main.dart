import 'package:beaver_learning/src/providers/profile_provider.dart';
import 'package:beaver_learning/src/screens/my_learning_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  sharedPrefs = prefs;

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  //runApp(MyApp(settingsController: settingsController));
  runApp(ProviderScope(
    overrides: [
      //sharedPrefs.overrideWith(prefs),
    ],
    child: MyLearningApp(settingsController: settingsController),
    //child: MyApp(settingsController: settingsController),
  ));
}

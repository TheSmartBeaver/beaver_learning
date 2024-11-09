import 'package:beaver_learning/src/providers/firebase_auth_provider.dart';
import 'package:beaver_learning/src/screens/assemblies_list.dart';
import 'package:beaver_learning/src/screens/assembly_editor.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/course_creator.dart';
import 'package:beaver_learning/src/screens/courses.dart';
import 'package:beaver_learning/src/screens/editors_screen.dart';
import 'package:beaver_learning/src/screens/interactive_speech.dart';
import 'package:beaver_learning/src/screens/login_screen.dart';
import 'package:beaver_learning/src/screens/marketplace.dart';
import 'package:beaver_learning/src/screens/settings_screen.dart';
import 'package:beaver_learning/src/screens/statistics.dart';
import 'package:beaver_learning/src/settings/settings_controller.dart';
import 'package:beaver_learning/src/widgets/group/group_editor.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ref.read(appbarProvider.notifier).changeSelectedDrawerIndex(item);

class MyLearningApp extends ConsumerStatefulWidget {
  const MyLearningApp({super.key, required this.settingsController});

  static const appTitle = 'Drawer Demo';
  final SettingsController settingsController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyLearningAppState();
  }
}

class _MyLearningAppState extends ConsumerState<MyLearningApp> {
  bool isUserLogged = false;
  bool isInitialized = false;

  Future init() async {
    isUserLogged = await ref.read(authProvider.notifier).checkIfUserLogged();
    if (!isInitialized) {
      setState(() {
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          // theme: ThemeData(
          // colorSchemeSeed: Colors.lightGreen, useMaterial3: true),
          darkTheme: ThemeData.light(),
          themeMode: widget.settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            final args = routeSettings.arguments as Map<String, dynamic>?;
            if(args?['isFromLogging'] != null){
              isInitialized = false;
            }
            init();
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                if (isUserLogged) {
                  switch (routeSettings.name) {
                    case CardEditorScreen.routeName:
                      return CardEditorScreen();
                    case LoginScreen.routeName:
                      return LoginScreen();
                    case AssemblyEditor.routeName:
                      return AssemblyEditor();
                    case AssembliesList.routeName:
                      return AssembliesList();
                    case RevisorDisplayer.routeName:
                      return RevisorDisplayer();
                    case EditorsScreen.routeName:
                      return EditorsScreen();
                    case MarketPlaceScreen.routeName:
                      return const MarketPlaceScreen();
                    case SettingsScreen.routeName:
                      return const SettingsScreen();
                    case StatisticsScreen.routeName:
                      return ChatScreenPage();
                    case GroupEditor.routeName:
                      return GroupEditor();
                    case CoursesScreen.routeName:
                      return const CoursesScreen();
                    case CourseCreatorScreen.routeName:
                      return CourseCreatorScreen();
                    default:
                      return const CoursesScreen();
                  }
                } else {
                  return LoginScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}

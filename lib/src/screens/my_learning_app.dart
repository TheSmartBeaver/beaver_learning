import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/courses.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/screens/marketplace.dart';
import 'package:beaver_learning/src/screens/settings_screen.dart';
import 'package:beaver_learning/src/screens/statistics.dart';
import 'package:beaver_learning/src/settings/settings_controller.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/group/group_editor.dart';
import 'package:beaver_learning/src/widgets/course/course_summary.dart';
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
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case CardEditorScreen.routeName:
                    return CardEditorScreen();
                  case GroupScreen.routeName:
                    return GroupScreen();
                  case RevisorDisplayer.routeName:
                    return RevisorDisplayer();
                  case CardList.routeName:
                    return CardList();
                  case MarketPlaceScreen.routeName:
                    return MarketPlaceScreen();
                  case SettingsScreen.routeName:
                    return SettingsScreen();
                  case StatisticsScreen.routeName:
                    return StatisticsScreen();
                  case GroupEditor.routeName:
                    return GroupEditor();
                  case CoursesScreen.routeName:
                    return CoursesScreen();
                  default:
                    return CoursesScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}

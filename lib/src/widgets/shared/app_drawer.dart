import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/providers/app_bar_provider.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/course_creator.dart';
import 'package:beaver_learning/src/screens/courses.dart';
import 'package:beaver_learning/src/screens/editors_screen.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/screens/marketplace.dart';
import 'package:beaver_learning/src/screens/settings_screen.dart';
import 'package:beaver_learning/src/screens/statistics.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/course/course_summary.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppDrawerState();
  }
}

enum DrawerItem {
  editors,
  statistics,
  revisor,
  courses,
  marketplace,
  settings,
  course_creator
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  void _internalOnItemTapped(DrawerItem item) {
    ref.read(appbarProvider.notifier).changeSelectedDrawerIndex(item);
    //Navigator.pop(context);
    switch (item) {
      case DrawerItem.editors:
        Navigator.pushReplacementNamed(context, EditorsScreen.routeName);
        break;
      case DrawerItem.statistics:
        Navigator.pushReplacementNamed(context, StatisticsScreen.routeName);
        break;
      case DrawerItem.revisor:
        Navigator.pushReplacementNamed(context, RevisorDisplayer.routeName);
        break;
      case DrawerItem.courses:
        Navigator.pushReplacementNamed(context, CoursesScreen.routeName);
        break;
      case DrawerItem.marketplace:
        Navigator.pushReplacementNamed(context, MarketPlaceScreen.routeName);
        break;
      case DrawerItem.settings:
        Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
        break;
      case DrawerItem.course_creator:
        Navigator.pushReplacementNamed(context, CourseCreatorScreen.routeName);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(AppConstante.AppTitle),
          ),
          ListTile(
            title: const Text('Editors'),
            selected:
                ref.watch(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.editors,
            onTap: () {
              _internalOnItemTapped(DrawerItem.editors);
            },
          ),
          ListTile(
            title: const Text('Statistiques'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.statistics,
            onTap: () {
              _internalOnItemTapped(DrawerItem.statistics);
              // showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //           title: const Text("Whooops !"),
              //           content: const Text(
              //               'Cet écran est actuellement en cours de développement. Veuillez réessayer plus tard !'),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text('Okay'),
              //             ),
              //           ],
              //         ));
            },
          ),
          ListTile(
            title: const Text('Réviseur'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.revisor,
            onTap: () {
              _internalOnItemTapped(DrawerItem.revisor);
            },
          ),
          ListTile(
            title: const Text('Cours'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.courses,
            onTap: () {
              _internalOnItemTapped(DrawerItem.courses);
            },
          ),
          ListTile(
            title: const Text('Marketplace'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.marketplace,
            onTap: () {
              _internalOnItemTapped(DrawerItem.marketplace);
            },
          ),
          ListTile(
            title: Container(
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.settings)),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.settings,
            onTap: () {
              _internalOnItemTapped(DrawerItem.settings);
            },
          ),
          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Course creator'),
                Text('(Experimental)'),
              ],
            ),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.course_creator,
            onTap: () {
              _internalOnItemTapped(DrawerItem.course_creator);
            },
          ),
        ],
      ),
    );
  }
}

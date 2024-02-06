import 'package:beaver_learning/src/providers/app_bar_provider.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/screens/marketplace.dart';
import 'package:beaver_learning/src/screens/settings_screen.dart';
import 'package:beaver_learning/src/screens/statistics.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/reviser/course_summary.dart';
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
  groups,
  cards,
  statistics,
  revisor,
  course,
  marketplace,
  settings
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  void _internalOnItemTapped(DrawerItem item) {
    ref.read(appbarProvider.notifier).changeSelectedDrawerIndex(item);
    //Navigator.pop(context);
    switch (item) {
      case DrawerItem.groups:
        Navigator.pushReplacementNamed(context, GroupEditorScreen.routeName);
        break;
      case DrawerItem.cards:
        Navigator.pushReplacementNamed(context, CardList.routeName);

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => CardEditorScreen(),
        //   ),
        // );
        break;
      case DrawerItem.statistics:
        Navigator.pushReplacementNamed(context, StatisticsScreen.routeName);
        break;
      case DrawerItem.revisor:
        Navigator.pushReplacementNamed(context, CardDisplayer.routeName);
        break;
      case DrawerItem.course:
        Navigator.pushReplacementNamed(context, CourseSummary.routeName);
        break;
      case DrawerItem.marketplace:
        Navigator.pushReplacementNamed(context, MarketPlaceScreen.routeName);
        break;
      case DrawerItem.settings:
        Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
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
            child: Text('My Learning App'),
          ),
          ListTile(
            title: const Text('Groupes'),
            selected:
                ref.watch(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.groups,
            onTap: () {
              _internalOnItemTapped(DrawerItem.groups);
            },
          ),
          ListTile(
            title: const Text('Cartes'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.cards,
            onTap: () {
              _internalOnItemTapped(DrawerItem.cards);
            },
          ),
          ListTile(
            title: const Text('Statistiques'),
            selected:
                ref.read(appbarProvider.notifier).state.currentDrawerIndex ==
                    DrawerItem.statistics,
            onTap: () {
              _internalOnItemTapped(DrawerItem.statistics);
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
                    DrawerItem.course,
            onTap: () {
              _internalOnItemTapped(DrawerItem.course);
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
        ],
      ),
    );
  }
}

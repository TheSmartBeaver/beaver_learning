import 'package:beaver_learning/src/providers/firebase_auth_provider.dart';
import 'package:beaver_learning/src/screens/courses.dart';
import 'package:beaver_learning/src/screens/login_screen.dart';
import 'package:beaver_learning/src/utils/export_functions.dart';
import 'package:beaver_learning/src/utils/synchronize_manager.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/SettingsScreen';

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

Widget buildSection(
    String sectionTitle, List<Widget> body, BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(5),
      child: Card(
          child: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            child: Text(
              sectionTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            )),
        ...body
      ])));
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Image? imageWidget;
  Image? imageWidget2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSection(
                "Account infos",
                [
                  const Text(
                      "Pour l'instant tu n'as pas la possibilité d'avoir de compte ^^")
                ],
                context),
            ElevatedButton(
                onPressed: () async {
                  SynchronizeManager syncManager = SynchronizeManager(context, ref);
                  await syncManager.synchronize();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                child: const Text("Synchronize",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: () async {
                  await importReal(context);
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                child: const Text("Import Deck",
                    style: TextStyle(color: Colors.black))),
            if (ref.read(authProvider.notifier).checkIfUserLogged())
              ElevatedButton(
                child: const Text("Logout"),
                onPressed: () {
                  ref.read(authProvider.notifier).signOut(context);
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
          ],
        )),
        drawer: const AppDrawer());
  }
}

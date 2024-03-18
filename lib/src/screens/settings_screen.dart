import 'dart:io';

import 'package:beaver_learning/src/utils/export_functions.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

Widget buildSection(List<Widget> body, BuildContext context) {
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
            child: const Text(
              "Account infos",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            )),
        ...body
      ])));
}

class _SettingsScreenState extends State<SettingsScreen> {
  Image? imageWidget;
  Image? imageWidget2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSection([
              Text("Settings")
            ], context),
            ElevatedButton(
                onPressed: () async {
                  await importReal();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                child: const Text("Import Deck",
                    style: TextStyle(color: Colors.black))),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: () async {
                var url = "https://image.api.playstation.com/vulcan/img/rnd/202010/2621/H9v5o8vP6RKkQtR77LIGrGDE.png";
                var imagePath = "batman.png";
                var imagePath2 = "batman2.png";
                var imagePath3 = "batman3.png";
                var imageFile = await downloadAndSaveImage(url,imagePath);
                var serverProps = await startLocalHttpServer();
                await copyImageToServerDirectory(imageFile.path, imagePath2);

                var imageFile2 = await downloadAndSaveImage("${serverProps.url}/$imagePath2",imagePath3);
                setState(() {
                  imageWidget = Image.file(imageFile);
                  imageWidget2 = Image.file(imageFile2);
                });
                var toto = 0;
              },
            ),
            if (imageWidget != null) imageWidget!,
            if (imageWidget2 != null) imageWidget2!
          ],
        )),
        drawer: const AppDrawer());
  }
}
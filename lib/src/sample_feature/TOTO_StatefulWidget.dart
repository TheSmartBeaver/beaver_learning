import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

class TOTO extends StatefulWidget {
  final String title = AppConstante.AppTitle;

  @override
  State<TOTO> createState() {
    return _TOTOState();
  }
}

class _TOTOState extends State<TOTO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Text("TODO"),
    );
  }
}

FutureBuilderExe() {
  init() async {}

  return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Text("FINAL RENDER");
        }
      });
}

scaffold(){
  return Scaffold(
      appBar: CustomAppBar(
        title: "widget.title",
        actions: [
        ],
      ),
      body: Text("TODO"),
      drawer: const AppDrawer()
      );
}
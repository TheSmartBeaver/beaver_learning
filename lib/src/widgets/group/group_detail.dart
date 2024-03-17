import 'dart:convert';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/export_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/group/group_list.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/form-styles.dart';
import 'package:flutter/material.dart';


class GroupDetail extends StatefulWidget {
  final String title = AppConstante.AppTitle;
  final GroupData group;
  const GroupDetail({Key? key, required this.group}) : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late List<GroupData> groups;

  init() async {
    final database = MyDatabaseInstance.getInstance();
    groups = await (database.select(database.group)
          ..where((group) => group.parentId.equals(widget.group.id)))
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.title,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Text(widget.group.title, style: const TextStyle(fontSize: 24)),
            ElevatedButton(
                onPressed: () async {
                  final database = MyDatabaseInstance.getInstance();
                  var cards = await (database.select(database.reviseCards)
                        ..where((card) => card.groupId.equals(widget.group.id)))
                      .get();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RevisorDisplayer(initialcards: cards),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen)),
                child: const Text("Revise cards",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CardList(initialGroup: widget.group),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.redAccent)),
                child: const Text("View cards",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: () async {
                  //await export(widget.group.id);
                  var export = await recursiveGroupDiscovery(widget.group);
                  var test = export.toJson();
                  var xd = 2;
                  final json = jsonEncode(test);
                  var xddd = 2;
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                child: const Text("Export",
                    style: TextStyle(color: Colors.black))),
            FutureBuilder(
                future: init(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                        margin: const EdgeInsets.all(4),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: containerWithLabel(
                            label: "Child groups",
                            body: GroupList(groups: groups)));
                  }
                })
          ],
        ),
        drawer: const AppDrawer());
  }
}

import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/widgets/group/group_detail.dart';
import 'package:beaver_learning/src/widgets/group/group_editor.dart';
import 'package:beaver_learning/src/widgets/group/group_list.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:beaver_learning/data/constants.dart';
//import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/groupScreen';

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<DropDownItem> items = [
    const DropDownItem("item1", "ITEM 1"),
    const DropDownItem("item2", "ITEM 2")
  ];

  late List<GroupData> groups;

  init() async {
    final database = MyDatabaseInstance.getInstance();
    groups = await (database.select(database.group)
          ..where((group) => group.parentId.isNull()))
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Decks")),
        body: Center(
            child: Column(
          children: [
            CustomDropdownMenu(
              items: items,
              label: "Tags",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 6),
            Container(
                margin: const EdgeInsets.all(4),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Words',
                  ),
                )),
            FutureBuilder(
                future: init(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                    return const CircularProgressIndicator();
                  } else {
                    return Expanded(
                        child: GroupList(groups: groups));
                  }
                }),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, GroupEditor.routeName);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        drawer: const AppDrawer());
  }
}

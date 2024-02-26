import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  static const routeName = '/cardListScreen';

  @override
  State<StatefulWidget> createState() {
    return _CardListState();
  }
}

List<DropDownItem> items = [
  const DropDownItem("item1", "ITEM 1"),
  const DropDownItem("item2", "ITEM 2")
];

void onGroupSelected(DropDownItem? item) {
  var toto = 0;
}

void onWordSelected(DropDownItem? item) {
  var toto = 0;
}

void onCardSelected(DropDownItem? item) {
  var toto = 0;
}

Widget packInBox(Widget child) {
  return Expanded(
      child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(border: Border.all()),
          child: child));
}

class _CardListState extends State<CardList> {
  final TextEditingController wordController = TextEditingController();
  late List<ReviseCard> cards;

  Future<void> init() async {
    var database = MyDatabaseInstance.getInstance();
    cards = await database.select(database.reviseCards).get();
    var toto = 0;
    //TODO: Pourquoi refait t'on cette appel quand on est dans écran création carte
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards List'),
      ),
      drawer: const AppDrawer(),
      body: Center(
          child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomDropdownMenu(
              items: items,
              label: "Group",
              onSelected: onGroupSelected,
              width: MediaQuery.of(context).size.width / 2,
            ),
            CustomDropdownMenu(
              items: items,
              label: "Cards",
              onSelected: onCardSelected,
              width: MediaQuery.of(context).size.width / 2,
            )
          ]),
          const SizedBox(height: 6),
          Container(
              margin: const EdgeInsets.all(4),
              child: TextField(
                obscureText: true,
                controller: wordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Words',
                ),
              )),
          FutureBuilder(
              future: init(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                      child: ListView.builder(
                    // Providing a restorationId allows the ListView to restore the
                    // scroll position when a user leaves and returns to the app after it
                    // has been killed while running in the background.
                    restorationId: 'sampleItemListView',
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(border: Border.all()),
                          margin: const EdgeInsets.all(2),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                packInBox(Text(cards[index].recto)),
                                packInBox(Text(cards[index].verso)),
                              ]));
                    },
                  ));
                }
              })
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CardEditorScreen.routeName);
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

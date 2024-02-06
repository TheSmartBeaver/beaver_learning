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

class _CardListState extends State<CardList> {
  final TextEditingController groupController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController wordController = TextEditingController();

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
            CustomDropdown(
              items: items,
              label: "Group",
              dpController: groupController,
              onSelected: onGroupSelected,
              width: MediaQuery.of(context).size.width / 2,
            ),
            CustomDropdown(
              items: items,
              label: "Cards",
              dpController: cardController,
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
              ))
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

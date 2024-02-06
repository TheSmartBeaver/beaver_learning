import 'package:beaver_learning/src/widgets/card/card_editor.dart/html_card_editor.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardEditorScreen extends StatefulWidget {
  CardEditorScreen({super.key});

  final String title = "My Learning App";
  static const routeName = '/cardEditorScreen';

  final TextEditingController cardTypeController = TextEditingController();
  final TextEditingController groupController = TextEditingController();

  @override
  State<CardEditorScreen> createState() => _CardEditorScreenState();
}

List<DropDownItem> items = [
  const DropDownItem("item1", "ITEM 1"),
  const DropDownItem("item2", "ITEM 2")
];

class _CardEditorScreenState extends State<CardEditorScreen> {
  @override
  Widget build(BuildContext context) {
    Widget editorToRender = HtmlCardEditor();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.all(4),
              child: CustomDropdown(
                items: items,
                label: "Card Type",
                dpController: widget.cardTypeController,
                width: MediaQuery.of(context).size.width,
              )),
          Container(
              margin: const EdgeInsets.all(4),
              child: CustomDropdown(
                items: items,
                label: "Group",
                dpController: widget.groupController,
                width: MediaQuery.of(context).size.width,
              )),
          editorToRender
        ]),
      ),
      drawer: const AppDrawer(),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            Navigator.pushNamed(context, CardEditorScreen.routeName);
          },
          foregroundColor: Colors.blue[900],
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          child: const Icon(FontAwesomeIcons.chartColumn),
        ),
        FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.pushNamed(context, CardEditorScreen.routeName);
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.redAccent,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.lightbulb)),
        FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, CardEditorScreen.routeName);
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.blueGrey,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.tags))
      ],
    );
  }
}

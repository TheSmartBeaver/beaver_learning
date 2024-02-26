import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:flutter/material.dart';

class HtmlCardEditor extends StatefulWidget implements CardEditorInterface {
  final TextEditingController rectoController = TextEditingController();
  final TextEditingController versoController = TextEditingController();

  HtmlCardEditor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HtmlCardEditorState();
  }

  @override
  Future<void> createCard(int groupId) async {
    final database = MyDatabaseInstance.getInstance();
    await database.into(database.reviseCards).insert(
        ReviseCardsCompanion.insert(
            groupId: groupId,
            recto: rectoController.text,
            verso: versoController.text,
            tags: 'toto;ahah'));
    var toto = 0;
  }
}

class _HtmlCardEditorState extends State<HtmlCardEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.all(4),
          child: TextField(
            maxLines: 2,
            minLines: 2,
            controller: widget.rectoController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Recto',
                fillColor: Color.fromARGB(20, 157, 189, 215),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(2)))),
          )),
      Container(
          margin: const EdgeInsets.all(4),
          child: TextField(
            maxLines: 5,
            minLines: 5,
            controller: widget.versoController,
            decoration: const InputDecoration(
                labelText: 'Verso',
                fillColor: Color.fromARGB(19, 207, 138, 128),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(2)))),
          ))
    ]);
  }
}

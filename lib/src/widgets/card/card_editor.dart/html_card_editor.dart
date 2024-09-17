import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/enum/answer_dificulty.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/queel_editor.dart';
import 'package:drift/drift.dart' as drift;
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
  Future<void> createCard(int groupId, CardDisplayerType displayerType, {String? path}) async {
    await createCardInDb(groupId, displayerType, path, HTMLContentsCompanion.insert(recto: drift.Value(rectoController.text), verso: drift.Value(versoController.text), cardTemplatedJson: const drift.Value(""), isTemplated: const drift.Value(false)));
  }
  
  @override
  Future<void> showCard(BuildContext context) {
    // TODO: implement showCard
    throw UnimplementedError();
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
      IconButton(
          onPressed: () async {
            String? htmlText = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                builder: (ctx) => MyQueelEditor("", isEditionMode: true),
              ),
            );
            widget.versoController.text = htmlText!;
          },
          icon: Icon(Icons.text_snippet)),
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

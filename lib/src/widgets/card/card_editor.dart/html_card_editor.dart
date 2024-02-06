import 'package:flutter/material.dart';

class HtmlCardEditor extends StatefulWidget {
  final TextEditingController rectoController = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _HtmlCardEditorState();
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
            controller: widget.rectoController,
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

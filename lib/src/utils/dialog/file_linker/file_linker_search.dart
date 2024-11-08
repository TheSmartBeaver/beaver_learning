import 'dart:async';

import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class FileLinkerSearchDialog extends StatefulWidget {
  final Function(int fileId) processFileLinkFunction;

  const FileLinkerSearchDialog(
      {super.key, required this.processFileLinkFunction});

  @override
  _FileLinkerSearchDialogState createState() => _FileLinkerSearchDialogState();
}

class _FileLinkerSearchDialogState extends State<FileLinkerSearchDialog> {
  TextEditingController _textEditingController = TextEditingController();
  String textValue = '';
  Timer? _debounce;
  List<FileContent> filesReturned = [];
  int? selectedFileIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> init() async {
      var database = MyDatabaseInstance.getInstance();

      filesReturned = await (database.select(database.fileContents)
            ..where((tbl) => tbl.name.like("%$textValue%"))
            ..limit(15))
          .get();
    }

    return Column(children: [
      Container(
        width: double.maxFinite,
        child: TextField(
          controller: _textEditingController,
          maxLines: null, // Allow unlimited lines
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Saisissez le fichier que vous recherchez',
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              setState(() {
                selectedFileIndex = null;
                textValue = value;
              });
            });
          },
        ),
      ),
      FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Container(
                  width: 500,
                  height: 500,
                  child: SingleChildScrollView(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filesReturned.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${filesReturned[index].path}\n${filesReturned[index].name} ${filesReturned[index].format}",
                            style: selectedFileIndex == index
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    color: Colors.red)
                                : null),
                        onTap: () {
                          setState(() {
                            selectedFileIndex = index;
                          });
                        },
                      );
                    },
                  )));
            }
          }),
      Row(children: [
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            if (selectedFileIndex != null) {
              widget.processFileLinkFunction(
                  filesReturned[selectedFileIndex!].id);
              Navigator.of(context).pop();
            }
          },
        ),
      ])
    ]);
  }
}

import 'dart:async';

import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class TemplateSearchDialog extends StatefulWidget {
  final Function(int templateId) processTemplateFunction;

  const TemplateSearchDialog(
      {super.key, required this.processTemplateFunction});

  @override
  _TemplateSearchDialogState createState() => _TemplateSearchDialogState();
}

class _TemplateSearchDialogState extends State<TemplateSearchDialog> {
  TextEditingController _textEditingController = TextEditingController();
  String textValue = '';
  Timer? _debounce;
  List<CardTemplateData> templatesReturned = [];
  int? selectedTemplateIndex;

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
      // Récupérer l'aide mnémotechnique enregistrée
      var database = MyDatabaseInstance.getInstance();

      templatesReturned = await (database.select(database.cardTemplate)
            ..where((tbl) => tbl.path.like("%$textValue%"))
            ..limit(15))
          .get();
    }

    return AlertDialog(
      title: const Text('Template Search'),
      content: Column(children: [
        Container(
          width: double.maxFinite,
          child: TextField(
            controller: _textEditingController,
            maxLines: null, // Allow unlimited lines
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Saisissez la template que vous recherchez',
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  selectedTemplateIndex = null;
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
                      itemCount: templatesReturned.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(templatesReturned[index].path,
                              style: selectedTemplateIndex == index
                                  ? const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible,
                                      color: Colors.red)
                                  : null),
                          onTap: () {
                            setState(() {
                              selectedTemplateIndex = index;
                            });
                          },
                        );
                      },
                    )));
              }
            })
      ]),
      actions: [
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            if(selectedTemplateIndex != null) {
              widget.processTemplateFunction(templatesReturned[selectedTemplateIndex!].id);
              Navigator.of(context).pop();
            }
            
          },
        ),
      ],
    );
  }
}

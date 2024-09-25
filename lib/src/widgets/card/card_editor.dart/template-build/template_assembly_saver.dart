import 'dart:async';

import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/assemblyCategoryTable.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateAssemblySaver extends ConsumerStatefulWidget {
  final Function(int templateId) processTemplateFunction;

  const TemplateAssemblySaver({Key? key, required this.processTemplateFunction})
      : super(key: key);

  @override
  _TemplateAssemblySaverState createState() => _TemplateAssemblySaverState();
}

class _TemplateAssemblySaverState extends ConsumerState<TemplateAssemblySaver> {
  TextEditingController _textEditingController = TextEditingController();
  String textValue = '';
  Timer? _debounce;
  List<AssemblyCategoryData> categoriesReturned = [];
  int? selectedCategoryIndex;

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

      categoriesReturned = await (database.select(database.assemblyCategory)
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
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  selectedCategoryIndex = null;
                  textValue = value;
                });
              });
            },
            decoration: const InputDecoration(
              hintText: 'Saisissez la catégorie que vous recherchez',
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: categoriesReturned.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categoriesReturned[index].path),
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              );
            },
          ),
        ),
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
            if (selectedCategoryIndex != null) {
              //TODO: Save or update assembly
              final cardDao = CardDao(MyDatabaseInstance.getInstance());
              cardDao.insertAssembly(
                  HTMLContent(
                      id: -1,
                      recto: "",
                      verso: "",
                      isTemplated: true,
                      cardTemplatedJson: "cardTemplatedJson",
                      isAssembly: true,
                      lastUpdated: getUpdateDateNow()),
                  categoriesReturned[selectedCategoryIndex!].id,
                  false);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

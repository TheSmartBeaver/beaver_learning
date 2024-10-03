import 'dart:async';

import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/assemblyCategoryTable.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateAssemblySaver extends ConsumerStatefulWidget {
  final Function(int assemblyId) processAssemblyFunction;

  const TemplateAssemblySaver({Key? key, required this.processAssemblyFunction})
      : super(key: key);

  @override
  _TemplateAssemblySaverState createState() => _TemplateAssemblySaverState();
}

class _TemplateAssemblySaverState extends ConsumerState<TemplateAssemblySaver> {
  TextEditingController _textEditingController = TextEditingController();
  String textValue = '';
  Timer? _debounce;
  List<HTMLContent> assemebliesReturned = [];
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
      HtmlDao htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
      assemebliesReturned = await htmlDao.getUsableAssemblies(textValue);
      var toto = 0;
    }

    return AlertDialog(
      title: const Text('Assembly Search'),
      content: Column(children: [
        TextField(
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
                            itemCount: assemebliesReturned.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(assemebliesReturned[index].path ??
                                    "UNKNOWN_PATH"),
                                onTap: () {
                                  setState(() {
                                    selectedCategoryIndex = index;
                                  });
                                },
                                selected: selectedCategoryIndex == index,
                              );
                            })));
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
            if (selectedCategoryIndex != null) {
              //TODO: Save or update assembly
              final cardDao = CardDao(MyDatabaseInstance.getInstance());

              // cardDao.insertAssembly(
              //     HTMLContent(
              //         id: -1,
              //         recto: "",
              //         verso: "",
              //         isTemplated: true,
              //         cardTemplatedJson: "cardTemplatedJson",
              //         isAssembly: true,
              //         lastUpdated: getUpdateDateNow()),
              //     categoriesReturned[selectedCategoryIndex!].id,
              //     false);

              widget.processAssemblyFunction(
                  assemebliesReturned[selectedCategoryIndex!].id);

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

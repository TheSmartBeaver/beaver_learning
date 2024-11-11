import 'dart:ui';

import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/dao/card_template_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/screens/editors_screen.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/html_functions.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardTemplateEditor extends ConsumerStatefulWidget {
  final cardDao = CardDao(MyDatabaseInstance.getInstance());
  final int? cardTemplateToEditId;
  static const routeName = '/cardTemplateEditorScreen';
  TextEditingController pathController = TextEditingController();
  TextEditingController htmlTextController = TextEditingController();

  CardTemplateEditor({super.key, this.cardTemplateToEditId});

  Future<void> createOrUpdateCardTemplate() async {
    if (cardTemplateToEditId == null) {
      int cardTemplateId = await createHtmlTemplateInDb(
          CardTemplateCompanion.insert(
              path: pathController.text,
              template: htmlTextController.text,
              lastUpdated: getUpdateDateNow()));
    } else {
      await updateCardTemplateInDb(
          cardTemplateToEditId!,
          CardTemplateCompanion.insert(
              path: pathController.text,
              template: htmlTextController.text,
              lastUpdated: getUpdateDateNow()));
    }
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CardTemplateEditorState();
  }

  Future<void> showCardTemplate(BuildContext context) async {
    printHtmlCode(context, htmlTextController.text);
  }
}

class CardTemplateEditorState extends ConsumerState<CardTemplateEditor> {
  bool isInitialized = false;
  CardTemplatedBranch cardTemplatedBranchToUpdate = CardTemplatedBranch(null);

  void onTextChangeListener(String text) {
    widget.pathController.text = text;
  }

  Future<void> init() async {
    try {
      if (!isInitialized) {
        if (widget.cardTemplateToEditId != null) {
          CardTemplateDao cardTemplateDao =
              CardTemplateDao(MyDatabaseInstance.getInstance());
          var cardTemplateToEdit =
              await cardTemplateDao.getById(widget.cardTemplateToEditId!);

          setState(() {
            widget.htmlTextController.text = cardTemplateToEdit?.template ?? "";
            widget.pathController.text = cardTemplateToEdit?.path ?? "";
          });
        }

        setState(() {
          isInitialized = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Assembly editor",
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () async {
              await widget.showCardTemplate(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () async {
              await widget.createOrUpdateCardTemplate();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => EditorsScreen(
                        initialMenuItem: InternMenuItemEnum.template)),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
              child: CustomTextField(
                  controller: widget.pathController
                    ..text = widget.pathController.text,
                  icon: Icons.abc,
                  label: "Assembly Path",
                  maxLength: null)),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.center,
                child: CustomTextField(
                    controller: widget.htmlTextController
                      ..text = widget.htmlTextController.text,
                    icon: Icons.abc,
                    label: "Card Template Path",
                    minLines: 15,
                    maxLength: null,
                    maxLines: null)),
          )
        ],
      )),
      drawer: const AppDrawer(),
      persistentFooterButtons: const [],
    );
  }
}

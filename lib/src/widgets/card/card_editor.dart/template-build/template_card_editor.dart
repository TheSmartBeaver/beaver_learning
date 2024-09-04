import 'dart:convert';
import 'dart:ui';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/data/test_data.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateCardEditor extends ConsumerStatefulWidget
    implements CardEditorInterface {
  bool isEditMode = true;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());

  TemplateCardEditor({super.key, this.isEditMode = true});

  @override
  Future<void> createCard(int groupId, CardDisplayerType displayerType) async {
    throw UnimplementedError();
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TemplateCardEditorState();
  }
}

class _TemplateCardEditorState extends ConsumerState<TemplateCardEditor> {
  late ReviseCard cardForPreview;
  bool isInitialized = false;
  CardTemplatedBranch cardTemplatedBranchToUpdate =
      CardTemplatedBranch(null);
  late HTMLCardDisplayer htmlCardDisplayer;
  

  _TemplateCardEditorState() {
    cardTemplatedBranchToUpdate.jsonObjectFields.putIfAbsent(
        AppConstante.rectoFieldName,
        () => CardTemplatedBranch(null)..parentCardTemplatedBranch = cardTemplatedBranchToUpdate);
    cardTemplatedBranchToUpdate.jsonObjectFields.putIfAbsent(
        AppConstante.versoFieldName,
        () => CardTemplatedBranch(null)..parentCardTemplatedBranch = cardTemplatedBranchToUpdate);

    Map<String, dynamic> json = jsonDecode(completeJsonCardTest);

    cardTemplatedBranchToUpdate = buildBranch(json);

    var toto = 0;
  }

  Future getPreviewCard() async {
    final database = MyDatabaseInstance.getInstance();
    cardForPreview = await (database.select(database.reviseCards)
          ..where((tbl) =>
              tbl.path.equals(AppConstante.templatedCardPreviewNameKey)))
        .getSingle();
  }
      
  Future<void> update_card() async {

    String value = CardTemplatedBranchToJsonString(cardTemplatedBranchToUpdate); //CardTemplatedBranchToJsonString(cardTemplatedBranchToUpdate)

    // On appelle la fonction de mise à jour de la carte
    await widget.cardDao
        .updateCardTemplatedJson(cardForPreview.htmlContent, value);

    // On remet un coup de "getPreviewCard"
    await getPreviewCard();

    htmlCardDisplayer.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
        padding: const EdgeInsets.all(8.0),
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          //color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(children: [
          FutureBuilder(
              future: getPreviewCard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  htmlCardDisplayer = HTMLCardDisplayer(
                          isPrintAnswer: true, cardToRevise: cardForPreview);
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: 
                      htmlCardDisplayer
                      );
                }
              }),
          ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: Container(
              alignment: Alignment.center,
              child: TemplateFormBuilder(
                    updateCard: update_card,
                    cardTemplatedBranchToUpdate: cardTemplatedBranchToUpdate)
            ),
          )),
        ]));
  }
}

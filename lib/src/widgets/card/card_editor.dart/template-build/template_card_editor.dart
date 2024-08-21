import 'dart:ui';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
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
  String jsonCard = '''
  {
  "recto": {
  },
  "verso": {
  },
  "version": "1.0.0"
}
  ''';

  Future getPreviewCard() async {
    final database = MyDatabaseInstance.getInstance();
    cardForPreview = await (database.select(database.reviseCards)
          ..where((tbl) =>
              tbl.path.equals(AppConstante.templatedCardPreviewNameKey)))
        .getSingle();
    var test = 0;
  }

  Future<void> update_card(List<String> fieldPath, String value) async {
      // On appelle la fonction de mise à jour de la carte
      await widget.cardDao.updateCardTemplatedJson(cardForPreview.htmlContent, value);

      // On remet un coup de "getPreviewCard"
      await getPreviewCard();
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
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: HTMLCardDisplayer(
                          isPrintAnswer: true, cardToRevise: cardForPreview));
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
              child: const Column(children: [
                TemplateFormBuilder(fieldName: "recto"),
                TemplateFormBuilder(fieldName: "verso")
              ]),
            ),
          )),
        ]));
  }
}
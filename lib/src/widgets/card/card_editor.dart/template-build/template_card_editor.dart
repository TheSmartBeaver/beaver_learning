import 'dart:convert';
import 'dart:ui';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/data/test_data.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/providers/templated_card_provider.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_form_builder.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:drift/drift.dart' as drift;

class TemplateCardEditor extends ConsumerStatefulWidget
    implements CardEditorInterface {
  bool isEditMode = true;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());
  late ReviseCard cardForPreview;
  final int? cardToEditId;
  late TemplateCardEditorState widgetState;

  TemplateCardEditor({super.key, this.isEditMode = true, this.cardToEditId});

  @override
  Future<void> createOrUpdateCard(int groupId) async {
    var cardForPreviewHtmlContent = await (MyDatabaseInstance.getInstance()
            .select(MyDatabaseInstance.getInstance().hTMLContents)
          ..where((tbl) => tbl.id.equals(cardForPreview.htmlContent)))
        .getSingle();

    if (cardToEditId == null) {
      await createCardInDb(
          groupId,
          CardDisplayerType.html,
          null,
          HTMLContentsCompanion.insert(
              cardTemplatedJson:
                  drift.Value(cardForPreviewHtmlContent.cardTemplatedJson),
              isTemplated: const drift.Value(false), isAssembly: const drift.Value(false)));
    } else {
      await updateCardInDb(
          groupId,
          CardDisplayerType.html,
          null,
          HTMLContentsCompanion.insert(
              cardTemplatedJson:
                  drift.Value(cardForPreviewHtmlContent.cardTemplatedJson)));
    }

    var ahah = 0;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    widgetState = TemplateCardEditorState();
    return widgetState;
  }

  @override
  Future<void> showCard(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: CustomAppBar(
            title: "Card editor",
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_circle_left_sharp),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
          body: HTMLCardDisplayer(
              isPrintAnswer: true, htmlContentId: cardForPreview.htmlContent),
          drawer: const AppDrawer(),
          persistentFooterButtons: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {},
              foregroundColor: Colors.blue[900],
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
              child: const Icon(FontAwesomeIcons.chartColumn),
            ),
          ],
        ),
      ),
    );
  }
}

class TemplateCardEditorState extends ConsumerState<TemplateCardEditor> {
  //late ReviseCard cardForPreview;
  bool isInitialized = false;
  CardTemplatedBranch cardTemplatedBranchToUpdate = CardTemplatedBranch(null);
  late HTMLCardDisplayer htmlCardDisplayer;

  Future getPreviewCard() async {
    final database = MyDatabaseInstance.getInstance();
    widget.cardForPreview = await (database.select(database.reviseCards)
          ..where((tbl) =>
              tbl.path.equals(AppConstante.templatedPreviewNameKey)))
        .getSingle();
    var test = 0;
  }

  Future<void> update_card() async {
    String value = CardTemplatedBranchToJsonString(
        cardTemplatedBranchToUpdate); //CardTemplatedBranchToJsonString(cardTemplatedBranchToUpdate)

    // On appelle la fonction de mise à jour de la carte
    await widget.cardDao
        .updateCardTemplatedJson(widget.cardForPreview.htmlContent, value);

    // On remet un coup de "getPreviewCard"
    await getPreviewCard();

    htmlCardDisplayer.refresh();
  }

  Future<void> init() async {
    await getPreviewCard();
    if (!isInitialized) {
      if (widget.cardToEditId != null) {
        var cardToEdit = await (MyDatabaseInstance.getInstance()
                .select(MyDatabaseInstance.getInstance().reviseCards)
              ..where((tbl) => tbl.id.equals(widget.cardToEditId!)))
            .getSingle();

        var cardToEditHtmlContent = await (MyDatabaseInstance.getInstance()
                .select(MyDatabaseInstance.getInstance().hTMLContents)
              ..where((tbl) => tbl.id.equals(cardToEdit.htmlContent)))
            .getSingle();

        await widget.cardDao.updateCardTemplatedJson(
            widget.cardForPreview.htmlContent,
            cardToEditHtmlContent.cardTemplatedJson);

        setState(() {
          cardTemplatedBranchToUpdate =
              buildBranch(jsonDecode(cardToEditHtmlContent.cardTemplatedJson));
          cardTemplatedBranchToUpdate.templateName = "NOT NEW";
          ref
              .read(templatedCardProvider.notifier)
              .makeRootCardTemplatedBranchChange();
        });

        var test = 0;
      }

      setState(() {
        isInitialized = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initCardTemplatedBranch(cardTemplatedBranchToUpdate);

    // Map<String, dynamic> json = jsonDecode(completeJsonCardTest);

    // cardTemplatedBranchToUpdate = buildBranch(json);

    var toto = 0;
  }

  @override
  Widget build(BuildContext context) {
    init();

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // if(cardForPreview != null){
    //   widget.cardForPreview = cardForPreview;
    // }

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
                      isPrintAnswer: true, htmlContentId: widget.cardForPreview.htmlContent);
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: htmlCardDisplayer);
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
                    cardTemplatedBranchToUpdate: cardTemplatedBranchToUpdate)),
          )),
        ]));
  }
}

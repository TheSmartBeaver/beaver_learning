import 'dart:convert';
import 'dart:ui';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/providers/templated_card_provider.dart';
import 'package:beaver_learning/src/screens/editors_screen.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/dialog/file_linker/file_linker_to_html_content_dialog.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_form_builder.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:drift/drift.dart' as drift;

class AssemblyEditor extends ConsumerStatefulWidget {
  bool isEditMode = true;
  final cardDao = CardDao(MyDatabaseInstance.getInstance());
  late HTMLContent htmlContentForPreview;
  final int? assemblyToEditId;
  static const routeName = '/assemblyEditorScreen';
  TextEditingController pathController = TextEditingController();

  AssemblyEditor({super.key, this.isEditMode = true, this.assemblyToEditId});

  Future<void> createOrUpdateAssembly() async {
    var cardForPreviewHtmlContent = await (MyDatabaseInstance.getInstance()
            .select(MyDatabaseInstance.getInstance().hTMLContents)
          ..where((tbl) => tbl.id.equals(htmlContentForPreview.id)))
        .getSingle();

    Future<void> linkFilesToHtmlContent(int htmlContentId) async {
      var htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
      var content = await htmlDao.getHtmlContents(htmlContentForPreview.id);
      for (var file in content.files) {
        await htmlDao.createHtmlContentFileContent(htmlContentId, file.id);
      }
    }

    if (assemblyToEditId == null) {
      int assemblyId = await createAssemblyInDb(HTMLContentsCompanion.insert(
          path: drift.Value(pathController.text),
          cardTemplatedJson:
              drift.Value(cardForPreviewHtmlContent.cardTemplatedJson),
          isTemplated: const drift.Value(true),
          isAssembly: const drift.Value(true),
          lastUpdated: getUpdateDateNow()));
      await linkFilesToHtmlContent(assemblyId);
    } else {
      await updateAssemblyInDb(
          assemblyToEditId!,
          HTMLContentsCompanion.insert(
              path: drift.Value(pathController.text),
              cardTemplatedJson:
                  drift.Value(cardForPreviewHtmlContent.cardTemplatedJson),
              lastUpdated: getUpdateDateNow()));
      await linkFilesToHtmlContent(assemblyToEditId!);
    }

    var ahah = 0;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AssemblyEditorState();
  }

  @override
  Future<void> showCard(BuildContext context) async {
    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(htmlContentForPreview.id);
    String recto = content.recto;
    String verso = content.verso;

    var customHtmlString = getCustomHtml(recto, verso, true);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: CustomAppBar(
            title: "Assembly editor",
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_circle_left_sharp),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
          body: HTMLDisplayer(
            htmlContentString: customHtmlString,
            fileContents: content.files,
          ),
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

class AssemblyEditorState extends ConsumerState<AssemblyEditor> {
  //late ReviseCard cardForPreview;
  bool isInitialized = false;
  CardTemplatedBranch cardTemplatedBranchToUpdate = CardTemplatedBranch(null);
  late HTMLCardDisplayer htmlCardDisplayer;
  String assemblyPath = "";

  void onTextChangeListener(String text) {
    assemblyPath = text;
  }

  Future getPreviewHtmlContent() async {
    final database = MyDatabaseInstance.getInstance();
    widget.htmlContentForPreview = await (database.select(database.hTMLContents)
          ..where((tbl) =>
              tbl.path.equals(AppConstante.templatedPreviewNameKey) &
              tbl.isAssembly.equals(true)))
        .getSingle();
    var test = 0;
  }

  Future<void> update_card() async {
    String value = CardTemplatedBranchToJsonString(
        cardTemplatedBranchToUpdate); //CardTemplatedBranchToJsonString(cardTemplatedBranchToUpdate)

    // On appelle la fonction de mise à jour de la carte
    await widget.cardDao
        .updateCardTemplatedJson(widget.htmlContentForPreview.id, value);

    // On remet un coup de "getPreviewCard"
    await getPreviewHtmlContent();

    htmlCardDisplayer.refresh();
  }

  Future<void> init() async {
    await getPreviewHtmlContent();
    if (!isInitialized) {
      if (widget.assemblyToEditId != null) {
        var assemblyToEdit = await (MyDatabaseInstance.getInstance()
                .select(MyDatabaseInstance.getInstance().hTMLContents)
              ..where((tbl) => tbl.id.equals(widget.assemblyToEditId!)))
            .getSingle();

        await widget.cardDao.updateCardTemplatedJson(
            widget.htmlContentForPreview.id, assemblyToEdit.cardTemplatedJson);

        setState(() {
          cardTemplatedBranchToUpdate =
              buildBranch(jsonDecode(assemblyToEdit.cardTemplatedJson));
          cardTemplatedBranchToUpdate.templateName = "NOT NEW";
          ref
              .read(templatedCardProvider.notifier)
              .makeRootCardTemplatedBranchChange();
          assemblyPath = assemblyToEdit.path ?? "";
        });
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

    void onFileLink() {}

    return Scaffold(
      appBar: CustomAppBar(
        title: "Assembly editor",
        actions: [
          IconButton(
            icon: const Icon(Icons.file_copy_rounded),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => FileLinkerToHtmlContentDialog(
                      htmlContentId: widget.htmlContentForPreview.id,
                      onLink: onFileLink));
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () async {
              await widget.showCard(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () async {
              await widget.createOrUpdateAssembly();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => EditorsScreen(
                        initialMenuItem: InternMenuItemEnum.assembly)),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
          child: CustomTextField(
              controller: widget.pathController..text = assemblyPath,
              icon: Icons.abc,
              label: "Assembly Path",
              maxLength: null,
              onChanged: onTextChangeListener),
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              //color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(children: [
              FutureBuilder(
                  future: getPreviewHtmlContent(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      htmlCardDisplayer = HTMLCardDisplayer(
                          isPrintAnswer: true,
                          htmlContentId: widget.htmlContentForPreview.id);
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
                        cardTemplatedBranchToUpdate:
                            cardTemplatedBranchToUpdate)),
              )),
            ]))
      ])),
      drawer: const AppDrawer(),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            // Navigator.pushNamed(context, CardEditorScreen.routeName);
          },
          foregroundColor: Colors.blue[900],
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          child: const Icon(FontAwesomeIcons.chartColumn),
        ),
        FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              //Navigator.pushNamed(context, CardEditorScreen.routeName);
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.redAccent,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.lightbulb)),
        FloatingActionButton(
            onPressed: () {},
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.blueGrey,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.tags))
      ],
    );
  }
}

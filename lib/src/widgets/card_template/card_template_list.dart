import 'package:beaver_learning/src/dao/card_template_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/providers/app_database_provider.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/card_template_html_editor.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardTemplatesList extends ConsumerStatefulWidget {
  static const routeName = '/cardListScreen';
  bool isInitialized = false;
  Function(EditorsState editorsState)?
      setActiveEditorScaffoldPropsInEditorsScreen;

  CardTemplatesList(
      {super.key, this.setActiveEditorScaffoldPropsInEditorsScreen});

  @override
  ConsumerState<CardTemplatesList> createState() {
    return _CardTemplatesListState();
  }
}

Widget packInBox(Widget child) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    ),
  );
}

class _CardTemplatesListState extends ConsumerState<CardTemplatesList> {
  final TextEditingController wordController = TextEditingController();
  late List<CardTemplateData> cardTemplates;
  late List<DropDownItem<int>> groupItems;

  Future<void> init(WidgetRef ref, BuildContext context) async {
    var database = MyDatabaseInstance.getInstance();

    if (!widget.isInitialized) {
      widget.isInitialized = true;
    }

    var cardTemplatesRequest = database.select(database.cardTemplate);
    if(wordController.text.isNotEmpty){
      cardTemplatesRequest.where((cardTemplate) => generateWordWhereClauseForCardTemplate(cardTemplate, wordController.text));
    }
    cardTemplates = await cardTemplatesRequest.get();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterBuild();
    });
  }

  void _afterBuild() {
    var floatingActionButton = [
      FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CardTemplateEditor.routeName);
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      )
    ];

    if (widget.setActiveEditorScaffoldPropsInEditorsScreen != null) {
      widget.setActiveEditorScaffoldPropsInEditorsScreen!(EditorsState(
          actions: null,
          currentEditorTitle: "Card Templates List",
          persistentFooterButtons: floatingActionButton));
    }
  }

  void onCardTemplateLongPressDown(
      int cardTemplateId, BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Modify'),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Remove'),
        ),
      ],
    ).then((value) async {
      if (value == 0) {
        // Logique pour modifier
        onCardTemplateClick(cardTemplateId);
      } else if (value == 1) {
        // Logique pour supprimer
        CardTemplateDao cardTemplateDao =
            CardTemplateDao(MyDatabaseInstance.getInstance());
        await cardTemplateDao.deleteById(cardTemplateId);
        setState(() {
          cardTemplates.removeWhere((element) => element.id == cardTemplateId);
        });
      }
    });
  }

  void onCardTemplateClick(int cardTemplateId) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) =>
              CardTemplateEditor(cardTemplateToEditId: cardTemplateId)),
    );
  }

  void onWordsChange(String value) {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            margin: const EdgeInsets.all(4),
            child: TextField(
              controller: wordController,
              onChanged: onWordsChange,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Words',
              ),
            ),
          ),
          FutureBuilder(
            future: init(ref, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                    // Providing a restorationId allows the ListView to restore the
                    // scroll position when a user leaves and returns to the app after it
                    // has been killed while running in the background.
                    restorationId: 'sampleItemListView',
                    itemCount: cardTemplates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.all(2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            packInBox(Text(
                                "cardId : ${cardTemplates[index].id} \npath : ${cardTemplates[index].path} \nSKU : ${cardTemplates[index].sku}")),
                            GestureDetector(
                                onLongPressDown: (details) {
                                  onCardTemplateLongPressDown(
                                      cardTemplates[index].id,
                                      context,
                                      details.globalPosition);
                                },
                                onTap: () {
                                  onCardTemplateClick(cardTemplates[index].id);
                                },
                                child: const Icon(
                                  Icons.list,
                                  size: 50,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

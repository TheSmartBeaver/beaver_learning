import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/providers/app_database_provider.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardList extends ConsumerStatefulWidget {
  static const routeName = '/cardListScreen';
  final GroupData? initialGroup;
  bool isInitialized = false;
  Function(EditorsState editorsState)?
      setActiveEditorScaffoldPropsInEditorsScreen;

  CardList(
      {super.key,
      this.initialGroup,
      this.setActiveEditorScaffoldPropsInEditorsScreen});

  @override
  ConsumerState<CardList> createState() {
    return _CardListState();
  }
}

List<DropDownItem> items = [
  const DropDownItem("item1", "ITEM 1"),
  const DropDownItem("item2", "ITEM 2")
];

void onGroupSelected(DropDownItem? item) {
  var toto = 0;
}

void onWordSelected(DropDownItem? item) {
  var toto = 0;
}

void onCardSelected(DropDownItem? item) {
  var toto = 0;
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

class _CardListState extends ConsumerState<CardList> {
  final TextEditingController wordController = TextEditingController();
  late List<ReviseCard> cards;
  late List<DropDownItem<int>> groupItems;
  CustomDropdownMenu<int>? groupDropdown;
  Map<int, HTMLContent> htmlContents = {};

  Widget getDropDowns(WidgetRef ref, BuildContext context) {
    List<Widget> getDropDowns2() {
      groupDropdown = CustomDropdownMenu(
        value: widget.initialGroup != null
            ? DropDownItem<int>(
                widget.initialGroup!.title, widget.initialGroup!.id)
            : null,
        items: groupItems,
        label: "Group",
        width: MediaQuery.of(context).size.width,
      );

      return [
        Container(
            margin: const EdgeInsets.all(4),
            child: CustomDropdownMenu(
              items: items,
              label: "Card Type",
              width: MediaQuery.of(context).size.width,
            )),
        Container(margin: const EdgeInsets.all(4), child: groupDropdown)
      ];
    }

    if (!widget.isInitialized) {
      return FutureBuilder(
          future: init(ref, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Column(children: getDropDowns2());
            }
          });
    } else {
      return Column(children: getDropDowns2());
    }
  }

  Future<void> init(WidgetRef ref, BuildContext context) async {
    var database = MyDatabaseInstance.getInstance();

    if (!widget.isInitialized) {
      var groups = await ref.read(appDatabaseProvider.notifier).getAllGroups();
      groupItems = groups.map<DropDownItem<int>>(
        (GroupData gData) {
          return DropDownItem<int>(gData.title, gData.id);
        },
      ).toList();
      widget.isInitialized = true;
    }

    var cardsRequest = database.select(database.reviseCards);
    cardsRequest.where((card) => generateNoTemplatedPreviewWhereClause(card));
    if (widget.initialGroup != null) {
      cardsRequest
          .where((card) => card.groupId.equals(widget.initialGroup!.id));
    }
    try {
      print(cardsRequest);
      cards = await cardsRequest.get();
      if (wordController.text.isNotEmpty) {
        CardDao cardDao = CardDao(MyDatabaseInstance.getInstance());
        cards = await cardDao.removeCardsWithoutProperWordWhereClause(cards, wordController.text);
      }
      print(cardsRequest);
    } catch (e) {
      print(e);
    }
    htmlContents = {};
    for (var card in cards) {
      htmlContents[card.id] = await (database.select(database.hTMLContents)
            ..where((tbl) => tbl.id.equals(card.htmlContent)))
          .getSingle();
      var toto = 0;
    }
    var toto = 0;
    //TODO: Pourquoi refait t'on cette appel quand on est dans écran création carte
  }

  void onCardLongPressDown(int cardId, BuildContext context, Offset position) {
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
        onCardClick(cardId);
      } else if (value == 1) {
        // Logique pour supprimer
        CardDao cardDao = CardDao(MyDatabaseInstance.getInstance());
        await cardDao.deleteById(cardId);
        setState(() {
          cards.removeWhere((element) => element.id == cardId);
        });
      }
    });
  }

  void onCardClick(int cardId) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => CardEditorScreen(cardToEditId: cardId)),
    );
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
          Navigator.pushNamed(context, CardEditorScreen.routeName);
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
          currentEditorTitle: "Cards List",
          persistentFooterButtons: floatingActionButton));
    }
  }

  void onWordsChange(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          getDropDowns(ref, context),
          const SizedBox(height: 6),
          Container(
            margin: const EdgeInsets.all(4),
            child: TextField(
              onChanged: onWordsChange,
              controller: wordController,
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
                    itemCount: cards.length,
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
                                "cardId : ${cards[index].id} isAssembly : ${htmlContents[cards[index].id]?.isAssembly}")),
                            packInBox(Text(htmlContents[cards[index].id]
                                    ?.cardTemplatedJson ??
                                '')),
                            GestureDetector(
                                onLongPressDown: (details) {
                                  onCardLongPressDown(cards[index].id, context,
                                      details.globalPosition);
                                },
                                onTap: () {
                                  onCardClick(cards[index].id);
                                },
                                child: const Icon(
                                  Icons.list,
                                  size: 50,
                                ))
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

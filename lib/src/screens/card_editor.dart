import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/providers/app_database_provider.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/html_card_editor.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/mnemotechnic_dialog.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/template-build/template_card_editor.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beaver_learning/data/constants.dart';

class CardEditorScreen extends ConsumerStatefulWidget {
  CardEditorScreen({super.key, this.cardToEditId});

  final String title = AppConstante.AppTitle;
  static const routeName = '/cardEditorScreen';
  final int? cardToEditId;

  late List<DropDownItem<int>> groupItems;
  CustomDropdownMenu<int>? groupDropdown;
  late List<DropDownItem<CardDisplayerType>> cardDiplayerTypeItems;
  CustomDropdownMenu<CardDisplayerType>? cardDiplayerTypeDropdown;

  final TextEditingController cardTypeController = TextEditingController();

  bool isInitialized = false;

  @override
  ConsumerState<CardEditorScreen> createState() => _CardEditorScreenState();
}

List<DropDownItem> items = [
  const DropDownItem("item1", "ITEM 1"),
  const DropDownItem("item2", "ITEM 2")
];

class _CardEditorScreenState extends ConsumerState<CardEditorScreen> {
  int? initialCardGroupId;

  Future<void> init(WidgetRef ref, BuildContext context) async {
    if (!widget.isInitialized) {
      //Group
      var groups = await ref.read(appDatabaseProvider.notifier).getAllGroups();
      widget.groupItems = groups.map<DropDownItem<int>>(
        (GroupData gData) {
          return DropDownItem<int>(gData.title, gData.id);
        },
      ).toList();

      //Card displayer types
      widget.cardDiplayerTypeItems =
          CardDisplayerType.values.map<DropDownItem<CardDisplayerType>>(
        (CardDisplayerType cdt) {
          return DropDownItem<CardDisplayerType>(cdt.name, cdt);
        },
      ).toList();

      if (widget.cardToEditId != null) {
        CardDao cardDao = CardDao(MyDatabaseInstance.getInstance());
        ReviseCard card = await cardDao.getCardById(widget.cardToEditId!);
        initialCardGroupId = card.groupId;
      }

      widget.isInitialized = true;
    }
  }

  Widget getDropDowns(WidgetRef ref, BuildContext context) {
    List<Widget> getDropDowns2() {
      DropDownItem<int>? dropDownItem;
      try {
        dropDownItem = widget.groupItems.firstWhere(
            (element) => element.value == initialCardGroupId);
      } catch (e) {}

      widget.groupDropdown = CustomDropdownMenu(
        items: widget.groupItems,
        label: "Group",
        value: dropDownItem,
        width: MediaQuery.of(context).size.width,
      );

      widget.cardDiplayerTypeDropdown = CustomDropdownMenu(
        items: widget.cardDiplayerTypeItems,
        label: "Card displayer type",
        width: MediaQuery.of(context).size.width,
      );

      return [
        Container(
            margin: const EdgeInsets.all(4),
            child: widget.cardDiplayerTypeDropdown),
        Container(margin: const EdgeInsets.all(4), child: widget.groupDropdown)
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

  @override
  Widget build(BuildContext context) {
    //CardEditorInterface editorToRender = HtmlCardEditor();
    CardEditorInterface editorToRender =
        TemplateCardEditor(cardToEditId: widget.cardToEditId);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Card editor",
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () async {
              editorToRender.showCard(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () async {
              int? groupId = widget.groupDropdown?.getValue()?.value;
              if (groupId != null) {
                await editorToRender.createOrUpdateCard(groupId);
                Navigator.pushNamed(context, CardList.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a group")));
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child:
              Column(children: [getDropDowns(ref, context), editorToRender])),
      drawer: const AppDrawer(),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            Navigator.pushNamed(context, CardEditorScreen.routeName);
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
            onPressed: () {
              if(widget.cardToEditId != null){
                showDialog(
                  context: context,
                  builder: (context) => MnemotechnicDialog(cardId: widget.cardToEditId!),
                );
              }
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.blueGrey,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.tags))
      ],
    );
  }
}

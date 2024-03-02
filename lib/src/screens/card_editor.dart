import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/providers/app_database_provider.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/card_editor_interface.dart';
import 'package:beaver_learning/src/widgets/card/card_editor.dart/html_card_editor.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beaver_learning/data/constants.dart';

class CardEditorScreen extends ConsumerStatefulWidget {
  CardEditorScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/cardEditorScreen';

  late List<DropDownItem<int>> groupItems;

  final TextEditingController cardTypeController = TextEditingController();
  CustomDropdownMenu<int>? groupDropdown;
  bool isInitialized = false;

  Future<void> init(WidgetRef ref, BuildContext context) async {
    if (!isInitialized) {
      var groups = await ref.read(appDatabaseProvider.notifier).getAllGroups();
      groupItems = groups.map<DropDownItem<int>>(
        (GroupData gData) {
          return DropDownItem<int>(gData.title, gData.id);
        },
      ).toList();
      isInitialized = true;
    }
  }

  @override
  ConsumerState<CardEditorScreen> createState() => _CardEditorScreenState();
}

List<DropDownItem> items = [
  const DropDownItem("item1", "ITEM 1"),
  const DropDownItem("item2", "ITEM 2")
];

class _CardEditorScreenState extends ConsumerState<CardEditorScreen> {
  Widget getDropDowns(WidgetRef ref, BuildContext context) {
    List<Widget> getDropDowns2() {
      widget.groupDropdown = CustomDropdownMenu(
        items: widget.groupItems,
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
        Container(margin: const EdgeInsets.all(4), child: widget.groupDropdown)
      ];
    }

    if (!widget.isInitialized) {
      return FutureBuilder(
          future: widget.init(ref, context),
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
    CardEditorInterface editorToRender = HtmlCardEditor();

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () async {
              int groupId = widget.groupDropdown!.getValue()!.value;
              await editorToRender.createCard(groupId);
              Navigator.pushNamed(context, CardList.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: Column(children: [getDropDowns(ref, context), editorToRender]),
      ),
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
              Navigator.pushNamed(context, CardEditorScreen.routeName);
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.redAccent,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.lightbulb)),
        FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, CardEditorScreen.routeName);
            },
            foregroundColor: Colors.yellow[400],
            backgroundColor: Colors.blueGrey,
            shape: const CircleBorder(),
            child: const Icon(FontAwesomeIcons.tags))
      ],
    );
  }
}

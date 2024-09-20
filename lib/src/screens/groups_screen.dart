import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/widgets/group/group_editor.dart';
import 'package:beaver_learning/src/widgets/group/group_list.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
//import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupsList extends ConsumerStatefulWidget {
  GroupsList({super.key, required this.setActiveEditorScaffoldPropsInEditorsScreen});

  final String title = "Groups list";
  static const routeName = '/groupScreen';

  @override
  ConsumerState<GroupsList> createState() => _GroupScreenState();

  Function(EditorsState editorsState) setActiveEditorScaffoldPropsInEditorsScreen;
}

class _GroupScreenState extends ConsumerState<GroupsList> {
  List<DropDownItem> items = [
    const DropDownItem("item1", "ITEM 1"),
    const DropDownItem("item2", "ITEM 2")
  ];

  late List<GroupData> groups;

  init() async {
    final database = MyDatabaseInstance.getInstance();
    groups = await (database.select(database.group)
          ..where((group) => group.parentId.isNull()))
        .get();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterBuild();
    });
  }

  void _afterBuild() {

    var persistentFooterButtons = [FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, GroupEditor.routeName);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        )];


    widget.setActiveEditorScaffoldPropsInEditorsScreen(EditorsState(
        actions: null,
        currentEditorTitle: widget.title,
        persistentFooterButtons: persistentFooterButtons));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Center(
        child: Column(
      children: [
        CustomDropdownMenu(
          items: items,
          label: "Tags",
          width: MediaQuery.of(context).size.width / 2,
        ),
        const SizedBox(height: 6),
        Container(
            margin: const EdgeInsets.all(4),
            child: const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Words',
              ),
            )),
        FutureBuilder(
            future: init(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                return const CircularProgressIndicator();
              } else {
                return Expanded(child: GroupList(groups: groups));
              }
            }),
      ],
    ));
  }
}

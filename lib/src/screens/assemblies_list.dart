import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/providers/app_database_provider.dart';
import 'package:beaver_learning/src/screens/assembly_editor.dart';
import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssembliesList extends ConsumerStatefulWidget {
  static const routeName = '/assembliesListScreen';
  bool isInitialized = false;
  Function(EditorsState editorsState)?
      setActiveEditorScaffoldPropsInEditorsScreen;

  AssembliesList({super.key, this.setActiveEditorScaffoldPropsInEditorsScreen});

  @override
  ConsumerState<AssembliesList> createState() {
    return _AssembliesListState();
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

class _AssembliesListState extends ConsumerState<AssembliesList> {
  final TextEditingController wordController = TextEditingController();
  late List<HTMLContent> assemblies;
  late List<DropDownItem<int>> groupItems;
  CustomDropdownMenu<int>? groupDropdown;
  Map<int, HTMLContent> htmlContents = {};

  Future<void> init(WidgetRef ref, BuildContext context) async {
    var database = MyDatabaseInstance.getInstance();

    if (!widget.isInitialized) {
      widget.isInitialized = true;
    }

    var htmlContentsRequest = database.select(database.hTMLContents);
    htmlContentsRequest.where(
        (assembly) => assembly.isAssembly.equals(true));
    htmlContentsRequest.where(
        (assembly) => generateNoPrivateItemsWhereClauseForHtmlContent(assembly));

    assemblies = await htmlContentsRequest.get();
    htmlContents = {};
    for (var assembly in assemblies) {
      htmlContents[assembly.id] = await (database.select(database.hTMLContents)
            ..where((tbl) => tbl.id.equals(assembly.id)))
          .getSingle();
    }
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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AssemblyEditor()),
          );
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
          currentEditorTitle: "Assemblies List",
          persistentFooterButtons: floatingActionButton));
    }
  }

  void onAssemblyLongPressDown(
      int assemblyId, BuildContext context, Offset position) {
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
        onAssemblyClick(assemblyId);
      } else if (value == 1) {
        // Logique pour supprimer
        HtmlDao htmlDao =
            HtmlDao(MyDatabaseInstance.getInstance());
        await htmlDao.deleteById(assemblyId);
        setState(() {
          assemblies.removeWhere((element) => element.id == assemblyId);
        });
      }
    });
  }

  void onAssemblyClick(int assemblyId) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) =>
              AssemblyEditor(assemblyToEditId: assemblyId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: TextField(
              obscureText: true,
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
                    restorationId: 'assembliesListView',
                    itemCount: assemblies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => AssemblyEditor(
                                      assemblyToEditId: assemblies[index].id)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.all(2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                packInBox(Text(
                                    "cardId : ${assemblies[index].id} isAssembly : ${htmlContents[assemblies[index].id]?.isAssembly}")),
                                packInBox(Text(
                                    htmlContents[assemblies[index].id]
                                            ?.cardTemplatedJson ??
                                        '')),
                                GestureDetector(
                                onLongPressDown: (details) {
                                  onAssemblyLongPressDown(
                                      assemblies[index].id,
                                      context,
                                      details.globalPosition);
                                },
                                onTap: () {
                                  onAssemblyClick(assemblies[index].id);
                                },
                                child: const Icon(
                                  Icons.list,
                                  size: 50,
                                )),
                              ],
                            ),
                          ));
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

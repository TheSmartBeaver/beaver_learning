import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/form-styles.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';

class GroupEditor extends StatefulWidget {
  final String title = AppConstante.AppTitle;
  static const routeName = '/groupEditorScreen';
  bool isEditMode = false;

  GroupEditor({super.key});
  GroupEditor.fromExistingGroup(GroupData group, {super.key}) {
    isEditMode = true;
  }

  @override
  State<GroupEditor> createState() {
    return _GroupEditorState();
  }
}

class _GroupEditorState extends State<GroupEditor> {
  TextEditingController nameController = TextEditingController();
  final database = MyDatabaseInstance.getInstance();

  late List<GroupData> possibleGroups;
  GroupData? _selectedParent;

  init() async {
    possibleGroups = await database.select(database.group).get();
  }

  Future<void> createGroup() async {
    createGroupInDb(GroupCompanion.insert(
        path: const drift.Value(null),
        title: nameController.text,
        tags: 'toto;ahah',
        parentId: drift.Value(_selectedParent?.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Deck editor",
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () async {
              await createGroup();
              Navigator.pushReplacementNamed(context, GroupScreen.routeName);
            },
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: GlobalKey<FormState>(),
            child: Column(
              children: [
                CustomTextField(
                    controller: nameController,
                    label: "Group name",
                    icon: Icons.text_fields_sharp,
                    maxLength: 50),
                FutureBuilder(
                    future: init(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                        return const CircularProgressIndicator();
                      } else {
                        return DropdownButtonFormField(
                          value: _selectedParent,
                          decoration: InputDecoration(
                            labelText: "Parent group",
                            prefixIcon: Icon(Icons.run_circle_outlined),
                            border: myinputborder,
                            enabledBorder: myinputborder,
                            focusedBorder: myfocusborder,
                          ),
                          items: [
                            for (final possibleGroup in possibleGroups) //
                              DropdownMenuItem(
                                value: possibleGroup,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      color: const Color.fromARGB(
                                          255, 0, 255, 128),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(possibleGroup.title)
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedParent = value;
                            });
                          },
                        );
                      }
                    }),
              ],
            ),
          )),
    );
  }
}

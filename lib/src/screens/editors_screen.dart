import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/screens/assemblies_list.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/card_template/card_template_list.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditorsScreen extends ConsumerStatefulWidget {
  EditorsScreen({super.key, this.initialMenuItem, this.initialGroupData});

  static const routeName = '/editorsScreen';
  InternMenuItemEnum? initialMenuItem;
  GroupData? initialGroupData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return EditorsScreenState();
  }
}

class InternMenuItem {
  InternMenuItemEnum id;
  String title;
  Color color;
  bool isActivated;
  EditorsScreenState editorsScreen;

  InternMenuItem(
      this.id, this.title, this.color, this.isActivated, this.editorsScreen);
}

class InternMenuItemWidget extends ConsumerStatefulWidget {
  InternMenuItemEnum id;
  String title;
  Color color;
  bool isActivated;
  EditorsScreenState editorsScreen;

  InternMenuItemWidget(
      this.id, this.title, this.color, this.isActivated, this.editorsScreen,
      {super.key});

  static create(InternMenuItem item) {
    InternMenuItemWidget widget = InternMenuItemWidget(
        item.id, item.title, item.color, item.isActivated, item.editorsScreen);
    return widget;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InternMenuItemWidgetState();
  }
}

class InternMenuItemWidgetState extends ConsumerState<InternMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: widget.isActivated ? 5 : 1,
              color: widget.isActivated ? Colors.green : Colors.black),
          borderRadius: BorderRadius.circular(8),
          color: widget.color,
        ),
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () {
              widget.editorsScreen.onMenuItemSelected(widget.id);
            },
            child: Text(widget.title)));
  }
}

enum InternMenuItemEnum { card, group, template, assembly }

class EditorsScreenState extends ConsumerState<EditorsScreen> {
  late List<InternMenuItem> items;
  Widget? rightEditor;
  List<Widget>? persistentFooterButtons = [];
  String? currentEditorTitle;

  @override
  void initState() {
    super.initState();
    items = [
      InternMenuItem(InternMenuItemEnum.card, 'Card', Colors.blue, true, this),
      InternMenuItem(
          InternMenuItemEnum.group, 'Group', Colors.green, false, this),
      InternMenuItem(
          InternMenuItemEnum.template, 'Template', Colors.red, false, this),
      InternMenuItem(
          InternMenuItemEnum.assembly, 'Assembly', Colors.yellow, false, this),
    ];

    if(widget.initialMenuItem != null) {
      onMenuItemSelected(widget.initialMenuItem!);
    }
  }

  void onMenuItemSelected(InternMenuItemEnum id) {
    setState(() {
      items.forEach((element) {
        element.isActivated = element.id == id;
      });
    });
  }

  void setActiveEditorScaffoldPropsInEditorsScreen(EditorsState editorsState) {
    setState(() {
      currentEditorTitle = editorsState.currentEditorTitle;
      persistentFooterButtons = editorsState.persistentFooterButtons;
    });
  }

  void getRightEditor() {
    var selectedInternMenuItem =
        items.firstWhere((element) => element.isActivated).id;
    switch (selectedInternMenuItem) {
      case InternMenuItemEnum.card:
        rightEditor = CardList(
          initialGroup: widget.initialGroupData,
            setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemEnum.group:
        rightEditor = GroupsList(
            setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemEnum.template:
        rightEditor = CardTemplatesList(
            setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemEnum.assembly:
        rightEditor = AssembliesList(setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    getRightEditor();

    return Scaffold(
        appBar: CustomAppBar(title: currentEditorTitle ?? ""),
        drawer: const AppDrawer(),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(), shape: BoxShape.rectangle),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                    maxHeight: 50.0,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: items
                        .map<Widget>((item) => Center(
                                child: InternMenuItemWidget.create(
                              item,
                            )))
                        .toList(),
                  ))),
          Expanded(child: rightEditor as Widget? ?? Container())
        ]),
        persistentFooterButtons: persistentFooterButtons);
  }
}

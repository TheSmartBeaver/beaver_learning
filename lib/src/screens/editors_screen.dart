import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:beaver_learning/src/screens/groups_screen.dart';
import 'package:beaver_learning/src/screens/interfaces/editors_state.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditorsScreen extends ConsumerStatefulWidget {
  const EditorsScreen({Key? key}) : super(key: key);

  static const routeName = '/editorsScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return EditorsScreenState();
  }
}

class InternMenuItem {
  InternMenuItemMenu id;
  String title;
  Color color;
  bool isActivated;
  EditorsScreenState editorsScreen;

  InternMenuItem(
      this.id, this.title, this.color, this.isActivated, this.editorsScreen);
}

class InternMenuItemWidget extends ConsumerStatefulWidget {
  InternMenuItemMenu id;
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

enum InternMenuItemMenu { card, group, template, assembly }

class EditorsScreenState extends ConsumerState<EditorsScreen> {
  late List<InternMenuItem> items;
  Widget? rightEditor;
  List<Widget>? persistentFooterButtons = [];
  String? currentEditorTitle;

  @override
  void initState() {
    super.initState();
    items = [
      InternMenuItem(InternMenuItemMenu.card, 'Card', Colors.blue, true, this),
      InternMenuItem(
          InternMenuItemMenu.group, 'Group', Colors.green, false, this),
      InternMenuItem(
          InternMenuItemMenu.template, 'Template', Colors.red, false, this),
      InternMenuItem(
          InternMenuItemMenu.assembly, 'Assembly', Colors.yellow, false, this),
      InternMenuItem(InternMenuItemMenu.card, 'Card', Colors.blue, true, this),
      InternMenuItem(
          InternMenuItemMenu.group, 'Group', Colors.green, false, this),
      InternMenuItem(
          InternMenuItemMenu.template, 'Template', Colors.red, false, this),
    ];
  }

  void onMenuItemSelected(InternMenuItemMenu id) {
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
      case InternMenuItemMenu.card:
        rightEditor = CardList(setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemMenu.group:
        rightEditor = GroupsList(
            setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemMenu.template:
        rightEditor = CardList(setActiveEditorScaffoldPropsInEditorsScreen:
                setActiveEditorScaffoldPropsInEditorsScreen);
      case InternMenuItemMenu.assembly:
        rightEditor = GroupsList(
            setActiveEditorScaffoldPropsInEditorsScreen:
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

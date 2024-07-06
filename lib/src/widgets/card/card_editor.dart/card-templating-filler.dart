// Le widget qui servira à remplir la template
// Le widget qu'on affichera dans card editor.dart

import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardTemplatingFiller extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CardTemplatingFillerState();
  }
}

class _CardTemplatingFillerState extends ConsumerState<CardTemplatingFiller> {
  Map<String, TextEditingController> argControllers = {};
  List<Widget> textfields = [];
  List<DropDownItem<String>> items = [];

  generateParametersFields(List<String> args) {
    for (var arg in args) {
      var tfController = TextEditingController();
      argControllers[arg] = tfController;

      textfields.add(TextField(
        maxLines: 5,
        minLines: 5,
        controller: tfController,
        decoration: const InputDecoration(
            labelText: 'Verso',
            fillColor: Color.fromARGB(19, 207, 138, 128),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.red, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(2)))),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Template filler",
          actions: [],
        ),
        body: Column(children: [
          Row(children: [
            CustomDropdownMenu<String>(items: items, label: "Choose template"),
            ElevatedButton(onPressed: () => {}, child: const Text("Preview"))
          ]),
          ...textfields
        ]),
        drawer: const AppDrawer());
  }
}

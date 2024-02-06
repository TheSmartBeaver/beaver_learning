import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';

class GroupEditorScreen extends StatefulWidget {
  const GroupEditorScreen({super.key});

  final String title = "My Learning App";
  static const routeName = '/groupEditorScreen';

  @override
  State<GroupEditorScreen> createState() => _GroupEditorScreenState();
}

class _GroupEditorScreenState extends State<GroupEditorScreen> {
  List<DropDownItem> items = [
    const DropDownItem("item1", "ITEM 1"),
    const DropDownItem("item2", "ITEM 2")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Column(
          children: [
            CustomDropdown(
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
            GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(courses[index].name),
                          ],
                        )),
                        Container(
                          margin: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.deepOrange,
                              ),
                              Text('${courses[index].price} €',
                                  style: const TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, GroupEditorScreen.routeName);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        drawer: const AppDrawer());
  }
}

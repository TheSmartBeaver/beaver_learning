import 'package:beaver_learning/src/widgets/course/summary_creator.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/queel_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseCreatorScreen extends ConsumerStatefulWidget {

  static const routeName = "/course-creator";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CourseCreatorState();
  }
  
}

class _CourseCreatorState extends ConsumerState<CourseCreatorScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "widget.title",
        actions: [
        ],
      ),
      body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text("Title", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              IconButton(onPressed: () => {
                print("Edit title")
              }, icon: const Icon(Icons.edit))
            ]),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder()
              ),
            ),
          ), 
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MyQueelEditor("", isEditionMode: true),
                    ),
                  );
              }, icon: const Icon(Icons.edit))
            ]),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder()
              ),
            ),
          ),
          SummaryCreator() 
        ],
      )),
      drawer: const AppDrawer()
      ); 
  }
  
}
QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      // locale: Locale('en'),
    );
  }

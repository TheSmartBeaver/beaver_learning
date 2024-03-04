import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/course/course_summary.dart';
import 'package:beaver_learning/src/widgets/group/group_list.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/form-styles.dart';
import 'package:flutter/material.dart';

class CourseDetail extends StatefulWidget {
  final String title = AppConstante.AppTitle;
  const CourseDetail({Key? key}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<GroupData> groups = [];

  init() async {
    final database = MyDatabaseInstance.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.title,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Text("TITRE", style: const TextStyle(fontSize: 24)),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RevisorDisplayer(initialcards: []),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen)),
                child: const Text("Revise course",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CourseSummary(),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.redAccent)),
                child: const Text("Course topics",
                    style: TextStyle(color: Colors.black))),
            Container(
                margin: const EdgeInsets.all(4),
                
                child: containerWithLabel(
                    label: "Description",
                    body: Container(
                        margin: const EdgeInsets.all(4),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: const Text("FULL DESCRIPTION\nFULL DESCRIPTION\nFULL DESCRIPTION")))),
            FutureBuilder(
                future: init(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                        margin: const EdgeInsets.all(4),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: containerWithLabel(
                            label: "Course groups",
                            body: GroupList(groups: groups)));
                  }
                })
          ],
        ),
        drawer: const AppDrawer());
  }
}

import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

class Topic {
  final String name;
  final List<Topic> childrenTopics;

  Topic(this.name, this.childrenTopics);
}

class CourseSummary extends StatefulWidget {
  static const routeName = '/courseScreen';

  Topic summary = Topic("Foot Course", [
    Topic("basics", [
      Topic("basics 1", []),
      Topic("basics 2", [Topic("basics 2.1", []), Topic("basics 2.2", [])])
    ]),
    Topic("advanced 1", [
      Topic("advanced 1", []),
      Topic(
          "advanced 2", [Topic("advanced 2.1", []), Topic("advanced 2.2", [])])
    ]),
  ]);

  Topic englishCourse = Topic("Cours d'anglais", [
    Topic("Bases", [
      Topic("Introduction à l'anglais", []),
      Topic("Les bases de la grammaire", [
        Topic("Les articles", []),
        Topic("Les pronoms", []),
        Topic("Les verbes", []),
        // Vous pouvez ajouter d'autres sous-thèmes ici
      ]),
      Topic("Vocabulaire de base", [
        Topic("Les chiffres et les nombres", []),
        Topic("Les jours de la semaine", []),
        Topic("Les mois de l'année", []),
        // Ajoutez d'autres sous-thèmes de vocabulaire ici
      ]),
    ]),
    Topic("Avancé", [
      Topic("Conversation avancée", [
        Topic("Dialogues et expressions courantes", []),
        Topic("Débats et discussions", []),
        // Vous pouvez ajouter d'autres sous-thèmes ici
      ]),
      Topic("Grammaire avancée", [
        Topic("Temps verbaux", []),
        Topic("Les propositions subordonnées", []),
        // Ajoutez d'autres sous-thèmes de grammaire ici
      ]),
      Topic("Vocabulaire avancé", [
        Topic("Idiomes et expressions idiomatiques", []),
        Topic("Termes techniques et professionnels", []),
        // Ajoutez d'autres sous-thèmes de vocabulaire ici
      ]),
    ]),
  ]);

  CourseSummary({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CourseSummaryState();
  }
}

Widget _renderButton() {
  return GestureDetector(
      onTap: () {
        print("Container clicked");
      },
      child: Container(
        //width: 30,
        margin: EdgeInsets.only(left: 4, right: 4),
        //decoration: BoxDecoration(border: Border.all()),
        child: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
      ));
}

Widget _renderButton2() {
  return GestureDetector(
      onTap: () {
        print("Container clicked");
      },
      child: Container(
        //width: 30,
        margin: EdgeInsets.only(left: 4, right: 4),
        //decoration: BoxDecoration(border: Border.all()),
        child: const Icon(Icons.sd_card_outlined, color: Colors.deepPurple),
      ));
}

Widget _renderTopicBlock(Topic topic) {
  List<Widget> childrenRendered = [];
  for (var child in topic.childrenTopics) {
    childrenRendered.add(_renderTopicBlock(child));
  }
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    Container(
      alignment: Alignment.topLeft,
      child:
          Row(children: [Text(topic.name), _renderButton(), _renderButton2()]),
    ),
    Container(
      padding: EdgeInsets.only(left: 15),
      child: Column(children: childrenRendered),
    )
  ]);
}

class _CourseSummaryState extends State<CourseSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Summary'),
        ),
        body: _renderTopicBlock(widget.englishCourse),
        drawer: const AppDrawer());
    //body: Text("aaaa"));
  }
}

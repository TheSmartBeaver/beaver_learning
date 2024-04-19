import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/widget/topic2.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class SummaryCreator extends StatefulWidget {
  SummaryCreator({Key? key}) : super(key: key);

  @override
  _SummaryCreatorState createState() => _SummaryCreatorState();
}

class _SummaryCreatorState extends State<SummaryCreator> {
  List<Topic> topics = [];
  int counter = 0;

  Widget _getPopupMenu(BuildContext context, int topicId) {
    return Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 4),
        child: PopupMenuButton<MenuOption>(
          onSelected: (MenuOption result) {
            // Gérer les actions en fonction de la sélection
            switch (result) {
              case MenuOption.add_sub_topic:
                counter++;
                setState(() {
                  topics.add(Topic(
                      path: null,
                      id: counter,
                      title: "NEW TOPIC $counter",
                      parentCourseId: -1,
                      parentId: topicId > 0 ? topicId : null,));
                });
                break;
              case MenuOption.rename_topic:
                // Action 2
                break;
              case MenuOption.ref_course_support:
                // Action 3
                break;
              case MenuOption.ref_card_pack:
                // Action 4
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(
              child: Text('Ajouter un sous-topic'),
              value: MenuOption.add_sub_topic,
            ),
            PopupMenuItem(
              child: Text('Modifier nom topic'),
              value: MenuOption.rename_topic,
            ),
            PopupMenuItem(
              child: Text('Référencer support de cours'),
              value: MenuOption.ref_course_support,
            ),
            PopupMenuItem(
              child: Text('Référencer paquet de cartes'),
              value: MenuOption.ref_card_pack,
            ),
          ],
        ));
  }

  Widget _renderTopicBlock(Topic2 topic) {
    List<Widget> childrenRendered = [];
    for (var child in topic.childrenTopics) {
      childrenRendered.add(_renderTopicBlock(child));
    }
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)),
        child:
            Row(children: [Text(topic.name), _getPopupMenu(context, topic.id)]),
      ),
      Container(
        padding: EdgeInsets.only(left: 15),
        child: Column(children: childrenRendered),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var topics2 = buildTopic2(topics);
    var topic3 = Topic2(-1, 'COURSE TITLE', topics2);
    return Container(
        margin: const EdgeInsets.all(10), child: _renderTopicBlock(topic3));
  }
}

enum MenuOption {
  add_sub_topic,
  rename_topic,
  ref_course_support,
  ref_card_pack
}

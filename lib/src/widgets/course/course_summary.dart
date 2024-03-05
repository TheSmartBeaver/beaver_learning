import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

class Topic2 {
  final int id;
  final String name;
  final List<Topic2> childrenTopics;
  int? parentId;

  Topic2(this.id, this.name, this.childrenTopics, {this.parentId});

  Topic2 deepCopy() {
  // Create a new Person object with the same properties
  Topic2 copy = Topic2(id, name, childrenTopics, parentId: parentId);
  return copy;
}
}

class CourseSummary extends StatefulWidget {
  static const routeName = '/courseScreen';
  final Course course;
  final List<Topic> topics;

  // Topic2 summary = Topic2("Foot Course", [
  //   Topic2("basics", [
  //     Topic2("basics 1", []),
  //     Topic2("basics 2", [Topic2("basics 2.1", []), Topic2("basics 2.2", [])])
  //   ]),
  //   Topic2("advanced 1", [
  //     Topic2("advanced 1", []),
  //     Topic2(
  //         "advanced 2", [Topic2("advanced 2.1", []), Topic2("advanced 2.2", [])])
  //   ]),
  // ]);

  CourseSummary({super.key, required this.course, required this.topics});



  @override
  State<StatefulWidget> createState() {
    return _CourseSummaryState();
  }
}

//une fonction qui convertit List<Topic> List<Topic2>
List<Topic2> buildTopic2(List<Topic> topics) {
  // List<Topic2> topics2 = topics.map((e) => Topic2(e.id ,e.title, [], parentId: e.parentId)).toList();
  // for (var topic in topics2) {
  //   if(topic.parentId != null){
  //     topics2.firstWhere((element) => element.id == topic.parentId).childrenTopics.add(topic.deepCopy());
  //     //topics2.remove(topic);
  //   }
  // }

  List<Topic2> topics2 = [];

  void setDirectChildren(Topic2 parent, List<Topic> topics){
    for(var topic in topics.where((element) => element.parentId == parent.id)){
      parent.childrenTopics.add(Topic2(topic.id, topic.title, [], parentId: topic.parentId));
      setDirectChildren(parent.childrenTopics.last, topics);
    }
  }

  for(var rootTopic in topics.where((element) => element.parentId == null)){
    var topic2 = Topic2(rootTopic.id ,rootTopic.title, [], parentId: rootTopic.parentId);
    setDirectChildren(topic2, topics);
    topics2.add(topic2);
  }

  return topics2;
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

Widget _renderTopicBlock(Topic2 topic) {
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
    var topics2 = buildTopic2(widget.topics);
    var topic3 = Topic2(-1, widget.course.title, topics2);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Summary'),
        ),
        body: _renderTopicBlock(topic3),
        drawer: const AppDrawer());
    //body: Text("aaaa"));
  }
}

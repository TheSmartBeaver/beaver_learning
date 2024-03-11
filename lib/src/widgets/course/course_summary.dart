import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/widget/topic2.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

class CourseSummary extends StatefulWidget {
  static const routeName = '/courseScreen';
  final Course course;
  final List<Topic> topics;

  CourseSummary({super.key, required this.course, required this.topics});



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

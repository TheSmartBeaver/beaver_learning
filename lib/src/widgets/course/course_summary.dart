import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/widget/topic2.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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

Widget _renderButton(BuildContext context, int? fileId) {
  return fileId !=null ? GestureDetector(
      onTap: () async {
        var database = MyDatabaseInstance.getInstance();
        var filecontent = await (database.select(database.fileContents)..where((tbl) => tbl.id.equals(fileId))).getSingle();
        Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => PDFViewer(pdfBytes: filecontent.content)),
                              );
      },
      child: Container(
        //width: 30,
        margin: EdgeInsets.only(left: 4, right: 4),
        //decoration: BoxDecoration(border: Border.all()),
        child: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
      )) : Container();
}

Widget _renderButton2(BuildContext context, int? groupId) {
  return groupId !=null ? GestureDetector(
      onTap: () {
         
      },
      child: Container(
        //width: 30,
        margin: EdgeInsets.only(left: 4, right: 4),
        //decoration: BoxDecoration(border: Border.all()),
        child: const Icon(Icons.sd_card_outlined, color: Colors.deepPurple),
      )) : Container();
}

Widget _renderTopicBlock(Topic2 topic, BuildContext context ) {
  List<Widget> childrenRendered = [];
  for (var child in topic.childrenTopics) {
    childrenRendered.add(_renderTopicBlock(child, context));
  }
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    Container(
      alignment: Alignment.topLeft,
      child:
          Row(children: [Text(topic.name), _renderButton(context, topic.fileId), _renderButton2(context, topic.groupId)]),
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
        body: _renderTopicBlock(topic3, context),
        drawer: const AppDrawer());
    //body: Text("aaaa"));
  }
}

class PDFViewer extends StatelessWidget {
  final Uint8List pdfBytes;

  PDFViewer({required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        pdfData: pdfBytes,
      ),
    );
  }
}

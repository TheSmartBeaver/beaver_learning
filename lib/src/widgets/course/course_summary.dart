import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/widget/topic2.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:beaver_learning/src/utils/templated_render_manager.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_displayer.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

Widget _renderViewPdfSupportButton(BuildContext context, int? fileId) {
  return fileId != null
      ? GestureDetector(
          onTap: () async {
            var database = MyDatabaseInstance.getInstance();
            var filecontent = await (database.select(database.fileContents)
                  ..where((tbl) => tbl.id.equals(fileId)))
                .getSingle();
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
          ))
      : Container();
}

Widget _renderViewHtmlSupportButton(BuildContext context, int? htmlContentId) {
  return htmlContentId != null
      ? GestureDetector(
          onTap: () async {

            HTMLContentWithFileContents hTMLContentWithFileContents = await getHtmlContentAndFileContentByHtmlContentId(htmlContentId);
            
            TemplatedRendererManager templatedCardRendererManager = TemplatedRendererManager(htmlContent: hTMLContentWithFileContents.htmlContent, contentFiles: hTMLContentWithFileContents.files);
            // TODO: Faire la gestion d'erreur pour quand même retourner un résultat ???
            HTMLContentCourseSupport result = await templatedCardRendererManager.renderTemplatedHtmlSupport();

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => Scaffold(
          appBar: CustomAppBar(
            title: "Card editor",
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_circle_left_sharp),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
          body: HTMLDisplayer(
              htmlContentString: result.htmlSupport, fileContents: result.files),
          drawer: const AppDrawer(),
          persistentFooterButtons: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {},
              foregroundColor: Colors.blue[900],
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
              child: const Icon(FontAwesomeIcons.chartColumn),
            ),
          ],
        )),
            );
          },
          child: Container(
            //width: 30,
            margin: EdgeInsets.only(left: 4, right: 4),
            //decoration: BoxDecoration(border: Border.all()),
            child: const Icon(Icons.html_sharp, color: Colors.redAccent),
          ))
      : Container();
}

Widget _renderReviseTopicButton(BuildContext context, int? groupId) {
  return groupId != null
      ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => RevisorDisplayer(
                  groupId: [groupId],
                ),
              ),
            );
          },
          child: Container(
            //width: 30,
            margin: EdgeInsets.only(left: 4, right: 4),
            //decoration: BoxDecoration(border: Border.all()),
            child: const Icon(Icons.sd_card_outlined, color: Colors.deepPurple),
          ))
      : Container();
}

Future<List<ReviseCard>> getReviseCards(int groupId) async {
  final database = MyDatabaseInstance.getInstance();
  return await (database.select(database.reviseCards)
        ..where((tbl) => tbl.groupId.equals(groupId)))
      .get();
}

Widget _renderTopicBlock(
    Topic2 topic, BuildContext context, bool isTileExpanded) {
  List<Widget> childrenRendered = [];
  for (var child in topic.childrenTopics) {
    childrenRendered.add(_renderTopicBlock(child, context, false));
  }

  return Card(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.blueGrey, width: 0.1),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: CustomExpansionTile(
        title: topic.name,
        subtitle: (topic.groupId != null)
            ? FutureBuilder(
                future: getReviseCards(topic.groupId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Text("cards: ${snapshot.data?.length}");
                  }
                })
            : const Text(""),
        trailingChildren: [
          _renderViewHtmlSupportButton(context, topic.htmlContentId),
          SizedBox(width: 8.0),
          _renderViewPdfSupportButton(context, topic.fileId),
          SizedBox(width: 8.0),
          _renderReviseTopicButton(context, topic.groupId)
        ],
        children: childrenRendered,
        isTileExpanded: isTileExpanded),
  );
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final List<Widget> children;
  final List<Widget> trailingChildren;
  final bool isTileExpanded;

  CustomExpansionTile(
      {super.key,
      required this.title,
      required this.trailingChildren,
      required this.children,
      required this.isTileExpanded,
      required this.subtitle});

  @override
  State<StatefulWidget> createState() {
    return _CustomExpansionTileState();
  }
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  @override
  void initState() {
    super.initState();
    _customTileExpanded = widget.isTileExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0, right: 2.0),
        child: SingleChildScrollView(
            child: ExpansionTile(
                initiallyExpanded: _customTileExpanded,
                shape: Border(),
                title: Text(
                  widget.title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: widget.subtitle,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...widget.trailingChildren,
                    Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    )
                  ],
                ),
                children: widget.children,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _customTileExpanded = expanded;
                  });
                })));
  }
}

class _CourseSummaryState extends State<CourseSummary> {
  @override
  Widget build(BuildContext context) {
    var topics2 = buildTopic2(widget.topics);
    var topic3 = Topic2(-1, widget.course.title, topics2);
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Course Summary', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: _renderTopicBlock(topic3, context, true),
      ),
      drawer: const AppDrawer(),
    );
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

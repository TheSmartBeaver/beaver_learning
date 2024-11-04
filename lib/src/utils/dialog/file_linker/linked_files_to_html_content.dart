import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinkedFilesToHtmlContentListView extends ConsumerStatefulWidget {
  final int htmlContentId;

  LinkedFilesToHtmlContentListView(
      {super.key, required this.htmlContentId});

  @override
  ConsumerState<LinkedFilesToHtmlContentListView> createState() {
    return _LinkedFilesToHtmlContentListViewState();
  }
}

class _LinkedFilesToHtmlContentListViewState extends ConsumerState<LinkedFilesToHtmlContentListView> {
  late List<FileContent> files;

  Future<void> init() async {
    var database = MyDatabaseInstance.getInstance();
    HtmlDao htmlDao = HtmlDao(database);
    files = await htmlDao.getAllFileContentsLinkedToHtmlContent(widget.htmlContentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: init(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container(
          child: ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(files[index].path ?? ''),
                subtitle: Text("${files[index]} ${files[index].name} (${files[index].format})"),
                onTap: () {
                  Navigator.pop(context, files[index].id);
                },
              );
            },
          ),
        );
      }
    });
  }
}
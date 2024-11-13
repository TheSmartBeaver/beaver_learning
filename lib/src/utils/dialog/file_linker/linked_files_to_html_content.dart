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
        return Column(children: [ 
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              var database = MyDatabaseInstance.getInstance();
              HtmlDao htmlDao = HtmlDao(database);
              htmlDao.removeAllFilesLinkedToContent(widget.htmlContentId);
              await init();
              setState(() {
                
              });
            },
          ),
          SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: files.isNotEmpty ? ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: SelectableText(files[index].path ?? ''),
                subtitle: SelectableText("${files[index].id} ${files[index].name} (${files[index].format})"),
                onTap: () {
                  Navigator.pop(context, files[index].id);
                },
              );
            },
          ) : const Center(child: Text('No files linked to this content')),
        )]);
      }
    });
  }
}
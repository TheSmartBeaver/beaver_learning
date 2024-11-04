import 'dart:typed_data';

import 'package:beaver_learning/src/dao/file_content_dao.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/dialog/file_linker/file_import_dialog.dart';
import 'package:beaver_learning/src/utils/dialog/file_linker/file_linker_navigator.dart';
import 'package:beaver_learning/src/utils/dialog/file_linker/file_linker_search.dart';
import 'package:beaver_learning/src/utils/dialog/file_linker/linked_files_to_html_content.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class FileLinkerToHtmlContentDialog extends ConsumerStatefulWidget {
  final int htmlContentId;
  final Function()? onLink;

  FileLinkerToHtmlContentDialog(
      {super.key, required this.htmlContentId, this.onLink});

  @override
  ConsumerState<FileLinkerToHtmlContentDialog> createState() {
    return _FileLinkerToHtmlContentDialogState();
  }
}

class _FileLinkerToHtmlContentDialogState
    extends ConsumerState<FileLinkerToHtmlContentDialog> {
  FileLinkerNavigatorMenuItem currentNavigatorItem =
      FileLinkerNavigatorMenuItem.IMPORT_FILE;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    var database = MyDatabaseInstance.getInstance();
  }

  void onLinkNavigItemChange(FileLinkerNavigatorMenuItem menuItem) {
    setState(() {
      currentNavigatorItem = menuItem;
    });
  }

  void processFileLinkFunction(int fileId) {
    var database = MyDatabaseInstance.getInstance();
    widget.onLink!();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> createFileAndLink(FileToImport fileToImport) async {
      FileContentDao fileContentDao =
          FileContentDao(MyDatabaseInstance.getInstance());
      HtmlDao htmlContentDao = HtmlDao(MyDatabaseInstance.getInstance());

      int createdFileContentId = await fileContentDao.createFileContent(
          FileContentsCompanion.insert(
              name: fileToImport.fileName,
              format: fileToImport.fileExtension,
              content: fileToImport.fileBytes ?? Uint8List.fromList([]),
              lastUpdated: getUpdateDateNow()));
      htmlContentDao.createHtmlContentFileContent(
          widget.htmlContentId, createdFileContentId);
      Navigator.pop(context);
    }

    return AlertDialog(
        title: const Text("Link file to HTML content"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FileLinkerNavigator(
                  numberOfFilesLinked: 0,
                  onLinkNavigItemChange: onLinkNavigItemChange),
              if (currentNavigatorItem ==
                  FileLinkerNavigatorMenuItem.SEARCH_FILES)
                FileLinkerSearchDialog(
                    processFileLinkFunction: processFileLinkFunction),
              if (currentNavigatorItem ==
                  FileLinkerNavigatorMenuItem.IMPORT_FILE)
                FileImportDialog(onFileImportChoose: createFileAndLink),
              if (currentNavigatorItem ==
                  FileLinkerNavigatorMenuItem.FILES_LINKED)
                LinkedFilesToHtmlContentListView(
                    htmlContentId: widget.htmlContentId)
            ],
          ),
        ));
  }
}

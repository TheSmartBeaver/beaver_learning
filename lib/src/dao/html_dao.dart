import 'dart:io';

import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentFilesTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/db/image_table.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'html_dao.g.dart';

@DriftAccessor(tables: [HTMLContents, HTMLContentFiles])
class HtmlDao extends DatabaseAccessor<AppDatabase> with _$HtmlDaoMixin {
  final AppDatabase db;

  HtmlDao(this.db) : super(db);

  Future<HTMLContentRectoVerso> getHtmlContents(int htmlContentId) async {
    HTMLContent htmlContent = await (select(hTMLContents)
          ..where((tbl) => tbl.id.equals(htmlContentId)))
        .getSingle();

    // List<FileContent> contentFiles = await (select(fileContents)
    //       ..join([
    //         innerJoin(
    //             hTMLContentFiles,
    //             hTMLContentFiles.htmlContentParentId.equals(htmlContent.id) &
    //                 hTMLContentFiles.fileId.equalsExp(fileContents.id))
    //       ]))
    //     .get();

    List<HTMLContentFile> htmlContentFiles = await (select(hTMLContentFiles)
          ..where((tbl) => tbl.htmlContentParentId.equals(htmlContent.id)))
        .get();

    List<FileContent> contentFiles = await (select(fileContents)
          ..where((tbl) => tbl.id.isIn(htmlContentFiles.map((e) => e.fileId))))
        .get();

    List<HTMLContentObjFiles> hTMLContentObjFiles = [];
    for (var e in contentFiles) {
      hTMLContentObjFiles.add(
          HTMLContentObjFiles(e.name, e.format, (await fileContentToFile(e))));
    }

    HTMLContentRectoVerso result;

    if(htmlContent.isTemplated) {
      result = HTMLContentRectoVerso(
          recto: htmlContent.cardTemplatedJson,
          verso: htmlContent.cardTemplatedJson,
          files: hTMLContentObjFiles);
    } else {
      result = HTMLContentRectoVerso(
          recto: htmlContent.recto,
          verso: htmlContent.verso,
          files: hTMLContentObjFiles);
    }

    return result;
  }
}

class HTMLContentRectoVerso {
  final String recto;
  final String verso;
  final List<HTMLContentObjFiles> files;

  HTMLContentRectoVerso(
      {required this.files, required this.recto, required this.verso});
}

class HTMLContentObjFiles {
  final String name;
  final String format;
  final File file;

  HTMLContentObjFiles(this.name, this.format, this.file);
}

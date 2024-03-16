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

  Future<HTMLContentRectoVerso> getHtmlContents(ReviseCard card) async {
    HTMLContent rectoHtmlContent = await (select(hTMLContents)
          ..where((tbl) => tbl.id.equals(card.recto)))
        .getSingle();
    HTMLContent versoHtmlContent = await (select(hTMLContents)
          ..where((tbl) => tbl.id.equals(card.verso)))
        .getSingle();

    // List<HTMLContentFile> rectoHtmlContentFiles = await (select(hTMLContentFiles)..where((tbl) => tbl.htmlContentParentId.equals(rectoHtmlContent.id))).get();
    // List<HTMLContentFile> versoHtmlContentFiles = await (select(hTMLContentFiles)..where((tbl) => tbl.id.equals(versoHtmlContent.id))).get();

    List<FileContent> rectoHtmlContentFiles = await (select(fileContents)
          ..join([
            leftOuterJoin(
                hTMLContentFiles,
                hTMLContentFiles.htmlContentParentId
                    .equals(rectoHtmlContent.id))
          ]))
        .get();
    List<FileContent> versoHtmlContentFiles = await (select(fileContents)
          ..where((tbl) => tbl.id.equals(versoHtmlContent.id)))
        .get();

    List<HTMLContentObjFiles> hTMLContentObjFilesRecto = [];
    for (var e in rectoHtmlContentFiles) {
      hTMLContentObjFilesRecto.add(
          HTMLContentObjFiles(e.name, e.format, (await fileContentToFile(e))));
    }

    List<HTMLContentObjFiles> hTMLContentObjFilesVerso = [];
    for (var e in versoHtmlContentFiles) {
      hTMLContentObjFilesVerso.add(
          HTMLContentObjFiles(e.name, e.format, (await fileContentToFile(e))));
    }

    HTMLContentRectoVerso result = HTMLContentRectoVerso(
        recto:
            HTMLContentObj(rectoHtmlContent.content, hTMLContentObjFilesRecto),
        verso:
            HTMLContentObj(versoHtmlContent.content, hTMLContentObjFilesVerso));

    return result;
  }
}

class HTMLContentRectoVerso {
  final HTMLContentObj recto;
  final HTMLContentObj verso;

  HTMLContentRectoVerso({required this.recto, required this.verso});
}

class HTMLContentObj {
  final String content;
  final List<HTMLContentObjFiles> files;

  HTMLContentObj(this.content, this.files);
}

class HTMLContentObjFiles {
  final String name;
  final String format;
  final File file;

  HTMLContentObjFiles(this.name, this.format, this.file);
}

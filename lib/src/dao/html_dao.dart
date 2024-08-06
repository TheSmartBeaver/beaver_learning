import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentFilesTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/utils/templated_card_render_manager.dart';
import 'package:drift/drift.dart';

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
      TemplatedCardRendererManager templatedCardRendererManager = TemplatedCardRendererManager(htmlContent: htmlContent, hTMLContentObjFiles: hTMLContentObjFiles);
      result = await templatedCardRendererManager.render();
    } else {
      result = HTMLContentRectoVerso(
          recto: htmlContent.recto,
          verso: htmlContent.verso,
          files: hTMLContentObjFiles);
    }

    return result;
  }
}

import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentFilesTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:beaver_learning/src/utils/templated_render_manager.dart';
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

    // List<HTMLContentObjFiles> hTMLContentObjFiles = [];
    // for (var e in contentFiles) {
    //   hTMLContentObjFiles.add(
    //       HTMLContentObjFiles(e.name, e.format, (await fileContentToFile(e))));
    // }

    HTMLContentRectoVerso result;

    if (htmlContent.isTemplated) {
      TemplatedRendererManager templatedCardRendererManager =
          TemplatedRendererManager(
              htmlContent: htmlContent, contentFiles: contentFiles);
      // TODO: Faire la gestion d'erreur pour quand même retourner un résultat ???
      result = await templatedCardRendererManager.renderTemplatedCard();
    } else {
      result = HTMLContentRectoVerso(
          recto: htmlContent.recto,
          verso: htmlContent.verso,
          files: contentFiles);
    }

    return result;
  }

  Future updateById(int id, HTMLContentsCompanion htmlContentCompanion) {
    return (update(hTMLContents)..where((t) => t.id.equals(id)))
        .write(htmlContentCompanion);
  }

  Future<HTMLContent?> getById(int id) async {
    var entity = await ((select(hTMLContents)..where((t) => t.id.equals(id)))
        .getSingleOrNull());
    return entity;
  }

  Future<HTMLContent?> getBySku(String sku) async {
    var entity = await ((select(hTMLContents)..where((t) => t.sku.equals(sku)))
        .getSingleOrNull());
    return entity;
  }

  Future insertOrUpdateBySku(
      String sku, HTMLContentsCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(hTMLContents).insert(companion);
    } else {
      return await (update(hTMLContents)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }

  Future<List<HTMLContent>> getUsableAssemblies(String? textValue) async {
    var assembliesRequest = await (select(hTMLContents)
          ..where((tbl) => tbl.isAssembly.equals(true))
          ..limit(15));
    if (textValue?.isNotEmpty ?? false) {
      assembliesRequest.where((tbl) => tbl.path.like("%$textValue%"));
    }

    var assemblies = await assembliesRequest.get();
        
    return assemblies;
  }

  Future createHtmlContentFileContent(
      int htmlContentId, int fileId) async {
    var matchingLinks = await (select(hTMLContentFiles)
          ..where((tbl) => tbl.htmlContentParentId.equals(htmlContentId) & tbl.fileId.equals(fileId)))
        .get();
    if(matchingLinks.isEmpty){
      await into(hTMLContentFiles).insert(HTMLContentFilesCompanion.insert(
          htmlContentParentId: htmlContentId, fileId: fileId, lastUpdated: getUpdateDateNow()));
    }
  }

  Future removeAllFilesLinkedToContent(
      int htmlContentId) async {
    await (delete(hTMLContentFiles)
          ..where((tbl) => tbl.htmlContentParentId.equals(htmlContentId)))
        .go();
  }

  Future removeAllFilesLinkedToContentAndDeleteFiles(
      int htmlContentId) async {
    List<HTMLContentFile> htmlContentFiles = await (select(hTMLContentFiles)
          ..where((tbl) => tbl.htmlContentParentId.equals(htmlContentId)))
        .get();
    await removeAllFilesLinkedToContent(htmlContentId);
    await (delete(fileContents)
            ..where((tbl) => tbl.id.isIn(htmlContentFiles.map((e) => e.fileId))))
          .go();
  }

  Future<List<FileContent>> getAllFileContentsLinkedToHtmlContent(
      int htmlContentId) async {
    var htmlContentFiles = await (select(hTMLContentFiles)
          ..where((tbl) => tbl.htmlContentParentId.equals(htmlContentId)))
        .get();

    var files = await (select(fileContents)
          ..where((tbl) => tbl.id.isIn(htmlContentFiles.map((e) => e.fileId))))
        .get();

    return files;
  }
}

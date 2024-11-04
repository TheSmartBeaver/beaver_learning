import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:drift/drift.dart';

part 'file_content_dao.g.dart';

@DriftAccessor(tables: [FileContents])
class FileContentDao extends DatabaseAccessor<AppDatabase>
    with _$FileContentDaoMixin {
  final AppDatabase db;

  FileContentDao(this.db) : super(db);

  Future updateById(int id, FileContentsCompanion fileContentCompanion) {
    return (update(fileContents)..where((t) => t.id.equals(id)))
        .write(fileContentCompanion);
  }

  Future insertOrUpdateBySku(String sku, FileContentsCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(fileContents).insert(companion);
    } else {
      return await (update(fileContents)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }

  Future<FileContent?> getById(int id) async {
    var entity = await ((select(fileContents)..where((t) => t.id.equals(id))).getSingleOrNull());
    return entity;
  }

  Future<FileContent?> getBySku(String sku) async {
    var entity = await ((select(fileContents)..where((t) => t.sku.equals(sku))).getSingleOrNull());
    return entity;
  }

  Future<int> createFileContent(FileContentsCompanion companion) async {
    int fileContentId = await into(fileContents).insert(companion);
    return fileContentId;
  }
}

import 'package:beaver_learning/src/models/db/assemblyCategoryTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:drift/drift.dart';

part 'assembly_category_dao.g.dart';

@DriftAccessor(tables: [AssemblyCategory])
class AssemblyCategoryDao extends DatabaseAccessor<AppDatabase> with _$AssemblyCategoryDaoMixin {
  final AppDatabase db;

  AssemblyCategoryDao(this.db) : super(db);

  Future updateById(int id, AssemblyCategoryCompanion assemblyCategoryCompanion) {
    return (update(assemblyCategory)..where((t) => t.id.equals(id)))
        .write(assemblyCategoryCompanion);
  }

  Future<AssemblyCategoryData?> getById(int id) async {
    var entity = await ((select(assemblyCategory)..where((t) => t.id.equals(id))).getSingleOrNull());
    return entity;
  }

  Future updateBySku(String sku, AssemblyCategoryCompanion companion) {
    return (update(assemblyCategory)..where((t) => t.sku.equals(sku)))
        .write(companion);
  }
}
